import { SeoServices } from '~~/server/services/cms/seo.services';

export default defineEventHandler(async event => {
  const body = await readBody(event);
  const seoServices = new SeoServices();
  await seoServices.update(body);

  return {
    code: 200,
    message: '更新成功'
  };
});
