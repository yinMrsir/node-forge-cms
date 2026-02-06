<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="分类状态" clearable>
          <el-option label="草稿" value="0" />
          <el-option label="发布" value="1" />
          <el-option label="下架" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['cms:category:add']">
          新增
        </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table
      v-loading="loading"
      :data="categoryList"
      row-key="categoryId"
      :tree-props="{ children: 'children' }"
      default-expand-all
    >
      <el-table-column label="分类名称" prop="categoryName" min-width="260">
        <template #default="scope">
          {{ scope.row.categoryName?.zh || '' }}
        </template>
      </el-table-column>
      <el-table-column label="URL_KEY" prop="urlKey" />
      <el-table-column label="重定向地址" prop="redirectUrl" />
      <el-table-column label="栏目类型" prop="templateType" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.templateType === 'news'">新闻列表</el-tag>
          <el-tag v-if="scope.row.templateType === 'products'" type="success">产品列表</el-tag>
          <el-tag v-if="scope.row.templateType === 'content'" type="warning">内容页</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="排序" prop="orderNum" width="100" />
      <el-table-column label="推荐" prop="isRecommend" width="80">
        <template #default="scope">
          <el-switch
            v-model="scope.row.isRecommend"
            active-value="1"
            inactive-value="0"
            @change="handleRecommendChange(scope.row)"
          ></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="状态" prop="status" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.status === '0'" type="info">草稿</el-tag>
          <el-tag v-else-if="scope.row.status === '1'" type="success">发布</el-tag>
          <el-tag v-else type="warning">下架</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" prop="updateTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="200" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['cms:category:edit']"
            >修改</el-button
          >
          <el-button
            link
            type="primary"
            icon="Delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['cms:category:remove']"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <!-- 添加或修改分类对话框 -->
    <el-dialog :title="title" v-model="open" width="600px" append-to-body>
      <el-form v-if="open" ref="categoryRef" :model="form" :rules="rules" label-width="150px">
        <el-tabs v-model="activeTab">
          <el-tab-pane :label="item.name" :name="item.code" v-for="item in locales" :key="item.code">
            <el-form-item :label="`分类名称(${item.name})`" :prop="`categoryName.${item.code}`">
              <div style="display: flex; gap: 8px; flex: 1">
                <el-input v-model="form.categoryName[item.code]" :placeholder="`请输入分类名称(${item.name})`" style="flex: 1" />
                <el-button
                  v-if="item.code !== 'zh' && form.categoryName?.zh"
                  type="primary"
                  :icon="icons.MagicStick"
                  :loading="translating.categoryName"
                  @click="handleTranslate('categoryName', item.code)"
                  title="AI翻译"
                >
                  AI翻译
                </el-button>
              </div>
            </el-form-item>
            <el-form-item :label="`关键词(${item.name})`">
              <div style="display: flex; gap: 8px; flex: 1">
                <el-input v-model="form.keywords[item.code]" :placeholder="`请输入关键词(${item.name})`" style="flex: 1" />
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
                <el-input v-model="form.description[item.code]" :placeholder="`请输入描述(${item.name})`" style="flex: 1" />
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
          </el-tab-pane>
        </el-tabs>

        <!-- 一键翻译所有语言按钮 -->
        <el-form-item v-if="hasNonZhLanguages">
          <el-button type="success" :icon="icons.MagicStick" :loading="translating.all" @click="handleTranslateAll">
            一键翻译所有语言
          </el-button>
          <span style="margin-left: 10px; color: #999; font-size: 12px"> 将中文内容翻译成所有其他语言 </span>
        </el-form-item>
        <el-form-item label="父级分类" prop="parentCategoryId">
          <el-tree-select
            :render-after-expand="false"
            v-model="form.parentCategoryId"
            :data="categoryOptions"
            :props="{ value: 'id', label: 'label', children: 'children' }"
            value-key="id"
            placeholder="选择父级分类"
            check-strictly
            clearable
          />
        </el-form-item>
        <el-form-item label="URL_KEY" prop="urlKey">
          <el-input v-model="form.urlKey" />
        </el-form-item>
        <el-form-item label="栏目类型" prop="templateType">
          <el-radio-group v-model="form.templateType">
            <el-radio label="news">新闻列表</el-radio>
            <el-radio label="products">产品列表</el-radio>
            <el-radio label="content">内容页</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="重定向地址" prop="redirectUrl">
          <el-input v-model="form.redirectUrl" placeholder="请输入地址"></el-input>
        </el-form-item>
        <el-form-item label="显示排序" prop="orderNum">
          <el-input-number v-model="form.orderNum" controls-position="right" :min="0" />
        </el-form-item>
        <el-form-item label="推荐" prop="isRecommend">
          <el-switch v-model="form.isRecommend" active-value="1" inactive-value="0" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">草稿</el-radio>
            <el-radio label="1">发布</el-radio>
            <el-radio label="2">下架</el-radio>
          </el-radio-group>
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

