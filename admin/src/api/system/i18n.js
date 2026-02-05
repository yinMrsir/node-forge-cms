import request from '@/utils/request';

// 查询语言列表
export function listLocale(query) {
  return request({
    url: '/system/i18n/list',
    method: 'get',
    params: query
  });
}

// 查询语言详细
export function getLocale(localeId) {
  return request({
    url: '/system/i18n/' + localeId,
    method: 'get'
  });
}

// 新增语言
export function addLocale(data) {
  return request({
    url: '/system/i18n',
    method: 'post',
    data: data
  });
}

// 修改语言
export function updateLocale(data) {
  return request({
    url: '/system/i18n',
    method: 'put',
    data: data
  });
}

// 删除语言
export function delLocale(localeId) {
  return request({
    url: '/system/i18n/' + localeId,
    method: 'delete'
  });
}

// 获取语言翻译内容（嵌套格式）
export function getLocaleContent(locale) {
  return request({
    url: '/system/i18n/translations/list',
    method: 'get',
    params: { locale }
  });
}

// 更新语言翻译内容
export function updateLocaleContent(locale, data) {
  return request({
    url: '/system/i18n/translations',
    method: 'put',
    params: { locale },
    data: data
  });
}

// 获取翻译列表（分页，扁平格式）
export function listTranslation(query) {
  return request({
    url: '/system/i18n/translations/list',
    method: 'get',
    params: query
  });
}

// 获取分组列表
export function listGroups(locale) {
  return request({
    url: '/system/i18n/translations/groups',
    method: 'get',
    params: { locale }
  });
}
