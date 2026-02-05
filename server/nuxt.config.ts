import path from 'path';

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: false },
  css: [
    '~/assets/css/main.css',
    '@unocss/reset/tailwind-compat.css',
    'element-plus/dist/index.css',
    'element-plus/theme-chalk/display.css'
  ],
  modules: [
    '@element-plus/nuxt',
    '@unocss/nuxt',
    'dayjs-nuxt',
    '@nuxtjs/sitemap',
    '@nuxt/image',
    '@nuxtjs/i18n',
    'nuxt-api-shield'
  ],
  nuxtApiShield: {
    limit: {
      max: 120,
      duration: 60, // seconds
      ban: 60 * 15 // 15 分钟
    },
    routes: ['/api/public'],
    delayOnBan: true,
    errorMessage: 'Too Many Requests',
    retryAfterHeader: false,
    log: {
      path: 'logs', // Logging is disabled if path is empty
      attempts: 100 // Logging per IP is disabled if attempts is 0
    },
    ipTTL: 7 * 24 * 60 * 60, // 7 days in seconds
    security: {
      trustXForwardedFor: true
    }
  },
  site: {
    url: process.env.SERVER_HOST || 'http://localhost:3000',
    name: 'name'
  },
  sitemap: {
    exclude: [],
    defaultSitemapsChunkSize: 1000,
    autoLastmod: true
  },
  image: {
    format: ['webp']
  },
  i18n: {
    locales: [
      { code: 'zh', name: '简体中文' },
      { code: 'en', name: 'English' },
      { code: 'ja', name: '日本語' }
    ],
    strategy: 'prefix_and_default',
    defaultLocale: 'zh',
    detectBrowserLanguage: {
      useCookie: true,
      cookieKey: 'i18n_redirected',
      redirectOn: 'root'
    },
    langDir: null
  },
  vite: {
    // css: {
    //   preprocessorOptions: {
    //     scss: {
    //       api: "modern-compiler", // 修复 Deprecation Warning: The legacy JS API is deprecated and will be removed in Dart Sass 2.0.0.
    //     },
    //   },
    // },
    optimizeDeps: {
      include: ['eastasianwidth']
    },
    build: {
      rollupOptions: {
        external: [],
        output: {
          globals: {}
        }
      }
    },
    resolve: {
      alias: {
        // 为 eastasianwidth 创建一个 ESM 包装器
        eastasianwidth: path.resolve(__dirname, './lib/eastasianwidth.mjs')
      }
    }
  },
  app: {
    head: {
      htmlAttrs: {
        lang: 'en'
      },
      meta: [{ charset: 'utf-8' }, { name: 'viewport', content: 'width=device-width, initial-scale=1' }],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.png' },
        { rel: 'preconnect', href: 'https://rsms.me/' },
        { rel: 'stylesheet', href: 'https://rsms.me/inter/inter.css' }
      ]
    }
  },
  nitro: {
    esbuild: {
      options: {
        target: 'esnext'
      }
    },
    storage: {
      // redis连接配置
      redis: {
        driver: 'redis',
        port: process.env.REDIS_PORT || 6379, // Redis port
        host: process.env.REDIS_HOST || '127.0.0.1', // Redis host
        username: process.env.REDIS_USERNAME || '', // needs Redis >= 6
        password: process.env.REDIS_PASSWORD || '',
        db: process.env.REDIS_DB || 0, // Defaults to 0
        ttl: 60 * 60 * 24
      },
      // 限制频繁请求挂载点：https://nuxt.com/modules/api-shield
      shield: {
        driver: 'redis',
        host: process.env.REDIS_HOST || '127.0.0.1',
        port: process.env.REDIS_PORT || 6379
      }
    },
    experimental: {
      tasks: true
    },
    scheduledTasks: {
      '*/15 * * * *': ['shield:cleanBans'],
      '0 0 * * *': ['shield:cleanIpData']
    },
    // 注意生产环境需要配置nginx代理，详见nginx.conf
    publicAssets: [
      {
        dir: path.resolve(__dirname, 'files/uploads'),
        baseURL: '/uploads'
      }
    ]
  },
  runtimeConfig: {
    public: {
      // 网页端域名
      serverHost: process.env.SERVER_HOST || 'http://localhost:3000'
    },
    mysql: {
      host: process.env.DATABASE_HOST,
      port: Number(process.env.DATABASE_PORT) || 3306,
      user: process.env.DATABASE_USERNAME,
      password: process.env.DATABASE_PASSWORD,
      database: process.env.DATABASE_DB
    },
    // jwt加密
    jwt: {
      secret: process.env.JWT_SECRET || 'node_forge_cms'
    },
    // 上传文件保存路径
    uploadPath: '/uploads',
    // 服务器域名 用户支付回调， 邮件等信息
    serverHost: process.env.SERVER_HOST || 'http://localhost:3000',
    // 上传图片访问host
    imgHost: process.env.IMG_HOST || 'http://localhost:3000'
  }
});
