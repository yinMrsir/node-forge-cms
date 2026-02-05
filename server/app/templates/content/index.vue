<template>
  <div class="flex flex-col">
    <!-- 二级导航（企业介绍子栏目） -->
    <div class="bg-white border-b border-gray-200">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <nav class="flex overflow-x-auto scrollbar-hide py-4 gap-6">
          <nuxt-link
            v-for="item in siblingCategory"
            :key="item.categoryId"
            :to="categoryLink(item.categoryMpath)"
            :class="
              route.path === categoryLink(item.categoryMpath)
                ? 'text-primary font-medium whitespace-nowrap border-b-2 border-primary pb-1'
                : 'text-gray-600 hover:text-primary whitespace-nowrap pb-1 transition-colors'
            "
          >
            {{ item.categoryName?.[locale] ?? item.categoryName?.zh }}
          </nuxt-link>
        </nav>
      </div>
    </div>

    <!-- 面包屑 -->
    <div class="bg-gray-50 border-b border-gray-200 py-4">
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
        <!-- 企业概览 -->
        <div class="max-w-5xl mx-auto bg-white rounded-lg shadow-sm p-6 md:p-8 mb-10">
          <div
            class="editor-html prose prose-lg max-w-none prose-p:leading-relaxed text-gray-700"
            v-html="categoryContent.content"
          ></div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
  const props = defineProps<{
    category?: any;
  }>();

  const route = useRoute();
  const { locale } = useI18n();
  const localePath = useLocalePath();

  // 根据是否有动态路由参数确定分类ID
  const categoryId = props.category?.categoryId || undefined;
  const categoryName = props.category?.categoryName?.[locale.value] || props.category?.categoryName?.zh;

  const [{ t }, { data: siblingCategory }, { data: categoryContent }]: any = await Promise.all([
    useI18nLoader(),
    useFetch('/api/public/cms/category/list', {
      params: {
        parentCategoryId:
          props.category.parentCategoryId === 0 ? props.category.categoryId : props.category.parentCategoryId,
        delFlag: '0'
      }
    }),
    useFetch('/api/public/cms/content/by-categoryId', {
      query: {
        categoryId: props.category.categoryId,
        locale: locale.value
      }
    })
  ]);
  function categoryLink(categoryMpath: any[]) {
    let categoryUrl = '';
    categoryMpath.forEach((item: any) => {
      categoryUrl += `/${item.urlKey}`;
    });
    return localePath(`${categoryUrl}`);
  }

  useHead({
    title: pageTitle(categoryName),
    meta: [
      { name: 'description', content: categoryContent.value.desciprtion },
      { name: 'keywords', content: categoryContent.value.keywords }
    ]
  });
</script>

<style scoped>
  /* 时间轴适配移动端 */
  @media (max-width: 1024px) {
    :deep(.development-history) {
      padding-left: 2rem;
    }
  }
  /* 隐藏滚动条 */
  .scrollbar-hide::-webkit-scrollbar {
    display: none;
  }
  .scrollbar-hide {
    -ms-overflow-style: none;
    scrollbar-width: none;
  }
</style>
