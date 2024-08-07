#!/bin/bash

# 引数を取得（タスク名）
task_name="$1"

# 引数が指定されていない場合はエラーメッセージを表示
if [ -z "$task_name" ]; then
    echo "使用法: $0 <タスク名>"
    exit 1
fi

echo "計測中"
read -r  # ユーザーが Enter を押すまで待機

# 開始時間を取得
start_time=$(date +%s)
# 終了時の時間を取得
end_time=$(date +%s)

# 経過時間を計算
elapsed_time=$((end_time - start_time))

# 経過時間を秒、分、時間に変換
elapsed_seconds=$elapsed_time
elapsed_minutes=$((elapsed_time / 60))
elapsed_hours=$((elapsed_time / 3600))

# 分と秒を計算
remaining_minutes=$((elapsed_minutes % 60))
remaining_seconds=$((elapsed_seconds % 60))

# 結果を表示
echo "タスク '$task_name' が完了しました。"
echo "経過時間: $elapsed_hours 時間 $remaining_minutes 分 $remaining_seconds 秒"
