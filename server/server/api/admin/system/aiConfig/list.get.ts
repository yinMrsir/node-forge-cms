import { AiConfigServices } from '~~/server/services/admin/system/aiConfig/ai.config.services';

export default defineEventHandler(async event => {
  const query = getQuery(event);
  const data = await new AiConfigServices().list(query);
  return createApiResponse(data);
});
