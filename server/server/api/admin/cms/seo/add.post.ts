import { SeoServices } from '~~/server/services/cms/seo.services';

export default defineEventHandler(async event => {
  const body = await readBody(event);
  const seoServices = new SeoServices();
  await seoServices.add(body);

  return {
    code: 200,
    message: '添加成功'
  };
});
