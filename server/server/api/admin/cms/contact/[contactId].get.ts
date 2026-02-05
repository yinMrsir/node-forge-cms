import { ContactServices } from '~~/server/services/cms/contact.services';

const contactServices = new ContactServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:contact:query');
  const contactId = getRouterParam(event, 'contactId');
  const data = await contactServices.findById(Number(contactId));
  return createApiResponse(data);
});
