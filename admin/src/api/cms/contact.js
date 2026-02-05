import request from '@/utils/request'

// 查询联系表单列表
export function listContact(query) {
  return request({
    url: '/cms/contact/list',
    method: 'get',
    params: query
  })
}

// 查询联系表单详细
export function getContact(contactId) {
  return request({
    url: '/cms/contact/' + contactId,
    method: 'get'
  })
}

// 删除联系表单
export function delContact(contactId) {
  return request({
    url: '/cms/contact/' + contactId,
    method: 'delete'
  })
}

// 修改处理状态
export function changeContactStatus(contactId, status, handleRemark) {
  const data = {
    contactId,
    status,
    handleRemark
  }
  return request({
    url: '/cms/contact/changeStatus',
    method: 'put',
    data: data
  })
}
