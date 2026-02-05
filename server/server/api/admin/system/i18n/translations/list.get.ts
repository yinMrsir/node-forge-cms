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

  // 如果指定了分页参数，返回分页列表
  if (query.page && query.pageSize) {
    const data = await i18nServices.getTranslationList(locale, {
      translationKey: query.translationKey as string,
      groupName: query.groupName as string,
      pageNum: parseInt(query.page as string),
      pageSize: parseInt(query.pageSize as string)
    });
    return createApiResponse(data);
  }

  // 返回嵌套对象格式（用于前端编辑）
  const data = await i18nServices.getLocaleContent(locale);
  return createApiResponse(data);
});
