import { NewsServices } from '~~/server/services/cms/news.services';

const newsServices = new NewsServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:news:add');
  const body = await readBody(event);
  body.createBy = event.context.user.userName;
  await newsServices.add(body);
  return createApiResponse(null, 200, '新增成功');
});
