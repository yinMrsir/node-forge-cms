<template>
  <div class="app-container">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span>首页SEO配置</span>
        </div>
      </template>

      <el-tabs v-model="activeLang">
        <el-tab-pane :label="item.name" :name="item.code" v-for="item in locales" :key="item.code" />
      </el-tabs>

      <el-form ref="formRef" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="SEO标题" prop="title">
          <el-input
            v-model="form.title[activeLang]"
            placeholder="请输入SEO标题，建议长度50-60个字符"
            maxlength="200"
            show-word-limit
          />
          <div class="form-tip">显示在浏览器标签页上的标题</div>
        </el-form-item>
        <el-form-item label="关键词" prop="keywords">
          <el-input
            v-model="form.keywords[activeLang]"
            type="textarea"
            :rows="2"
            placeholder="请输入关键词，多个关键词用逗号分隔"
            maxlength="500"
            show-word-limit
          />
          <div class="form-tip">用于搜索引擎优化，多个关键词用英文逗号分隔</div>
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input
            v-model="form.description[activeLang]"
            type="textarea"
            :rows="3"
            placeholder="请输入页面描述，建议长度150-160个字符"
            maxlength="500"
            show-word-limit
          />
          <div class="form-tip">显示在搜索结果中的描述文字</div>
        </el-form-item>
        <el-divider content-position="left">社交媒体分享优化 (OG)</el-divider>
        <el-form-item label="分享标题">
          <el-input
            v-model="form.ogTitle[activeLang]"
            placeholder="留空则使用SEO标题"
            maxlength="200"
            show-word-limit
          />
          <div class="form-tip">分享到微信、微博等社交媒体时显示的标题</div>
        </el-form-item>
        <el-form-item label="分享描述">
          <el-input
            v-model="form.ogDescription[activeLang]"
            type="textarea"
            :rows="2"
            placeholder="留空则使用页面描述"
            maxlength="500"
            show-word-limit
          />
          <div class="form-tip">分享到社交媒体时显示的描述</div>
        </el-form-item>
        <el-form-item label="分享图片">
          <el-input v-model="form.ogImage" placeholder="社交媒体分享时显示的图片URL" />
          <div class="form-tip">建议尺寸：1200x630px，支持jpg/png格式</div>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :loading="loading" @click="submitForm">保存配置</el-button>
          <el-button @click="resetForm">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup name="Seo">
  import { getSeoList, addSeo, updateSeo } from '@/api/cms/seo';
  import { useListLocale } from '@/hooks/useListLocale';

  const { locales } = useListLocale();
  const { proxy } = getCurrentInstance();

  const formRef = ref(null);
  const loading = ref(false);
  const activeLang = ref('zh');

  const form = ref({
    id: null,
    pageType: 'home',
    pageKey: '',
    title: {},
    keywords: {},
    description: {},
    ogTitle: {},
    ogDescription: {},
    ogImage: ''
  });

  // 初始化默认值
  const defaultValues = {
    title: {
      zh: 'NodeForge - 企业级CMS内容管理系统',
      en: 'NodeForge - Enterprise CMS Content Management System'
    },
    keywords: {
      zh: 'CMS,内容管理系统,企业级CMS,Node.js,Nuxt,Vue,网站建设,数字化官网',
      en: 'CMS,Content Management System,Enterprise CMS,Node.js,Nuxt,Vue,Web Development,Digital Platform'
    },
    description: {
      zh: 'NodeForge专注于企业数字化解决方案，提供高性能、可扩展的CMS系统和全栈技术服务，帮助企业快速搭建数字化官网、内容管理平台。',
      en: 'NodeForge specializes in enterprise digital solutions, providing high-performance, scalable CMS systems and full-stack technical services to help enterprises rapidly build digital websites and content management platforms.'
    }
  };

  const rules = {
    title: [
      {
        validator: (rule, value, callback) => {
          const localesValue = locales.value;
          if (localesValue.length === 0) {
            callback();
            return;
          }
          const hasEmpty = localesValue.some(locale => !value || !value[locale.code]);
          if (hasEmpty) {
            callback(new Error('请输入所有语言的SEO标题'));
          } else {
            callback();
          }
        },
        trigger: 'blur'
      }
    ],
    keywords: [
      {
        validator: (rule, value, callback) => {
          const localesValue = locales.value;
          if (localesValue.length === 0) {
            callback();
            return;
          }
          const hasEmpty = localesValue.some(locale => !value || !value[locale.code]);
          if (hasEmpty) {
            callback(new Error('请输入所有语言的关键词'));
          } else {
            callback();
          }
        },
        trigger: 'blur'
      }
    ],
    description: [
      {
        validator: (rule, value, callback) => {
          const localesValue = locales.value;
          if (localesValue.length === 0) {
            callback();
            return;
          }
          const hasEmpty = localesValue.some(locale => !value || !value[locale.code]);
          if (hasEmpty) {
            callback(new Error('请输入所有语言的描述'));
          } else {
            callback();
          }
        },
        trigger: 'blur'
      }
    ]
  };

  // 获取首页SEO配置
  function getConfig() {
    getSeoList({ pageType: 'home', pageNum: 1, limit: 1 }).then(res => {
      if (res.data && res.data.length > 0) {
        // 解析JSON字段
        const data = res.data[0];
        form.value = {
          ...data,
          title: typeof data.title === 'string' ? JSON.parse(data.title) : data.title,
          keywords: typeof data.keywords === 'string' ? JSON.parse(data.keywords) : data.keywords,
          description: typeof data.description === 'string' ? JSON.parse(data.description) : data.description,
          ogTitle: typeof data.ogTitle === 'string' ? JSON.parse(data.ogTitle) : data.ogTitle,
          ogDescription: typeof data.ogDescription === 'string' ? JSON.parse(data.ogDescription) : data.ogDescription
        };
      } else {
        // 使用默认值
        form.value = {
          ...form.value,
          ...defaultValues
        };
      }
    });
  }

  // 提交表单
  function submitForm() {
    formRef.value.validate(valid => {
      if (valid) {
        loading.value = true;
        const api = form.value.id ? updateSeo : addSeo;
        api(form.value)
          .then(() => {
            proxy.$modal.msgSuccess('保存成功');
            if (!form.value.id) {
              form.value.id = 'temp'; // 防止重复新增
            }
          })
          .finally(() => {
            loading.value = false;
          });
      }
    });
  }

  // 重置表单
  function resetForm() {
    getConfig();
    formRef.value?.resetFields();
  }

  getConfig();
</script>

<style scoped>
  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .form-tip {
    font-size: 12px;
    color: #999;
    margin-top: 4px;
  }
</style>
