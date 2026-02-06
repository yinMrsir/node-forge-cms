import request from '@/utils/request';

// 查询AI配置列表
export function listAiConfig(query) {
  return request({
    url: '/system/aiConfig/list',
    method: 'get',
    params: query
  });
}

// 查询AI配置详细
export function getAiConfig(aiConfigId) {
  return request({
    url: '/system/aiConfig/' + aiConfigId,
    method: 'get'
  });
}

// 根据配置键名查询AI配置
export function getAiConfigByKey(configKey) {
  return request({
    url: '/system/aiConfig/key/' + configKey,
    method: 'get'
  });
}

// 新增AI配置
export function addAiConfig(data) {
  return request({
    url: '/system/aiConfig',
    method: 'post',
    data: data
  });
}

// 修改AI配置
export function updateAiConfig(data) {
  return request({
    url: '/system/aiConfig',
    method: 'put',
    data: data
  });
}

// 删除AI配置
export function delAiConfig(aiConfigId) {
  return request({
    url: '/system/aiConfig/' + aiConfigId,
    method: 'delete'
  });
}

// 启用/停用AI配置
export function updateAiConfigStatus(aiConfigId, status) {
  return request({
    url: '/system/aiConfig/status',
    method: 'put',
    data: {
      aiConfigId,
      status
    }
  });
}

// 设置默认AI配置
export function setDefaultAiConfig(aiConfigId, provider) {
  return request({
    url: '/system/aiConfig/default',
    method: 'put',
    data: {
      aiConfigId,
      provider
    }
  });
}

// 根据服务商获取AI配置列表
export function getAiConfigByProvider(provider) {
  return request({
    url: '/system/aiConfig/provider/' + provider,
    method: 'get'
  });
}

// 获取默认AI配置
export function getDefaultAiConfig(provider) {
  return request({
    url: '/system/aiConfig/default/' + provider,
    method: 'get'
  });
}
