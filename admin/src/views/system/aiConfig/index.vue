<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="配置名称" prop="configName">
        <el-input
          v-model="queryParams.configName"
          placeholder="请输入配置名称"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="服务商" prop="provider">
        <el-select v-model="queryParams.provider" placeholder="请选择服务商" clearable>
          <el-option label="智谱AI" value="zhipu" />
          <el-option label="豆包/火山引擎" value="doubao" />
          <el-option label="DeepSeek" value="deepseek" />
        </el-select>
      </el-form-item>
      <el-form-item label="配置键名" prop="configKey">
        <el-input
          v-model="queryParams.configKey"
          placeholder="请输入配置键名"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="配置状态" clearable>
          <el-option label="启用" value="1" />
          <el-option label="停用" value="0" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['system:aiConfig:add']"
          >新增</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:aiConfig:edit']"
          >修改</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:aiConfig:remove']"
          >删除</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['system:aiConfig:export']"
          >导出</el-button
        >
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="aiConfigList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55px" align="center" />
      <el-table-column label="配置ID" align="center" prop="aiConfigId" width="80" />
      <el-table-column label="配置名称" align="center" prop="configName" :show-overflow-tooltip="true" />
      <el-table-column label="服务商" align="center" prop="provider" width="150">
        <template #default="scope">
          <el-tag v-if="scope.row.provider === 'zhipu'" type="success">智谱AI</el-tag>
          <el-tag v-else-if="scope.row.provider === 'doubao'" type="warning">豆包/火山引擎</el-tag>
          <el-tag v-else-if="scope.row.provider === 'deepseek'" type="primary">DeepSeek</el-tag>
          <el-tag v-else type="info">{{ scope.row.provider }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="配置键名" align="center" prop="configKey" :show-overflow-tooltip="true" />
      <el-table-column label="配置值" align="center" prop="configValue" width="200">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleViewConfig(scope.row)">查看</el-button>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template #default="scope">
          <el-switch
            v-model="scope.row.status"
            active-value="1"
            inactive-value="0"
            @change="handleStatusChange(scope.row)"
          ></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="默认" align="center" prop="isDefault" width="80">
        <template #default="scope">
          <el-tag v-if="scope.row.isDefault === 'Y'" type="success">是</el-tag>
          <el-tag v-else type="info">否</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="排序" align="center" prop="sortOrder" width="80" />
      <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.updateTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="240" fixed="right">
        <template #default="scope">
          <el-button
            link
            type="primary"
            icon="Edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:aiConfig:edit']"
            >修改</el-button
          >
          <el-button
            v-if="scope.row.isDefault !== 'Y'"
            link
            type="success"
            icon="Star"
            @click="handleSetDefault(scope.row)"
            v-hasPermi="['system:aiConfig:edit']"
            >设为默认</el-button
          >
          <el-button
            link
            type="primary"
            icon="Delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:aiConfig:remove']"
            >删除</el-button
          >
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

    <!-- 添加或修改AI配置对话框 -->
    <el-dialog :title="title" v-model="open" width="700px" append-to-body>
      <el-form ref="aiConfigRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="配置名称" prop="configName">
          <el-input v-model="form.configName" placeholder="请输入配置名称，如：智谱AI-生产环境" />
        </el-form-item>
        <el-form-item label="AI服务商" prop="provider">
          <el-select v-model="form.provider" placeholder="请选择AI服务商" @change="handleProviderChange">
            <el-option label="智谱AI" value="zhipu" />
            <el-option label="豆包/火山引擎" value="doubao" />
            <el-option label="DeepSeek" value="deepseek" />
          </el-select>
        </el-form-item>
        <el-form-item label="配置键名" prop="configKey">
          <el-input v-model="form.configKey" placeholder="请输入配置键名，如：zhipu_prod" />
        </el-form-item>
        <el-form-item label="API Key" prop="apiKey">
          <el-input v-model="form.apiKey" type="password" placeholder="请输入API Key" show-password />
        </el-form-item>
        <el-form-item label="端点URL" prop="endpoint">
          <el-input v-model="form.endpoint" placeholder="请输入API端点URL（可选）" />
        </el-form-item>
        <el-form-item label="模型" prop="model">
          <el-input v-model="form.model" placeholder="请输入模型名称，如：glm-4" />
        </el-form-item>
        <el-form-item label="Temperature" prop="temperature">
          <el-input-number v-model="form.temperature" :min="0" :max="2" :step="0.1" :precision="1" />
          <span style="margin-left: 10px; color: #999">控制生成文本的随机性，0-2之间，默认0.7</span>
        </el-form-item>
        <el-form-item label="Max Tokens" prop="maxTokens">
          <el-input-number v-model="form.maxTokens" :min="1" :max="100000" :step="100" />
          <span style="margin-left: 10px; color: #999">最大生成token数</span>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="1">启用</el-radio>
            <el-radio label="0">停用</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="设为默认" prop="isDefault">
          <el-radio-group v-model="form.isDefault">
            <el-radio label="Y">是</el-radio>
            <el-radio label="N">否</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="排序" prop="sortOrder">
          <el-input-number v-model="form.sortOrder" :min="0" :max="9999" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 查看配置JSON对话框 -->
    <el-dialog title="配置详情" v-model="viewDialogOpen" width="700px" append-to-body>
      <el-descriptions :column="1" border>
        <el-descriptions-item label="配置名称">{{ currentConfig.configName }}</el-descriptions-item>
        <el-descriptions-item label="服务商">
          <el-tag v-if="currentConfig.provider === 'zhipu'" type="success">智谱AI</el-tag>
          <el-tag v-else-if="currentConfig.provider === 'doubao'" type="warning">豆包/火山引擎</el-tag>
          <el-tag v-else-if="currentConfig.provider === 'deepseek'" type="primary">DeepSeek</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="配置键名">{{ currentConfig.configKey }}</el-descriptions-item>
        <el-descriptions-item label="配置值">
          <pre style="max-height: 300px; overflow: auto; background: #f5f5f5; padding: 10px; border-radius: 4px">{{
            formatConfigValue(currentConfig.configValue)
          }}</pre>
        </el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="viewDialogOpen = false">关 闭</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="AiConfig">
  import {
    listAiConfig,
    getAiConfig,
    delAiConfig,
    addAiConfig,
    updateAiConfig,
    updateAiConfigStatus,
    setDefaultAiConfig
  } from '@/api/system/aiConfig';

  const { proxy } = getCurrentInstance();

  const aiConfigList = ref([]);
  const open = ref(false);
  const viewDialogOpen = ref(false);
  const loading = ref(true);
  const showSearch = ref(true);
  const ids = ref([]);
  const single = ref(true);
  const multiple = ref(true);
  const total = ref(0);
  const title = ref('');
  const currentConfig = ref({});

  // 服务商默认配置模板
  const providerTemplates = {
    zhipu: {
      endpoint: 'https://open.bigmodel.cn/api/paas/v4/chat/completions',
      model: 'glm-4',
      temperature: 0.7,
      maxTokens: 2000
    },
    doubao: {
      endpoint: 'https://ark.cn-beijing.volces.com/api/v3/chat/completions',
      model: 'ep-2024xxxx',
      temperature: 0.7,
      maxTokens: 2000
    },
    deepseek: {
      endpoint: 'https://api.deepseek.com/chat/completions',
      model: 'deepseek-chat',
      temperature: 0.7,
      maxTokens: 2000
    }
  };

  const data = reactive({
    form: {
      status: '1',
      isDefault: 'N',
      sortOrder: 0,
      temperature: 0.7,
      maxTokens: 2000
    },
    queryParams: {
      pageNum: 1,
      limit: 10,
      configName: undefined,
      provider: undefined,
      configKey: undefined,
      status: undefined
    },
    rules: {
      configName: [{ required: true, message: '配置名称不能为空', trigger: 'blur' }],
      provider: [{ required: true, message: '请选择AI服务商', trigger: 'change' }],
      configKey: [
        { required: true, message: '配置键名不能为空', trigger: 'blur' },
        { pattern: /^[a-zA-Z0-9_]+$/, message: '配置键名只能包含字母、数字和下划线', trigger: 'blur' }
      ],
      apiKey: [{ required: true, message: 'API Key不能为空', trigger: 'blur' }],
      model: [{ required: true, message: '模型名称不能为空', trigger: 'blur' }]
    }
  });

  const { queryParams, form, rules } = toRefs(data);

  /** 查询AI配置列表 */
  function getList() {
    loading.value = true;
    listAiConfig(queryParams.value).then(response => {
      aiConfigList.value = response.data.rows;
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
      aiConfigId: undefined,
      configName: undefined,
      provider: undefined,
      configKey: undefined,
      apiKey: undefined,
      endpoint: undefined,
      model: undefined,
      temperature: 0.7,
      maxTokens: 2000,
      status: '1',
      isDefault: 'N',
      sortOrder: 0,
      remark: undefined
    };
    proxy.resetForm('aiConfigRef');
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
    ids.value = selection.map(item => item.aiConfigId);
    single.value = selection.length != 1;
    multiple.value = !selection.length;
  }

  /** 新增按钮操作 */
  function handleAdd() {
    reset();
    open.value = true;
    title.value = '添加AI配置';
  }

  /** 修改按钮操作 */
  function handleUpdate(row) {
    reset();
    const aiConfigId = row.aiConfigId || ids.value;
    getAiConfig(aiConfigId).then(response => {
      const config = response.data;
      // 将configValue中的字段展开到form
      form.value = {
        ...config,
        apiKey: config.configValue?.apiKey || '',
        endpoint: config.configValue?.endpoint || '',
        model: config.configValue?.model || '',
        temperature: config.configValue?.temperature || 0.7,
        maxTokens: config.configValue?.maxTokens || 2000
      };
      open.value = true;
      title.value = '修改AI配置';
    });
  }

  /** 服务商变更时设置默认值 */
  function handleProviderChange(provider) {
    const template = providerTemplates[provider];
    if (template) {
      form.value.endpoint = template.endpoint;
      form.value.model = template.model;
      form.value.temperature = template.temperature;
      form.value.maxTokens = template.maxTokens;
    }
  }

  /** 提交按钮 */
  function submitForm() {
    proxy.$refs['aiConfigRef'].validate(valid => {
      if (valid) {
        // 构建configValue JSON对象
        const configValue = {
          apiKey: form.value.apiKey,
          endpoint: form.value.endpoint,
          model: form.value.model,
          temperature: form.value.temperature,
          maxTokens: form.value.maxTokens
        };

        const submitData = {
          aiConfigId: form.value.aiConfigId,
          configName: form.value.configName,
          provider: form.value.provider,
          configKey: form.value.configKey,
          configValue: configValue,
          status: form.value.status,
          isDefault: form.value.isDefault,
          sortOrder: form.value.sortOrder,
          remark: form.value.remark
        };

        if (form.value.aiConfigId != undefined) {
          updateAiConfig(submitData).then(response => {
            proxy.$modal.msgSuccess('修改成功');
            open.value = false;
            getList();
          });
        } else {
          addAiConfig(submitData).then(response => {
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
    const text = row.status === '1' ? '启用' : '停用';
    proxy.$modal
      .confirm('确认要"' + text + '""' + row.configName + '"配置吗？')
      .then(function () {
        return updateAiConfigStatus(row.aiConfigId, row.status);
      })
      .then(() => {
        proxy.$modal.msgSuccess(text + '成功');
      })
      .catch(function () {
        row.status = row.status === '0' ? '1' : '0';
      });
  }

  /** 设置默认配置 */
  function handleSetDefault(row) {
    proxy.$modal
      .confirm('确认要将"' + row.configName + '"设为默认配置吗？')
      .then(function () {
        return setDefaultAiConfig(row.aiConfigId, row.provider);
      })
      .then(() => {
        proxy.$modal.msgSuccess('设置成功');
        getList();
      })
      .catch(() => {});
  }

  /** 删除按钮操作 */
  function handleDelete(row) {
    const aiConfigIds = row.aiConfigId || ids.value;
    proxy.$modal
      .confirm('是否确认删除AI配置编号为"' + aiConfigIds + '"的数据项？')
      .then(function () {
        return delAiConfig(aiConfigIds);
      })
      .then(() => {
        getList();
        proxy.$modal.msgSuccess('删除成功');
      })
      .catch(() => {});
  }

  /** 导出按钮操作 */
  function handleExport() {
    proxy.download(
      'system/aiConfig/export',
      {
        ...queryParams.value
      },
      `aiConfig_${new Date().getTime()}.xlsx`
    );
  }

  /** 查看配置详情 */
  function handleViewConfig(row) {
    currentConfig.value = row;
    viewDialogOpen.value = true;
  }

  /** 格式化配置值显示 */
  function formatConfigValue(configValue) {
    if (!configValue) return '{}';
    // 隐藏API Key
    const masked = { ...configValue };
    if (masked.apiKey) {
      masked.apiKey = masked.apiKey.substring(0, 8) + '****';
    }
    return JSON.stringify(masked, null, 2);
  }

  getList();
</script>

<style scoped>
  pre {
    font-family: 'Courier New', monospace;
    font-size: 12px;
    line-height: 1.5;
  }
</style>
