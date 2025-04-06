#!/bin/bash

# 呼び出し元の設定
run_mode="${1:-command}"

# 問題番号を入力
read -p "コンテストIDを入力してください (例: abc001, arc159): " contest_id

# contest_idに応じてディレクトリを選択
if [[ "$contest_id" =~ ^abc[0-9]{3}$ ]]; then
    WORKING_DIR="${WORKSPACE_DIR}/ABC"
elif [[ "$contest_id" =~ ^arc[0-9]{3}$ ]]; then
    WORKING_DIR="${WORKSPACE_DIR}/ARC"
elif [[ "$contest_id" =~ ^agc[0-9]{3}$ ]]; then
    WORKING_DIR="${WORKSPACE_DIR}/AGC"
else
    WORKING_DIR="${WORKSPACE_DIR}/Others"
fi

# 各コンテストディレクトリに移動
cd $WORKING_DIR

# 問題をダウンロード
acc new $contest_id

# 不正な入力時に処理を終了
if [ -z "$contest_id" ] || [ ! -d "${WORKING_DIR}/${contest_id}" ]; then
    echo "エラー: 正しいコンテストIDを指定してください。"
    if [[ "$run_mode" == "task" ]]; then
        exit 0
    elif [[ "$run_mode" == "command" ]]; then
        return 1
    fi
fi

# テンプレートファイルのパスを設定
TEMPLATE="${WORKSPACE_DIR}/.templates/template.cpp"

# 各難度のフォルダにテンプレートがない場合作成
for PROBLEM_DIR in ${WORKING_DIR}/${contest_id}/*/; do
    if [ -d "$PROBLEM_DIR" ]; then
        if [ ! -f "${PROBLEM_DIR}main.cpp" ]; then
            # ディレクトリ名から問題のラベル（a, b, c...）を取得
            problem_letter=$(basename "$PROBLEM_DIR")

            # 該当する問題のタイトルを取得
            problem_title=$(jq -r --arg problem_letter "$problem_letter" '.tasks[] | select(.directory.path == $problem_letter) | .title' "${WORKING_DIR}/${contest_id}/contest.acc.json")

            # テンプレートファイルをコピーし、問題情報を挿入
            cp -n $TEMPLATE "${PROBLEM_DIR}main.cpp"
            echo "// ${contest_id} ${problem_letter^^} - $problem_title" | cat - "${PROBLEM_DIR}main.cpp" > temp && mv temp "${PROBLEM_DIR}main.cpp"
        fi
    fi
done

# 最も若いディレクトリに移動
first_problem_dir=$(find "${contest_id}" -mindepth 1 -maxdepth 1 -type d | sort | head -n 1)

cd "$first_problem_dir"

#ファイルを開く
if command -v code &> /dev/null; then
    code main.cpp
elif command -v cursor &> /dev/null; then
    cursor main.cpp
fi
