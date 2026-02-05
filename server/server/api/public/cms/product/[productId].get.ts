import { Category } from '~~/server/db/schema/cms/category';
import { ProductServices } from '~~/server/services/cms/product.services';
import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();
const productServices = new ProductServices();

export default defineEventHandler(async event => {
  const productId = getRouterParam(event, 'productId');
  const data = await productServices.publicFindById(Number(productId));
  if (!data) {
    throw createError({ statusCode: 404, message: '产品不存在' });
  }
  const categoryIds = data.category?.mpath?.split('.').filter(item => Boolean(item));
  let categoryMpath: Array<Pick<Category, 'categoryId' | 'categoryName' | 'description' | 'parentCategoryId' | 'urlKey' | 'mpath'> | undefined> = []
  if (categoryIds) {
    categoryMpath = await Promise.all(categoryIds.map(item => categoryServices.findById(Number(item))));
  }
  return { ...data, categoryMpath };
});
