#!/bin/bash

# コンテストIDと問題を入力
read -p "コンテストIDと問題を入力してください (例: abc001 a): " contest_id problem_letter

if [ -z "$contest_id" ] || [ -z "$problem_letter" ]; then
    echo "エラー: コンテストIDおよび問題を入力してください。"
    return 1
fi

# ディレクトリを検索して移動
target_dir=$(find "${WORKSPACE_DIR}" -type d -path "*/${contest_id}/${problem_letter}")

if [[ -n "$target_dir" ]]; then
    cd "$target_dir"
else
    echo "エラー: 指定した問題が見つかりません。"
    return 1
fi

# ファイルを開く
if command -v code &> /dev/null; then
    code main.cpp
elif command -v cursor &> /dev/null; then
    cursor main.cpp
fi
