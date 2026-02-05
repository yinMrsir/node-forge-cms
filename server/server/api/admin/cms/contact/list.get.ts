import { ContactServices } from '~~/server/services/cms/contact.services';

const contactServices = new ContactServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:contact:list');
  const query = getQuery(event);
  const data = await contactServices.list(query);
  return createApiResponse(data);
});
