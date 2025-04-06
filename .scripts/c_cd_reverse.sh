#!/bin/bash

# カレントディレクトリを取得
current_dir=$(basename "$PWD")

# ルートディレクトリからの深さを取得
depth=$(echo "$PWD" | awk -F'/' '{print NF-1}')

# 現在のディレクトリが問題ディレクトリかを確認
if [[ $depth -ne 5 ]]; then
    echo "エラー: カレントディレクトリが問題ディレクトリではありません。"
    return 1
fi

# ディレクトリ一覧を取得してソート
dirs=($(ls -d ../*/ | sed 's|../||;s|/||' | sort))

# 現在のディレクトリのインデックスを取得
current_index=-1
for i in "${!dirs[@]}"; do
    if [[ "${dirs[$i]}" == "$current_dir" ]]; then
        current_index=$i
        break
    fi
done

# 前のディレクトリに移動
if [[ $current_index -gt 0 ]]; then
    prev_dir="../${dirs[$(($current_index - 1))]}"
    cd "$prev_dir"
else
    # 前のディレクトリがない場合は最後のディレクトリに移動
    last_dir="../${dirs[-1]}"
    cd "$last_dir"
fi

# ファイルを開く
if command -v code &> /dev/null; then
    code main.cpp
elif command -v cursor &> /dev/null; then
    cursor main.cpp
fi
