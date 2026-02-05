import { BannerServices } from '~~/server/services/cms/banner.services';

const bannerServices = new BannerServices();

export default defineEventHandler(async event => {
  const data = await bannerServices.getActiveList();
  return data;
});
