import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:category:edit');
  const body = await readBody(event);
  body.updateBy = event.context.user.userName;
  await categoryServices.update(body);
  return createApiResponse(null, 200, '修改成功');
});
