import { I18nServices } from '~~/server/services/admin/i18n/i18n.services';

export default defineEventHandler(async event => {
  const query = getQuery(event);
  const i18nServices = new I18nServices();

  // 支持分页查询
  if (query.pageNum && query.pageSize) {
    const data = await i18nServices.getLocalesByPage({
      localeCode: query.localeCode as string,
      localeName: query.localeName as string,
      status: query.status as string,
      pageNum: parseInt(query.pageNum as string),
      pageSize: parseInt(query.pageSize as string)
    });
    return createApiResponse(data);
  }

  // 查询所有启用的语言
  const status = query.status as string;
  const data = await i18nServices.getLocales(status);
  return createApiResponse(data);
});
