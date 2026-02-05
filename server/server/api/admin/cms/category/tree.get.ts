import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:category:query');
  const query = getQuery(event);
  const data = await categoryServices.treeselect(query.categoryType as string);
  return createApiResponse(data);
});
