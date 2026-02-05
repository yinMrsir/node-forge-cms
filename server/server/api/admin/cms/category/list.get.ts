import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:category:list');
  const query = getQuery(event);
  const data = await categoryServices.list(query);
  return createApiResponse(data);
});
