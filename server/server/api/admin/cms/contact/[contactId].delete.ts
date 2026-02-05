import { ContactServices } from '~~/server/services/cms/contact.services';

const contactServices = new ContactServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:contact:remove');
  const contactId = getRouterParam(event, 'contactId');
  await contactServices.delete([contactId]);
  return createApiResponse(null, 200, '删除成功');
});
