# Cookie Consent 使用指南

## 概述

本项目已集成符合 GDPR (欧盟《通用数据保护条例》) 的 Cookie 同意管理系统。系统会根据用户的选择来启用/禁用追踪脚本（如 Google Analytics）。

## 工作原理

```
用户首次访问 → 显示 Cookie 横幅 → 用户做出选择
                                    ↓
                      保存选择到 localStorage
                                    ↓
                 根据选择加载/禁用追踪脚本
                                    ↓
                        用户可随时通过右下角按钮修改设置
```

## 已创建的文件

### 1. 组件文件

- `app/components/CookieConsent.vue` - Cookie 同意横幅和设置模态框

### 2. Composables

- `app/composables/useCookieConsent.ts` - Cookie 偏好管理
- `app/composables/useGoogleAnalytics.ts` - Google Analytics 集成（可选使用）
- `app/composables/useTrackingScripts.ts` - 第三方脚本统一管理

### 3. 多语言翻译

- `i18n/locales/en.json`
- `i18n/locales/zh.json`
- `i18n/locales/tw.json`
- `i18n/locales/ja.json`
- `i18n/locales/ko.json`

## 配置说明

### 在 `nuxt.config.ts` 中配置追踪工具 ID

```typescript
runtimeConfig: {
  public: {
    // Google Analytics (已配置为你的 GA4 ID)
    gaMeasurementId: 'G-BQQ92E8CEX',

    // Google Tag Manager (可选)
    gtmContainerId: '',

    // Facebook Pixel (可选)
    fbPixelId: 'XXXXXXXXXXXXXXXX',
  },
}
```

## Cookie 类型

| 类型               | 说明                   | 示例             |
| ------------------ | ---------------------- | ---------------- |
| 必要 (Necessary)   | 网站运行必需，无法禁用 | 会话、语言偏好   |
| 分析 (Analytics)   | 用于分析网站使用情况   | Google Analytics |
| 营销 (Marketing)   | 用于展示相关广告       | Facebook Pixel   |
| 偏好 (Preferences) | 记住用户设置           | 主题、语言       |

## 如何使用

### 方式一：自动管理（推荐）

系统会自动根据用户选择加载/禁用追踪脚本，无需额外代码。

### 方式二：在组件中检查用户同意

```vue
<script setup>
  import { useCookieConsent } from '~/composables/useCookieConsent';

  const { analyticsAllowed, marketingAllowed } = useCookieConsent();

  // 仅在用户同意时执行某些操作
  watchEffect(() => {
    if (analyticsAllowed.value) {
      // 用户已同意分析 Cookie
      console.log('Analytics is enabled');
    }
  });
</script>
```

### 方式三：使用 Google Analytics Composable

```vue
<script setup>
  import { useGoogleAnalytics } from '~/composables/useGoogleAnalytics';

  const { init, trackPageView, trackEvent } = useGoogleAnalytics();

  // 在应用启动时初始化
  onMounted(() => {
    init();
  });

  // 追踪页面浏览
  // trackPageView('/some-page');

  // 追踪事件
  // trackEvent('button_click', { button_name: 'signup' });
</script>
```

## 测试

### 1. 测试首次访问

1. 清除浏览器 localStorage 和 cookies
2. 刷新页面
3. 应该看到底部横幅

### 2. 测试"拒绝全部"

1. 点击"拒绝全部"
2. 打开浏览器开发者工具 → Application → Cookies
3. 不应该看到 `_ga`、`_gid` 等 GA cookies

### 3. 测试"接受全部"

1. 点击"接受全部"
2. 检查 Network 面板，应该看到 GA 脚本被加载
3. 检查 Cookies，应该看到 `_ga`、`_gid`

### 4. 测试修改设置

1. 点击右下角的设置按钮
2. 修改某些选项
3. 保存后检查相应的脚本是否被启用/禁用

## 常见问题

### Q: 如何添加其他追踪工具？

编辑 `app/composables/useTrackingScripts.ts`，在 `applyTracking` 函数中添加：

```typescript
if (preferences.marketing) {
  loadYourTrackingTool();
} else {
  disableYourTrackingTool();
}
```

### Q: 在开发环境中如何禁用 Cookie 横幅？

在 `nuxt.config.ts` 中添加环境变量：

```typescript
runtimeConfig: {
  public: {
    disableCookieBanner: process.env.NODE_ENV === 'development',
  },
}
```

然后在 `CookieConsent.vue` 中检查此配置。

### Q: 如何查看用户当前的选择？

```javascript
const preferences = JSON.parse(localStorage.getItem('cookie_conent_preferences'));
console.log(preferences);
// { necessary: true, analytics: true, marketing: false, preferences: false }
```

## GDPR 合规要点

1. **默认拒绝**: 非必要 Cookie 默认未勾选
2. **明确同意**: 用户必须主动点击接受
3. **随时撤回**: 用户可随时通过设置按钮修改
4. **细粒度控制**: 用户可选择不同类型的 Cookie
5. **持久化**: 选择保存在 localStorage 中

## 环境变量

如果需要在不同环境使用不同的追踪 ID，可以在 `.env` 文件中配置：

```bash
# .env
NUXT_PUBLIC_GA_MEASUREMENT_ID=G-BQQ92E8CEX
NUXT_PUBLIC_GTM_CONTAINER_ID=
NUXT_PUBLIC_FB_PIXEL_ID=XXXXXXXXXXXXXXXX
```

## 支持

如有问题，请查看：

- [GDPR 官方指南](https://gdpr-info.eu/)
- [Google Analytics Consent Mode](https://developers.google.com/tag-platform/security/guides/consent)
