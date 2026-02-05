import { ProductServices } from '~~/server/services/cms/product.services';

const productServices = new ProductServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:product:query');
  const productId = getRouterParam(event, 'productId');
  const data = await productServices.findById(Number(productId));
  return createApiResponse(data);
});
