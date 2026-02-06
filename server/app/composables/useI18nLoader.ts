export async function useI18nLoader() {
  const nuxtApp = useNuxtApp();
  const locale = nuxtApp.$i18n.locale.value;

  // 全局翻译存储
  const languages = useState<Map<string, any>>('i18n-translations', () => new Map());

  // 全局加载状态，防止重复请求
  const loadingLocales = useState<Set<string>>('i18n-loading-locales', () => new Set());

  // 标记是否已设置监听器（全局只设置一次）
  const isWatcherSetup = useState<boolean>('i18n-watcher-setup', () => false);

  // 加载指定语言的翻译
  const loadLocale = async (loc: string) => {
    // 如果已加载或正在加载，直接返回
    if (languages.value.has(loc) || loadingLocales.value.has(loc)) {
      return languages.value.get(loc) || {};
    }

    // 标记为正在加载
    loadingLocales.value.add(loc);

    try {
      const response: any = await $fetch('/api/public/i18n/locale/' + loc);
      const data = response?.code === 200 && response?.data ? response.data : {};
      languages.value.set(loc, data);
      return data;
    } catch (error) {
      console.error(`Failed to load locale "${loc}":`, error);
      languages.value.set(loc, {});
      return {};
    } finally {
      // 加载完成后移除标记
      loadingLocales.value.delete(loc);
    }
  };

  // 初始化当前语言的翻译
  await loadLocale(locale);

  // 全局只设置一次监听器
  if (!isWatcherSetup.value) {
    isWatcherSetup.value = true;

    // 监听语言变化，自动加载新语言的翻译
    watch(
      () => nuxtApp.$i18n.locale.value,
      async newLocale => {
        if (!languages.value.has(newLocale) && !loadingLocales.value.has(newLocale)) {
          await loadLocale(newLocale);
        }
      }
    );
  }

  // 响应式的 t 函数
  const t = (key: string, options?: any) => {
    const currentLocale = nuxtApp.$i18n.locale.value;
    const translations = languages.value.get(currentLocale) || {};

    // 支持点号分隔的嵌套 key，如 'nav.home'
    const keys = key.split('.');
    let value: any = translations;

    for (const k of keys) {
      if (value && typeof value === 'object' && k in value) {
        value = value[k];
      } else {
        return key; // 找不到对应 key，返回原始 key
      }
    }

    options &&
      typeof options === 'object' &&
      Object.keys(options).forEach(key => {
        value = value.replaceAll(`{${key}}`, options[key]);
      });

    return value;
  };

  return {
    t
  };
}
