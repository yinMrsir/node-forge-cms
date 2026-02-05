import { I18nServices } from '~~/server/services/admin/i18n/i18n.services';

export default defineEventHandler(async event => {
  const body = await readBody(event);

  if (!body?.localeId) {
    throw createError({
      statusCode: 400,
      message: 'localeId is required'
    });
  }

  const i18nServices = new I18nServices();
  await i18nServices.updateLocale(body.localeId, {
    localeName: body.localeName,
    icon: body.icon,
    sortOrder: body.sortOrder,
    status: body.status
  });

  return createApiResponse(null, 200, '更新成功');
});
