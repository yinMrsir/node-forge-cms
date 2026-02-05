<template>
  <main class="flex-grow">
    <!-- 轮播图区域 -->
    <swiper
      v-if="bannerListData?.length"
      :modules="modules"
      navigation
      :pagination="{ clickable: true }"
      :autoplay="{ delay: 5000 }"
    >
      <swiper-slide v-for="(banner, index) in bannerListData" :key="index">
        <div class="h-[60vh] md:h-[70vh] relative">
          <img
            :src="banner.imageUrl"
            :alt="banner.title?.[locale] ?? banner.title?.zh"
            class="w-full h-full object-cover"
          />
          <div class="absolute inset-0 bg-black/30 flex items-center">
            <div class="container mx-auto px-4 sm:px-6 lg:px-8">
              <div class="max-w-2xl text-white">
                <h1 class="text-[clamp(2rem,5vw,3.5rem)] font-bold leading-tight mb-4">
                  {{ banner.title?.[locale] ?? banner.title?.zh }}
                </h1>
                <p class="text-[clamp(1rem,2vw,1.25rem)] mb-6 text-gray-100">
                  {{ banner.description?.[locale] ?? banner.description?.zh }}
                </p>
                <nuxt-link
                  v-if="banner.linkUrl"
                  :to="localePath(banner.linkUrl)"
                  class="inline-block bg-primary hover:bg-primary/90 text-white font-medium px-6 py-3 rounded-md transition-all duration-300 transform hover:scale-105"
                >
                  {{ (banner.buttonText?.[locale] ?? banner.buttonText?.zh) || t('home.banner.learnMore') }}
                </nuxt-link>
              </div>
            </div>
          </div>
        </div>
      </swiper-slide>
    </swiper>
    <!-- 默认轮播图（无数据时显示） -->
    <swiper v-else :modules="modules" navigation :pagination="{ clickable: true }" :autoplay="{ delay: 5000 }">
      <swiper-slide v-for="(_, index) in 3" :key="index">
        <div class="h-[60vh] md:h-[70vh]">
          <img
            src="https://picsum.photos/id/1068/1920/1080"
            :alt="t('home.banner.title')"
            class="w-full h-full object-cover"
          />
          <div class="absolute inset-0 bg-black/30 flex items-center">
            <div class="container mx-auto px-4 sm:px-6 lg:px-8">
              <div class="max-w-2xl text-white">
                <h1 class="text-[clamp(2rem,5vw,3.5rem)] font-bold leading-tight mb-4">{{ t('home.banner.title') }}</h1>
                <p class="text-[clamp(1rem,2vw,1.25rem)] mb-6 text-gray-100">
                  {{ t('home.banner.description') }}
                </p>
                <a
                  href="#products"
                  class="inline-block bg-primary hover:bg-primary/90 text-white font-medium px-6 py-3 rounded-md transition-all duration-300 transform hover:scale-105"
                >
                  {{ t('home.banner.viewProducts') }}
                </a>
              </div>
            </div>
          </div>
        </div>
      </swiper-slide>
    </swiper>

    <!-- 产品中心 -->
    <section id="products" class="py-16 bg-white">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-12">
          <h2 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-gray-800 mb-4">{{ t('home.products.title') }}</h2>
          <div class="w-20 h-1 bg-primary mx-auto mb-6"></div>
          <p class="text-gray-600 max-w-2xl mx-auto">{{ t('home.products.description') }}</p>
        </div>

        <!-- 产品列表 -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          <nuxt-link
            v-for="(product, index) in productListData?.rows || []"
            :key="index"
            :to="productLink(product)"
            class="product-card bg-gray-50 rounded-lg overflow-hidden shadow-sm hover:shadow-lg transition-all duration-300 pt-4"
          >
            <img
              :src="product.mainImage || ''"
              :alt="product.productName?.[locale] ?? product.productName?.zh"
              class="w-full h-48 object-contain"
            />
            <div class="p-6">
              <h3 class="text-xl font-semibold text-gray-800 mb-2">
                {{ product.productName?.[locale] ?? product.productName?.zh }}
              </h3>
              <p class="text-gray-600 mb-4 whitespace-pre-wrap">
                {{ product.summary?.[locale] ?? product.summary?.zh }}
              </p>
              <div class="text-[var(--primary-color)] font-medium inline-flex items-center">
                {{ t('home.products.viewDetails') }}
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-4 w-4 ml-1"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                </svg>
              </div>
            </div>
          </nuxt-link>
        </div>
      </div>
    </section>

    <!-- 新闻中心 -->
    <section id="news" class="py-16 bg-gray-50">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-12">
          <h2 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-gray-800 mb-4">{{ t('home.news.title') }}</h2>
          <div class="w-20 h-1 bg-primary mx-auto mb-6"></div>
          <p class="text-gray-600 max-w-2xl mx-auto">{{ t('home.news.description') }}</p>
        </div>

        <!-- 新闻列表 -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <!-- 重点新闻 -->
          <div class="md:col-span-1">
            <div
              v-for="item in topNewsData.rows"
              :key="item.newsId"
              class="bg-white rounded-lg overflow-hidden shadow-sm hover:shadow-lg transition-all duration-300"
            >
              <nuxt-link :to="newsLink(item)">
                <img
                  :src="item.coverImage || ''"
                  :alt="item.title?.[locale] ?? item.title?.en"
                  class="w-full h-64 object-cover"
                />
              </nuxt-link>
              <div class="p-6">
                <div class="flex items-center text-sm text-gray-500 mb-2">
                  <span>{{ item.publishTime }}</span>
                  <span class="mx-2">|</span>
                  <span>{{ item.category?.categoryName?.[locale] ?? item.category?.categoryName?.en }}</span>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 mb-3">
                  {{ item.title?.[locale] ?? item.title?.en }}
                </h3>
                <p class="text-gray-600 mb-4 line-clamp-3">
                  {{ item.summary?.[locale] ?? item.summary?.en }}
                </p>
                <nuxt-link
                  :to="newsLink(item)"
                  class="text-primary font-medium hover:text-primary/80 inline-flex items-center"
                >
                  {{ t('home.news.readFull') }}
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-4 w-4 ml-1"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M14 5l7 7m0 0l-7 7m7-7H3"
                    />
                  </svg>
                </nuxt-link>
              </div>
            </div>
          </div>

          <!-- 新闻列表 -->
          <div class="md:col-span-1">
            <div class="space-y-4">
              <!-- 新闻项1 -->
              <nuxt-link
                v-for="item in newsData.rows"
                :key="item.newsId"
                :to="newsLink(item)"
                class="bg-white rounded-lg p-4 shadow-sm hover:shadow-lg transition-all duration-300 flex"
              >
                <img
                  :src="item.coverImage || ''"
                  :alt="item.title?.[locale] ?? item.title?.en"
                  class="w-20 h-20 object-cover rounded-md flex-shrink-0"
                />
                <div class="ml-4 flex-grow">
                  <div class="flex items-center text-sm text-gray-500 mb-1">
                    <span>{{ item.publishTime }}</span>
                    <span class="mx-2">|</span>
                    <span>{{ item.category?.categoryName?.[locale] ?? item.category?.categoryName?.en }}</span>
                  </div>
                  <h3 class="text-lg font-medium text-gray-800 mb-1 line-clamp-1">
                    {{ item.title?.[locale] ?? item.title?.en }}
                  </h3>
                  <p class="text-gray-600 text-sm line-clamp-2">
                    {{ item.summary?.[locale] ?? item.summary?.en }}
                  </p>
                </div>
              </nuxt-link>

              <!-- 查看更多 -->
              <div class="text-center pt-2">
                <nuxt-link
                  :to="localePath('/news')"
                  class="inline-block border border-primary text-primary hover:bg-primary hover:text-white font-medium px-5 py-2 rounded-md transition-all duration-300"
                >
                  {{ t('home.news.viewMore') }}
                </nuxt-link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 企业介绍 -->
    <section id="about" class="py-16 bg-white">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-12">
          <h2 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-gray-800 mb-4">{{ t('home.about.title') }}</h2>
          <div class="w-20 h-1 bg-primary mx-auto mb-6"></div>
          <p class="text-gray-600 max-w-2xl mx-auto">{{ t('home.about.subtitle') }}</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          <div>
            <img
              src="https://picsum.photos/id/1082/800/600"
              :alt="t('home.about.title')"
              class="w-full rounded-lg shadow-lg"
            />
          </div>
          <div class="space-y-4">
            <p class="text-gray-700 leading-relaxed">
              {{ t('home.about.intro1') }}
            </p>
            <p class="text-gray-700 leading-relaxed">
              {{ t('home.about.intro2') }}
            </p>
            <p class="text-gray-700 leading-relaxed">
              {{ t('home.about.intro3') }}
            </p>
            <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 mt-8">
              <div class="text-center">
                <div class="text-3xl font-bold text-primary mb-1">500+</div>
                <div class="text-gray-600 text-sm">{{ t('home.about.stats.partners') }}</div>
              </div>
              <div class="text-center">
                <div class="text-3xl font-bold text-primary mb-1">10+</div>
                <div class="text-gray-600 text-sm">{{ t('home.about.stats.products') }}</div>
              </div>
              <div class="text-center">
                <div class="text-3xl font-bold text-primary mb-1">50+</div>
                <div class="text-gray-600 text-sm">{{ t('home.about.stats.team') }}</div>
              </div>
              <div class="text-center">
                <div class="text-3xl font-bold text-primary mb-1">98%</div>
                <div class="text-gray-600 text-sm">{{ t('home.about.stats.satisfaction') }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 关于我们 -->
    <section id="contact" class="py-16 bg-gray-50">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-12">
          <h2 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-gray-800 mb-4">{{ t('home.contact.title') }}</h2>
          <div class="w-20 h-1 bg-primary mx-auto mb-6"></div>
          <p class="text-gray-600 max-w-2xl mx-auto">{{ t('home.contact.subtitle') }}</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <!-- 联系信息 -->
          <div class="bg-white rounded-lg p-6 shadow-sm">
            <h3 class="text-xl font-semibold text-gray-800 mb-6">{{ t('footer.contactUs') }}</h3>
            <div class="space-y-4">
              <div class="flex items-start">
                <div
                  class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary flex-shrink-0"
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
                      d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"
                    />
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"
                    />
                  </svg>
                </div>
                <div class="ml-4">
                  <h4 class="font-medium text-gray-800">{{ t('home.contact.info.address') }}</h4>
                  <p class="text-gray-600">{{ t('home.contact.address') }}</p>
                </div>
              </div>

              <div class="flex items-start">
                <div
                  class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary flex-shrink-0"
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
                      d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"
                    />
                  </svg>
                </div>
                <div class="ml-4">
                  <h4 class="font-medium text-gray-800">{{ t('home.contact.info.phone') }}</h4>
                  <p class="text-gray-600">{{ t('home.contact.phone') }}</p>
                </div>
              </div>

              <div class="flex items-start">
                <div
                  class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary flex-shrink-0"
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
                      d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
                    />
                  </svg>
                </div>
                <div class="ml-4">
                  <h4 class="font-medium text-gray-800">{{ t('home.contact.info.email') }}</h4>
                  <p class="text-gray-600">contact@nodeforge.com</p>
                </div>
              </div>
            </div>

            <!-- 社交媒体 -->
            <div class="mt-8">
              <h4 class="font-medium text-gray-800 mb-4">{{ t('home.contact.social.title') }}</h4>
              <div class="flex space-x-4">
                <a
                  href="#"
                  class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary hover:bg-primary hover:text-white transition-all duration-300"
                >
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="currentColor" viewBox="0 0 24 24">
                    <path
                      d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"
                    />
                  </svg>
                </a>
                <a
                  href="#"
                  class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary hover:bg-primary hover:text-white transition-all duration-300"
                >
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="currentColor" viewBox="0 0 24 24">
                    <path
                      d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"
                    />
                  </svg>
                </a>
                <a
                  href="#"
                  class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary hover:bg-primary hover:text-white transition-all duration-300"
                >
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="currentColor" viewBox="0 0 24 24">
                    <path
                      d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"
                    />
                  </svg>
                </a>
              </div>
            </div>
          </div>

          <!-- 联系表单 -->
          <div class="bg-white rounded-lg p-6 shadow-sm">
            <h3 class="text-xl font-semibold text-gray-800 mb-6">{{ t('home.contact.form.title') }}</h3>
            <form class="space-y-4" @submit.prevent="submitContact">
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-1" for="name">{{
                    t('home.contact.form.name')
                  }}</label>
                  <input
                    id="name"
                    v-model="contactForm.name"
                    type="text"
                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary"
                    :placeholder="t('home.contact.form.namePlaceholder')"
                    required
                  />
                </div>
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-1" for="phone">{{
                    t('home.contact.form.phone')
                  }}</label>
                  <input
                    id="phone"
                    v-model="contactForm.phone"
                    type="tel"
                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary"
                    :placeholder="t('home.contact.form.phonePlaceholder')"
                  />
                </div>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1" for="email">{{
                  t('home.contact.form.email')
                }}</label>
                <input
                  id="email"
                  v-model="contactForm.email"
                  type="email"
                  class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary"
                  :placeholder="t('home.contact.form.emailPlaceholder')"
                />
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1" for="subject">
                  {{ t('home.contact.form.subject') }}
                </label>
                <select
                  id="subject"
                  v-model="contactForm.subject"
                  class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary"
                >
                  <option value="">{{ t('home.contact.form.subjectPlaceholder') }}</option>
                  <option value="product">{{ t('home.contact.form.subjectProduct') }}</option>
                  <option value="cooperation">{{ t('home.contact.form.subjectCooperation') }}</option>
                  <option value="technical">{{ t('home.contact.form.subjectTechnical') }}</option>
                  <option value="other">{{ t('home.contact.form.subjectOther') }}</option>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1" for="message">
                  {{ t('home.contact.form.message') }}
                </label>
                <textarea
                  id="message"
                  v-model="contactForm.message"
                  rows="4"
                  class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary"
                  :placeholder="t('home.contact.form.messagePlaceholder')"
                  required
                ></textarea>
              </div>
              <button
                type="submit"
                :disabled="submitting"
                class="w-full bg-primary hover:bg-primary/90 text-white font-medium px-4 py-3 rounded-md transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                {{ submitting ? t('home.contact.form.submitting') : t('home.contact.form.submit') }}
              </button>
              <div v-if="submitSuccess" class="text-green-600 text-sm text-center">
                {{ t('home.contact.form.success') }}
              </div>
              <div v-if="submitError" class="text-red-600 text-sm text-center">
                {{ submitError }}
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
  </main>
