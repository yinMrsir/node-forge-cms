import { I18nServices } from '~~/server/services/admin/i18n/i18n.services';

export default defineEventHandler(async event => {
  const locale = getRouterParam(event, 'locale') as string;

  if (!locale) {
    throw createError({
      statusCode: 400,
      message: 'Locale is required'
    });
  }

  const i18nServices = new I18nServices();
  const data = await i18nServices.getLocaleContent(locale);
  return createApiResponse(data);
});
