import { NewsServices } from '~~/server/services/cms/news.services';
import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();
const newsServices = new NewsServices();

export default defineEventHandler(async event => {
  const query = getQuery(event);
  const data = await newsServices.publicList(query);

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
