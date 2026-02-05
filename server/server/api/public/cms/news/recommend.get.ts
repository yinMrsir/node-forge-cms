import { NewsServices } from '~~/server/services/cms/news.services';

const newsServices = new NewsServices();

export default defineEventHandler(async event => {
  const query = getQuery(event);
  const limit = Number(query.limit) || 5;
  const data = await newsServices.getRecommend(limit);
  return createApiResponse(data);
});
