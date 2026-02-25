# 多阶段构建 - 首先构建 admin 前端
FROM node:20.19.3-alpine AS admin-builder

WORKDIR /app

# 安装 pnpm
RUN npm install -g pnpm@latest

# 复制 admin 项目文件
COPY admin/package.json admin/pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile

COPY admin/ ./
RUN pnpm build:prod

# 多阶段构建 - 构建 server 后端
FROM node:20.19.3-alpine AS server-builder

WORKDIR /app

# 安装 pnpm
RUN npm install -g pnpm@latest

# 复制 server 项目文件
COPY server/package.json server/pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile

COPY server/ ./

# 复制 admin 构建产物到 server
COPY --from=admin-builder /app/dist ./public/admin

# 构建生产环境
ENV NUXT_PUBLIC_BUILD_BASE=/app
RUN pnpm build

# 最终运行镜像
FROM node:20.19.3-alpine

# 安装必要的系统依赖
RUN apk add --no-cache \
    curl \
    dumb-init

WORKDIR /app

# 安装 pnpm
RUN npm install -g pnpm@latest

# 创建非 root 用户
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# 复制构建产物
COPY --from=server-builder /app/.output ./
COPY --from=server-builder /app/package.json ./
COPY --from=server-builder /app/node_modules ./node_modules

# 创建上传目录
RUN mkdir -p /app/files/uploads && \
    chown -R nodejs:nodejs /app

# 切换到非 root 用户
USER nodejs

# 暴露端口
EXPOSE 3000

# 使用 dumb-init 启动
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "server/index.mjs"]
