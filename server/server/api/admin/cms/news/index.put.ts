import { NewsServices } from '~~/server/services/cms/news.services';

const newsServices = new NewsServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:news:edit');
  const body = await readBody(event);
  body.updateBy = event.context.user.userName;
  await newsServices.update(body);
  return createApiResponse(null, 200, '修改成功');
});
