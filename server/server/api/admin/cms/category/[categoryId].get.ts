import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:category:query');
  const categoryId = getRouterParam(event, 'categoryId');
  const data = await categoryServices.findById(Number(categoryId));
  return createApiResponse(data);
});
