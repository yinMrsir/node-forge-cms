import { NewsServices } from '~~/server/services/cms/news.services';

const newsServices = new NewsServices();

export default defineEventHandler(async event => {
  const body = await readBody(event);
  await newsServices.changeStatus(body.newsId, body.status, event.context.user.userName);
  return createApiResponse(null, 200, '状态修改成功');
});
