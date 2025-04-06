#!/bin/bash

# 開いているファイルパスを取得
file_path="$1"

# ファイルパスが無効でないか確認
if [[ -z "$file_path" ]]; then
    echo "エラー: ファイルパスを取得できませんでした。タスクの設定を確認してください。"
    exit 1
fi

# ファイルのディレクトリに移動
cd "$(dirname "$file_path")" || exit 0

# コンパイル
g++ main.cpp -std=c++23 -O2 -I "${WORKSPACE_DIR}/.include/"
if [ $? -ne 0 ]; then
    echo "エラー: コンパイルに失敗しました。"
    exit 0
fi

# テストの実行
if [ -d "tests" ]; then
    oj test -c "./a.out" -d tests
elif [ -d "test" ]; then
    oj test -c "./a.out" -d test
else
    echo "エラー: "tests"もしくは"test"ディレクトリが見つかりません。"
    exit 0
fi

# ojコマンドのエラー出力の非表示
if [ $? -ne 0 ]; then
    exit 0
fi
