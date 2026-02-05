import { ContentServices } from '~~/server/services/cms/content.services';

const contentServices = new ContentServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:content:list');
  const query = getQuery(event);
  const data = await contentServices.list(query);
  return createApiResponse(data);
});
