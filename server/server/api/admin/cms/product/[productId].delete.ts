import { ProductServices } from '~~/server/services/cms/product.services';

const productServices = new ProductServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:product:remove');
  const productId = getRouterParam(event, 'productId');
  await productServices.delete([productId]);
  return createApiResponse(null, 200, '删除成功');
});
