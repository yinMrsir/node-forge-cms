import { SeoServices } from '~~/server/services/cms/seo.services';

export default defineEventHandler(async event => {
  const { pageType, pageKey } = getQuery(event);

  if (!pageType) {
    throw createError({
      statusCode: 400,
      statusMessage: 'pageType is required'
    });
  }

  const seoServices = new SeoServices();
  const data = await seoServices.getByPage(pageType as string, pageKey as string);

  return {
    code: 200,
    data: data || null,
    message: 'success'
  };
});
