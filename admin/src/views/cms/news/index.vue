<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="标题" prop="title">
        <el-input v-model="queryParams.title" placeholder="请输入标题" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="所属栏目" prop="categoryId">
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
        <el-select v-model="queryParams.status" placeholder="新闻状态" clearable>
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
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['cms:news:add']"> 新增 </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="newsList">
      <el-table-column label="封面图" prop="coverImage" width="120">
        <template #default="scope">
          <el-image
            v-if="scope.row.coverImage"
            :src="scope.row.coverImage"
            style="width: 80px; height: 60px"
            fit="cover"
          />
        </template>
      </el-table-column>
      <el-table-column label="标题" prop="title" min-width="300">
        <template #default="scope">
          <span>{{ scope.row.title?.zh || '' }}</span>
          <el-tag v-if="scope.row.isTop === '1'" type="danger" style="margin-left: 5px">置顶</el-tag>
          <el-tag v-if="scope.row.isRecommend === '1'" type="warning" style="margin-left: 5px">推荐</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="分类" prop="categoryId" width="120">
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
      <el-table-column label="发布时间" prop="publishTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.publishTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="270" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['cms:news:edit']"
            >修改</el-button
          >
          <el-button link type="primary" @click="handleTop(scope.row)" v-hasPermi="['cms:news:edit']">
            {{ scope.row.isTop === '1' ? '取消置顶' : '置顶' }}
          </el-button>
          <el-button link type="primary" @click="handleRecommend(scope.row)" v-hasPermi="['cms:news:edit']">
            {{ scope.row.isRecommend === '1' ? '取消推荐' : '推荐' }}
          </el-button>
          <el-button
            link
            type="primary"
            icon="Delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['cms:news:remove']"
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

    <!-- 添加或修改新闻对话框 -->
    <el-dialog :title="title" v-model="open" width="900px" append-to-body>
      <el-form v-if="open" ref="newsRef" :model="form" :rules="rules" label-width="120px">
        <el-tabs v-model="activeTab">
          <el-tab-pane :label="item.name" :name="item.code" v-for="item in locales">
            <el-form-item :label="`标题(${item.name})`" :prop="`title.${item.code}`">
              <el-input v-model="form.title[item.code]" :placeholder="`请输入标题(${item.name})`" />
            </el-form-item>
            <el-form-item :label="`关键词(${item.name})`">
              <el-input
                v-model="form.keywords[item.code]"
                :placeholder="`请输入关键词(${item.name})，多个关键词用逗号分隔`"
              />
            </el-form-item>
            <el-form-item :label="`摘要(${item.name})`">
              <el-input
                v-model="form.summary[item.code]"
                type="textarea"
                :rows="2"
                :placeholder="`请输入摘要(${item.name})`"
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

        <el-form-item label="封面图">
          <image-upload v-model="form.coverImage" :limit="1" />
        </el-form-item>

        <el-form-item label="作者">
          <el-input v-model="form.author" placeholder="请输入作者" />
        </el-form-item>

        <el-form-item label="来源">
          <el-input v-model="form.source" placeholder="请输入来源" />
        </el-form-item>

        <el-form-item label="发布时间">
          <el-date-picker
            v-model="form.publishTime"
            value-format="YYYY-MM-DD HH:mm:ss"
            type="datetime"
            placeholder="选择日期时间"
          />
        </el-form-item>

        <el-form-item label="属性">
          <el-checkbox v-model="form.isTop" :true-label="'1'" :false-label="'0'">置顶</el-checkbox>
          <el-checkbox v-model="form.isRecommend" :true-label="'1'" :false-label="'0'">推荐</el-checkbox>
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

<script setup name="News">
  import RichTextEditor from '@/components/RichTextEditor';
  import {
    listNews,
    getNews,
    addNews,
    updateNews,
    delNews,
    changeNewsStatus,
    changeNewsTop,
    changeNewsRecommend
  } from '@/api/cms/news';
  import { listCategory } from '@/api/cms/category';
  import { useListLocale } from '@/hooks/useListLocale';

  const { locales } = useListLocale();
  const { proxy } = getCurrentInstance();

  const newsList = ref([]);
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
      title: null,
      categoryId: null,
      status: null
    },
    rules: {
      'title.zh': [{ required: true, message: '标题(中文)不能为空', trigger: 'blur' }],
      'content.zh': [{ required: true, message: '内容(中文)不能为空', trigger: 'blur' }],
      categoryId: [{ required: true, message: '请选择分类', trigger: 'change' }]
    }
  });

  const { queryParams, form, rules } = toRefs(data);

  /** 查询新闻列表 */
  function getList() {
    loading.value = true;
    listNews(queryParams.value).then(response => {
      newsList.value = response.data.rows;
      total.value = response.data.total;
      loading.value = false;
    });
  }

  /** 查询下拉树结构 */
  function getCategoryOptions() {
    listCategory({ templateType: 'news' }).then(response => {
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
      newsId: null,
      titleZh: null,
      titleEn: null,
      keywordsZh: null,
      keywordsEn: null,
      summaryZh: null,
      summaryEn: null,
      contentZh: null,
      contentEn: null,
      categoryId: null,
      coverImage: null,
      author: null,
      source: null,
      isTop: '0',
      isRecommend: '0',
      publishTime: null,
      status: '1'
    };
    proxy.resetForm('newsRef');
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
    title.value = '添加新闻';
  }

  /** 修改按钮操作 */
  function handleUpdate(row) {
    reset();
    getCategoryOptions();
    const newsId = row.newsId;
    getNews(newsId).then(response => {
      form.value = {
        ...response.data
      };
      open.value = true;
      title.value = '修改新闻';
    });
  }

  /** 提交按钮 */
  function submitForm() {
    proxy.$refs['newsRef'].validate(valid => {
      if (valid) {
        const data = {
          ...form.value
        };
        if (form.value.newsId != undefined) {
          updateNews(data).then(response => {
            proxy.$modal.msgSuccess('修改成功');
            open.value = false;
            getList();
          });
        } else {
          addNews(data).then(response => {
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
      .confirm('确认要"' + text + '""' + row.title?.zh + '"新闻吗？')
      .then(() => {
        return changeNewsStatus(row.newsId, row.status);
      })
      .then(() => {
        proxy.$modal.msgSuccess('操作成功');
      })
      .catch(() => {
        row.status = row.status === '1' ? '0' : '1';
      });
  }

  /** 置顶操作 */
  function handleTop(row) {
    const text = row.isTop === '1' ? '取消置顶' : '置顶';
    proxy.$modal
      .confirm('确认要"' + text + '""' + row.title?.zh + '"吗？')
      .then(() => {
        const newTop = row.isTop === '1' ? '0' : '1';
        return changeNewsTop(row.newsId, newTop);
      })
      .then(() => {
        proxy.$modal.msgSuccess('操作成功');
        getList();
      });
  }

  /** 推荐操作 */
  function handleRecommend(row) {
    const text = row.isRecommend === '1' ? '取消推荐' : '推荐';
    proxy.$modal
      .confirm('确认要"' + text + '""' + row.title?.zh + '"吗？')
      .then(() => {
        const newRecommend = row.isRecommend === '1' ? '0' : '1';
        return changeNewsRecommend(row.newsId, newRecommend);
      })
      .then(() => {
        proxy.$modal.msgSuccess('操作成功');
        getList();
      });
  }

  /** 删除按钮操作 */
  function handleDelete(row) {
    proxy.$modal
      .confirm('是否确认删除标题为"' + row.title?.zh + '"的数据项？')
      .then(function () {
        return delNews(row.newsId);
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
