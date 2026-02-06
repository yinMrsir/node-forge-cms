import { AiConfigServices } from '~~/server/services/admin/system/aiConfig/ai.config.services';

export default defineEventHandler(async event => {
  const aiConfigId = getRouterParam(event, 'aiConfigId');
  const data = await new AiConfigServices().delete(aiConfigId?.split(','));
  return createApiResponse(data);
});
