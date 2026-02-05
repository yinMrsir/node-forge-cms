import { BannerServices } from '~~/server/services/cms/banner.services';

const bannerServices = new BannerServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:banner:query');
  const bannerId = getRouterParam(event, 'bannerId');
  const data = await bannerServices.findById(Number(bannerId));
  return createApiResponse(data);
});
