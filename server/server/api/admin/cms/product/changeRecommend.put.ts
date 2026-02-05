import { ProductServices } from '~~/server/services/cms/product.services';

const productServices = new ProductServices();

export default defineEventHandler(async event => {
  const body = await readBody(event);
  await productServices.changeRecommend(body.productId, body.isRecommend, event.context.user.userName);
  return createApiResponse(null, 200, '操作成功');
});
