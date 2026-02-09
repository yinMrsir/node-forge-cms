<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100">
    <!-- 头部搜索区域 -->
    <div class="bg-white shadow-sm border-b border-gray-200">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- 面包屑 -->
        <nav class="flex text-sm mb-6" aria-label="Breadcrumb">
          <ol class="flex items-center space-x-2">
            <li>
              <nuxt-link :to="localePath('/')" class="text-gray-600 hover:text-primary">
                {{ t('common.home') }}
              </nuxt-link>
            </li>
            <li class="flex items-center">
              <svg class="h-4 w-4 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
              </svg>
              <span class="ml-2 text-primary font-medium">{{ t('common.search') }}</span>
            </li>
          </ol>
        </nav>

        <!-- AI 智能搜索框 -->
        <div class="max-w-4xl mx-auto">
          <div class="relative">
            <div
              class="flex items-center bg-white rounded-2xl shadow-xl border-2 border-gray-200 focus-within:border-primary transition-all duration-300"
            >
              <div class="flex-1 relative">
                <svg
                  class="absolute left-4 top-1/2 transform -translate-y-1/2 h-6 w-6 text-gray-400"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                  />
                </svg>
                <input
                  v-model="searchKey"
                  type="text"
                  :placeholder="t('news.aiSearchPlaceholder') || '请输入您想查找的内容，例如：最新的科技新闻'"
                  class="w-full pl-14 pr-4 py-5 text-lg outline-none bg-transparent rounded-l-2xl"
                  @keyup.enter="handleAISearch"
                />
              </div>
              <button
                :disabled="!searchKey.trim() || searching"
                :class="[
                  'px-8 py-5 rounded-r-2xl font-medium transition-all duration-300 flex items-center gap-2',
                  !searchKey.trim() || searching
                    ? 'bg-gray-300 cursor-not-allowed'
                    : 'from-primary to-primary-dark hover:from-primary-dark hover:to-primary text-white shadow-lg hover:shadow-xl'
                ]"
                @click="handleAISearch"
              >
                <svg
                  v-if="!searching"
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
                    d="M13 10V3L4 14h7v7l9-11h-7z"
                  />
                </svg>
                <span v-if="!searching">{{ t('common.aiSearch') || 'AI 智能搜索' }}</span>
                <span v-else class="flex items-center">
                  <svg class="animate-spin -ml-1 mr-2 h-5 w-5 text-white" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                    <path
                      class="opacity-75"
                      fill="currentColor"
                      d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                    ></path>
                  </svg>
                  {{ t('common.searching') || '搜索中...' }}
                </span>
              </button>
            </div>
            <!-- 搜索提示 -->
            <div v-if="!searchKey && !hasSearched" class="mt-4 flex flex-wrap gap-2 justify-center items-center">
              <span class="text-sm text-gray-500">{{ t('news.trySearch') || '试试搜索：' }}</span>
              <button
                v-for="suggestion in searchSuggestions"
                :key="suggestion"
                class="px-3 py-1 text-sm bg-gray-100 text-gray-700 rounded-full hover:bg-gray-200 transition-colors"
                @click="
                  searchKey = suggestion;
                  handleAISearch();
                "
              >
                {{ suggestion }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 主内容 -->
    <main class="container mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- 初始状态 -->
      <div v-if="!hasSearched && !searching" class="text-center py-16">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-24 w-24 text-gray-300 mx-auto mb-6"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="1.5"
            d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"
          />
        </svg>
        <h2 class="text-2xl font-semibold text-gray-700 mb-2">{{ t('news.aiSearchTitle') || 'AI 智能搜索' }}</h2>
        <p class="text-gray-500 max-w-md mx-auto">
          {{ t('news.aiSearchDesc') || '用自然语言描述您想要查找的内容，AI 将帮您智能匹配最相关的结果' }}
        </p>

        <!-- 功能特点 -->
        <div class="mt-12 grid grid-cols-1 md:grid-cols-3 gap-6 max-w-4xl mx-auto">
          <div class="bg-white rounded-xl p-6 shadow-sm">
            <div class="w-12 h-12 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6 text-primary"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"
                />
              </svg>
            </div>
            <h3 class="font-semibold text-gray-800 mb-2">{{ t('news.featureUnderstand') || '智能理解' }}</h3>
            <p class="text-sm text-gray-600">
              {{ t('news.featureUnderstandDesc') || '理解您的搜索意图，自动匹配最相关的内容' }}
            </p>
          </div>
          <div class="bg-white rounded-xl p-6 shadow-sm">
            <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6 text-green-600"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
                />
              </svg>
            </div>
            <h3 class="font-semibold text-gray-800 mb-2">{{ t('news.featureSummarize') || '智能总结' }}</h3>
            <p class="text-sm text-gray-600">
              {{ t('news.featureSummarizeDesc') || 'AI 自动总结搜索结果，快速了解核心信息' }}
            </p>
          </div>
          <div class="bg-white rounded-xl p-6 shadow-sm">
            <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6 text-blue-600"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"
                />
              </svg>
            </div>
            <h3 class="font-semibold text-gray-800 mb-2">{{ t('news.featureSuggest') || '智能推荐' }}</h3>
            <p class="text-sm text-gray-600">
              {{ t('news.featureSuggestDesc') || '基于搜索结果推荐相关内容和优化建议' }}
            </p>
          </div>
        </div>
      </div>

      <!-- 加载状态 -->
      <div v-if="searching" class="text-center py-16">
        <div class="relative inline-block">
          <div class="animate-spin rounded-full h-16 w-16 border-4 border-primary border-t-transparent"></div>
          <svg
            class="absolute top-0 left-0 h-16 w-16 animate-pulse"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
          >
            <circle
              cx="12"
              cy="12"
              r="10"
              stroke="currentColor"
              stroke-width="1"
              stroke-dasharray="4 4"
              class="opacity-30"
            >
              <animate attributeName="stroke-dashoffset" from="0" to="8" dur="1s" repeatCount="indefinite" />
            </circle>
          </svg>
        </div>
        <p class="text-gray-600 mt-6 text-lg">{{ t('news.aiAnalyzing') || 'AI 正在分析您的查询...' }}</p>
        <p class="text-gray-400 text-sm mt-2">{{ t('news.aiAnalyzingDesc') || '正在理解搜索意图，智能匹配内容' }}</p>
      </div>

      <!-- 搜索结果 -->
      <div v-if="hasSearched && !searching">
        <!-- AI 总结区域 -->
        <div
          v-if="aiResponse"
          class="mb-8 bg-gradient-to-r from-primary/5 to-primary/10 rounded-2xl p-8 border border-primary/20"
        >
          <div class="flex items-start gap-4">
            <div class="flex-shrink-0">
              <div
                class="w-10 h-10 bg-gradient-to-br from-primary to-primary-dark rounded-full flex items-center justify-center"
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
                    d="M13 10V3L4 14h7v7l9-11h-7z"
                  />
                </svg>
              </div>
            </div>
            <div class="flex-1">
              <h3 class="text-lg font-semibold text-gray-800 mb-3">{{ t('news.aiSummary') || 'AI 搜索总结' }}</h3>
              <p class="text-gray-700 leading-relaxed whitespace-pre-line">{{ aiResponse.summary }}</p>
            </div>
          </div>

          <!-- AI 建议 -->
          <div v-if="aiResponse.suggestions && aiResponse.suggestions.length > 0" class="mt-6">
            <h4 class="text-sm font-medium text-gray-700 mb-3">{{ t('news.aiSuggestions') || '智能建议' }}</h4>
            <ul class="space-y-2">
              <li
                v-for="(suggestion, index) in aiResponse.suggestions"
                :key="index"
                class="flex items-start gap-2 text-gray-600 text-sm"
              >
                <svg class="flex-shrink-0 w-4 h-4 text-primary mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                  <path
                    fill-rule="evenodd"
                    d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                    clip-rule="evenodd"
                  />
                </svg>
                {{ suggestion }}
              </li>
            </ul>
          </div>

          <!-- 相关搜索 -->
          <div v-if="aiResponse.relatedQueries && aiResponse.relatedQueries.length > 0" class="mt-6">
            <h4 class="text-sm font-medium text-gray-700 mb-3">{{ t('news.relatedSearches') || '相关搜索' }}</h4>
            <div class="flex flex-wrap gap-2">
              <button
                v-for="(query, index) in aiResponse.relatedQueries"
                :key="index"
                class="px-4 py-2 bg-white text-gray-700 rounded-lg hover:bg-gray-50 transition-colors text-sm border border-gray-200 hover:border-primary"
                @click="
                  searchKey = query;
                  handleAISearch();
                "
              >
                {{ query }}
              </button>
            </div>
          </div>
        </div>

        <!-- 搜索结果数量 -->
        <div v-if="searchResults && searchResults.length > 0" class="mb-6">
          <h2 class="text-xl font-semibold text-gray-800">
            {{ t('news.searchResultsCount', { count: totalResults, keyword: currentQuery }) }}
          </h2>
        </div>
        <!-- 搜索结果列表 -->
        <div
          v-if="searchResults && searchResults.length > 0"
          class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"
        >
          <nuxt-link
            v-for="news in searchResults"
            :key="news.newsId"
            target="_blank"
            class="bg-white rounded-xl overflow-hidden shadow-sm hover:shadow-xl transition-all duration-300 cursor-pointer group"
            :to="newsLink(news)"
          >
            <div class="relative overflow-hidden">
              <nuxt-img
                format="webp"
                loading="lazy"
                :src="news.coverImage || ''"
                :alt="getNewsTitle(news)"
                class="w-full h-48 object-cover group-hover:scale-105 transition-transform duration-300"
              />
              <div class="absolute top-3 left-3">
                <span class="px-3 py-1 bg-primary/90 text-white text-xs rounded-full">
                  {{ getCategoryName(news.category) }}
                </span>
              </div>
            </div>
            <div class="p-5">
              <div class="flex items-center text-xs text-gray-500 mb-2">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-4 w-4"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
                  />
                </svg>
                <span class="ml-1">{{ formatDate(news.publishTime) }}</span>
                <span class="mx-2">|</span>
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-4 w-4"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
                  />
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7"
                  />
                </svg>
                <span class="ml-1">{{ news.viewCount || 0 }}</span>
              </div>
              <h3
                class="text-lg font-semibold text-gray-800 mb-2 line-clamp-2 group-hover:text-primary transition-colors"
              >
                {{ getNewsTitle(news) }}
              </h3>
              <p class="text-gray-600 text-sm line-clamp-2">{{ getNewsSummary(news) }}</p>
            </div>
          </nuxt-link>
        </div>

        <!-- 无结果 -->
        <div v-else class="text-center py-16">
          <div class="max-w-md mx-auto">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-20 w-20 text-gray-300 mx-auto mb-4"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="1.5"
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
              />
            </svg>
            <h3 class="text-lg font-semibold text-gray-700 mb-2">{{ t('news.noResults') || '未找到相关内容' }}</h3>
            <p class="text-gray-500 mb-6">{{ t('news.noResultsDesc') || '请尝试使用其他关键词或更通用的搜索条件' }}</p>
            <button
              class="px-6 py-2 bg-primary text-white rounded-lg hover:bg-primary-dark transition-colors"
              @click="resetSearch"
            >
              {{ t('common.newSearch') || '重新搜索' }}
            </button>
          </div>
        </div>

        <!-- 分页 -->
        <div v-if="totalResults > pageSize" class="mt-12 flex justify-center">
          <nav class="flex items-center space-x-2">
            <button
              v-if="currentPage > 1"
              :disabled="searching"
              class="px-4 py-2 rounded-lg border border-gray-300 text-gray-700 hover:bg-primary hover:text-white hover:border-primary transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
              @click="goToPage(currentPage - 1)"
            >
              {{ t('common.prevPage') }}
            </button>

            <button
              v-for="page in displayPages"
              :key="page"
              :disabled="searching"
              :class="[
                'px-4 py-2 rounded-lg min-w-10 text-center',
                currentPage === page
                  ? 'bg-primary text-white cursor-default'
                  : 'border border-gray-300 text-gray-700 hover:bg-primary/10'
              ]"
              @click="goToPage(page)"
            >
              {{ page }}
            </button>

            <button
              v-if="currentPage < totalPages"
              :disabled="searching"
              class="px-4 py-2 rounded-lg border border-gray-300 text-gray-700 hover:bg-primary hover:text-white hover:border-primary transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
              @click="goToPage(currentPage + 1)"
            >
              {{ t('common.nextPage') }}
            </button>
          </nav>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
  const config = useRuntimeConfig();
  const { locale, locales } = useI18n();
  const localePath = useLocalePath();
  const { t } = await useI18nLoader();
  const route = useRoute();

  // 搜索状态
  const searchKey = ref('');
  const searching = ref(false);
  const hasSearched = ref(false);
  const currentQuery = ref('');

  // 搜索结果
  const searchResults = ref<any[]>([]);
  const totalResults = ref(0);
  const aiResponse = ref<any>(null);

  // 分页
  const pageSize = 12;
  const currentPage = ref(1);
  const totalPages = ref(1);

  // 搜索建议
  const searchSuggestions = computed(() => {
    const suggestions = [
      t('news.suggestionLatest') || '最近的新闻',
      t('news.suggestionHot') || '热门新闻',
      t('news.suggestionTech') || '科技新闻',
      t('news.suggestionProduct') || '产品信息'
    ];
    return suggestions;
  });

  // 显示的分页页码
  const displayPages = computed(() => {
    const pages: number[] = [];
    const total = totalPages.value;
    const current = currentPage.value;

    // 始终显示第一页
    pages.push(1);

    // 当前页码附近显示的页码
    for (let i = Math.max(2, current - 1); i <= Math.min(total - 1, current + 1); i++) {
      if (i !== 1 && i !== total) {
        pages.push(i);
      }
    }

    // 始终显示最后一页
    if (total > 1) {
      pages.push(total);
    }

    return pages;
  });

  // AI 智能搜索
  async function handleAISearch() {
    if (!searchKey.value.trim() || searching.value) return;

    searching.value = true;
    hasSearched.value = false;
    currentPage.value = 1;

    try {
      const data = await $fetch('/api/public/cms/news/ai-search', {
        method: 'POST',
        body: {
          query: searchKey.value.trim(),
          locale: locale.value
        }
      });

      if (data.code === 200) {
        currentQuery.value = searchKey.value.trim();
        searchResults.value = data.data.results;
        totalResults.value = data.data.total;
        aiResponse.value = {
          summary: data.data.aiSummary,
          suggestions: data.data.aiSuggestions,
          relatedQueries: data.data.relatedQueries
        };
        totalPages.value = Math.ceil(data.data.total / pageSize);
      }
    } catch (error) {
      console.error('AI 搜索失败:', error);
      // 显示错误提示
      aiResponse.value = {
        summary: t('news.searchError') || '搜索失败，请稍后重试',
        suggestions: [],
        relatedQueries: []
      };
    } finally {
      searching.value = false;
      hasSearched.value = true;
    }
  }

  // 分页跳转
  async function goToPage(page: number) {
    if (page === currentPage.value || searching.value) return;

    currentPage.value = page;
    searching.value = true;

    try {
      const data: any = await $fetch('/api/public/cms/news/ai-search', {
        method: 'POST',
        body: {
          query: currentQuery.value,
          locale: locale.value,
          page,
          limit: pageSize
        }
      });

      if (data.code === 200) {
        searchResults.value = data.data.results;
        // AI 总结只在第一页显示
        if (page === 1) {
          aiResponse.value = {
            summary: data.data.aiSummary,
            suggestions: data.data.aiSuggestions,
            relatedQueries: data.data.relatedQueries
          };
        } else {
          // 非第一页不显示 AI 总结
          aiResponse.value = null;
        }
      }
    } catch (error) {
      console.error('加载分页失败:', error);
    } finally {
      searching.value = false;
    }
  }

  // 重置搜索
  function resetSearch() {
    searchKey.value = '';
    hasSearched.value = false;
    searchResults.value = [];
    aiResponse.value = null;
    currentQuery.value = '';
    currentPage.value = 1;
  }

  // 构建新闻链接
  function newsLink(news: any) {
    let categoryUrl = '';
    if (news.categoryMpath && news.categoryMpath.length > 0) {
      news.categoryMpath.forEach((item: any) => {
        categoryUrl += `/${item.urlKey}`;
      });
    }
    return localePath(`${categoryUrl}/${news.newsId}`);
  }

  // 获取新闻标题（多语言支持）
  function getNewsTitle(news: any) {
    if (!news.title) return '';
    return news.title[locale.value] || news.title.zh || news.title.en || '';
  }

  // 获取新闻摘要（多语言支持）
  function getNewsSummary(news: any) {
    if (!news.summary) return '';
    return news.summary[locale.value] || news.summary.zh || news.summary.en || '';
  }

  // 获取分类名称（多语言支持）
  function getCategoryName(category: any) {
    if (!category) return '';
    return category.categoryName?.[locale.value] || category.categoryName?.zh || category.categoryName?.en || '';
  }

  // 格式化日期
  function formatDate(dateStr: string | null) {
    if (!dateStr) return '';
    const date = new Date(dateStr);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  const links = computed(() => {
    return locales.value.map(locale => {
      return {
        rel: 'alternate',
        hreflang: locale.language,
        href: `${config.public.serverHost}/${locale.code}/ai-search`
      };
    });
  });
  // 设置页面标题
  useHead({
    title: pageTitle(currentQuery.value ? `${currentQuery.value} - ${t('common.search')}` : t('common.search')),
    link: [
      {
        rel: 'canonical',
        href: `${config.public.serverHost}${route.path}`
      },
      ...links.value
    ]
  });
</script>

<style scoped>
  .line-clamp-2 {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }

  .line-clamp-3 {
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }
</style>
