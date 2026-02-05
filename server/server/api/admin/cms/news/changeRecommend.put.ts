import { NewsServices } from '~~/server/services/cms/news.services';

const newsServices = new NewsServices();

export default defineEventHandler(async event => {
  const body = await readBody(event);
  await newsServices.changeRecommend(body.newsId, body.isRecommend, event.context.user.userName);
  return createApiResponse(null, 200, '操作成功');
});
