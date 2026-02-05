import { CategoryServices } from '~~/server/services/cms/category.services';

const categoryServices = new CategoryServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:category:add');
  const body = await readBody(event);
  body.createBy = event.context.user.userName;
  await categoryServices.add(body);
  return createApiResponse(null, 200, '新增成功');
});
