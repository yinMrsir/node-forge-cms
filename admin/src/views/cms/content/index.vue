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
              <el-input
                v-model="form.keywords[item.code]"
                :placeholder="`请输入关键词(${item.name})，多个关键词用逗号分隔`"
              />
            </el-form-item>
            <el-form-item :label="`描述(${item.name})`">
              <el-input
                v-model="form.description[item.code]"
                type="textarea"
                :rows="3"
                :placeholder="`请输入描述(${item.name})`"
              />
            </el-form-item>
            <el-form-item :label="`内容(${item.name})`" :prop="`content.${item.code}`">
              <rich-text-editor v-model="form.content[item.code]" />
            </el-form-item>
          </el-tab-pane>
        </el-tabs>

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

  const { locales } = useListLocale();
  const { proxy } = getCurrentInstance();

  const contentList = ref([]);
  const categoryOptions = ref([]);
  const open = ref(false);
  const loading = ref(true);
  const showSearch = ref(true);
  const activeTab = ref('zh');
  const title = ref('');
  const total = ref(0);

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

  getCategoryOptions();
  getList();
</script>

<style scoped>
  .content-preview {
    color: #606266;
    font-size: 13px;
  }
</style>
