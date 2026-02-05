import { I18nServices } from '~~/server/services/admin/i18n/i18n.services';

export default defineEventHandler(async event => {
  const localeId = parseInt(getRouterParam(event, 'localeId') as string);

  if (!localeId) {
    throw createError({
      statusCode: 400,
      message: 'localeId is required'
    });
  }

  const i18nServices = new I18nServices();
  const data = await i18nServices.getLocaleById(localeId);

  if (!data) {
    throw createError({
      statusCode: 404,
      message: 'Locale not found'
    });
  }

  return createApiResponse(data);
});
