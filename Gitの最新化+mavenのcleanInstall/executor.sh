#!/bin/bash

# 設定ファイルの読み込み
source config.sh

# 最大並列処理数
MAX_PARALLEL=4

# ログ関数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# リポジトリ処理関数
process_repo() {
    local repo=$1
    local script=$2
    log "リポジトリ $repo に対して $script を実行します。"
    ./$script "$repo"
    local status=$?
    if [ $status -ne 0 ]; then
        log "警告: $repo で $script の実行に失敗しました。"
        echo "$repo" >> /tmp/failed_repos.txt
    else
        log "$repo の処理が完了しました。"
    fi
    return $status
}

# 並列処理関数
process_repos_parallel() {
    local repos=("$@")
    local script=$1
    shift
    local running=0
    local errors=0

    for repo in "${repos[@]}"; do
        # 最大並列数に達したら待機
        if [ $running -ge $MAX_PARALLEL ]; then
            wait -n
            running=$((running - 1))
        fi

        # バックグラウンドでリポジトリ処理を実行
        process_repo "$repo" "$script" &
        running=$((running + 1))
    done

    # 残りのジョブが完了するのを待つ
    wait

    # エラーをカウント
    if [ -f /tmp/failed_repos.txt ]; then
        errors=$(wc -l < /tmp/failed_repos.txt)
        rm /tmp/failed_repos.txt
    fi

    return $errors
}

# メイン処理
main() {
    local git_errors=0
    local mvn_errors=0

    log "Gitリポジトリの処理を開始します。"
    process_repos_parallel "git.sh" "${GIT_REPOS[@]}"
    git_errors=$?

    log "Mavenリポジトリの処理を開始します。"
    process_repos_parallel "mvn.sh" "${MAVEN_REPOS[@]}"
    mvn_errors=$?

    local total_errors=$((git_errors + mvn_errors))
    log "全ての処理が完了しました。合計エラー数: $total_errors"
    log "Gitリポジトリのエラー数: $git_errors"
    log "Mavenリポジトリのエラー数: $mvn_errors"

    [ $total_errors -gt 0 ] && exit 1 || exit 0
}

# スクリプトの実行
main "$@"
