import request from '@/utils/request'

// 查询产品列表
export function listProduct(query) {
  return request({
    url: '/cms/product/list',
    method: 'get',
    params: query
  })
}

// 查询产品详细
export function getProduct(productId) {
  return request({
    url: '/cms/product/' + productId,
    method: 'get'
  })
}

// 新增产品
export function addProduct(data) {
  return request({
    url: '/cms/product',
    method: 'post',
    data: data
  })
}

// 修改产品
export function updateProduct(data) {
  return request({
    url: '/cms/product',
    method: 'put',
    data: data
  })
}

// 删除产品
export function delProduct(productId) {
  return request({
    url: '/cms/product/' + productId,
    method: 'delete'
  })
}

// 修改产品状态
export function changeProductStatus(productId, status) {
  const data = {
    productId,
    status
  }
  return request({
    url: '/cms/product/changeStatus',
    method: 'put',
    data: data
  })
}

// 修改推荐
export function changeProductRecommend(productId, isRecommend) {
  const data = {
    productId,
    isRecommend
  }
  return request({
    url: '/cms/product/changeRecommend',
    method: 'put',
    data: data
  })
}

// 修改新品
export function changeProductNew(productId, isNew) {
  const data = {
    productId,
    isNew
  }
  return request({
    url: '/cms/product/changeNew',
    method: 'put',
    data: data
  })
}
