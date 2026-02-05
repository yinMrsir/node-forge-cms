import { ProductServices } from '~~/server/services/cms/product.services';

const productServices = new ProductServices();

export default defineEventHandler(async event => {
  const query = getQuery(event);
  const limit = Number(query.limit) || 6;
  const data = await productServices.getRecommend(limit);
  return data;
});
