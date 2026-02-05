import { BannerServices } from '~~/server/services/cms/banner.services';

const bannerServices = new BannerServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:banner:edit');
  const body = await readBody(event);
  await bannerServices.changeStatus(body.bannerId, body.status, event.context.user.userName);
  return createApiResponse(null, 200, '操作成功');
});
