import { BannerServices } from '~~/server/services/cms/banner.services';

const bannerServices = new BannerServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:banner:remove');
  const bannerId = getRouterParam(event, 'bannerId');
  await bannerServices.delete([bannerId]);
  return createApiResponse(null, 200, '删除成功');
});
