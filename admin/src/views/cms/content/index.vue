<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="所属栏目" prop="categoryId">
        <el-tree-select
          v-model="queryParams.categoryId"
          :data="categoryOptions"
          :props="{ value: 'id', label: 'label', children: 'children' }"
          value-key="id"
          placeholder="选择栏目"
          check-strictly
          clearable
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['cms:content:add']">
          新增
        </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="contentList">
      <el-table-column label="栏目" prop="categoryId" width="200">
        <template #default="scope">
          {{ scope.row.category?.categoryName?.zh || '-' }}
        </template>
      </el-table-column>
      <el-table-column label="内容预览" prop="content" min-width="300">
        <template #default="scope">
          <span class="content-preview">{{ getContentPreview(scope.row.content) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新人" prop="updateBy" width="180"> </el-table-column>
      <el-table-column label="更新时间" prop="updateTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.updateTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="180" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['cms:content:edit']"
            >修改</el-button
          >
          <el-button
            link
            type="primary"
            icon="Delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['cms:content:remove']"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.limit"
      @pagination="getList"
    />

    <!-- 添加或修改内容对话框 -->
    <el-dialog :title="title" v-model="open" width="900px" append-to-body>
      <el-form v-if="open" ref="contentRef" :model="form" :rules="rules" label-width="120px">
        <el-tabs v-model="activeTab">
          <el-tab-pane :label="item.name" :name="item.code" v-for="item in locales" :key="item.code">
            <el-form-item :label="`关键词(${item.name})`">
              <div style="display: flex; gap: 8px; flex: 1">
                <el-input
                  v-model="form.keywords[item.code]"
                  :placeholder="`请输入关键词(${item.name})，多个关键词用逗号分隔`"
                  style="flex: 1"
                />
                <el-button
                  v-if="item.code !== 'zh' && form.keywords?.zh"
                  type="primary"
                  :icon="icons.MagicStick"
                  :loading="translating.keywords"
                  @click="handleTranslate('keywords', item.code)"
                  title="AI翻译"
                >
                  AI翻译
                </el-button>
              </div>
            </el-form-item>
            <el-form-item :label="`描述(${item.name})`">
              <div style="display: flex; gap: 8px; flex: 1">
                <el-input
                  v-model="form.description[item.code]"
                  type="textarea"
                  :rows="3"
                  :placeholder="`请输入描述(${item.name})`"
                  style="flex: 1"
                />
                <el-button
                  v-if="item.code !== 'zh' && form.description?.zh"
                  type="primary"
                  :icon="icons.MagicStick"
                  :loading="translating.description"
                  @click="handleTranslate('description', item.code)"
                  title="AI翻译"
                >
                  AI翻译
                </el-button>
              </div>
            </el-form-item>
            <el-form-item :label="`内容(${item.name})`" :prop="`content.${item.code}`">
              <div style="display: flex; gap: 8px; flex: 1">
                <rich-text-editor v-model="form.content[item.code]" style="flex: 1" />
                <el-button
                  v-if="item.code !== 'zh' && form.content?.zh"
                  type="primary"
                  :icon="icons.MagicStick"
                  :loading="translating.content"
                  @click="handleTranslate('content', item.code)"
                  title="AI翻译"
                >
                  AI翻译
                </el-button>
              </div>
            </el-form-item>
          </el-tab-pane>
        </el-tabs>

        <!-- 一键翻译所有语言按钮 -->
        <el-form-item v-if="hasNonZhLanguages">
          <el-button type="success" :icon="icons.MagicStick" :loading="translating.all" @click="handleTranslateAll">
            一键翻译所有语言
          </el-button>
          <span style="margin-left: 10px; color: #999; font-size: 12px"> 将中文内容翻译成所有其他语言 </span>
        </el-form-item>

        <el-form-item label="所属栏目" prop="categoryId">
          <el-tree-select
            v-model="form.categoryId"
            :data="categoryOptions"
            :props="{ value: 'id', label: 'label', children: 'children' }"
            value-key="id"
            placeholder="请选择所属栏目"
            check-strictly
            clearable
          />
        </el-form-item>

        <el-form-item label="备注">
          <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Content">
  import RichTextEditor from '@/components/RichTextEditor';
  import { listContent, getContent, addContent, updateContent, delContent } from '@/api/cms/content';
  import { listCategory } from '@/api/cms/category';
  import { useListLocale } from '@/hooks/useListLocale';
  import { translateText } from '@/api/ai';
  import * as ElementPlusIconsVue from '@element-plus/icons-vue';

  const { locales } = useListLocale();
  const { proxy } = getCurrentInstance();
  const icons = ElementPlusIconsVue;

  const contentList = ref([]);
  const categoryOptions = ref([]);
  const open = ref(false);
  const loading = ref(true);
  const showSearch = ref(true);
  const activeTab = ref('zh');
  const title = ref('');
  const total = ref(0);

  // 翻译状态
  const translating = reactive({
    keywords: false,
    description: false,
    content: false,
    all: false
  });

  const data = reactive({
    form: {},
    queryParams: {
      pageNum: 1,
      limit: 10,
      categoryId: null
    },
    rules: {
      'content.zh': [{ required: true, message: '内容(中文)不能为空', trigger: 'blur' }],
      categoryId: [{ required: true, message: '请选择栏目', trigger: 'change' }]
    }
  });

  const { queryParams, form, rules } = toRefs(data);

  // 计算是否有非中文语言
  const hasNonZhLanguages = computed(() => {
    return locales.value.some(locale => locale.code !== 'zh');
  });

  /** 获取内容预览 */
  function getContentPreview(content) {
    if (!content) return '-';
    const text = content.zh || content.en || '';
    // 移除HTML标签并截取前100个字符
    const plainText = text.replace(/<[^>]*>/g, '').replace(/&nbsp;/g, ' ');
    return plainText.length > 100 ? plainText.substring(0, 100) + '...' : plainText;
  }

  /** 查询内容列表 */
  function getList() {
    loading.value = true;
    listContent(queryParams.value).then(response => {
      contentList.value = response.data.rows;
      total.value = response.data.total;
      loading.value = false;
    });
  }

  /** 查询下拉树结构 */
  function getCategoryOptions() {
    listCategory({ templateType: 'content' }).then(response => {
      categoryOptions.value = proxy.handleTree(
        response.data.rows.map(item => ({ ...item, id: item.categoryId, label: item.categoryName.zh })),
        'categoryId',
        'parentCategoryId'
      );
    });
  }

  /** 取消按钮 */
  function cancel() {
    open.value = false;
    reset();
  }

  /** 表单重置 */
  function reset() {
    form.value = {
      contentId: null,
      keywords: {},
      description: {},
      content: {},
      categoryId: null,
      remark: null
    };
    proxy.resetForm('contentRef');
  }

  /** 搜索按钮操作 */
  function handleQuery() {
    queryParams.value.pageNum = 1;
    getList();
  }

  /** 重置按钮操作 */
  function resetQuery() {
    proxy.resetForm('queryRef');
    handleQuery();
  }

  /** 新增按钮操作 */
  function handleAdd() {
    reset();
    getCategoryOptions();
    open.value = true;
    title.value = '添加内容';
  }

  /** 修改按钮操作 */
  function handleUpdate(row) {
    reset();
    getCategoryOptions();
    const contentId = row.contentId;
    getContent(contentId).then(response => {
      form.value = {
        ...response.data
      };
      open.value = true;
      title.value = '修改内容';
    });
  }

  /** 提交按钮 */
  function submitForm() {
    proxy.$refs['contentRef'].validate(valid => {
      if (valid) {
        const data = {
          ...form.value
        };
        if (form.value.contentId != undefined) {
          updateContent(data).then(response => {
            proxy.$modal.msgSuccess('修改成功');
            open.value = false;
            getList();
          });
        } else {
          addContent(data).then(response => {
            proxy.$modal.msgSuccess('新增成功');
            open.value = false;
            getList();
          });
        }
      }
    });
  }

  /** 删除按钮操作 */
  function handleDelete(row) {
    proxy.$modal
      .confirm('是否确认删除该内容？')
      .then(function () {
        return delContent(row.contentId);
      })
      .then(() => {
        getList();
        proxy.$modal.msgSuccess('删除成功');
      })
      .catch(() => {});
  }

  /** AI翻译单个字段 */
  async function handleTranslate(field, targetLang) {
    const sourceText = form.value[field]?.zh;
    if (!sourceText || !sourceText.trim()) {
      proxy.$modal.msgWarning('请先输入中文内容');
      return;
    }

    translating[field] = true;
    try {
      const response = await translateText({
        text: sourceText,
        targetLang: targetLang
      });

      if (response.data && response.data.translatedText) {
        form.value[field][targetLang] = response.data.translatedText;
        proxy.$modal.msgSuccess('翻译成功');
      } else {
        proxy.$modal.msgError('翻译失败，请重试');
      }
    } catch (error) {
      console.error('AI翻译错误:', error);
      proxy.$modal.msgError(error.message || '翻译失败，请检查AI配置');
    } finally {
      translating[field] = false;
    }
  }

  /** AI翻译所有字段 */
  async function handleTranslateAll() {
    const hasChineseContent =
      (form.value.keywords?.zh && form.value.keywords.zh.trim()) ||
      (form.value.description?.zh && form.value.description.zh.trim()) ||
      (form.value.content?.zh && form.value.content.zh.trim());

    if (!hasChineseContent) {
      proxy.$modal.msgWarning('请先输入中文内容');
      return;
    }

    translating.all = true;
    const nonZhLocales = locales.value.filter(locale => locale.code !== 'zh');

    try {
      for (const locale of nonZhLocales) {
        if (form.value.keywords?.zh && form.value.keywords.zh.trim()) {
          try {
            const response = await translateText({
              text: form.value.keywords.zh,
              targetLang: locale.code
            });
            if (response.data?.translatedText) {
              form.value.keywords[locale.code] = response.data.translatedText;
            }
          } catch (e) {
            console.error(`翻译关键词到${locale.name}失败:`, e);
          }
        }

        if (form.value.description?.zh && form.value.description.zh.trim()) {
          try {
            const response = await translateText({
              text: form.value.description.zh,
              targetLang: locale.code
            });
            if (response.data?.translatedText) {
              form.value.description[locale.code] = response.data.translatedText;
            }
          } catch (e) {
            console.error(`翻译描述到${locale.name}失败:`, e);
          }
        }

        if (form.value.content?.zh && form.value.content.zh.trim()) {
          try {
            const response = await translateText({
              text: form.value.content.zh,
              targetLang: locale.code
            });
            if (response.data?.translatedText) {
              form.value.content[locale.code] = response.data.translatedText;
            }
          } catch (e) {
            console.error(`翻译内容到${locale.name}失败:`, e);
          }
        }

        await new Promise(resolve => setTimeout(resolve, 500));
      }

      proxy.$modal.msgSuccess('批量翻译完成');
    } catch (error) {
      console.error('批量翻译错误:', error);
      proxy.$modal.msgError(error.message || '批量翻译失败');
    } finally {
      translating.all = false;
    }
  }

  getCategoryOptions();
  getList();
</script>

<style scoped>
  .content-preview {
    color: #606266;
    font-size: 13px;
  }
</style>
