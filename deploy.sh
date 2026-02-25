#!/bin/bash

# NodeForgeCMS Docker 一键部署脚本
# 作者: Claude Code
# 描述: 自动化部署 NodeForgeCMS 到 Docker 容器

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查命令是否存在
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 检查必要的命令
check_requirements() {
    print_info "检查系统依赖..."

    if ! command_exists docker; then
        print_error "Docker 未安装，请先安装 Docker"
        exit 1
    fi

    if ! command_exists docker-compose; then
        print_error "Docker Compose 未安装，请先安装 Docker Compose"
        exit 1
    fi

    print_success "系统依赖检查通过"
}

# 创建环境配置文件
setup_env() {
    print_info "配置环境变量..."

    if [ ! -f .env ]; then
        cat > .env << 'EOF'
# MySQL 配置
MYSQL_ROOT_PASSWORD=nodeforge_root_password_change_me
MYSQL_DATABASE=node_forge_cms
MYSQL_USER=nodeforge
MYSQL_PASSWORD=nodeforge_password_change_me
MYSQL_PORT=3306

# Redis 配置
REDIS_PASSWORD=redis_password_change_me
REDIS_PORT=6379

# JWT 密钥 (请修改为随机字符串)
JWT_SECRET=your_jwt_secret_key_change_in_production

# 服务配置
SERVER_HOST=http://localhost
IMG_HOST=http://localhost
IS_DEMO_ENVIRONMENT=false

# Nginx 端口配置
NGINX_HTTP_PORT=80
NGINX_HTTPS_PORT=443

# 应用端口
APP_PORT=3000

# 邮件配置 (可选)
FORM_USER_EMAIL=
FORM_USER_EMAIL_PASSWORD=
USER_EMAIL_SERVICE=QQ
EOF
        print_warning ".env 文件已创建，请修改其中的密码和密钥！"
        print_info "编辑 .env 文件后按回车继续..."
        read -r
    else
        print_info ".env 文件已存在"
    fi
}

# 创建初始化 SQL 文件
create_init_sql() {
    if [ ! -f init-db.sql ]; then
        print_info "创建数据库初始化文件..."
        cat > init-db.sql << 'EOF'
-- NodeForgeCMS 数据库初始化脚本
-- 注意: 数据表由 Drizzle ORM 自动创建

SET CHARACTER SET utf8mb4;
EOF
    fi
}

# 创建 SSL 目录
setup_ssl() {
    if [ ! -d ssl ]; then
        mkdir -p ssl
        print_info "ssl 目录已创建，如需 HTTPS 请将证书放入此目录"
    fi
}

# 停止并删除旧容器
cleanup_old() {
    print_info "清理旧的容器和镜像..."

    # 询问是否清理
    read -p "是否清理旧的数据? 这将删除所有数据! (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        docker-compose down -v
        print_success "旧数据已清理"
    else
        docker-compose down
        print_info "容器已停止，数据已保留"
    fi
}

# 构建镜像
build_image() {
    print_info "开始构建 Docker 镜像..."
    docker-compose build --no-cache
    print_success "镜像构建完成"
}

# 启动服务
start_services() {
    print_info "启动服务..."
    docker-compose up -d
    print_success "服务启动完成"
}

# 等待服务就绪
wait_for_services() {
    print_info "等待服务启动..."

    local max_attempts=60
    local attempt=0

    while [ $attempt -lt $max_attempts ]; do
        if docker-compose exec -T app wget --quiet --tries=1 --spider http://localhost:3000/ 2>/dev/null; then
            print_success "应用服务已就绪"
            return 0
        fi
        attempt=$((attempt + 1))
        echo -n "."
        sleep 2
    done

    print_error "服务启动超时"
    return 1
}

# 显示状态
show_status() {
    print_info "容器状态:"
    docker-compose ps

    echo ""
    print_info "服务日志 (最近 20 行):"
    docker-compose logs --tail=20 app
}

# 显示访问信息
show_access_info() {
    local http_port=$(grep NGINX_HTTP_PORT .env | cut -d'=' -f2)
    local app_port=$(grep APP_PORT .env | cut -d'=' -f2)

    echo ""
    echo "=========================================="
    print_success "部署完成！"
    echo "=========================================="
    echo ""
    echo "🌐 网站访问地址:"
    echo "   - 前台: http://localhost:${http_port}"
    echo "   - 管理后台: http://localhost:${http_port}/admin"
    echo "   - 直接访问应用: http://localhost:${app_port}"
    echo ""
    echo "📊 查看状态:"
    echo "   docker-compose ps"
    echo ""
    echo "📝 查看日志:"
    echo "   docker-compose logs -f app"
    echo ""
    echo "🛑 停止服务:"
    echo "   docker-compose down"
    echo ""
    echo "🔄 重启服务:"
    echo "   docker-compose restart"
    echo ""
    echo "=========================================="
    print_warning "请及时修改 .env 文件中的密码和密钥！"
    echo "=========================================="
}

# 主函数
main() {
    echo ""
    echo "=========================================="
    echo "   NodeForgeCMS Docker 一键部署脚本"
    echo "=========================================="
    echo ""

    # 检查依赖
    check_requirements

    # 配置环境
    setup_env
    create_init_sql
    setup_ssl

    # 询问是否清理旧数据
    read -p "是否清理旧的容器和镜像? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cleanup_old
    fi

    # 构建镜像
    build_image

    # 启动服务
    start_services

    # 等待服务就绪
    wait_for_services

    # 显示状态
    show_status

    # 显示访问信息
    show_access_info
}

# 运行主函数
main "$@"
