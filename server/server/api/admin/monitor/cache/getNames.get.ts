import {
  CAPTCHA_IMG_KEY,
  DICTTYPE_KEY,
  SITEMAP_KEY,
  USER_TOKEN_KEY,
  UPLOAD_LOCK_KEY,
  BAN_KEY
} from '~~/server/contants/redis.contant';

export default defineEventHandler(() => {
  const caches = [];
  caches.push({
    cacheName: USER_TOKEN_KEY,
    cacheKey: '',
    cacheValue: '',
    remark: '系统用户'
  });
  caches.push({
    cacheName: DICTTYPE_KEY,
    cacheKey: '',
    cacheValue: '',
    remark: '数据字典'
  });
  caches.push({
    cacheName: CAPTCHA_IMG_KEY,
    cacheKey: '',
    cacheValue: '',
    remark: '登录验证码'
  });
  caches.push({
    cacheName: SITEMAP_KEY,
    cacheKey: '',
    cacheValue: '',
    remark: '网站地图'
  });
  caches.push({
    cacheName: UPLOAD_LOCK_KEY,
    cacheKey: '',
    cacheValue: '',
    remark: '导入文件批量上传'
  });
  caches.push({
    cacheName: BAN_KEY,
    cacheKey: '',
    cacheValue: '',
    remark: '封禁用户'
  });

  return createApiResponse(caches);
});
