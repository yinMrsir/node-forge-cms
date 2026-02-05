import { Category } from '~~/server/db/schema/cms/category';
import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();

/**
 * 根据路径段查找栏目（支持多级栏目）
 * POST /api/public/cms/category/by-path
 * Body: { pathSegments: string[] }
 */
export default defineEventHandler(async event => {
  const body = await readBody(event);

  if (!body || !body.pathSegments || !Array.isArray(body.pathSegments)) {
    throw createError({
      statusCode: 400,
      statusMessage: 'pathSegments is required and must be an array'
    });
  }

  const data = await categoryServices.getByPath(body.pathSegments);

  const categoryIds = data.mpath?.split('.').filter(item => Boolean(item));
  let categoryMpath: Array<Pick<Category, 'categoryId' | 'categoryName' | 'description' | 'parentCategoryId' | 'urlKey' | 'mpath'> | undefined> = []
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
