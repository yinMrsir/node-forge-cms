<template>
  <div class="flex flex-col">
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
            <li v-for="category in newsDetail?.categoryMpath" :key="category.categoryId" class="flex items-center">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-4 w-4 text-gray-400"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
              </svg>
              <nuxt-link :to="categoryUrl(category)" class="ml-2 text-gray-600 hover:text-primary">
                {{ category?.categoryName?.[locale] || category?.categoryName?.zh }}
              </nuxt-link>
            </li>
            <li class="flex items-center">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-4 w-4 text-gray-400"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
              </svg>
              <span class="ml-2 text-primary">{{ newsDetail?.title?.[locale] ?? newsDetail?.title?.zh }}</span>
            </li>
          </ol>
        </nav>
      </div>
    </div>

    <!-- 主内容 -->
    <main class="flex-grow py-12">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-sm p-6 md:p-8 lg:p-10">
          <!-- 新闻标题&发布信息 -->
          <div class="text-center mb-8">
            <h1 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-gray-800 mb-4">
              {{ newsTitle }}
            </h1>
            <div class="flex items-center justify-center text-gray-500 text-sm space-x-4">
              <span>
                {{ t('news.detail.category') }}：{{
                  newsDetail.category.categoryName?.[locale] ?? newsDetail?.category.categoryName?.zh
                }}
              </span>
              <span>{{ t('news.detail.publishTime') }}：{{ newsDetail.publishTime }}</span>
              <span>{{ t('news.detail.viewCount') }}：{{ newsDetail.viewCount }}</span>
            </div>
          </div>

          <!-- 新闻富文本内容（v-html渲染后台富文本） -->
          <div
            class="prose prose-lg max-w-none prose-img:rounded-lg prose-p:leading-relaxed prose-h2:mt-8 prose-h2:mb-4 prose-h2:text-2xl prose-h3:mt-6 prose-h3:mb-3 prose-h3:text-xl"
          >
            <div class="editor-html" v-html="newsDetail.content?.[locale] ?? newsDetail?.content?.zh"></div>
          </div>

          <!-- 上一篇/下一篇 -->
          <div class="mt-12 border-t border-gray-200 pt-6 flex flex-col md:flex-row justify-between gap-4">
            <div v-if="prevNews" class="flex-1">
              <p class="text-sm text-gray-500 mb-1">{{ t('news.detail.prev') }}</p>
              <nuxt-link
                :to="newsLink(prevNews)"
                class="text-gray-800 hover:text-primary transition-colors line-clamp-1"
              >
                {{ getLocalizedTitle(prevNews.title) }}
              </nuxt-link>
            </div>
            <div v-else class="flex-1 text-gray-400">{{ t('news.detail.prevEmpty') }}</div>
            <div v-if="nextNews" class="flex-1 text-right">
              <p class="text-sm text-gray-500 mb-1">{{ t('news.detail.next') }}</p>
              <nuxt-link
                :to="newsLink(nextNews)"
                class="text-gray-800 hover:text-primary transition-colors line-clamp-1"
              >
                {{ getLocalizedTitle(nextNews.title) }}
              </nuxt-link>
            </div>
            <div v-else class="flex-1 text-right text-gray-400">{{ t('news.detail.nextEmpty') }}</div>
          </div>
        </div>

        <!-- 相关推荐 -->
        <div v-if="relatedNews.length > 0" class="max-w-4xl mx-auto mt-12">
          <h2 class="text-xl font-bold text-gray-800 mb-6 flex items-center">
            <span class="w-4 h-2 bg-primary mr-2"></span>
            {{ t('news.detail.related') }}
          </h2>
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <nuxt-link
              v-for="item in relatedNews"
              :key="item.newsId"
              :to="newsLink(item)"
              class="bg-white rounded-lg shadow-sm hover:shadow-lg transition-all duration-300 block"
            >
              <img
                v-if="item.coverImage"
                :src="item.coverImage"
                :alt="getLocalizedTitle(item.title)"
                class="w-full h-36 object-cover rounded-t-lg"
              />
              <div v-else class="w-full h-36 bg-gray-200 rounded-t-lg flex items-center justify-center text-gray-400">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-12 w-12"
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
              </div>
              <div class="p-4">
                <h3 class="text-base font-medium text-gray-800 line-clamp-2 mb-2">
                  {{ getLocalizedTitle(item.title) }}
                </h3>
                <p class="text-xs text-gray-500">{{ item.publishTime }}</p>
              </div>
            </nuxt-link>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
  import { ref } from 'vue';
  import { useRoute } from 'vue-router';

  const route = useRoute();
  const { locale } = useI18n();
  const localePath = useLocalePath();

  // 接收动态路由传递的参数
  const props = defineProps<{
    category?: any;
    contentId?: number | string;
  }>();

  // 优先使用 props 传递的 contentId，否则使用路由参数
  const newsId = ref(props.contentId || (route.params.id as string));

  // 上一篇/下一篇
  const prevNews = ref<any>(null);
  const nextNews = ref<any>(null);

  // 相关推荐新闻
  const relatedNews = ref<any[]>([]);

  const [{ t }, { data: newsDetail }]: any = await Promise.all([
    useI18nLoader(),
    useFetch('/api/public/cms/news/' + newsId.value)
  ]);

  if (newsDetail.value) {
    const [{ data: adjacentNews }, { data: related }]: any = await Promise.all([
      useFetch('/api/public/cms/news/' + newsId.value + '/adjacent'),
      useFetch('/api/public/cms/news/' + newsId.value + '/related')
    ]);
    // 获取上一篇/下一篇
    if (adjacentNews.value) {
      prevNews.value = adjacentNews.value.prev;
      nextNews.value = adjacentNews.value.next;
    }

    // 获取相关推荐新闻
    if (related.value) {
      relatedNews.value = related.value;
    }
  }

  const newsTitle = computed(() => {
    return newsDetail.value?.title?.[locale.value] ?? newsDetail.value?.title?.zh;
  });
  const summary = computed(() => newsDetail.value.summary?.[locale.value] || newsDetail.value?.summary?.zh);
  const keywords = computed(() => newsDetail.value.keywords?.[locale.value] || newsDetail.value?.keywords?.zh);

  function newsLink(news: any) {
    let categoryUrl = '';
    news.categoryMpath.forEach((item: any) => {
      categoryUrl += `/${item.urlKey}`;
    });
    return localePath(`${categoryUrl}/${news.newsId}`);
  }
  function categoryUrl(category: any) {
    let url = '';
    for (const element of newsDetail.value.categoryMpath) {
      url += `/${element.urlKey}`;
      if (element.categoryId === category.categoryId) {
        break;
      }
    }

    return localePath(url);
  }

  // 获取本地化的标题
  function getLocalizedTitle(title: any) {
    if (!title) return '';
    if (typeof title === 'string') return title;
    return title[locale.value] || title.zh || '';
  }

  useHead({
    title: pageTitle(newsTitle.value),
    meta: [
      { name: 'description', content: summary.value },
      { name: 'keywords', content: keywords }
    ]
  });
</script>

<style>
  /* 富文本样式优化 */
  .prose a {
    color: #165dff;
    text-decoration: none;
  }
  .prose a:hover {
    text-decoration: underline;
  }
  .prose img {
    max-width: 100%;
    height: auto;
  }
</style>