<script setup name="Category">
  import {
    listCategory,
    getCategory,
    addCategory,
    updateCategory,
    delCategory,
    changeCategoryRecommend
  } from '@/api/cms/category';
  import { useListLocale } from '@/hooks/useListLocale';
  import { translateText } from '@/api/ai';
  import * as ElementPlusIconsVue from '@element-plus/icons-vue';

  const { locales } = useListLocale();
  const { proxy } = getCurrentInstance();
  const icons = ElementPlusIconsVue;

  const categoryList = ref([]);
  const categoryOptions = ref([]);
  const open = ref(false);
  const loading = ref(true);
  const showSearch = ref(true);
  const activeTab = ref('zh');
  const title = ref('');

  // 翻译状态
  const translating = reactive({
    categoryName: false,
    keywords: false,
    description: false,
    all: false
  });

  const data = reactive({
    form: {},
    queryParams: {
      categoryType: null,
      status: null,
      limit: 1000
    },
    rules: {
      'categoryName.zh': [{ required: true, message: '分类名称(中文)不能为空', trigger: 'blur' }],
      urlKey: [{ required: true, message: '请输入URL_KEY', trigger: 'change' }],
      templateType: [{ required: true, message: '请选择模板类型', trigger: 'change' }]
    }
  });

  const { queryParams, form, rules } = toRefs(data);

  // 计算是否有非中文语言
  const hasNonZhLanguages = computed(() => {
    return locales.value.some(locale => locale.code !== 'zh');
  });

  /** 查询分类列表 */
  function getList() {
    loading.value = true;
    listCategory(queryParams.value).then(response => {
      categoryList.value = proxy.handleTree(response.data.rows, 'categoryId', 'parentCategoryId');
      loading.value = false;
    });
  }

  /** 查询分类下拉树结构 */
  function getTreeselect() {
    listCategory().then(response => {
      categoryOptions.value = [
        {
          id: 0,
          label: '顶级分类',
          children: proxy.handleTree(
            response.data.rows.map(item => ({ ...item, id: item.categoryId, label: item.categoryName.zh })),
            'categoryId',
            'parentCategoryId'
          )
        }
      ];
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
      categoryId: null,
      parentCategoryId: 0,
      categoryName: {},
      keywords: {},
      description: {},
      categoryType: '1',
      orderNum: 0,
      isRecommend: '0',
      status: '1',
      urlKey: undefined,
      templateType: undefined,
      detailTemplateType: undefined
    };
    proxy.resetForm('categoryRef');
  }

  /** 搜索按钮操作 */
  function handleQuery() {
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
    getTreeselect();
    open.value = true;
    title.value = '添加分类';
  }

  /** 修改按钮操作 */
  function handleUpdate(row) {
    reset();
    getTreeselect();
    const categoryId = row.categoryId || ids[0];
    getCategory(categoryId).then(response => {
      form.value = {
        ...response.data
      };
      open.value = true;
      title.value = '修改分类';
    });
  }

  /** 提交按钮 */
  function submitForm() {
    proxy.$refs['categoryRef'].validate(valid => {
      if (valid) {
        const data = {
          ...form.value
        };
        if (form.value.categoryId != undefined) {
          updateCategory(data).then(response => {
            proxy.$modal.msgSuccess('修改成功');
            open.value = false;
            getList();
          });
        } else {
          addCategory(data).then(response => {
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
      .confirm('是否确认删除名称为"' + row.categoryName?.zh + '"的数据项？')
      .then(function () {
        return delCategory(row.categoryId);
      })
      .then(() => {
        getList();
        proxy.$modal.msgSuccess('删除成功');
      })
      .catch(() => {});
  }

  /** 推荐操作 */
  function handleRecommendChange(row) {
    const text = row.isRecommend === '1' ? '设为推荐' : '取消推荐';
    proxy.$modal
      .confirm(`确认要${text}""${row.categoryName?.zh}"分类吗？`)
      .then(() => {
        return changeCategoryRecommend(row.categoryId, row.isRecommend);
      })
      .then(() => {
        proxy.$modal.msgSuccess('操作成功');
        getList();
      })
      .catch(() => {
        row.isRecommend = row.isRecommend === '1' ? '0' : '1';
      });
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
      (form.value.categoryName?.zh && form.value.categoryName.zh.trim()) ||
      (form.value.keywords?.zh && form.value.keywords.zh.trim()) ||
      (form.value.description?.zh && form.value.description.zh.trim());

    if (!hasChineseContent) {
      proxy.$modal.msgWarning('请先输入中文内容');
      return;
    }

    translating.all = true;
    const nonZhLocales = locales.value.filter(locale => locale.code !== 'zh');

    try {
      for (const locale of nonZhLocales) {
        if (form.value.categoryName?.zh && form.value.categoryName.zh.trim()) {
          try {
            const response = await translateText({
              text: form.value.categoryName.zh,
              targetLang: locale.code
            });
            if (response.data?.translatedText) {
              form.value.categoryName[locale.code] = response.data.translatedText;
            }
          } catch (e) {
            console.error(`翻译分类名称到${locale.name}失败:`, e);
          }
        }

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

  getList();
</script>
