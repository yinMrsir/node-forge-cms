import { JsonConfigServices } from '~~/server/services/admin/system/jsonConfig/json.config.services';

export default defineEventHandler(async event => {
  const configKey = getRouterParam(event, 'configKey') as string;
  const body = await readBody(event);

  if (!configKey) {
    throw createError({
      statusCode: 400,
      message: 'configKey is required'
    });
  }

  // 设置更新时间
  body.updateTime = new Date();
  delete body.createTime;
  delete body.configKey; // 不允许通过此接口修改configKey

  await new JsonConfigServices().updateByKey(configKey, body);

  return createApiResponse(null);
});
