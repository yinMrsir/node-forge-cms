import { BannerServices } from '~~/server/services/cms/banner.services';

const bannerServices = new BannerServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:banner:list');
  const query = getQuery(event);
  const data = await bannerServices.list(query);
  return createApiResponse(data);
});
