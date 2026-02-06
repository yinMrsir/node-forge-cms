<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="产品名称" prop="productName">
        <el-input v-model="queryParams.productName" placeholder="请输入产品名称" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="分类" prop="categoryId">
        <el-tree-select
          v-model="form.categoryId"
          :data="categoryOptions"
          :props="{ value: 'id', label: 'label', children: 'children' }"
          value-key="id"
          placeholder="选择父级分类"
          check-strictly
          clearable
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="产品状态" clearable>
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
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['cms:product:add']">
          新增
        </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="productList">
      <el-table-column label="主图" prop="mainImage" width="120">
        <template #default="scope">
          <el-image
            v-if="scope.row.mainImage"
            :src="scope.row.mainImage"
            style="width: 80px; height: 80px"
            fit="cover"
          />
        </template>
      </el-table-column>
      <el-table-column label="产品名称" prop="productName" min-width="300">
        <template #default="scope">
          <span>{{ scope.row.productName?.zh || '' }}</span>
          <div>
            <el-tag v-if="scope.row.isRecommend === '1'" type="warning" size="small">推荐</el-tag>
            <el-tag v-if="scope.row.isNew === '1'" type="danger" size="small">新品</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="分类" prop="categoryId" min-width="120">
        <template #default="scope">
          {{ scope.row.category?.categoryName?.zh || '-' }}
        </template>
      </el-table-column>
      <el-table-column label="浏览量" prop="viewCount" width="100" />
      <el-table-column label="状态" prop="status" width="100">
        <template #default="scope">
          <el-switch
            v-model="scope.row.status"
            active-value="1"
            inactive-value="0"
            @change="handleStatusChange(scope.row)"
          ></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" prop="updateTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.updateTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="250" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['cms:product:edit']"
            >修改</el-button
          >
          <el-button link type="primary" @click="handleRecommend(scope.row)" v-hasPermi="['cms:product:edit']">
            {{ scope.row.isRecommend === '1' ? '取消推荐' : '推荐' }}
          </el-button>
          <el-button link type="primary" @click="handleNew(scope.row)" v-hasPermi="['cms:product:edit']">
            {{ scope.row.isNew === '1' ? '取消新品' : '新品' }}
          </el-button>
          <el-button
            link
            type="primary"
            icon="Delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['cms:product:remove']"
          ></el-button>
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

    <!-- 添加或修改产品对话框 -->
    <el-dialog :title="title" v-model="open" width="900px" append-to-body>
      <el-form v-if="open" ref="productRef" :model="form" :rules="rules" label-width="160px">
        <el-tabs v-model="activeTab">
          <el-tab-pane :label="item.name" :name="item.code" v-for="item in locales" :key="item.code">
            <el-form-item :label="`产品名称(${item.name})`" :prop="`productName.${item.code}`">
              <div style="display: flex; gap: 8px; flex: 1">
                <el-input v-model="form.productName[item.code]" :placeholder="`请输入产品名称(${item.name})`" style="flex: 1" />
                <el-button
                  v-if="item.code !== 'zh' && form.productName?.zh"
                  type="primary"
                  :icon="icons.MagicStick"
                  :loading="translating.productName"
                  @click="handleTranslate('productName', item.code)"
                  title="AI翻译"
                >
                  AI翻译
                </el-button>
              </div>
            </el-form-item>
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
            <el-form-item :label="`简介(${item.name})`">
              <div style="display: flex; gap: 8px; flex: 1">
                <el-input
                  v-model="form.summary[item.code]"
                  type="textarea"
                  :rows="2"
                  :placeholder="`请输入简介(${item.name})`"
                  style="flex: 1"
                />
                <el-button
                  v-if="item.code !== 'zh' && form.summary?.zh"
                  type="primary"
                  :icon="icons.MagicStick"
                  :loading="translating.summary"
                  @click="handleTranslate('summary', item.code)"
                  title="AI翻译"
                >
                  AI翻译
                </el-button>
              </div>
            </el-form-item>
            <el-form-item :label="`描述(${item.name})`" :prop="`description.${item.code}`">
              <div style="display: flex; gap: 8px; flex: 1">
                <rich-text-editor v-model="form.description[item.code]" style="flex: 1" />
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

        <el-form-item label="分类" prop="categoryId">
          <el-tree-select
            v-model="form.categoryId"
            :data="categoryOptions"
            :props="{ value: 'id', label: 'label', children: 'children' }"
            value-key="id"
            placeholder="选择父级分类"
            check-strictly
            clearable
          />
        </el-form-item>

        <el-form-item label="主图" prop="mainImage">
          <image-upload v-model="form.mainImage" :limit="1" />
        </el-form-item>

        <el-form-item label="产品多图">
          <image-upload v-model="form.images" :limit="10" />
        </el-form-item>

        <el-form-item label="属性">
          <el-checkbox v-model="form.isRecommend" :true-label="'1'" :false-label="'0'">推荐</el-checkbox>
          <el-checkbox v-model="form.isNew" :true-label="'1'" :false-label="'0'">新品</el-checkbox>
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

