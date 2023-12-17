# pleroma-scripts
- Pleromaサーバーのメンテナンスやバックアップ用のスクリプト
## DB Backup
- PostgreSQLのバックアップを作成し、rcloneを使用してCloudflare R2にアップロードするスクリプトなど
### rclone.conf
- `/root/.config/rclone/rclone.conf`として配置する
- Cloudflare R2のアクセスキーID、シークレットアクセスキー、エンドポイントをファイル内に書き込む
### db_backup.sh
- `/var/lib/sbin/db_backup.sh`として配置する
- PostgreSQLのダンプファイルをgzipで圧縮する
- 圧縮したファイルをrcloneでR2バケットにアップロードする
### db_restore.sh
- `/var/lib/sbin/db_restore.sh`として配置する
- PostgreSQLのバックアップファイルからデータベースをリストアする
- コマンドライン引数
    - `--latest`: リストアに最新のバックアップファイルを使用する
    - `--file ${file}`: リストアに`${file}`で指定したバックアップファイルを使用する
### db_backup_schedule
- `/etc/cron.d/db_backup_schedule`として配置する
- 毎日3:00(JST)にdb_backup.shを実行してバックアップしたファイルをアップロードする
- 毎日3:10(JST)に14日以上経過したバックアップファイルを削除する