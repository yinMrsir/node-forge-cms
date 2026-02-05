import { AuthServices } from '~~/server/services/admin/auth/auth.services';
import { LoginServices } from '~~/server/services/admin/login/login.services';

const authServices = new AuthServices();

export default defineEventHandler(async event => {
  const body = await readBody(event);
  const ip = getRequestIP(event, { xForwardedFor: true })?.replace('::ffff:', '');
  const headers = getHeaders(event);
  const loginInfo = { headers, ip, user: { userName: body.username } };
  await authServices.checkImgCaptcha(body.uuid, body.code, loginInfo);
  const data = await new LoginServices().login(body.username, body.password, {
    ...headers,
    ip
  });
  return createApiResponse(data);
});
