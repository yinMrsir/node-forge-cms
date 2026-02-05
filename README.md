# NodeForgeCMS

NodeForgeCMS 是基于 **Nuxt4 + Node.js + MySQL** 打造的现代化企业级内容管理系统，聚焦企业官网、产品展示、内容门户、多语言站群核心场景，融合现代前端工程化架构与轻量化运营体验，兼顾**灵活的栏目管理、高规格SEO优化、全链路多语言、高效二次开发**能力，既让非技术人员能便捷管理内容与栏目，又为开发者提供现代化、高扩展性的技术架构，完美替代传统老旧CMS。

## 核心优势

1. **灵活栏目管理，动态路径按需配置**

   支持后台自定义栏目分类、配置专属访问路径（urlkey），栏目与页面逻辑解耦，新增、修改栏目无需调整前端代码，一键生效，快速适配企业业务板块迭代。

2. **Nuxt4原生架构，SEO与访问体验双优**

   基于Nuxt4实现SSR/SSG双渲染模式，服务端渲染保障搜索引擎抓取友好，静态预渲染实现页面秒开，从底层解决传统CMS前端老旧、加载慢、SEO差的核心痛点。

3. **全链路多语言支持，一站覆盖海内外**

   内置多语言字段存储、多语言动态路由、内容按语言隔离管理，无需多站部署，一套系统即可搭建国内官网与海外多语言站点，降低跨境运营成本。

4. **前后端解耦，生产级稳定与易迭代**

   采用前后端分离架构，后台管理与前端展示相互独立，功能迭代、样式更新不影响线上业务；内置数据校验、接口防护机制，保障系统安全稳定运行。

5. **低门槛运营，高自由度开发**

   后台可视化管理内容、栏目、权限，非技术人员可快速上手；全栈现代化技术栈，模块化架构设计，支持开发者高效二次开发与功能定制，兼顾运营与开发效率。

## 技术亮点

- 核心技术栈：**Nuxt4 + Nitro + Vue3 + TypeScript + MySQL**，全栈类型安全、生态完善、开发效率高
- 渲染能力：SSR/SSG/CSR自由切换，适配不同场景的SEO与部署需求，首屏加载速度拉满
- 路由机制：文件系统路由+动态路由重写，支持栏目自定义访问路径，灵活适配各类业务路径规划
- 多语言架构：多语言字段设计+国际化路由，原生支持多语言内容管理与访问，无需额外开发
- 部署友好：支持静态打包、Node服务部署、容器化部署，适配常规服务器、云平台等各类部署环境
- 扩展特性：模块化设计+完善权限系统+开放API，支持插件开发、功能定制与业务系统无缝集成

## 在线体验(网络带宽有限，请耐心等待 🍵)

- [用户端演示地址](http://node-forge.yinchunyu.com)
- [管理端演示地址](http://node-forge.yinchunyu.com/admin/)
- 源码地址 1: [GitHub](https://github.com/yinMrsir/node-forge-cms)
- 源码地址 2: [Gitee](https://gitee.com/yinMrsir/node-forge-cms)

## 使用前

如未安装`node`，`mysql`数据库和`redis`请先自行安装。node20.x，mysql8.x，redis7。

**mysql**和**redis**配置你可以到`server/nuxt.config.ts`进行配置。你也可以创建一个`server/.env`文件

```dotenv
DATABASE_USERNAME=root
DATABASE_PASSWORD=123456
DATABASE_HOST=127.0.0.1
DATABASE_PORT=3306
DATABASE_DB=node_forge_cms

JWT_SECRET=node_forge

REDIS_HOST=127.0.0.1
REDIS_PORT=6379
REDIS_USERNAME=
REDIS_PASSWORD=
REDIS_DB=0

SERVER_HOST=http://127.0.0.1:3000
IMG_HOST=http://127.0.0.1:3000
```

**注意：** `mysql`和`redis`的端口号，用户名，密码，数据库名称，jwt 加密密钥等配置信息，请自行修改。

## 数据库初始化

1. 先到数据库目录下，创建数据库`node_forge_cms`
2. 导入数据库文件`server/node_forge_cms.sql`

## 本地开发

### 服务端和用户端同时启动

```shell
cd server
pnpm install
pnpm dev
```

启动成功后，请访问：http://localhost:3000

### 管理端启动

```shell
cd admin
pnpm install
pnpm dev
```

启动成功后，请访问：http://localhost:4000, 用户名：admin，密码：admin123

## 部署

### 构建管理端

执行以下命令会生成`dist`目录，可通过`nginx`指定到目录。

```shell
cd admin
pnpm isntall
pnpm build:prod
```

### 构建服务端和用户端

```shell
cd server
pnpm isntall
pnpm build
```

构建完成后，可通过 pm2 进行部署，未安装的可执行`npm install -g pm2`安装

执行以下命令启动服务：

```shell
cd server && pm2 start pm2.config.cjs
```

nginx 配置如下：

```nginx configuration
server {
    listen 80;
    server_name your.domain.com;

    location / {
        proxy_pass http://127.0.0.1:3000/;
    }
    location /uploads {
        alias /path/to/NodeForgeCMS/server/uploads;
    }
}

server {
    listen 80;
    server_name your-admin.domain.com;

    location / {
        root  /path/to/NodeForgeCMS/admin/dist;
        index index.html;
        try_files $uri $uri/ /index.html;
    }

    location /api/ {
        proxy_pass http://127.0.0.1:3000/api/;
    }
}
```

Nuxt 项目部署文档：https://nuxt.com/docs/getting-started/deployment
