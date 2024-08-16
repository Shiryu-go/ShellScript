#!/bin/bash

# 引数を受け取る
if [ $# -eq 0 ]; then
    echo "エラー: パスが指定されていません。"
    exit 1
fi

path="$1"

# 引数で受け取ったパスへ移動
cd "$path" && {echo "移動しました。";} || { echo "エラー: 指定されたパスに移動できません。"; exit 1; }

# 変更内容をstashする
git stash && {echo "stashしました。";} || { echo "エラー: git stashに失敗しました。"; exit 1; }

# 変更を取り込みする
git pull && {echo "変更を取り込みました。";} || { echo "エラー: git pullに失敗しました。"; exit 1; }

# 変更内容をstashから取り出す
git stash apply && {echo "stashから変更を取り出しました。";} || { echo "エラー: git stash applyに失敗しました。"; exit 1; }
