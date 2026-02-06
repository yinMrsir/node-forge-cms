<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="轮播图状态" clearable>
          <el-option label="禁用" value="0" />
          <el-option label="启用" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['cms:banner:add']">
          新增
        </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="bannerList">
      <el-table-column label="图片" prop="imageUrl" width="150">
        <template #default="scope">
          <el-image
            v-if="scope.row.imageUrl"
            :src="scope.row.imageUrl"
            style="width: 120px; height: 60px"
            fit="cover"
            :preview-src-list="[scope.row.imageUrl]"
          />
        </template>
      </el-table-column>
      <el-table-column label="标题" prop="title" min-width="200">
        <template #default="scope">
          {{ scope.row.title?.zh || '-' }}
        </template>
      </el-table-column>
      <el-table-column label="描述" prop="description" min-width="250">
        <template #default="scope">
          {{ scope.row.description?.zh || '-' }}
        </template>
      </el-table-column>
      <el-table-column label="链接地址" prop="linkUrl" width="200">
        <template #default="scope">
          <el-link v-if="scope.row.linkUrl" :href="scope.row.linkUrl" target="_blank" type="primary">
            {{ scope.row.linkUrl }}
          </el-link>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="排序" prop="orderNum" width="80" />
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
      <el-table-column label="操作" align="center" width="150" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['cms:banner:edit']"
            >修改</el-button
          >
          <el-button
            link
            type="primary"
            icon="Delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['cms:banner:remove']"
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

    <!-- 添加或修改轮播图对话框 -->
    <el-dialog :title="title" v-model="open" width="700px" append-to-body>
      <el-form v-if="open" ref="bannerRef" :model="form" :rules="rules" label-width="140px">
        <el-tabs v-model="activeTab">
          <el-tab-pane :label="item.name" :name="item.code" v-for="item in locales" :key="item.code">
            <el-form-item :label="`标题(${item.name})`" :prop="`title.${item.code}`">
              <div style="display: flex; gap: 8px; flex: 1">
                <el-input v-model="form.title[item.code]" :placeholder="`请输入标题(${item.name})`" style="flex: 1" />
                <el-button
                  v-if="item.code !== 'zh' && form.title?.zh"
                  type="primary"
                  :icon="icons.MagicStick"
                  :loading="translating.title"
                  @click="handleTranslate('title', item.code)"
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
            <el-form-item :label="`按钮文字(${item.name})`">
              <div style="display: flex; gap: 8px; flex: 1">
                <el-input
                  v-model="form.buttonText[item.code]"
                  :placeholder="`请输入按钮文字(${item.name})，如：查看详情`"
                  style="flex: 1"
                />
                <el-button
                  v-if="item.code !== 'zh' && form.buttonText?.zh"
                  type="primary"
                  :icon="icons.MagicStick"
                  :loading="translating.buttonText"
                  @click="handleTranslate('buttonText', item.code)"
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

        <el-form-item label="图片地址" prop="imageUrl">
          <image-upload v-model="form.imageUrl" :limit="1" />
        </el-form-item>

        <el-form-item label="链接地址">
          <el-input v-model="form.linkUrl" placeholder="请输入链接地址，如：/products 或 https://example.com" />
        </el-form-item>

        <el-form-item label="排序" prop="orderNum">
          <el-input-number v-model="form.orderNum" :min="0" controls-position="right" style="width: 200px" />
        </el-form-item>

        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="1">启用</el-radio>
            <el-radio label="0">禁用</el-radio>
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

