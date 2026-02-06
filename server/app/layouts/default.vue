<template>
  <div class="min-h-screen flex flex-col bg-gray-50">
    <NuxtLoadingIndicator :height="2" />
    <el-backtop :right="20" :bottom="70" />

    <!-- 悬浮 AI 搜索按钮 -->
    <ClientOnly>
      <nuxt-link
        v-if="!isAISearchPage"
        :to="localePath('/ai-search')"
        class="fixed right-6 bottom-40 z-50 flex items-center justify-center w-10 h-10 bg-gradient-to-r from-primary to-primary-dark text-white rounded-full shadow-lg hover:shadow-xl hover:scale-110 transition-all duration-300 group"
        :title="t('common.aiSearch') || 'AI 智能搜索'"
      >
        <!-- AI 图标 -->
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-7 w-7 group-hover:rotate-12 transition-transform duration-300"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
        </svg>
        <!-- 脉冲动画效果 -->
        <span class="absolute inline-flex h-full w-full rounded-full bg-primary opacity-20 animate-ping"></span>
      </nuxt-link>
    </ClientOnly>
    <!-- 顶部导航栏 -->
    <header
      class="sticky top-0 z-50 bg-white shadow-sm transition-all duration-300"
      :class="{ 'shadow-md': isScrolled }"
    >
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16 md:h-20">
          <!-- 品牌 Logo -->
          <div class="flex items-center">
            <nuxt-link :to="localePath('/')" class="flex items-center">
              <div
                class="w-10 h-10 bg-primary rounded-md flex items-center justify-center text-white font-bold text-xl"
              >
                N
              </div>
              <span class="ml-2 text-xl font-semibold text-gray-800">NodeForge</span>
            </nuxt-link>
          </div>

          <!-- 桌面端导航 -->
          <nav class="hidden md:flex space-x-8">
            <nuxt-link :to="localePath('/')">{{ t('nav.home') }}</nuxt-link>
            <nuxt-link v-for="item in categoryList" :key="item.categoryId" :to="categoryLink(item.categoryMpath)">
              {{ item.categoryName?.[locale] || item.categoryName?.zh }}
            </nuxt-link>
          </nav>

          <!-- 语言切换 -->
          <div class="hidden md:flex items-center space-x-4">
            <div class="relative language-menu">
              <button
                class="bg-transparent flex items-center space-x-1 text-gray-600 hover:text-primary transition-colors"
                @click="showLanguageMenu = !showLanguageMenu"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-5 w-5"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M3 5h12M9 3v2m1.048 9.5A18.022 18.022 0 016.412 9m6.088 9h7M11 21l5-10 5 10M12.751 5C11.783 10.77 8.07 15.61 3 18.129"
                  />
                </svg>
                <span class="text-sm font-medium">{{ currentLanguage }}</span>
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-4 w-4"
                  :class="{ 'rotate-180': showLanguageMenu }"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                </svg>
              </button>
              <div
                v-if="showLanguageMenu"
                class="absolute right-0 mt-2 w-32 bg-white rounded-md shadow-lg py-1 z-50 max-h-100 overflow-y-auto"
              >
                <button
                  v-for="lang in localesData"
                  :key="lang.localeCode"
                  class="bg-transparent block w-full text-left px-4 py-2 text-sm hover:bg-gray-100"
                  :class="{ 'bg-primary/10 text-primary': lang.localeCode === locale }"
                  @click="switchLanguage(lang.localeCode)"
                >
                  {{ lang.localeName }}
                </button>
              </div>
            </div>
          </div>

          <!-- 移动端菜单按钮 -->
          <div class="md:hidden">
            <button class="p-2 rounded-md text-gray-600 hover:bg-gray-100" @click="mobileMenuOpen = !mobileMenuOpen">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            </button>
          </div>
        </div>
      </div>

      <!-- 移动端导航菜单 -->
      <div v-if="mobileMenuOpen" class="md:hidden bg-white border-t shadow-lg">
        <div class="container flex flex-col gap-4 px-4 py-3">
          <nuxt-link :to="localePath('/')" @click="mobileMenuOpen = false">{{ t('nav.home') }}</nuxt-link>
          <nuxt-link v-for="item in categoryList" :key="item.categoryId" :to="categoryLink(item.categoryMpath)">
            {{ item.categoryName?.[locale] || item.categoryName?.zh }}
          </nuxt-link>
          <!-- 移动端语言切换 -->
          <div class="border-t pt-3">
            <div class="text-sm text-gray-500 mb-2">{{ t('nav.language') }}</div>
            <div class="flex gap-3 flex-wrap">
              <button
                v-for="lang in localesData"
                :key="lang.localeCode"
                class="px-3 py-1 text-sm rounded-md transition-colors"
                :class="
                  lang.localeCode === locale ? 'bg-primary text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                "
                @click="switchLanguage(lang.localeCode)"
              >
                {{ lang.localeName }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </header>

    <slot />

    <!-- 页脚 -->
    <footer class="bg-gray-800 text-white py-12">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          <!-- 公司信息 -->
          <div>
            <h3 class="text-lg font-semibold mb-4">NodeForge</h3>
            <p class="text-gray-400 mb-4">{{ t('footer.description') }}</p>
            <div class="flex space-x-4">
              <a href="#" class="text-gray-400 hover:text-white transition-colors">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="currentColor" viewBox="0 0 24 24">
                  <path
                    d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"
                  />
                </svg>
              </a>
              <a href="#" class="text-gray-400 hover:text-white transition-colors">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="currentColor" viewBox="0 0 24 24">
                  <path
                    d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"
                  />
                </svg>
              </a>
              <a href="#" class="text-gray-400 hover:text-white transition-colors">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="currentColor" viewBox="0 0 24 24">
                  <path
                    d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"
                  />
                </svg>
              </a>
            </div>
          </div>

          <!-- 快速链接 -->
          <div>
            <h3 class="text-lg font-semibold mb-4">{{ t('footer.quickLinks') }}</h3>
            <ul class="space-y-2">
              <li>
                <nuxt-link :to="localePath('/')" class="text-gray-400 hover:text-white transition-colors">{{
                  t('nav.home')
                }}</nuxt-link>
              </li>
              <li v-for="item in categoryList" :key="item.categoryId">
                <nuxt-link
                  :to="categoryLink(item.categoryMpath)"
                  class="text-gray-400 hover:text-white transition-colors"
                >
                  {{ item.categoryName?.[locale] || item.categoryName?.zh }}
                </nuxt-link>
              </li>
            </ul>
          </div>

          <!-- 热门栏目 -->
          <div>
            <h3 class="text-lg font-semibold mb-4">{{ t('footer.hotCategories') }}</h3>
            <ul class="space-y-2">
              <li v-for="item in recommendCategoryList" :key="item.categoryId">
                <nuxt-link
                  :to="categoryLink(item.categoryMpath)"
                  class="text-gray-400 hover:text-white transition-colors"
                >
                  {{ item.categoryName?.[locale] || item.categoryName?.zh }}
                </nuxt-link>
              </li>
            </ul>
          </div>

          <!-- 联系我们 -->
          <div>
            <h3 class="text-lg font-semibold mb-4">{{ t('footer.contactUs') }}</h3>
            <ul class="space-y-2 text-gray-400">
              <li class="flex items-center">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-5 w-5 mr-2"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"
                  />
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"
                  />
                </svg>
                {{ t('footer.address') }}
              </li>
              <li class="flex items-center">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-5 w-5 mr-2"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"
                  />
                </svg>
                {{ t('footer.phone') }}
              </li>
              <li class="flex items-center">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-5 w-5 mr-2"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
                  />
                </svg>
                contact@nodeforge.com
              </li>
            </ul>
          </div>
        </div>

        <div class="border-t border-gray-700 mt-8 pt-8 text-center text-gray-400">
          <p>{{ t('footer.copyright') }}</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
  const { locale, setLocale } = useI18n();
  const localePath = useLocalePath();
  const route = useRoute();

  const mobileMenuOpen = ref(false);
  const isScrolled = ref(false);
  const showLanguageMenu = ref(false);

  // 判断当前是否为 AI 搜索页面
  const isAISearchPage = computed(() => {
    return route.path === '/ai-search' || route.path === '/zh/ai-search' || route.path.endsWith('/ai-search');
  });

  // 切换语言
  const switchLanguage = langCode => {
    setLocale(langCode);
    showLanguageMenu.value = false;
  };

  const [{ t }, { data: categoryList }, { data: recommendCategoryList }, { data: localesData }] = await Promise.all([
    useI18nLoader(),
    useFetch('/api/public/cms/category/list', {
      query: {
        parentCategoryId: 0,
        status: '1'
      },
      getCachedData: key => localCacheData(key)
    }),
    useFetch('/api/public/cms/category/list', {
      query: {
        isRecommend: '1',
        status: '1'
      },
      getCachedData: key => localCacheData(key)
    }),
    useFetch('/api/public/i18n/list', {
      getCachedData: key => localCacheData(key)
    })
  ]);

  // 当前语言名称
  const currentLanguage = computed(() => {
    return localesData.value?.find(lang => lang.code === locale.value)?.name || 'Language';
  });

  function categoryLink(categoryMpath) {
    let categoryUrl = '';
    categoryMpath.forEach(item => {
      categoryUrl += `/${item.urlKey}`;
    });
    return localePath(`${categoryUrl}`);
  }

  // 点击外部关闭语言菜单
  onMounted(() => {
    const handleClickOutside = event => {
      if (!event.target.closest('.language-menu')) {
        showLanguageMenu.value = false;
      }
    };
    document.addEventListener('click', handleClickOutside);
    onUnmounted(() => {
      document.removeEventListener('click', handleClickOutside);
    });
  });

  // 监听滚动事件，控制导航栏样式
  const handleScroll = () => {
    isScrolled.value = window.scrollY > 50;
  };

  // 生命周期
  onMounted(() => {
    window.addEventListener('scroll', handleScroll);
    handleScroll(); // 初始化
  });

  onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll);
  });
</script>

<style scoped></style>
