import { ProductServices } from '~~/server/services/cms/product.services';

const productServices = new ProductServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:product:edit');
  const body = await readBody(event);
  body.updateBy = event.context.user.userName;
  await productServices.update(body);
  return createApiResponse(null, 200, '修改成功');
});
