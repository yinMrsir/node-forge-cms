#!/bin/bash

# ========== 关键：手动加载 NVM 环境 ==========
# 1. 定义 NVM 安装路径（Mac 默认路径，Linux 若不同需调整）
NVM_DIR="$HOME/.nvm"
# 2. 加载 NVM 核心脚本
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

git pull
nvm use 20.19.3
yarn build_pro
pm2 start pm2.config.cjs
