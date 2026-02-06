import { AiConfigServices } from '~~/server/services/admin/system/aiConfig/ai.config.services';

export default defineEventHandler(async event => {
  const body = await readBody(event);
  body.updateTime = new Date();
  delete body.createTime;
  await new AiConfigServices().update(body);
  return createApiResponse(null);
});
