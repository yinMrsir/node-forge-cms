import { BannerServices } from '~~/server/services/cms/banner.services';

const bannerServices = new BannerServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:banner:add');
  const body = await readBody(event);
  body.createBy = event.context.user.userName;
  await bannerServices.add(body);
  return createApiResponse(null, 200, '新增成功');
});
