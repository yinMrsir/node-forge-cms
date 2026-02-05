import { ContentServices } from '~~/server/services/cms/content.services';

const contentServices = new ContentServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:content:query');
  const contentId = getRouterParam(event, 'contentId');
  const data = await contentServices.findById(Number(contentId));
  return createApiResponse(data);
});
