

# .config/bash_custom.sh

# スタックサイズの指定
ulimit -s 1048576

#以下、プロンプト設定
# ディレクトリ名の取得
BASE_DIR="${WORKSPACE_DIR#/workspaces/}"

# パスを3以下にする
get_short_path() {
  echo "$PWD" | sed -E "s|^.*/${BASE_DIR}/([^/]+/[^/]+).*|/${BASE_DIR}/\1|"
}

# カレントディレクトリから問題名を抽出
get_problem_info() {
  if [[ "$PWD" == *"/${BASE_DIR}/"* ]]; then
    local current_dir=$(pwd)

    # ディレクトリの深さをカウント
    local depth=$(echo "$current_dir" | awk -F'/' '{print NF-1}')

    # ディレクトリの深さが5の場合は問題ディレクトリと判断
    if [[ "$depth" -eq 5 ]]; then
        # ディレクトリ名を大文字に変換して表示
        echo -e "\e[1;92m$(basename "$current_dir" | tr '[:lower:]' '[:upper:]')\e[0m"
    else
        echo -e "\e[38;5;218m-\e[0m"
    fi
  else
    echo -e "\e[38;5;218m-\e[0m"
  fi
}

# PS1の設定
export PS1='┌─[ \t | $(get_short_path) ][ $(get_problem_info) ]\n└─▪ '

# コマンドの結果の後に改行を追加
first_call=true

function add_newline() {
  if $first_call; then
    first_call=false
  else
    echo ""
  fi
}

export PROMPT_COMMAND=add_newline
