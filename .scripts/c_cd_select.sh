#!/bin/bash

# 現在のディレクトリの深さをカウント
current_dir_depth=$(echo "$PWD" | awk -F'/' '{print NF-1}')

# 現在のディレクトリが問題ディレクトリかどうかを確認
if [[ "$current_dir_depth" -ne 5 ]]; then
    echo "エラー: 問題ディレクトリ内で使用してください。"
    return 1
fi

# コンテストのディレクトリを取得
contest_dir=$(dirname "$PWD")

# 移動したい問題ディレクトリを入力
read -p "移動したい問題を入力してください (例: a, c1): " target_problem

# 入力が空であるかどうかを確認
if [[ -z "$target_problem" ]]; then
    echo "エラー: 問題が入力されていません。"
    return 1
fi

# 指定された問題ディレクトリが存在するか確認し、存在すれば移動
target_dir="$contest_dir/$target_problem"
if [[ -d "$target_dir" ]]; then
    cd "$target_dir"
    echo "問題 $target_problem に移動しました。"
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
