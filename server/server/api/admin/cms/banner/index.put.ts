import { BannerServices } from '~~/server/services/cms/banner.services';

const bannerServices = new BannerServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:banner:edit');
  const body = await readBody(event);
  body.updateBy = event.context.user.userName;
  await bannerServices.update(body);
  return createApiResponse(null, 200, '修改成功');
});
