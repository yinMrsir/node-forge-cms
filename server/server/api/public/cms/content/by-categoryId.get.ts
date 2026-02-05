import { ContentServices } from '~~/server/services/cms/content.services';

const contentServices = new ContentServices();

export default defineEventHandler(async event => {
  const query = getQuery(event);
  if (!query.categoryId) {
    return createError({ statusCode: 404, message: '参数错误' });
  }
  const data = await contentServices.findByCategoryId(Number(query.categoryId));
  const locale = typeof query.locale === 'string' ? query.locale : 'zh';

  const content = (data?.content as any)?.[locale] ?? data?.content?.zh;
  const description = (data?.description as any)?.[locale] ?? data?.description?.zh;
  const keywords = (data?.keywords as any)?.[locale] ?? data?.keywords?.zh;

  return {
    content,
    description,
    keywords
  };
});
