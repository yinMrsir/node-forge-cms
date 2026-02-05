import { NewsServices } from '~~/server/services/cms/news.services';

const newsServices = new NewsServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:news:query');
  const newsId = getRouterParam(event, 'newsId');
  const data = await newsServices.findById(Number(newsId));
  return createApiResponse(data);
});
