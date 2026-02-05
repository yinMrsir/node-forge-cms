import { JsonConfigServices } from '~~/server/services/admin/system/jsonConfig/json.config.services';

export default defineEventHandler(async event => {
  const body = await readBody(event);

  // 验证必填字段
  if (!body.jsonConfigId) {
    throw createError({
      statusCode: 400,
      message: 'jsonConfigId is required'
    });
  }

  // 设置更新时间
  body.updateTime = new Date();
  delete body.createTime;

  await new JsonConfigServices().update(body.jsonConfigId, body);

  return createApiResponse(null);
});
