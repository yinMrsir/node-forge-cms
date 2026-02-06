import { AiConfigServices } from '~~/server/services/admin/system/aiConfig/ai.config.services';

export default defineEventHandler(async event => {
  const body = await readBody(event);
  body.createTime = body.updateTime = new Date();
  await new AiConfigServices().add(body);
  return createApiResponse(null);
});
