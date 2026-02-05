#!/bin/bash

# 配置区
DB_NAME="node_forge_cms"             # 数据库名称
DB_USER="root"              # 备份专用用户
DB_PASS="node_forge_cms"            # 用户密码
BACKUP_DIR="/NodeForgeCMS/bin/backup/mysql"   # 备份存储路径
KEEP_DAYS=7                 # 保留天数
DB_PORT=3306                # 数据库端口

# 生成备份文件名（格式：数据库名_年_月_日_时_分.sql.gz）
DATE=$(date +%Y%m%d%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${DATE}.sql.gz"

# 创建备份目录（如果不存在）
mkdir -p "$BACKUP_DIR"
chown -R mysql:mysql "$BACKUP_DIR"

# 执行备份
echo "Starting backup at $(date +%Y-%m-%d\ %H:%M:%S)"
mysqldump -h 127.0.0.1 -P $DB_PORT -u "$DB_USER" -p"$DB_PASS" --opt "$DB_NAME" | gzip > "$BACKUP_FILE"

# 检查备份是否成功
if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_FILE"
else
    echo "Backup failed!"
    exit 1
fi

# 清理旧备份
find "$BACKUP_DIR" -type f -name "*.sql.gz" -mtime +"$KEEP_DAYS" -delete
echo "Cleaned backups older than $KEEP_DAYS days"

# 解压
#gunzip /backup/mysql/your_database_*.sql.gz
# 解压并恢复
#gunzip -c /backup/mysql/your_database_*.sql.gz | mysql -u $DB_USER -p$DB_PASS $DB_NAME
