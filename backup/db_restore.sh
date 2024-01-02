#!/bin/bash

BACKUP_DIR="/var/lib/postgresql/backup"

# 実行時の引数がない場合は異常終了
if [ $# -lt 1 ]; then
    echo "Too few arguments."
    exit 1
fi

cd ${BACKUP_DIR}
backup_file=""
if [ "$1" = "--latest" ]; then
    # 最新のバックアップファイルを使用する
    backup_file=$(ls -t *.gz | head -n 1)
elif [ "$1" = "--file" ]; then
    # 引数で指定されたバックアップファイルを使用する
    backup_file=$2
else
    echo "Not implementation."
    exit 1
fi
if [ -z "$backup_file" ]; then
    echo "Backup file is not found."
    exit 1
fi

# リストア処理
systemctl stop pleroma
su postgres <<EOF
    #TODO: 処理が成功した場合のみ次の処理を実行するようにしたい
    gunzip -dc "${BACKUP_DIR}/${backup_file}" | psql -f -
    vacuumdb -a -z
    echo "Restore finished."
EOF
systemctl start pleroma