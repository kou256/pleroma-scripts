# pleroma-scripts
- Pleromaサーバーのメンテナンスやバックアップ用のスクリプト
## DB Backup
- PostgreSQLのバックアップを作成し、rcloneを使用してCloudflare R2にアップロードするスクリプトなど
### rclone.conf
- `/root/.config/rclone/rclone.conf`として配置する
- Cloudflare R2のアクセスキーID、シークレットアクセスキー、エンドポイントをファイル内に書き込む
### backup.sh
- `/root/backup.sh`として配置する（仮）
- PostgreSQLのダンプファイルをgzipで圧縮する
- 圧縮したファイルをrcloneでR2バケットにアップロードする
### backup_schedule
- `/etc/cron.d/backup_schedule`として配置する
- 毎日3:00(JST)にbackup.shを実行してバックアップしたファイルをアップロードする
- 毎日3:10(JST)に14日以上経過したバックアップファイルを削除する