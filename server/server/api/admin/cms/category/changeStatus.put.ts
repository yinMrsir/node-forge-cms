import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();

export default defineEventHandler(async event => {
  const body = await readBody(event);
  await categoryServices.changeStatus(body.categoryId, body.status, event.context.user.userName);
  return createApiResponse(null, 200, '状态修改成功');
});
