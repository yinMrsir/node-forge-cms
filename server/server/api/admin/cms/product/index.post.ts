import { ProductServices } from '~~/server/services/cms/product.services';

const productServices = new ProductServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:product:add');
  const body = await readBody(event);
  body.createBy = event.context.user.userName;
  await productServices.add(body);
  return createApiResponse(null, 200, '新增成功');
});
