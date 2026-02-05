import { JsonConfigServices } from '~~/server/services/admin/system/jsonConfig/json.config.services';

export default defineEventHandler(async event => {
  const jsonConfigId = parseInt(getRouterParam(event, 'jsonConfigId') as string);

  if (isNaN(jsonConfigId)) {
    throw createError({
      statusCode: 400,
      message: 'Invalid config ID'
    });
  }

  const data = await new JsonConfigServices().findById(jsonConfigId);

  if (!data) {
    throw createError({
      statusCode: 404,
      message: 'Config not found'
    });
  }

  return createApiResponse(data);
});
