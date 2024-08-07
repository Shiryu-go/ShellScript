#!/bin/bash

# ディレクトリが存在しない場合は作成する
mkdir -p $HOME/.config/git/template

# commit.txt ファイルに文章を追加する
cat << EOF > $HOME/.config/git/template/commit.txt
# コミットメッセージの書き方の例:

# [タグ] コミットの要約
#
# コミットの詳細説明はここに書きます。

EOF

# git のコミットテンプレートに設定する
git config --global commit.template $HOME/.config/git/template/commit.txt
