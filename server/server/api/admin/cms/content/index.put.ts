import { ContentServices } from '~~/server/services/cms/content.services';

const contentServices = new ContentServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:content:edit');
  const body = await readBody(event);
  body.updateBy = event.context.user.userName;
  await contentServices.update(body);
  return createApiResponse(null, 200, '修改成功');
});
