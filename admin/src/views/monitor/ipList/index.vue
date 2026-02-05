<template>
  <div class="app-container">
    <table-pro
      :is-show-button-list="false"
      :is-show-id-column="false"
      :columns="columns"
      :table-request-fn="getIpList"
    />
  </div>
</template>

<script setup>
  import dayjs from 'dayjs';
  import { getIpList } from '@/api/monitor/cache';

  const columns = ref([
    { title: 'IP', field: 'key' },
    { title: '次数', field: 'value.count' },
    {
      title: '时间',
      field: 'value.time',
      render: row => {
        return dayjs(row.value.time).format('YYYY-MM-DD HH:mm:ss');
      }
    }
  ]);
</script>
