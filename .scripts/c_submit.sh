#!/bin/bash

# カレントディレクトリにmain.cppが存在するか確認
if [[ ! -f "main.cpp" ]]; then
    echo "エラー: main.cppが見つかりません。"
    return 1
fi

# 確認メッセージを表示してユーザーの入力を待つ
read -n 1 -p "カレントディレクトリのファイルを提出しますか？ (y/N): " confirm

# "y" 以外が入力された場合はスクリプトを終了
if [[ "$confirm" != "y" ]]; then
    echo 
    echo "提出がキャンセルされました。"
    return 0
fi

# 提出の実行
timeout 20s acc submit main.cpp -- -y

return 0