<script setup name="Product">
  import RichTextEditor from '@/components/RichTextEditor';
  import {
    listProduct,
    getProduct,
    addProduct,
    updateProduct,
    delProduct,
    changeProductStatus,
    changeProductRecommend,
    changeProductNew
  } from '@/api/cms/product';
  import { listCategory } from '@/api/cms/category';
  import { useListLocale } from '@/hooks/useListLocale';
  import { translateText } from '@/api/ai';
  import * as ElementPlusIconsVue from '@element-plus/icons-vue';

  const { locales } = useListLocale();
  const { proxy } = getCurrentInstance();
  const icons = ElementPlusIconsVue;

  const productList = ref([]);
  const categoryOptions = ref([]);
  const open = ref(false);
  const loading = ref(true);
  const showSearch = ref(true);
  const activeTab = ref('zh');
  const title = ref('');
  const total = ref(0);

  // 翻译状态
  const translating = reactive({
    productName: false,
    keywords: false,
    summary: false,
    description: false,
    all: false
  });

  const data = reactive({
    form: {},
    queryParams: {
      pageNum: 1,
      limit: 10,
      productName: null,
      categoryId: null,
      status: null
    },
    rules: {
      'productName.zh': [{ required: true, message: '产品名称(中文)不能为空', trigger: 'blur' }],
      'description.zh': [{ required: true, message: '描述(中文)不能为空', trigger: 'blur' }],
      categoryId: [{ required: true, message: '请选择分类', trigger: 'change' }]
    }
  });

  const { queryParams, form, rules } = toRefs(data);

  // 计算是否有非中文语言
  const hasNonZhLanguages = computed(() => {
    return locales.value.some(locale => locale.code !== 'zh');
  });

  /** 查询产品列表 */
  function getList() {
    loading.value = true;
    listProduct(queryParams.value).then(response => {
      productList.value = response.data.rows;
      total.value = response.data.total;
      loading.value = false;
    });
  }

  /** 查询分类下拉树结构 */
  function getCategoryOptions() {
    listCategory({ templateType: 'products' }).then(response => {
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
      productId: null,
      productName: {},
      keywords: {},
      summary: {},
      description: {},
      categoryId: null,
      mainImage: null,
      images: [],
      isRecommend: '0',
      isNew: '0',
      status: '1'
    };
    proxy.resetForm('productRef');
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
    title.value = '添加产品';
  }

  /** 修改按钮操作 */
  function handleUpdate(row) {
    reset();
    getCategoryOptions();
    const productId = row.productId;
    getProduct(productId).then(response => {
      form.value = {
        ...response.data
      };
      open.value = true;
      title.value = '修改产品';
    });
  }

  /** 提交按钮 */
  function submitForm() {
    proxy.$refs['productRef'].validate(valid => {
      if (valid) {
        const data = {
          ...form.value,
          images: typeof form.value.images === 'string' ? form.value.images : form.value.images.join(',')
        };
        if (form.value.productId != undefined) {
          updateProduct(data).then(response => {
            proxy.$modal.msgSuccess('修改成功');
            open.value = false;
            getList();
          });
        } else {
          addProduct(data).then(response => {
            proxy.$modal.msgSuccess('新增成功');
            open.value = false;
            getList();
          });
        }
      }
    });
  }

  /** 状态修改 */
  function handleStatusChange(row) {
    const text = row.status === '1' ? '发布' : '草稿';
    proxy.$modal
      .confirm('确认要"' + text + '""' + row.productName?.zh + '"产品吗？')
      .then(() => {
        return changeProductStatus(row.productId, row.status);
      })
      .then(() => {
        proxy.$modal.msgSuccess('操作成功');
      })
      .catch(() => {
        row.status = row.status === '1' ? '0' : '1';
      });
  }

  /** 推荐操作 */
  function handleRecommend(row) {
    const text = row.isRecommend === '1' ? '取消推荐' : '推荐';
    proxy.$modal
      .confirm('确认要"' + text + '""' + row.productName?.zh + '"吗？')
      .then(() => {
        const newRecommend = row.isRecommend === '1' ? '0' : '1';
        return changeProductRecommend(row.productId, newRecommend);
      })
      .then(() => {
        proxy.$modal.msgSuccess('操作成功');
        getList();
      });
  }

  /** 新品操作 */
  function handleNew(row) {
    const text = row.isNew === '1' ? '取消新品' : '设为新品';
    proxy.$modal
      .confirm('确认要"' + text + '""' + row.productName?.zh + '"吗？')
      .then(() => {
        const newIsNew = row.isNew === '1' ? '0' : '1';
        return changeProductNew(row.productId, newIsNew);
      })
      .then(() => {
        proxy.$modal.msgSuccess('操作成功');
        getList();
      });
  }

  /** 删除按钮操作 */
  function handleDelete(row) {
    proxy.$modal
      .confirm('是否确认删除产品名称为"' + row.productName?.zh + '"的数据项？')
      .then(function () {
        return delProduct(row.productId);
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
      (form.value.productName?.zh && form.value.productName.zh.trim()) ||
      (form.value.keywords?.zh && form.value.keywords.zh.trim()) ||
      (form.value.summary?.zh && form.value.summary.zh.trim()) ||
      (form.value.description?.zh && form.value.description.zh.trim());

    if (!hasChineseContent) {
      proxy.$modal.msgWarning('请先输入中文内容');
      return;
    }

    translating.all = true;
    const nonZhLocales = locales.value.filter(locale => locale.code !== 'zh');

    try {
      for (const locale of nonZhLocales) {
        if (form.value.productName?.zh && form.value.productName.zh.trim()) {
          try {
            const response = await translateText({
              text: form.value.productName.zh,
              targetLang: locale.code
            });
            if (response.data?.translatedText) {
              form.value.productName[locale.code] = response.data.translatedText;
            }
          } catch (e) {
            console.error(`翻译产品名称到${locale.name}失败:`, e);
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

        if (form.value.summary?.zh && form.value.summary.zh.trim()) {
          try {
            const response = await translateText({
              text: form.value.summary.zh,
              targetLang: locale.code
            });
            if (response.data?.translatedText) {
              form.value.summary[locale.code] = response.data.translatedText;
            }
          } catch (e) {
            console.error(`翻译简介到${locale.name}失败:`, e);
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

  getCategoryOptions();
  getList();
</script>
