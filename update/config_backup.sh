#!/bin/bash

TIME=$(date +%Y%m%d_%H-%M-%S)
HOME_DIR=$(echo $HOME)
BACKUP_DIR="${HOME_DIR}/backup/${TIME}"
BACKUP_FILE="${BACKUP_DIR}-config-backup.tar.gz"

mkdir -p "${BACKUP_DIR}"

# Create NGINX Backup
echo "Create NGINX backup."
mkdir -p ${BACKUP_DIR}/nginx
sudo cp -r /etc/nginx/* ${BACKUP_DIR}/nginx
echo "Finished NGINX backup."

# Create Pleroma Backup
echo "Create Pleroma backup."
mkdir -p ${BACKUP_DIR}/pleroma
sudo cp -r /etc/pleroma/* ${BACKUP_DIR}/pleroma
echo "Finished Pleroma backup."

# Create LetsEncrypt Backup
echo "Create LetsEncrypt backup."
mkdir -p ${BACKUP_DIR}/letsencrypt
sudo cp -r /etc/letsencrypt/* ${BACKUP_DIR}/letsencrypt
echo "Finished LetsEncrypt backup."

# Create Logfile Backup
echo "Create Logfile backup."
mkdir -p ${BACKUP_DIR}/log
cp -r /var/log/* ${BACKUP_DIR}/log
echo "Finished Logfile backup."

# Upload backup to Cloudflare R2
echo "Upload backup file"
cd "${HOME_DIR}/backup"
sudo tar -zcvf ${BACKUP_FILE} ${BACKUP_DIR}
sudo rclone copy ${BACKUP_FILE} r2:/backup/
echo "Upload finished"