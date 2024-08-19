#!/bin/bash

# Gitリポジトリの絶対パスを配列として宣言
GIT_REPOS=(
    "/home/user/projects/git-project1"
    "/var/www/html/git-website"
    "/opt/applications/git-backend"
    "/home/user/documents/git-blog"
)

# Mavenリポジトリの絶対パスを配列として宣言
MAVEN_REPOS=(
    "/home/user/projects/maven-project1"
    "/opt/applications/maven-backend"
    "/var/www/maven-webapp"
    "/home/user/documents/maven-library"
)

# その他の設定
MAX_PARALLEL=4  # 並列処理の最大数
LOG_FILE="/var/log/build_script.log"  # ログファイルのパス
