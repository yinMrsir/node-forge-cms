import { ContentServices } from '~~/server/services/cms/content.services';

const contentServices = new ContentServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:content:add');
  const body = await readBody(event);

  const exintingContent = await contentServices.findByCategoryId(body.categoryId);
  if (exintingContent) {
    return createError({
      statusCode: 400,
      message: '该分类下已存在内容'
    });
  }

  body.createBy = event.context.user.userName;
  body.updateBy = event.context.user.userName;
  await contentServices.add(body);
  return createApiResponse(null, 200, '新增成功');
});
