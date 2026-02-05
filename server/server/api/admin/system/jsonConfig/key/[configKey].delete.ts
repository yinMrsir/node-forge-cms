import { JsonConfigServices } from '~~/server/services/admin/system/jsonConfig/json.config.services';

export default defineEventHandler(async event => {
  const configKey = getRouterParam(event, 'configKey') as string;

  if (!configKey) {
    throw createError({
      statusCode: 400,
      message: 'configKey is required'
    });
  }

  await new JsonConfigServices().deleteByKey(configKey);

  return createApiResponse(null);
});
