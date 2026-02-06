import { useAuth } from '../composables/useAuth';

/* 管理端不需要验证Auth的路由 */
const noVerificationRouters = [
  '/api/admin/login',
  '/api/admin/logout',
  '/api/admin/captchaImage',
  '/api/admin/common/upload'
];

/* 公开端API免认证（所有 /api/public 开头的路由） */
const isPublicApi = (path: string) => path.startsWith('/api/public');

export default defineEventHandler(async event => {
  // 公开端API免认证
  if (isPublicApi(event.path)) {
    return;
  }

  // 管理端验证
  if (!noVerificationRouters.includes(event.path) && event.path.includes('/api/admin')) {
    const auth = useAuth(event);
    event.context.user = await auth.verification();
    event.context.validatePermission = auth.validatePermission;
  }
});
