import { JsonConfigServices } from '~~/server/services/admin/system/jsonConfig/json.config.services';

export default defineEventHandler(async event => {
  const configKey = getRouterParam(event, 'configKey') as string;

  if (!configKey) {
    throw createError({
      statusCode: 400,
      message: 'configKey is required'
    });
  }

  const data = await new JsonConfigServices().findByKey(configKey);

  if (!data) {
    throw createError({
      statusCode: 404,
      message: 'Config not found'
    });
  }

  return createApiResponse(data);
});
