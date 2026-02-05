import { NewsServices } from '~~/server/services/cms/news.services';
import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();
const newsServices = new NewsServices();

export default defineEventHandler(async event => {
  const newsId = getRouterParam(event, 'newsId');
  const news = await newsServices.publicFindById(Number(newsId));

  if (!news) {
    throw createError({ statusCode: 404, message: '新闻不存在' });
  }

  const data: any = await newsServices.getAdjacentNews(Number(newsId), news.categoryId!);
  if (data.next) {
    const categoryIds = data.next.category?.mpath?.split('.').filter((item: any) => Boolean(item));
    if (categoryIds) {
      data.next.categoryMpath = await Promise.all(
        categoryIds.map((item: any) => categoryServices.findById(Number(item)))
      );
    }
  }
  if (data.prev) {
    const categoryIds = data.prev.category?.mpath?.split('.').filter((item: any) => Boolean(item));
    if (categoryIds) {
      data.prev.categoryMpath = await Promise.all(
        categoryIds.map((item: any) => categoryServices.findById(Number(item)))
      );
    }
  }
  return data;
});
