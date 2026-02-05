import { ContentServices } from '~~/server/services/cms/content.services';

const contentServices = new ContentServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:content:remove');
  const contentId = getRouterParam(event, 'contentId');
  await contentServices.delete([contentId]);
  return createApiResponse(null, 200, '删除成功');
});
