<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="姓名" prop="name">
        <el-input v-model="queryParams.name" placeholder="请输入姓名" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="处理状态" clearable>
          <el-option label="未处理" value="0" />
          <el-option label="已处理" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="!selectedIds.length"
          @click="handleDeleteSelected"
          v-hasPermi="['cms:contact:remove']"
        >
          批量删除
        </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="contactList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" />
      <el-table-column label="姓名" prop="name" width="120" />
      <el-table-column label="电话" prop="phone" width="130" />
      <el-table-column label="邮箱" prop="email" min-width="180" />
      <el-table-column label="咨询主题" prop="subject" width="120">
        <template #default="scope">
          {{ getSubjectText(scope.row.subject) }}
        </template>
      </el-table-column>
      <el-table-column label="留言内容" prop="message" min-width="200" show-overflow-tooltip />
      <el-table-column label="状态" prop="status" width="100">
        <template #default="scope">
          <el-tag :type="scope.row.status === '1' ? 'success' : 'warning'">
            {{ scope.row.status === '1' ? '已处理' : '未处理' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="提交时间" prop="createTime" width="180">
        <template #default="scope">
          {{ parseTime(scope.row.createTime) }}
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="240px" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleView(scope.row)">查看</el-button>
          <el-button link type="primary" @click="handleStatus(scope.row)" v-hasPermi="['cms:contact:edit']">
            {{ scope.row.status === '1' ? '标记未处理' : '标记已处理' }}
          </el-button>
          <el-button
            link
            type="primary"
            icon="Delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['cms:contact:remove']"
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

    <!-- 详情对话框 -->
    <el-dialog title="留言详情" v-model="detailOpen" width="600px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="姓名">{{ contactDetail.name }}</el-descriptions-item>
        <el-descriptions-item label="状态">
          <el-tag :type="contactDetail.status === '1' ? 'success' : 'warning'">
            {{ contactDetail.status === '1' ? '已处理' : '未处理' }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="电话">{{ contactDetail.phone || '-' }}</el-descriptions-item>
        <el-descriptions-item label="邮箱">{{ contactDetail.email || '-' }}</el-descriptions-item>
        <el-descriptions-item label="咨询主题" :span="2">
          {{ getSubjectText(contactDetail.subject) }}
        </el-descriptions-item>
        <el-descriptions-item label="留言内容" :span="2">
          <div class="whitespace-pre-wrap">{{ contactDetail.message }}</div>
        </el-descriptions-item>
        <el-descriptions-item label="提交时间" :span="2">
          {{ parseTime(contactDetail.createTime) }}
        </el-descriptions-item>
        <el-descriptions-item label="处理备注" :span="2" v-if="contactDetail.status === '1'">
          {{ contactDetail.handleRemark || '-' }}
        </el-descriptions-item>
      </el-descriptions>
      <template #footer v-if="contactDetail.status === '0'">
        <div class="dialog-footer">
          <el-button type="primary" @click="showHandleDialog">标记为已处理</el-button>
          <el-button @click="detailOpen = false">关 闭</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 处理对话框 -->
    <el-dialog title="处理留言" v-model="handleOpen" width="500px" append-to-body>
      <el-form ref="handleRef" :model="handleForm" label-width="100px">
        <el-form-item label="处理备注">
          <el-input v-model="handleForm.handleRemark" type="textarea" :rows="4" placeholder="请输入处理备注（可选）" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitHandle">确 定</el-button>
          <el-button @click="handleOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Contact">
  import { listContact, getContact, delContact, changeContactStatus } from '@/api/cms/contact';

  const { proxy } = getCurrentInstance();

  const contactList = ref([]);
  const selectedIds = ref([]);
  const detailOpen = ref(false);
  const handleOpen = ref(false);
  const loading = ref(true);
  const showSearch = ref(true);
  const total = ref(0);
  const contactDetail = ref({});
  const currentContactId = ref(null);

  const data = reactive({
    queryParams: {
      pageNum: 1,
      limit: 10,
      name: null,
      status: null
    },
    handleForm: {
      handleRemark: null
    }
  });

  const { queryParams, handleForm } = toRefs(data);

  // 咨询主题映射
  const subjectMap = {
    product: '产品咨询',
    cooperation: '合作洽谈',
    technical: '技术支持',
    other: '其他问题'
  };

  function getSubjectText(subject) {
    return subjectMap[subject] || subject || '-';
  }

  /** 查询联系表单列表 */
  function getList() {
    loading.value = true;
    listContact(queryParams.value).then(response => {
      contactList.value = response.data.rows;
      total.value = response.data.total;
      loading.value = false;
    });
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
    selectedIds.value = selection.map(item => item.contactId);
  }

  /** 查看详情 */
  async function handleView(row) {
    const res = await getContact(row.contactId);
    contactDetail.value = res.data;
    currentContactId.value = row.contactId;
    detailOpen.value = true;
  }

  /** 显示处理对话框 */
  function showHandleDialog() {
    detailOpen.value = false;
    handleOpen.value = true;
    handleForm.value.handleRemark = null;
  }

  /** 处理状态变更 */
  function handleStatus(row) {
    const newStatus = row.status === '1' ? '0' : '1';
    const text = newStatus === '1' ? '标记为已处理' : '标记为未处理';
    proxy.$modal
      .confirm(`确认要${text}吗？`)
      .then(() => {
        return changeContactStatus(row.contactId, newStatus);
      })
      .then(() => {
        proxy.$modal.msgSuccess('操作成功');
        getList();
      })
      .catch(() => {});
  }

  /** 提交处理 */
  function submitHandle() {
    changeContactStatus(currentContactId.value, '1', handleForm.value.handleRemark).then(() => {
      proxy.$modal.msgSuccess('处理成功');
      handleOpen.value = false;
      getList();
    });
  }

  /** 删除按钮操作 */
  function handleDelete(row) {
    proxy.$modal
      .confirm('是否确认删除该留言？')
      .then(function () {
        return delContact(row.contactId);
      })
      .then(() => {
        getList();
        proxy.$modal.msgSuccess('删除成功');
      })
      .catch(() => {});
  }

  /** 批量删除 */
  function handleDeleteSelected() {
    proxy.$modal
      .confirm(`是否确认删除选中的 ${selectedIds.value.length} 条数据？`)
      .then(() => {
        // 批量删除需要后端支持，这里暂时循环调用单个删除
        return Promise.all(selectedIds.value.map(id => delContact(id)));
      })
      .then(() => {
        getList();
        proxy.$modal.msgSuccess('删除成功');
        selectedIds.value = [];
      })
      .catch(() => {});
  }

  getList();
</script>
