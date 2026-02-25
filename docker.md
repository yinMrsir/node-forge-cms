# Docker 部署步骤

## 1. 复制环境变量配置

`cp .env.example .env`

## 2. 修改 .env 文件中的密码和配置（重要！）

`vim .env`

## 3. 一键部署

`./deploy.sh`

## 常用命令

### 查看服务状态

docker-compose ps

### 查看日志

docker-compose logs -f app

### 停止服务

docker-compose down

### 停止并删除数据

docker-compose down -v

### 重启服务

docker-compose restart

### 进入容器

docker-compose exec app sh

## 访问地址

- 前台: http://localhost
- 管理后台: http://localhost/admin
- 直接访问应用: http://localhost:3000
