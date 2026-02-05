import request from '@/utils/request';

export function getJsonConfigKey(configKey) {
  return request({
    url: '/system/jsonConfig/key/' + configKey,
    method: 'get'
  });
}

export function updateJsonConfig(data) {
  return request({
    url: '/system/jsonConfig/key/' + data.configKey,
    method: 'put',
    data: data
  });
}
