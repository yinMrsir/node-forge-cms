import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();

export default defineEventHandler(async event => {
  const query = getQuery(event);
  const categoryType = (query.categoryType as string) || '1';
  const data = await categoryServices.getTree(categoryType);
  return createApiResponse(data);
});