</template>

<script setup lang="ts">
  import { Navigation, Pagination, Autoplay } from 'swiper/modules';
  import { Swiper, SwiperSlide } from 'swiper/vue';
  import 'swiper/css';
  import 'swiper/css/navigation';
  import 'swiper/css/pagination';

  const modules = [Navigation, Pagination, Autoplay];
  const { locale } = useI18n();
  const localePath = useLocalePath();

  // 获取首页SEO配置
  const [{ t }, { data: seoData }] = await Promise.all([
    useI18nLoader(),
    useFetch('/api/public/cms/seo/get', {
      query: { pageType: 'home' }
    })
  ]);

  // 设置SEO meta标签
  const seoConfig = seoData.value?.data;
  const currentLocale = locale.value as 'zh' | 'en';

  const defaultTitle = {
    zh: '',
    en: ''
  };
  const defaultDescription = {
    zh: '',
    en: ''
  };
  const defaultKeywords = {
    zh: '',
    en: ''
  };

  // 获取当前语言的SEO配置
  const getTitle = () =>
    seoConfig?.title?.[currentLocale] || seoConfig?.title?.zh || defaultTitle[currentLocale] || defaultTitle.zh;
  const getKeywords = () =>
    seoConfig?.keywords?.[currentLocale] ||
    seoConfig?.keywords?.zh ||
    defaultKeywords[currentLocale] ||
    defaultKeywords.zh;
  const getDescription = () =>
    seoConfig?.description?.[currentLocale] ||
    seoConfig?.description?.zh ||
    defaultDescription[currentLocale] ||
    defaultDescription.zh;
  const getOgTitle = () => seoConfig?.ogTitle?.[currentLocale] || seoConfig?.ogTitle?.zh || getTitle();
  const getOgDescription = () =>
    seoConfig?.ogDescription?.[currentLocale] || seoConfig?.ogDescription?.zh || getDescription();

  useHead({
    title: getTitle(),
    meta: [
      { name: 'description', content: getDescription() },
      { name: 'keywords', content: getKeywords() },
      { property: 'og:title', content: getOgTitle() },
      { property: 'og:description', content: getOgDescription() },
      { property: 'og:image', content: seoConfig?.ogImage || '/favicon.png' },
      { property: 'og:type', content: 'website' }
    ]
  });

  const [{ data: bannerListData }, { data: productListData }, { data: newsData }, { data: topNewsData }]: any =
    await Promise.all([
      useFetch('/api/public/cms/banner/list'),
      useFetch('/api/public/cms/product/list', {
        query: {
          isRecommend: '1',
          limit: 3
        }
      }),
      useFetch('/api/public/cms/news/list', {
        query: {
          isRecommend: '1',
          limit: 3
        }
      }),
      useFetch('/api/public/cms/news/list', {
        query: {
          isTop: '1',
          limit: 1
        }
      })
    ]);

  // 联系表单
  const contactForm = ref({
    name: '',
    phone: '',
    email: '',
    subject: '',
    message: ''
  });

  const submitting = ref(false);
  const submitSuccess = ref(false);
  const submitError = ref('');

  async function submitContact() {
    submitting.value = true;
    submitSuccess.value = false;
    submitError.value = '';

    try {
      await $fetch('/api/public/cms/contact', {
        method: 'POST',
        body: contactForm.value
      });
      submitSuccess.value = true;
      // 重置表单
      contactForm.value = {
        name: '',
        phone: '',
        email: '',
        subject: '',
        message: ''
      };
      // 3秒后隐藏成功消息
      setTimeout(() => {
        submitSuccess.value = false;
      }, 3000);
    } catch (error: any) {
      submitError.value = error.data?.message || t('home.contact.form.error');
    } finally {
      submitting.value = false;
    }
  }

  function productLink(product: any) {
    let categoryUrl = '';
    product.categoryMpath.forEach((item: any) => {
      categoryUrl += `/${item.urlKey}`;
    });
    return localePath(`${categoryUrl}/${product.productId}`);
  }

  function newsLink(news: any) {
    let categoryUrl = '';
    news.categoryMpath.forEach((item: any) => {
      categoryUrl += `/${item.urlKey}`;
    });
    return localePath(`${categoryUrl}/${news.newsId}`);
  }
</script>

<style scoped></style>
