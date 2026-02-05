import { SeoServices } from '~~/server/services/cms/seo.services';

export default defineEventHandler(async event => {
  const { id } = getQuery(event);
  const user = event.context.user;

  if (!user) {
    throw createError({
      statusCode: 401,
      statusMessage: 'Unauthorized'
    });
  }

  const seoServices = new SeoServices();
  await seoServices.delete(id as string, user.userName);

  return {
    code: 200,
    message: '删除成功'
  };
});
