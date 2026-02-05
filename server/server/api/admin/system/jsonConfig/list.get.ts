import { JsonConfigServices } from '~~/server/services/admin/system/jsonConfig/json.config.services';

export default defineEventHandler(async event => {
  const query = getQuery(event);

  // 支持分页查询
  if (query.page && query.pageSize) {
    const page = parseInt(query.page as string);
    const pageSize = parseInt(query.pageSize as string);
    const data = await new JsonConfigServices().findByPage(page, pageSize);
    return createApiResponse(data);
  }

  // 查询所有配置
  const data = await new JsonConfigServices().findAll();
  return createApiResponse(data);
});
