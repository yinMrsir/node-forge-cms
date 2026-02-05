<template>
  <div>
    <!-- 加载状态 -->
    <div v-if="loading" class="min-h-screen flex items-center justify-center">
      <div class="text-center">
        <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto"></div>
        <p class="mt-4 text-gray-600">{{ t('common.loading') }}</p>
      </div>
    </div>

    <!-- 列表页：动态加载对应的模板组件 -->
    <component
      :is="templateComponent"
      v-else-if="templateComponent && !isDetailPage"
      :category="category"
      :url-key="category?.urlKey"
    />

    <!-- 详情页：动态加载对应的详情模板组件 -->
    <component :is="detailComponent" v-else-if="detailComponent && isDetailPage" :content-id="contentId" />

    <!-- 404 页面 -->
    <div v-else class="min-h-screen flex items-center justify-center">
      <div class="text-center">
        <h1 class="text-2xl font-bold text-gray-800 mb-4">{{ t('error.pageNotFound') }}</h1>
        <p class="text-gray-600">{{ t('error.categoryNotFound') }}</p>
        <nuxt-link :to="localePath('/')" class="inline-block mt-4 text-primary hover:underline">{{
          t('error.backToHome')
        }}</nuxt-link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { ref, shallowRef, defineAsyncComponent, computed } from 'vue';

  const route = useRoute();
  const { t } = await useI18nLoader();
  const localePath = useLocalePath();
  const slugs = route.params.slug as string[];
  const category = ref<any>(null);
  const templateComponent = shallowRef<any>(null);
  const detailComponent = shallowRef<any>(null);
  const loading = ref(true);

  // 判断是否为详情页（最后一段是纯数字）
  const isDetailPage = computed(() => {
    if (!slugs || slugs.length === 0) return false;
    const lastSegment = slugs[slugs.length - 1];
    // 添加 undefined 检查
    return lastSegment !== undefined && /^\d+$/.test(lastSegment);
  });

  // 提取内容ID
  const contentId = computed(() => {
    if (!isDetailPage.value) return null;
    const lastSegment = slugs[slugs.length - 1];
    return lastSegment ? parseInt(lastSegment) : null;
  });

  // 列表模板映射
  const templateMap: Record<string, () => Promise<any>> = {
    news: () => import('../templates/news/index.vue'),
    products: () => import('../templates/products/index.vue'),
    content: () => import('../templates/content/index.vue')
  };

  // 详情模板映射
  const detailTemplateMap: Record<string, () => Promise<any>> = {
    news: () => import('../templates/news/[id].vue'),
    products: () => import('../templates/products/[id].vue')
  };

  // 根据路径段查找栏目
  const findCategoryByPath = async (pathSegments: string[]): Promise<any> => {
    if (!pathSegments || pathSegments.length === 0) return null;

    // 详情页：移除最后的 ID 段
    const segmentsForLookup = isDetailPage.value ? pathSegments.slice(0, -1) : pathSegments;

    // 如果只有一段，直接查询 urlKey
    if (segmentsForLookup.length === 1) {
      const { data: result }: any = await useFetch('/api/public/cms/category/by-urlkey/' + segmentsForLookup[0]);
      return result.value?.data || null;
    }

    // 多级栏目：逐级匹配
    // 这里我们需要查询 urlKey 等于最后一段，并且 mpath 匹配的栏目
    const { data: result }: any = await useFetch('/api/public/cms/category/by-path', {
      method: 'POST',
      body: {
        pathSegments: segmentsForLookup
      }
    });

    return result.value?.data || null;
  };

  // 加载栏目和模板
  const loadPage = async () => {
    try {
      // 查找栏目
      const cat = await findCategoryByPath(slugs);

      if (!cat) {
        console.error('Category not found for path:', slugs);
        return;
      }

      category.value = cat;

      if (category.value.redirectUrl) {
        await navigateTo(localePath(category.value.redirectUrl), {
          redirectCode: 301
        });
        return;
      }

      if (isDetailPage.value) {
        // 加载详情页模板
        if (cat.templateType) {
          const loader = detailTemplateMap[cat.templateType];
          if (loader) {
            detailComponent.value = defineAsyncComponent({
              loader,
              delay: 200,
              timeout: 3000
            });
          } else {
            console.error('Detail template type not found:', cat.detailTemplateType);
          }
        } else {
          console.error('Detail template type not configured for category');
        }
      } else if (cat.templateType) {
        const loader = templateMap[cat.templateType];
        if (loader) {
          templateComponent.value = defineAsyncComponent({
            loader,
            delay: 200,
            timeout: 3000
          });
        } else {
          console.error('Template type not found:', cat.templateType);
        }
      } else {
        console.error('Template type not configured for category');
      }
    } catch (error) {
      console.error('Error loading page:', error);
    } finally {
      loading.value = false;
    }
  };

  await loadPage();
</script>
