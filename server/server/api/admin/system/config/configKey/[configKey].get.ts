import { SysConfigServices } from '~~/server/services/admin/system/sysConfig/sys.config.services';

export default defineEventHandler(async event => {
  const configKey = getRouterParam(event, 'configKey');
  if (!configKey) {
    throw createError({
      statusCode: 400,
      message: '缺少参数：configKey'
    });
  }
  const data = await new SysConfigServices().findByConfigKey(configKey);
  return createApiResponse(data);
});
