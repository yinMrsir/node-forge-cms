import { I18nServices } from '~~/server/services/admin/i18n/i18n.services';

export default defineEventHandler(async () => {
  const i18nServices = new I18nServices();
  const data = await i18nServices.getLocales('0'); // 只返回启用的语言
  return createApiResponse(data);
});
