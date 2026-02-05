# NodeForgeCMS

### 定时任务：

> 备份数据库脚本：bin/mysql_backup.sh

1. 确认脚本可执行权限
   `chmod +x mysql_backup.sh`
2. 编辑 cron 表
   `crontab -e`
3. 添加定时任务
   `0 11 * * * /path/to/mysql_backup.sh`
4. 验证定时任务
   `crontab -l`
5. 日志查看与调试
   `grep cron /var/log/syslog`

### 远程数据库链接不上检查防火墙

```
# 防火墙状态
sudo ufw status

# 关闭防火墙
sudo ufw disable

# 开启防火墙
sudo ufw enable
```

### 其他信息

服务端画图：`xvfb-run node ./src/index.js`
