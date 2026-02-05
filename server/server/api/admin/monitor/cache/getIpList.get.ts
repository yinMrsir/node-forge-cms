/**
 * 分页查询 IP 访问记录 - 优化版
 * 使用批量并行获取和查询缓存提升性能
 */
export default defineEventHandler(async event => {
  const query = getQuery(event);
  const page = Number(query.page) || 1;
  const pageSize = Number(query.pageSize) || 10;
  const sortOrder = query.sortOrder === 'asc' ? 'asc' : 'desc';

  const shieldStorage = useStorage('shield');

  // 缓存键：包含排序和分页参数
  const cacheKey = `ip:query:cache:${sortOrder}:${page}:${pageSize}`;

  // 尝试从缓存获取结果
  const cachedResult = await shieldStorage.getItem(cacheKey);
  if (cachedResult) {
    return createApiResponse(cachedResult);
  }

  // 获取所有 IP 相关的键
  const allKeys = await shieldStorage.getKeys('ip:');

  // 批量并行获取所有值（优化点：替代循环串行获取）
  const values = await Promise.all(allKeys.map(key => shieldStorage.getItem(key)));

  // 组装数据
  const ipList = [];
  for (let i = 0; i < allKeys.length; i++) {
    if (values[i]) {
      ipList.push({
        key: allKeys[i],
        value: values[i]
      });
    }
  }

  // 按时间排序 (value.time 字段)
  ipList.sort((a, b) => {
    const getTimeValue = (val: any): number => {
      return typeof val === 'object' && val && 'time' in val ? (val.time as number) : 0;
    };

    const timeA = getTimeValue(a.value);
    const timeB = getTimeValue(b.value);
    return sortOrder === 'asc' ? timeA - timeB : timeB - timeA;
  });

  // 计算分页
  const total = ipList.length;
  const totalPages = Math.ceil(total / pageSize);
  const startIndex = (page - 1) * pageSize;
  const endIndex = startIndex + pageSize;

  // 获取当前页数据
  const rows = ipList.slice(startIndex, endIndex);

  const result = {
    rows,
    total,
    page,
    pageSize,
    totalPages
  };

  // 缓存结果 30 秒（可根据实际需求调整）
  await shieldStorage.setItem(cacheKey, result, { ttl: 30 });

  return createApiResponse(result);
});
