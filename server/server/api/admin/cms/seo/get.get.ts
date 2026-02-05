import { SeoServices } from '~~/server/services/cms/seo.services';

export default defineEventHandler(async event => {
  const { id } = getQuery(event);
  const seoServices = new SeoServices();
  const data = await seoServices.findById(Number(id));

  return {
    code: 200,
    data: data || null,
    message: 'success'
  };
});
