import { I18nServices } from '~~/server/services/admin/i18n/i18n.services';

export default defineEventHandler(async event => {
  const query = getQuery(event);
  const locale = query.locale as string;

  if (!locale) {
    throw createError({
      statusCode: 400,
      message: 'locale is required'
    });
  }

  const i18nServices = new I18nServices();
  const data = await i18nServices.getGroups(locale);

  return createApiResponse(data);
});
