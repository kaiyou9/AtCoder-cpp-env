#!/bin/bash

# accのログイン状態を確認
acc_logged_in=false
if acc session | grep -q "OK"; then
    acc_logged_in=true
else
    acc login
fi

# ojのログイン状態を確認
oj_logged_in=false
if oj login --check https://atcoder.jp/ | grep -q "You are not signed in." ; then
    oj login https://atcoder.jp/
else
    oj_logged_in=true
fi

# 両方にログインしている場合メッセージを表示
if $acc_logged_in && $oj_logged_in; then
    echo "AtCoder CLIとOnline Judge Toolsにログイン済みです。"
fi
