import { ProductServices } from '~~/server/services/cms/product.services';
import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();
const productServices = new ProductServices();

export default defineEventHandler(async event => {
  const query = getQuery(event);
  const data = await productServices.publicList(query);

  for (const item of data.rows) {
    if (item.category && item.category.mpath) {
      const categoryIds = item.category.mpath.split('.').filter(id => Boolean(id));
      if (categoryIds && categoryIds.length > 0) {
        (item as any).categoryMpath = await Promise.all(categoryIds.map(id => categoryServices.findById(Number(id))));
      }
    }
  }

  return data;
});
