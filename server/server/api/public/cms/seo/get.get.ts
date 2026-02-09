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
  const data = await seoServices.getByPage(pageType as string, pageKey as string, {
    title: true,
    description: true,
    keywords: true,
    ogTitle: true,
    ogDescription: true,
    ogImage: true
  });

  return data;
});
