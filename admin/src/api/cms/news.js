import request from '@/utils/request'

// 查询新闻列表
export function listNews(query) {
  return request({
    url: '/cms/news/list',
    method: 'get',
    params: query
  })
}

// 查询新闻详细
export function getNews(newsId) {
  return request({
    url: '/cms/news/' + newsId,
    method: 'get'
  })
}

// 新增新闻
export function addNews(data) {
  return request({
    url: '/cms/news',
    method: 'post',
    data: data
  })
}

// 修改新闻
export function updateNews(data) {
  return request({
    url: '/cms/news',
    method: 'put',
    data: data
  })
}

// 删除新闻
export function delNews(newsId) {
  return request({
    url: '/cms/news/' + newsId,
    method: 'delete'
  })
}

// 修改新闻状态
export function changeNewsStatus(newsId, status) {
  const data = {
    newsId,
    status
  }
  return request({
    url: '/cms/news/changeStatus',
    method: 'put',
    data: data
  })
}

// 修改置顶
export function changeNewsTop(newsId, isTop) {
  const data = {
    newsId,
    isTop
  }
  return request({
    url: '/cms/news/changeTop',
    method: 'put',
    data: data
  })
}

// 修改推荐
export function changeNewsRecommend(newsId, isRecommend) {
  const data = {
    newsId,
    isRecommend
  }
  return request({
    url: '/cms/news/changeRecommend',
    method: 'put',
    data: data
  })
}
