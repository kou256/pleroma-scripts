# pleroma-scripts
- Pleromaサーバーのメンテナンスやバックアップ用のスクリプト
- PleeromaサーバーはUbuntu 22.04かつ[OTPインストール](https://docs-develop.pleroma.social/backend/installation/otp_en/)されている環境を想定している
## 使用方法
- `setup.sh`により必要なファイルを適切な場所へ配置する
    - スクリプトは必要に応じて配置する場所を変えても構わない
```shell
sudo bash setup.sh
```

## Backup
- PostgreSQLのバックアップを作成し、rcloneを使用してCloudflare R2にアップロードするスクリプト
- NGINXやPleromaの設定ファイルのバックアップを作成し同様にCloudflare R2にアップロードするスクリプト
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
### config_backup.sh
- `/var/lib/sbin/config_backup.sh`として配置する
- NGINXの設定ファイルをバックアップする
- Pleromaの設定ファイルをバックアップする
- Let's Encrypt関連のファイルをバックアップする
- 出力済みのログファイルをバックアップする
- 上記のファイルをまとめてCloudflare R2にアップロードする

## Update
- Pleroma(OTPインストール)をアップデートするためのスクリプト
- Ubuntuをアップデートおよび不要なパッケージ，キャッシュを削除するスクリプト
### ubuntu_update.sh
- `/var/lib/sbin/ubuntu_update.sh`として配置する
- Ubuntuのアップデート（update, upgrade）を実行する
- 不要なパッケージやキャッシュを削除する（autoremove, autovlean, clean）
### update_schedule
- `/etc/cron.d/update_schedule`として配置する
- 毎日3:30(JST)にubuntu_update.shを実行する
### pleroma_update.sh
- `/var/lib/sbin/pleroma_update.sh`として配置する
- [公式のアップデート手順](https://docs-develop.pleroma.social/backend/administration/updating/)通りにコマンドを実行しPleromaをバージョンアップする
- アップデート前にOSアップデート，設定ファイルとデータベースのバックアップを実行しておく
