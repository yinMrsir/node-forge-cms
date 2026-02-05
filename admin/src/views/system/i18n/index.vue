<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="语言代码" prop="localeCode">
        <el-input
          v-model="queryParams.localeCode"
          placeholder="请输入语言代码"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="语言名称" prop="localeName">
        <el-input
          v-model="queryParams.localeName"
          placeholder="请输入语言名称"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="状态" clearable style="width: 200px">
          <el-option label="正常" value="0" />
          <el-option label="停用" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['system:i18n:add']">新增</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="localeList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55px" align="center" />
      <el-table-column label="ID" align="center" prop="localeId" width="80" />
      <el-table-column label="语言代码" align="center" prop="localeCode" minWidth="100" />
      <el-table-column label="语言名称" align="center" prop="localeName" minWidth="150" />
      <el-table-column label="图标" align="center" prop="icon" width="80">
        <template #default="scope">
          <span>{{ scope.row.icon || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="默认语言" align="center" prop="isDefault" minWidth="100">
        <template #default="scope">
          <el-tag v-if="scope.row.isDefault === 'Y'" type="success">是</el-tag>
          <el-tag v-else type="info">否</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="排序" align="center" prop="sortOrder" minWidth="80" />
      <el-table-column label="状态" align="center" prop="status" minWidth="80">
        <template #default="scope">
          <el-tag v-if="scope.row.status === '0'" type="success">正常</el-tag>
          <el-tag v-else type="danger">停用</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updateTime" minWidth="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.updateTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="220px" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:i18n:edit']"
            >编辑</el-button
          >
          <el-button
            link
            type="primary"
            icon="Document"
            @click="handleTranslations(scope.row)"
            v-hasPermi="['system:i18n:edit']"
            >翻译</el-button
          >
          <el-button
            link
            type="primary"
            icon="Delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:i18n:remove']"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改语言对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="localeRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="语言代码" prop="localeCode">
          <el-input
            v-model="form.localeCode"
            placeholder="请输入语言代码，如: zh, en, ja"
            :disabled="form.localeId !== undefined"
          />
        </el-form-item>
        <el-form-item label="语言名称" prop="localeName">
          <el-input v-model="form.localeName" placeholder="请输入语言名称，如: 简体中文" />
        </el-form-item>
        <el-form-item label="语言图标" prop="icon">
          <el-input v-model="form.icon" placeholder="请输入图标，如: 🇨🇳" />
        </el-form-item>
        <el-form-item label="排序" prop="sortOrder">
          <el-input-number v-model="form.sortOrder" :min="0" controls-position="right" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">正常</el-radio>
            <el-radio label="1">停用</el-radio>
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

    <!-- 翻译内容编辑对话框 -->
    <el-dialog :title="translationTitle" v-model="translationOpen" width="900px" append-to-body>
      <el-form :model="translationForm" label-width="80px">
        <el-form-item label="JSON内容">
          <el-input
            type="textarea"
            v-model="translationJson"
            :rows="20"
            placeholder='请输入JSON格式的翻译内容，如: { "site": { "name": "网站名称" }, "nav": { "home": "首页" } }'
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="translationOpen = false">取 消</el-button>
          <el-button type="primary" @click="submitTranslation">确 定</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="I18n">
  import {
    listLocale,
    getLocale,
    delLocale,
    addLocale,
    updateLocale,
    getLocaleContent,
    updateLocaleContent
  } from '@/api/system/i18n';

  const { proxy } = getCurrentInstance();

  const localeList = ref([]);
  const open = ref(false);
  const translationOpen = ref(false);
  const loading = ref(true);
  const showSearch = ref(true);
  const ids = ref([]);
  const single = ref(true);
  const multiple = ref(true);
  const total = ref(0);
  const title = ref('');
  const translationTitle = ref('');
  const currentLocale = ref('');
  const translationJson = ref('');

  const data = reactive({
    form: {},
    queryParams: {
      pageNum: 1,
      pageSize: 10,
      localeCode: undefined,
      localeName: undefined,
      status: undefined
    },
    translationForm: {},
    rules: {
      localeCode: [{ required: true, message: '语言代码不能为空', trigger: 'blur' }],
      localeName: [{ required: true, message: '语言名称不能为空', trigger: 'blur' }]
    }
  });

  const { queryParams, form, rules, translationForm } = toRefs(data);

  /** 查询语言列表 */
  function getList() {
    loading.value = true;
    listLocale(queryParams.value).then(response => {
      localeList.value = response.data.rows;
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
      localeId: undefined,
      localeCode: undefined,
      localeName: undefined,
      icon: '',
      sortOrder: 0,
      status: '0'
    };
    proxy.resetForm('localeRef');
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

  /** 多选框选中数据 */
  function handleSelectionChange(selection) {
    ids.value = selection.map(item => item.localeId);
    single.value = selection.length != 1;
    multiple.value = !selection.length;
  }

  /** 新增按钮操作 */
  function handleAdd() {
    reset();
    open.value = true;
    title.value = '添加语言';
  }

  /** 修改按钮操作 */
  function handleUpdate(row) {
    reset();
    const localeId = row.localeId;
    getLocale(localeId).then(response => {
      form.value = response.data;
      open.value = true;
      title.value = '修改语言';
    });
  }

  /** 翻译内容按钮操作 */
  function handleTranslations(row) {
    currentLocale.value = row.localeCode;
    translationTitle.value = `编辑翻译内容 - ${row.localeName} (${row.localeCode})`;
    translationOpen.value = true;

    getLocaleContent(row.localeCode).then(response => {
      translationJson.value = JSON.stringify(response.data, null, 2);
    });
  }

  /** 提交按钮 */
  function submitForm() {
    proxy.$refs['localeRef'].validate(valid => {
      if (valid) {
        if (form.value.localeId != undefined) {
          updateLocale(form.value).then(response => {
            proxy.$modal.msgSuccess('修改成功');
            open.value = false;
            getList();
          });
        } else {
          addLocale(form.value).then(response => {
            proxy.$modal.msgSuccess('新增成功');
            open.value = false;
            getList();
          });
        }
      }
    });
  }

  /** 提交翻译内容 */
  function submitTranslation() {
    try {
      const content = JSON.parse(translationJson.value);
      updateLocaleContent(currentLocale.value, content).then(response => {
        proxy.$modal.msgSuccess('更新成功');
        translationOpen.value = false;
      });
    } catch (e) {
      proxy.$modal.msgError('JSON格式错误，请检查');
    }
  }

  /** 删除按钮操作 */
  function handleDelete(row) {
    const localeId = row.localeId;
    const localeName = row.localeName;
    proxy.$modal
      .confirm('是否确认删除语言"' + localeName + '"？')
      .then(function () {
        return delLocale(localeId);
      })
      .then(() => {
        getList();
        proxy.$modal.msgSuccess('删除成功');
      })
      .catch(() => {});
  }

  getList();
</script>
