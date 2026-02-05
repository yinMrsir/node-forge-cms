import fs from 'fs';
import path from 'path';
import WxPay from 'wechatpay-node-v3';

const runtimeConfig = useRuntimeConfig();

export const wxPay = new WxPay({
  appid: runtimeConfig.xcxConfig.appid,
  mchid: runtimeConfig.mchId,
  publicKey: fs.readFileSync(path.join(process.cwd(), 'apiclient/apiclient_cert.pem')),
  privateKey: fs.readFileSync(path.join(process.cwd(), 'apiclient/apiclient_key.pem'))
});
