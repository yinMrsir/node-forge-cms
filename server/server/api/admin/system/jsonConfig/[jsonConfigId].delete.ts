import { JsonConfigServices } from '~~/server/services/admin/system/jsonConfig/json.config.services';

export default defineEventHandler(async event => {
  const jsonConfigId = parseInt(getRouterParam(event, 'jsonConfigId') as string);

  if (isNaN(jsonConfigId)) {
    throw createError({
      statusCode: 400,
      message: 'Invalid config ID'
    });
  }

  await new JsonConfigServices().delete(jsonConfigId);

  return createApiResponse(null);
});
