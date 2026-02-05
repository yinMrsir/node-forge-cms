import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:category:edit');
  const body = await readBody(event);
  await categoryServices.changeRecommend(body.categoryId, body.isRecommend, event.context.user.userName);
  return createApiResponse(null, 200, '操作成功');
});
