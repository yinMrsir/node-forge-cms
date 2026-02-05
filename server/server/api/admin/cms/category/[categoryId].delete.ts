import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:category:remove');
  const categoryId = getRouterParam(event, 'categoryId');
  await categoryServices.delete(categoryId, event.context.user.userName);
  return createApiResponse(null, 200, '删除成功');
});
