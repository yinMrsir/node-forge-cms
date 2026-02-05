import { NewsServices } from '~~/server/services/cms/news.services';

const newsServices = new NewsServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:news:list');
  const query = getQuery(event);
  const data = await newsServices.list(query);
  return createApiResponse(data);
});