<script setup name="Banner">
  import ImageUpload from '@/components/ImageUpload';
  import { listBanner, getBanner, addBanner, updateBanner, delBanner, changeBannerStatus } from '@/api/cms/banner';
  import { useListLocale } from '@/hooks/useListLocale';
  import { translateText } from '@/api/ai';
  import * as ElementPlusIconsVue from '@element-plus/icons-vue';

  const { locales } = useListLocale();
  const { proxy } = getCurrentInstance();
  const icons = ElementPlusIconsVue;

  const bannerList = ref([]);
  const open = ref(false);
  const loading = ref(true);
  const showSearch = ref(true);
  const activeTab = ref('zh');
  const title = ref('');
  const total = ref(0);

  // 翻译状态
  const translating = reactive({
    title: false,
    description: false,
    buttonText: false,
    all: false
  });

  const data = reactive({
    form: {},
    queryParams: {
      pageNum: 1,
      limit: 10,
      status: null
    },
    rules: {
      'title.zh': [{ required: true, message: '标题(中文)不能为空', trigger: 'blur' }],
      imageUrl: [{ required: true, message: '图片地址不能为空', trigger: 'blur' }]
    }
  });

  const { queryParams, form, rules } = toRefs(data);

  // 计算是否有非中文语言
  const hasNonZhLanguages = computed(() => {
    return locales.value.some(locale => locale.code !== 'zh');
  });

  /** 查询轮播图列表 */
  function getList() {
    loading.value = true;
    listBanner(queryParams.value).then(response => {
      bannerList.value = response.data.rows;
      total.value = response.data.total;
      loading.value = false;
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
      bannerId: null,
      title: {},
      description: {},
      buttonText: {},
      imageUrl: null,
      linkUrl: null,
      orderNum: 0,
      status: '1'
    };
    proxy.resetForm('bannerRef');
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
    open.value = true;
    title.value = '添加轮播图';
  }

  /** 修改按钮操作 */
  function handleUpdate(row) {
    reset();
    const bannerId = row.bannerId;
    getBanner(bannerId).then(response => {
      form.value = {
        ...response.data
      };
      open.value = true;
      title.value = '修改轮播图';
    });
  }

  /** 提交按钮 */
  function submitForm() {
    proxy.$refs['bannerRef'].validate(valid => {
      if (valid) {
        const data = {
          ...form.value
        };
        if (form.value.bannerId != undefined) {
          updateBanner(data).then(response => {
            proxy.$modal.msgSuccess('修改成功');
            open.value = false;
            getList();
          });
        } else {
          addBanner(data).then(response => {
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
    const text = row.status === '1' ? '启用' : '禁用';
    proxy.$modal
      .confirm('确认要"' + text + '""' + row.title?.zh + '"轮播图吗？')
      .then(() => {
        return changeBannerStatus(row.bannerId, row.status);
      })
      .then(() => {
        proxy.$modal.msgSuccess('操作成功');
      })
      .catch(() => {
        row.status = row.status === '1' ? '0' : '1';
      });
  }

  /** 删除按钮操作 */
  function handleDelete(row) {
    proxy.$modal
      .confirm('是否确认删除标题为"' + row.title?.zh + '"的数据项？')
      .then(function () {
        return delBanner(row.bannerId);
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
    // 检查是否有中文内容
    const hasChineseContent =
      (form.value.title?.zh && form.value.title.zh.trim()) ||
      (form.value.description?.zh && form.value.description.zh.trim()) ||
      (form.value.buttonText?.zh && form.value.buttonText.zh.trim());

    if (!hasChineseContent) {
      proxy.$modal.msgWarning('请先输入中文内容');
      return;
    }

    translating.all = true;
    const nonZhLocales = locales.value.filter(locale => locale.code !== 'zh');

    try {
      // 逐个语言翻译
      for (const locale of nonZhLocales) {
        // 翻译标题
        if (form.value.title?.zh && form.value.title.zh.trim()) {
          try {
            const titleResponse = await translateText({
              text: form.value.title.zh,
              targetLang: locale.code
            });
            if (titleResponse.data?.translatedText) {
              form.value.title[locale.code] = titleResponse.data.translatedText;
            }
          } catch (e) {
            console.error(`翻译标题到${locale.name}失败:`, e);
          }
        }

        // 翻译描述
        if (form.value.description?.zh && form.value.description.zh.trim()) {
          try {
            const descResponse = await translateText({
              text: form.value.description.zh,
              targetLang: locale.code
            });
            if (descResponse.data?.translatedText) {
              form.value.description[locale.code] = descResponse.data.translatedText;
            }
          } catch (e) {
            console.error(`翻译描述到${locale.name}失败:`, e);
          }
        }

        // 翻译按钮文字
        if (form.value.buttonText?.zh && form.value.buttonText.zh.trim()) {
          try {
            const btnResponse = await translateText({
              text: form.value.buttonText.zh,
              targetLang: locale.code
            });
            if (btnResponse.data?.translatedText) {
              form.value.buttonText[locale.code] = btnResponse.data.translatedText;
            }
          } catch (e) {
            console.error(`翻译按钮文字到${locale.name}失败:`, e);
          }
        }

        // 添加延迟避免请求过快
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
