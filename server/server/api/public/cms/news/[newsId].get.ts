import { Category } from '~~/server/db/schema/cms/category';
import { NewsServices } from '~~/server/services/cms/news.services';
import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();
const newsServices = new NewsServices();

export default defineEventHandler(async event => {
  const newsId = getRouterParam(event, 'newsId');
  const data = await newsServices.publicFindById(Number(newsId));
  if (!data) {
    throw createError({ statusCode: 404, message: '新闻不存在' });
  }
  const categoryIds = data.category?.mpath?.split('.').filter(item => Boolean(item));
  let categoryMpath: Array<
    Pick<Category, 'categoryId' | 'categoryName' | 'description' | 'parentCategoryId' | 'urlKey' | 'mpath'> | undefined
  > = [];
  if (categoryIds) {
    categoryMpath = await Promise.all(categoryIds.map(item => categoryServices.findById(Number(item))));
  }
  return { ...data, categoryMpath };
});
