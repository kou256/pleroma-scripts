#!/bin/bash/

# Update Ubuntu
bash /usr/local/sbin/ubuntu_update.sh

# Config Backup
bash /usr/local/sbin/config_backup.sh

# DB Backup
bash /usr/local/sbin/db_backup.sh

# Pleroma Update
echo "Pleroma Update Start."
systemctl stop pleroma
su pleroma -s $SHELL -lc "./bin/pleroma_ctl update"
su pleroma -s $SHELL -lc "./bin/pleroma_ctl migrate"
systemctl start pleroma
echo "Pleroma Update Finished."