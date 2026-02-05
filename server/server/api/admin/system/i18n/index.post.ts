import { I18nServices } from '~~/server/services/admin/i18n/i18n.services';

export default defineEventHandler(async event => {
  const body = await readBody(event);

  if (!body?.localeCode || !body?.localeName) {
    throw createError({
      statusCode: 400,
      message: 'localeCode and localeName are required'
    });
  }

  const i18nServices = new I18nServices();
  const result = await i18nServices.createLocale({
    localeCode: body.localeCode,
    localeName: body.localeName,
    icon: body.icon,
    sortOrder: body.sortOrder,
    status: body.status
  });

  return createApiResponse(result, 200, '创建成功');
});
