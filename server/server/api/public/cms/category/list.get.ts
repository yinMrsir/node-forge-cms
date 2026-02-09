import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();

export default defineEventHandler(async event => {
  const query = getQuery(event);
  const data = await categoryServices.list(query, {
    columns: {
      categoryId: true,
      categoryName: true,
      categoryType: true,
      description: true,
      keywords: true,
      redirectUrl: true,
      templateType: true,
      urlKey: true,
      parentCategoryId: true,
      mpath: true
    }
  });

  for (const item of data.rows) {
    if (item.mpath) {
      const categoryIds = item.mpath.split('.').filter(id => Boolean(id));
      if (categoryIds && categoryIds.length > 0) {
        (item as any).categoryMpath = await Promise.all(categoryIds.map(id => categoryServices.findById(Number(id))));
      }
    }
  }

  return data.rows;
});
