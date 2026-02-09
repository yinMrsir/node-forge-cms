import { BannerServices } from '~~/server/services/cms/banner.services';

const bannerServices = new BannerServices();

export default defineEventHandler(async () => {
  const data = await bannerServices.getActiveList({
    columns: {
      buttonText: true,
      description: true,
      imageUrl: true,
      linkUrl: true,
      title: true
    }
  });
  return data;
});
