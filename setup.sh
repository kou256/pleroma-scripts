#!/bin/bash

# Put backup scripts
sudo cp ./backup/db_backup.sh /usr/lib/sbin/db_backup.sh
sudo chmod +x /usr/lib/sbin/db_backup.sh
sudo cp ./backup/db_restore.sh /usr/lib/sbin/db_restore.sh
sudo chmod +x /usr/lib/sbin/db_restore.sh
sudo cp ./backup/config_backup.sh /usr/lib/sbin/config_backup.sh
sudo chmod +x /usr/lib/sbin/config_backup.sh
sudo cp ./backup/db_backup_schedule /etc/cron.d/db_backup_schedule
sudo chmod 644 /etc/cron.d/db_backup_schedule
sudo mkdir -p /root/.config/rclone
sudo cp ./backup/rclone.conf /root/.config/rclone/rclone.conf

# Put update scripts
sudo cp ./update/pleroma_update.sh /usr/lib/sbin/pleroma_update.sh
sudo chmod +x /usr/lib/sbin/pleroma_update.sh
sudo cp ./update/ubuntu_update.sh /usr/lib/sbin/ubuntu_update.sh
sudo chmod +x /usr/lib/sbin/ubuntu_update.sh
sudo cp ./update/ubuntu_update_schedule /etc/cron.d/ubuntu_update_schedule
sudo chmod 644 /etc/cron.d/ubuntu_update_schedule