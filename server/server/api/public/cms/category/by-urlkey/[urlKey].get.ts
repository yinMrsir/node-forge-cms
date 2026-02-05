import { Category } from '~~/server/db/schema/cms/category';
import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();

/**
 * 根据 urlKey 获取栏目信息（用于动态路由）
 */
export default defineEventHandler(async event => {
  const urlKey = getRouterParam(event, 'urlKey');

  if (!urlKey) {
    throw createError({
      statusCode: 400,
      statusMessage: 'urlKey is required'
    });
  }

  const data = await categoryServices.getByUrlKey(urlKey);
  const categoryIds = data.mpath?.split('.').filter(item => Boolean(item));
  let categoryMpath: Array<Category | undefined> = []
  if (categoryIds) {
    categoryMpath = await Promise.all(categoryIds.map(item => categoryServices.findById(Number(item))));
  }
  return createApiResponse({
     ...data, 
     categoryMpath: categoryMpath.map(item => ({
      categoryName: item?.categoryName, 
      urlKey: item?.urlKey, 
      categoryId: item?.categoryId
    }))
  });
});
