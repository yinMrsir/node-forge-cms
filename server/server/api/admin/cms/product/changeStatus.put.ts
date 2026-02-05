import { ProductServices } from '~~/server/services/cms/product.services';

const productServices = new ProductServices();

export default defineEventHandler(async event => {
  const body = await readBody(event);
  await productServices.changeStatus(body.productId, body.status, event.context.user.userName);
  return createApiResponse(null, 200, '状态修改成功');
});
