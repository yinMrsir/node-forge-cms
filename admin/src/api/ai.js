import request from '@/utils/request';

/**
 * AI翻译
 * @param {Object} data - 翻译参数
 * @param {string} data.text - 要翻译的文本
 * @param {string} data.targetLang - 目标语言代码 (zh, en, ja, ko, fr, de, es, pt, ru, ar)
 * @param {string} [data.provider] - 指定的AI服务提供者 (zhipu, doubao, deepseek)，可选
 */
export function translateText(data) {
  return request({
    url: '/ai/translate',
    method: 'post',
    data: data
  });
}

/**
 * 获取可用的AI服务提供者列表
 */
export function getAvailableProviders() {
  return request({
    url: '/ai/providers',
    method: 'get'
  });
}
