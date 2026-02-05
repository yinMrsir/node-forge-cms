import { ContactServices } from '~~/server/services/cms/contact.services';

const contactServices = new ContactServices();

export default defineEventHandler(async event => {
  await event.context.validatePermission('cms:contact:edit');
  const body = await readBody(event);
  await contactServices.changeStatus(body.contactId, body.status, body.handleRemark);
  return createApiResponse(null, 200, '操作成功');
});
