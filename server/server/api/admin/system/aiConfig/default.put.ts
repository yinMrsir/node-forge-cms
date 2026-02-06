import { AiConfigServices } from '~~/server/services/admin/system/aiConfig/ai.config.services';

export default defineEventHandler(async event => {
  const body = await readBody(event);
  const { aiConfigId, provider } = body;
  await new AiConfigServices().setDefault(aiConfigId, provider);
  return createApiResponse(null);
});
