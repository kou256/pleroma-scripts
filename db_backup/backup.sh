#!/bin/bash

TIME=$(date +%Y%m%d_%H-%M-%S)
BACKUP_FILE="${TIME}-db-backup.gz"

# Stop Pleroma Service
systemctl stop pleroma

# Create DB Backup
echo "Create DB backup"
su postgres -s $SHELL -lc "pg_dumpall | gzip -c > /tmp/backup/${BACKUP_FILE}"
echo "Create DB backup finished."

# Upload backup to Cloudflare R2
echo "Upload backup file"
cd /tmp/backup
rclone copy ${BACKUP_FILE} r2:/backup/
echo "Upload finished"

systemctl start pleroma
