import { AiConfigServices } from '~~/server/services/admin/system/aiConfig/ai.config.services';

export default defineEventHandler(async event => {
  const body = await readBody(event);
  const { aiConfigId, status } = body;
  await new AiConfigServices().updateStatus(aiConfigId, status);
  return createApiResponse(null);
});
