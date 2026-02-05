import { ContactServices } from '~~/server/services/cms/contact.services';

const contactServices = new ContactServices();

export default defineEventHandler(async event => {
  const body = await readBody(event);

  // 验证必填字段
  if (!body.name || !body.message) {
    throw createError({
      statusCode: 400,
      message: '姓名和留言内容不能为空'
    });
  }

  await contactServices.submit(body);
  return createApiResponse(null, 200, '提交成功');
});
