import { AITranslateService } from '~~/server/services/ai/ai.service';

export default defineEventHandler(async event => {
  try {
    const body = await readBody(event);
    const { text, targetLang } = body;

    // 验证参数
    if (!text || typeof text !== 'string') {
      throw createError({
        statusCode: 400,
        message: '请提供要翻译的文本'
      });
    }

    if (!targetLang || typeof targetLang !== 'string') {
      throw createError({
        statusCode: 400,
        message: '请提供目标语言代码'
      });
    }

    // 验证目标语言代码
    const validLangs = ['zh', 'en', 'ja', 'ko', 'fr', 'de', 'es', 'pt', 'ru', 'ar'];
    if (!validLangs.includes(targetLang)) {
      throw createError({
        statusCode: 400,
        message: `不支持的目标语言代码: ${targetLang}。支持的语言: ${validLangs.join(', ')}`
      });
    }

    // 调用翻译服务
    const translateService = new AITranslateService();
    const result = await translateService.translate(text, targetLang);

    return createApiResponse({
      originalText: text,
      translatedText: result,
      targetLang
    });
  } catch (error: any) {
    console.error('AI翻译API错误:', error);
    throw createError({
      statusCode: error.statusCode || 500,
      message: error.message || '翻译失败，请稍后重试'
    });
  }
});
