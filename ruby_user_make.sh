#!/bin/sh

#
# ユーザアカウントを複数生成して環境を構築するためのスクリプト
# root で実行しましょう
#


PW_LEN=8 # パスワードの長さ
USERS=(sample1 sample2 sample3) # ユーザ名の配列

# 初期化とか
addgroup newcomer
mkdir account_inf

# user 毎に処理するためのループ
for user in ${USERS[@]}
do
    homeusr = "/home/${user}"
    password = generate_password(PW_LEN)
    echo "ID: ${user}\nPassword: ${password}\n※全角のO（オー）、半角のo（オー）、半角のl（エル）は使ってません" > account_inf/${user}.txt
    adduser -G newcomer -s /bin/zsh ${user}
    passwd ${user} ${password}
    cp -R $HOME/.rbenv/ ${homeusr}
    touch ${homeusr}/.zshrc
    echo 'export PATH=$PATH:$HOME/.rbenv\neval "$(rbenv init -)"' >> ${homeusr}/.zshrc
done

# パスワード生成用の関数
# http://blog.paz-para.com/?p=1709 より拝借。製作者の方に感謝。
function generate_password() {
    len=$1

    [ -z $len ] && len="8"
    char='ABCDEFGHIJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz1234567890';
    i=1
    while [ $i -le $len ]; do
        dm=$(( (RANDOM % ${#char}) ))
        str="${str}${char:${dm}:1}"
        i=$(( i+1 ))
    done

    return "$str"
}


