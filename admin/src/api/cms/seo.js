import request from '@/utils/request';

// 获取SEO配置列表
export function getSeoList(params) {
  return request({
    url: '/cms/seo/list',
    method: 'get',
    params
  });
}

// 获取SEO配置详情
export function getSeo(id) {
  return request({
    url: '/cms/seo/get',
    method: 'get',
    params: { id }
  });
}

// 新增SEO配置
export function addSeo(data) {
  return request({
    url: '/cms/seo/add',
    method: 'post',
    data
  });
}

// 修改SEO配置
export function updateSeo(data) {
  return request({
    url: '/cms/seo/update',
    method: 'put',
    data
  });
}

// 删除SEO配置
export function delSeo(id) {
  return request({
    url: '/cms/seo/delete',
    method: 'delete',
    params: { id }
  });
}
