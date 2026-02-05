import { NewsServices } from '~~/server/services/cms/news.services';
import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();
const newsServices = new NewsServices();

export default defineEventHandler(async event => {
  const newsId = getRouterParam(event, 'newsId');
  const query = getQuery(event);
  const limit = Number(query.limit) || 6;

  const news = await newsServices.publicFindById(Number(newsId));

  if (!news) {
    throw createError({ statusCode: 404, message: '新闻不存在' });
  }

  const data: any = await newsServices.getRelated(Number(newsId), news.categoryId!, limit);
  for (const item of data) {
    if (item.category && item.category.mpath) {
      const categoryIds = item.category.mpath.split('.').filter((id: any) => Boolean(id));
      if (categoryIds && categoryIds.length > 0) {
        (item as any).categoryMpath = await Promise.all(
          categoryIds.map((id: any) => categoryServices.findById(Number(id)))
        );
      }
    }
  }
  return data;
});
