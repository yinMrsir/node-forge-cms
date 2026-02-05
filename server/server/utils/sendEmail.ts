import { createTransport } from 'nodemailer';

const fromUser = '542968439@qq.com';

// 创建一个传输对象
const transporter = createTransport({
  // service: "QQ", // 使用 Gmail 服务，你可以使用其他服务，如 'SMTP' 并配置主机、端口等
  host: 'smtp.feishu.cn',
  port: 465,
  auth: {
    user: fromUser, // 你的邮箱地址
    pass: 'ZIp6KQGfi2p6kvAd' // 你的邮箱密码或应用程序特定密码
  }
});

export const sendEmail = async (mailOptions: { to: string; subject: string; text?: string; html?: string }) => {
  try {
    await transporter.sendMail({
      from: fromUser,
      to: mailOptions.to,
      subject: mailOptions.subject,
      text: mailOptions.text,
      html: mailOptions.html
    });
  } catch (error) {
    return error;
  }
};
