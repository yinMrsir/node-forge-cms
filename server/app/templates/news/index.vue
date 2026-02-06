<template>
  <div>
    <!-- 面包屑 -->
    <div class="bg-white border-b border-gray-200 py-4">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <nav class="flex text-sm" aria-label="Breadcrumb">
          <ol class="flex items-center space-x-2">
            <li>
              <nuxt-link :to="localePath('/')" class="text-gray-600 hover:text-primary">{{
                t('common.home')
              }}</nuxt-link>
            </li>
            <li v-for="value in category.categoryMpath" :key="value.categoryId" class="flex items-center">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-4 w-4 text-gray-400"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
              </svg>
              <nuxt-link
                v-if="value.categoryId !== categoryId"
                :to="localePath(`/${value.urlKey}`)"
                class="ml-2 text-gray-600 hover:text-primary"
              >
                {{ value.categoryName[locale] ?? value.categoryName['zh'] }}
              </nuxt-link>
              <span v-else class="ml-2 text-primary">
                {{ value.categoryName[locale] ?? value.categoryName['zh'] }}
              </span>
            </li>
          </ol>
        </nav>
      </div>
    </div>

    <!-- 主内容 -->
    <main class="flex-grow py-12">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <!-- 搜索+筛选 -->
        <div class="mb-8 flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
          <div class="flex items-center bg-white rounded-md shadow-sm w-full md:w-auto">
            <el-button
              type="primary"
              size="large"
              plain
              class="text-white rounded-md hover:bg-primary/90 transition-colors flex items-center"
              @click="handleSearch"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-5 w-5 mr-2"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
              </svg>
              {{ t('common.aiSearch') || 'AI 智能搜索' }}
            </el-button>
          </div>
          <div class="flex flex-wrap gap-2">
            <nuxt-link
              v-for="cate in newsCates"
              :key="cate.categoryId"
              :to="categoryLink(cate.categoryMpath)"
              class="px-4 py-2 rounded-md transition-colors bg-gray-100 text-gray-700 hover:bg-gray-200"
            >
              {{ cate.categoryName?.[locale] ?? cate.categoryName?.['zh'] }}
            </nuxt-link>
          </div>
        </div>

        <!-- 新闻列表 -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
          <nuxt-link
            v-for="news in newsData?.rows || []"
            :key="news.newsId"
            class="bg-white rounded-lg overflow-hidden shadow-sm hover:shadow-lg transition-all duration-300 cursor-pointer"
            :to="newsLink(news)"
          >
            <nuxt-img
              format="webp"
              loading="lazy"
              :src="news.coverImage || ''"
              alt="news.title"
              class="w-full h-48 object-cover"
            />
            <div class="p-6">
              <div class="flex items-center text-xs text-gray-500 mb-2">
                <span>{{ news.category?.categoryName?.[locale] ?? news.category?.categoryName?.zh }}</span>
                <span class="mx-2">|</span>
                <span>{{ news.publishTime }}</span>
              </div>
              <h3 class="text-lg font-semibold text-gray-800 mb-3 line-clamp-2">
                {{ news.title?.[locale] ?? news.title?.zh }}
              </h3>
              <p class="text-gray-600 text-sm line-clamp-3">{{ news.summary?.[locale] ?? news.summary?.zh }}</p>
            </div>
          </nuxt-link>

          <!-- 空数据占位 -->
          <div v-if="newsData?.rows.length === 0" class="col-span-full text-center py-12">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-16 w-16 text-gray-300 mx-auto mb-4"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"
              />
            </svg>
            <p class="text-gray-500">{{ t('common.noNews') }}</p>
          </div>
        </div>

        <!-- 分页 -->
        <div class="mt-12 flex justify-center">
          <nav class="flex items-center space-x-2">
            <nuxt-link
              v-if="currentPage > 1"
              :to="buildPageLink(currentPage - 1)"
              class="px-3 py-1 rounded-md border border-gray-300 text-gray-700 hover:bg-primary hover:text-white hover:border-primary transition-colors"
            >
              {{ t('common.prevPage') }}
            </nuxt-link>
            <span v-else class="px-3 py-1 rounded-md border border-gray-300 text-gray-400 cursor-not-allowed">
              {{ t('common.prevPage') }}
            </span>

            <nuxt-link
              v-for="page in totalPages"
              :key="page"
              :to="buildPageLink(page)"
              :class="[
                'px-3 py-1 rounded-md min-w-8 text-center',
                currentPage === page
                  ? 'bg-primary text-white cursor-default'
                  : 'border border-gray-300 text-gray-700 hover:bg-primary/10'
              ]"
            >
              {{ page }}
            </nuxt-link>

            <nuxt-link
              v-if="currentPage < totalPages"
              :to="buildPageLink(currentPage + 1)"
              class="px-3 py-1 rounded-md border border-gray-300 text-gray-700 hover:bg-primary hover:text-white hover:border-primary transition-colors"
            >
              {{ t('common.nextPage') }}
            </nuxt-link>
            <span v-else class="px-3 py-1 rounded-md border border-gray-300 text-gray-400 cursor-not-allowed">
              {{ t('common.nextPage') }}
            </span>
          </nav>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
  // 接收动态路由传递的参数
  const props = defineProps<{
    category?: any;
    urlKey?: string;
  }>();

  const route = useRoute();
  const router = useRouter();
  const { locale } = useI18n();
  const localePath = useLocalePath();

  // 根据是否有动态路由参数确定分类ID
  const categoryId = props.category?.categoryId || undefined;
  const categoryName = props.category?.categoryName?.[locale.value] || props.category?.categoryName?.zh;
  const desciprtion = props.category?.description?.[locale.value] || props.category?.description?.zh;
  const keywords = props.category?.keywords?.[locale.value] || props.category?.keywords?.zh;

  // 搜索&筛选参数
  const searchKey = ref('');
  // 分页参数
  const pageSize = 8;
  const currentPage = computed(() => Number(route.query.page) || 1);

  // 产品分类
  const [{ t }, { data: newsCates }, { data: newsData }]: any = await Promise.all([
    useI18nLoader(),
    useFetch('/api/public/cms/category/list', {
      query: {
        parentCategoryId: categoryId,
        status: '1'
      },
      getCachedData: key => localCacheData(key)
    }),
    useFetch('/api/public/cms/news/list', {
      query: {
        categoryId,
        limit: pageSize,
        pageNum: currentPage
      },
      getCachedData: key => localCacheData(key)
    })
  ]);
  const totalPages = ref(Math.ceil((newsData.value?.total || 0) / pageSize));

  function newsLink(news: any) {
    let categoryUrl = '';
    news.categoryMpath.forEach((item: any) => {
      categoryUrl += `/${item.urlKey}`;
    });
    return localePath(`${categoryUrl}/${news.newsId}`);
  }

  function categoryLink(categoryMpath: any[]) {
    let categoryUrl = '';
    categoryMpath.forEach((item: any) => {
      categoryUrl += `/${item.urlKey}`;
    });
    return localePath(`${categoryUrl}`);
  }

  // 构建分页链接
  function buildPageLink(page: number) {
    const query = { ...route.query, page: page.toString() };
    return localePath({ path: route.path, query });
  }

  // 搜索事件
  const handleSearch = () => {
    router.push(localePath({ path: '/search' }));
  };

  useHead({
    title: pageTitle(categoryName),
    meta: [
      { name: 'description', content: desciprtion },
      { name: 'keywords', content: keywords }
    ]
  });
</script>
