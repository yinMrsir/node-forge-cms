<template>
  <!-- 上文模板内容不变，此处为完整模板，已补全所有逻辑 -->
  <div class="flex flex-col">
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
            <li v-for="category in productDetail?.categoryMpath" :key="category.categoryId" class="flex items-center">
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
              <span class="ml-2 text-primary">
                {{ productName }}
              </span>
            </li>
          </ol>
        </nav>
      </div>
    </div>

    <!-- 主内容 -->
    <main class="flex-grow py-12">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="max-w-5xl mx-auto">
          <!-- 产品基础信息 -->
          <div class="bg-white rounded-lg shadow-sm p-6 md:p-8 mb-8 grid grid-cols-1 lg:grid-cols-2 gap-8 items-center">
            <div class="relative">
              <swiper :modules="modules" navigation>
                <swiper-slide v-for="(item, index) in imgs" :key="index">
                  <img :src="item" class="w-full max-h-[300px] object-contain rounded-lg" />
                </swiper-slide>
              </swiper>
            </div>
            <div>
              <h1 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-gray-800 mb-4">
                {{ productName }}
              </h1>
              <p class="text-gray-600 mb-6 leading-relaxed whitespace-pre-wrap">
                {{ summary }}
              </p>
              <button
                class="bg-primary hover:bg-primary/90 text-white font-medium px-8 py-3 rounded-md transition-all duration-300 shadow-md hover:shadow-lg mr-4 mb-4 sm:mb-0"
              >
                {{ t('product.consultNow') }}
              </button>
              <button
                class="border border-primary text-primary hover:bg-primary/5 font-medium px-8 py-3 rounded-md transition-all duration-300"
              >
                {{ t('product.freeTrial') }}
              </button>
            </div>
          </div>

          <!-- 产品详情 -->
          <div class="bg-white rounded-lg shadow-sm p-6 md:p-8 mb-8">
            <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center">
              <span class="w-4 h-2 bg-primary mr-2"></span>
              {{ t('product.detailTitle') }}
            </h2>
            <div
              class="editor-html prose prose-lg max-w-none prose-img:rounded-lg prose-p:leading-relaxed prose-a:text-primary"
              v-html="productDetail.description?.[locale] || productDetail?.description?.zh"
            ></div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
  import { Navigation } from 'swiper/modules';
  import { Swiper, SwiperSlide } from 'swiper/vue';
  import 'swiper/css';
  import 'swiper/css/navigation';
  import 'swiper/css/pagination';

  const modules = [Navigation];

  const { locale } = useI18n();
  const localePath = useLocalePath();
  const route = useRoute();

  // 接收动态路由传递的参数
  const props = defineProps<{
    contentId?: number | string;
  }>();

  // 优先使用 props 传递的 contentId，否则使用路由参数
  const productId = ref(props.contentId || (route.params.id as string));

  // 获取产品详情
  const [{ t }, { data: productDetail }]: any = await Promise.all([
    useI18nLoader(),
    useFetch('/api/public/cms/product/' + productId.value)
  ]);

  // 产品名称
  const productName = computed(
    () => productDetail.value.productName?.[locale.value] || productDetail.value?.productName?.zh
  );
  // 产品描述
  const summary = computed(() => productDetail.value.summary?.[locale.value] || productDetail.value?.summary?.zh);
  // 关键词
  const keywords = computed(() => productDetail.value.keywords?.[locale.value] || productDetail.value?.keywords?.zh);

  // 产品图
  const imgs = computed(() => {
    return productDetail.value.images ? productDetail.value.images.split(',') : [productDetail.value.mainImage];
  });

  function categoryUrl(category: any) {
    let url = '';
    for (const element of productDetail.value.categoryMpath) {
      url += `/${element.urlKey}`;
      if (element.categoryId === category.categoryId) {
        break;
      }
    }

    return localePath(url);
  }

  useHead({
    title: pageTitle(productName.value),
    meta: [
      { name: 'description', content: summary.value },
      { name: 'keywords', content: keywords }
    ]
  });
</script>

<style scoped>
  /* 富文本样式局部优化，避免全局污染 */
  :deep(.prose) {
    color: #4b5563;
    line-height: 2;
  }
  :deep(.prose h3) {
    color: #1f2937;
    font-weight: 600;
    margin-top: 1.5rem;
    margin-bottom: 0.8rem;
  }
  :deep(.prose ul, .prose ol) {
    margin-left: 1.5rem;
    margin-bottom: 1rem;
  }
  :deep(.prose li) {
    margin-bottom: 0.5rem;
  }
  /* 按钮移动端自适应 */
  @media (max-width: 640px) {
    button {
      width: 100%;
    }
  }
</style>
