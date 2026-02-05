import { JsonConfigServices } from '~~/server/services/admin/system/jsonConfig/json.config.services';

export default defineEventHandler(async event => {
  const body = await readBody(event);

  // 验证必填字段
  if (!body.configKey) {
    throw createError({
      statusCode: 400,
      message: 'configKey is required'
    });
  }

  // 检查配置键是否已存在
  const existingConfig = await new JsonConfigServices().findByKey(body.configKey);
  if (existingConfig) {
    throw createError({
      statusCode: 400,
      message: 'Config key already exists'
    });
  }

  // 设置创建时间
  body.createTime = new Date();

  const result = await new JsonConfigServices().create(body);
  return createApiResponse(result);
});
