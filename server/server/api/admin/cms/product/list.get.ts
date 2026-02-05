import { ProductServices } from '~~/server/services/cms/product.services';

const productServices = new ProductServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:product:list');
  const query = getQuery(event);
  const data = await productServices.list(query);
  return createApiResponse(data);
});
