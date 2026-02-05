import { I18nServices } from '~~/server/services/admin/i18n/i18n.services';

export default defineEventHandler(async event => {
  const query = getQuery(event);
  const locale = query.locale as string;
  const body = await readBody(event);

  if (!locale) {
    throw createError({
      statusCode: 400,
      message: 'locale is required'
    });
  }

  if (!body || typeof body !== 'object') {
    throw createError({
      statusCode: 400,
      message: 'Invalid content body'
    });
  }

  const i18nServices = new I18nServices();
  await i18nServices.updateLocaleContent(locale, body);

  return createApiResponse(null, 200, '更新成功');
});
