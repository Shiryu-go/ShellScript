#!/bin/bash

IGNORE_PATTERNS=(
    "/.classpath"
    "/.project"
    "/.settings/"
    "/bin/"
    "/target/"
)

if [ ! -d "$HOME/.config" ]; then
  mkdir "$HOME/.config"
  echo "$HOME/.config ディレクトリが無かったので作成しました"
fi
if [ ! -d "$HOME/.config/git" ]; then
  mkdir "$HOME/.config/git"
  echo "$HOME/.config/git ディレクトリが無かったので作成しました。"
fi
if [ ! -d "$HOME/.config/git/ignore" ]; then
  touch "$HOME/.config/git/ignore"
  echo "$HOME/.config/git/ignore ファイルが無かったので作成しました。"
fi

for pattern in "${IGNORE_PATTERNS[@]}"; do
  if grep -q "$pattern" "$HOME/.config/git/ignore"; then
    echo "$pattern はすでに存在していたみたいです。"
  else
    # パターンをファイルに追加する
    echo "$pattern" >> "$HOME/.config/git/ignore"
    echo "'$pattern' を追加しました。"
  fi
done
