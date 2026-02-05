import { SeoServices } from '~~/server/services/cms/seo.services';

export default defineEventHandler(async event => {
  const query = getQuery(event);
  const seoServices = new SeoServices();
  const data = await seoServices.list({
    pageNum: Number(query.pageNum) || 1,
    limit: Number(query.limit) || 10,
    pageType: query.pageType as string
  });

  return {
    code: 200,
    data: data.rows,
    total: data.total,
    message: 'success'
  };
});
