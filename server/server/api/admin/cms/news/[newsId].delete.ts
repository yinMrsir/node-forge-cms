import { NewsServices } from '~~/server/services/cms/news.services';

const newsServices = new NewsServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:news:remove');
  const newsId = getRouterParam(event, 'newsId');
  await newsServices.delete([newsId]);
  return createApiResponse(null, 200, '删除成功');
});
