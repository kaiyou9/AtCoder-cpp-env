#!/bin/bash

# コンパイル
g++ main.cpp -std=c++23 -O2 -I "${WORKSPACE_DIR}/.include/"
if [ $? -ne 0 ]; then
    echo "エラー: コンパイルに失敗しました。"
    return 1
fi

# テストの実行
if [ -d "tests" ]; then
    oj test -c "./a.out" -d tests
elif [ -d "test" ]; then
    oj test -c "./a.out" -d test
else
    echo "エラー: "tests"もしくは"test"ディレクトリが見つかりません。"
    return 1
fi
