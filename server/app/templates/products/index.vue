<template>
  <div>
    <!-- 面包屑 -->
    <div class="bg-white border-b border-gray-200 py-4">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <nav class="flex text-sm" aria-label="Breadcrumb">
          <ol class="flex items-center space-x-2">
            <li>
              <nuxt-link :to="localePath('/')" class="text-gray-600 hover:text-primary">
                {{ t('common.home') }}
              </nuxt-link>
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
        <!-- 产品分类筛选 -->
        <div class="mb-10 text-center">
          <h2 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-gray-800 mb-2">{{ categoryName }}</h2>
          <p class="text-gray-600 max-w-2xl mx-auto mb-8">{{ desciprtion }}</p>
          <div class="flex flex-wrap justify-center gap-3">
            <nuxt-link
              v-for="cate in productCates"
              :key="cate.categoryId"
              :to="categoryLink(cate.categoryMpath)"
              :class="[
                'px-6 py-2 rounded-md transition-all duration-300 bg-white text-gray-700 hover:bg-gray-50 shadow-sm'
              ]"
            >
              {{ cate.categoryName?.[locale] ?? cate.categoryName?.['zh'] }}
            </nuxt-link>
          </div>
        </div>

        <!-- 产品列表 -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
          <nuxt-link
            v-for="product in productList"
            :key="product.productId"
            class="bg-white rounded-lg overflow-hidden shadow-sm hover:shadow-lg transition-all duration-300 group cursor-pointer"
            :to="productLink(product)"
          >
            <div class="relative overflow-hidden pt-4">
              <nuxt-img
                format="webp"
                loading="lazy"
                :src="product.mainImage || ''"
                alt="product.name"
                class="w-full h-48 object-contain transition-transform duration-500 group-hover:scale-105"
              />
              <div
                v-if="product.category"
                class="absolute top-3 left-3 bg-blue-600/80 text-white text-xs px-2 py-1 rounded"
              >
                {{ product.category.categoryName?.[locale] ?? product.productName?.zh }}
              </div>
            </div>
            <div class="p-6">
              <h3 class="text-xl font-semibold text-gray-800 mb-2 group-hover:text-primary transition-colors">
                {{ product.productName?.[locale] ?? product.productName?.zh }}
              </h3>
              <p class="text-gray-600 mb-4 line-clamp-3 whitespace-pre-wrap">
                {{ product.summary?.[locale] ?? product.summary?.zh }}
              </p>
              <div class="inline-flex items-center text-primary font-medium text-sm hover:text-primary/80">
                {{ t('common.viewDetails') }}
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-4 w-4 ml-1 transition-transform group-hover:translate-x-1"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                </svg>
              </div>
            </div>
          </nuxt-link>

          <!-- 空数据占位 -->
          <div v-if="productList.length === 0" class="col-span-full text-center py-12">
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
                d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"
              />
            </svg>
            <p class="text-gray-500">{{ t('common.noProducts') }}</p>
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
  const { locale } = useI18n();
  const localePath = useLocalePath();

  // 根据是否有动态路由参数确定分类ID和名称
  const categoryId = props.category?.categoryId || undefined;
  const categoryName = props.category?.categoryName?.[locale.value] || props.category?.categoryName?.zh;
  const desciprtion = props.category?.description?.[locale.value] || props.category?.description?.zh;
  const keywords = props.category?.keywords?.[locale.value] || props.category?.keywords?.zh;

  // 分页参数
  const pageSize = 8;
  const currentPage = computed(() => Number(route.query.page) || 1);

  // 产品分类
  const [{ t }, { data: productCates }, { data: productListData }]: any = await Promise.all([
    useI18nLoader(),
    useFetch('/api/public/cms/category/list', {
      query: {
        parentCategoryId: categoryId,
        status: '1'
      }
    }),
    useFetch('/api/public/cms/product/list', {
      query: {
        categoryId,
        limit: pageSize,
        pageNum: currentPage
      }
    })
  ]);

  const productList = computed(() => productListData.value?.rows || []);
  const total = computed(() => productListData.value?.total || 0);
  const totalPages = computed(() => Math.ceil(total.value / pageSize));

  // 监听路由变化，重新获取数据
  watch(
    () => route.query.page,
    () => {
      // 滚动到顶部
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }
  );

  // 构建产品详情链接
  function productLink(product: any) {
    let categoryUrl = '';
    product.categoryMpath.forEach((item: any) => {
      categoryUrl += `/${item.urlKey}`;
    });
    return localePath(`${categoryUrl}/${product.productId}`);
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

  useHead({
    title: pageTitle(categoryName),
    meta: [
      { name: 'description', content: desciprtion },
      { name: 'keywords', content: keywords }
    ]
  });
</script>
