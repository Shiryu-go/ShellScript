#!/bin/bash

# 引数を受け取る
if [ $# -eq 0 ]; then
    echo "エラー: 絶対パスが指定されていません。"
    exit 1
fi

# 絶対パスかどうかを確認
if [[ ! "$1" = /* ]]; then
    echo "エラー: 指定されたパスは絶対パスではありません。"
    exit 1
fi

# 絶対パスを変数に格納
absolute_path="$1"

# パスが存在するか確認
if [ ! -d "$absolute_path" ]; then
    echo "エラー: 指定された絶対パスが存在しません。"
    exit 1
fi

echo "指定された絶対パス: $absolute_path"

# 指定された絶対パスへ移動
cd "$absolute_path" && {
    echo "指定されたパスへ移動しました。"
} || {
    echo "エラー: 指定されたパスへの移動に失敗しました。"
    exit 1
}

# Mavenのcleanとinstallを実行
mvn clean install && {
    echo "Mavenのcleanとinstallが正常に完了しました。"
} || {
    echo "エラー: Mavenのcleanとinstallに失敗しました。"
    exit 1
}

