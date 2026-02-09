import { AiConfigServices } from '../admin/system/aiConfig/ai.config.services';
import { I18nServices } from '../admin/i18n/i18n.services';

export interface AIProvider {
  name: string;
  translate(text: string, targetLang: string, langMap: Record<string, string>): Promise<string>;
}

/**
 * 获取语言映射表
 */
async function getLangMap(): Promise<Record<string, string>> {
  const i18nServices = new I18nServices();
  const locales = await i18nServices.getLocales();
  const langMap: Record<string, string> = {};
  locales.forEach(locale => {
    langMap[locale.code] = locale.name;
  });
  return langMap;
}

/**
 * 构建翻译提示词
 */
function buildTranslatePrompt(text: string, targetLang: string, langMap: Record<string, string>): string {
  const targetLanguage = langMap[targetLang] || targetLang;
  return `请将以下内容翻译成${targetLanguage}，只返回翻译结果，不要有任何解释或额外内容：${text}`;
}

/**
 * 智谱AI服务提供者
 */
class ZhipuAIProvider implements AIProvider {
  name = 'zhipu';

  private config: any;

  constructor(config: any) {
    this.config = config;
  }

  translate(text: string, targetLang: string, langMap: Record<string, string>): Promise<string> {
    const prompt = buildTranslatePrompt(text, targetLang, langMap);
    return this.callAI(prompt);
  }

  private async callAI(prompt: string): Promise<string> {
    try {
      const response = await fetch(this.config.endpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${this.config.apiKey}`
        },
        body: JSON.stringify({
          model: this.config.model || 'glm-4',
          messages: [
            {
              role: 'user',
              content: prompt
            }
          ],
          temperature: this.config.temperature || 0.3,
          max_tokens: this.config.maxTokens || 2000
        })
      });

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`智谱AI调用失败: ${response.status} - ${errorText}`);
      }

      const data = await response.json();
      return data.choices?.[0]?.message?.content || '';
    } catch (error: any) {
      console.error('智谱AI翻译错误:', error);
      throw new Error(`智谱AI翻译失败: ${error.message}`);
    }
  }
}

/**
 * 豆包/火山引擎服务提供者
 */
class DoubaoAIProvider implements AIProvider {
  name = 'doubao';

  private config: any;

  constructor(config: any) {
    this.config = config;
  }

  translate(text: string, targetLang: string, langMap: Record<string, string>): Promise<string> {
    const prompt = buildTranslatePrompt(text, targetLang, langMap);
    return this.callAI(prompt);
  }

  private async callAI(prompt: string): Promise<string> {
    try {
      const response = await fetch(this.config.endpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${this.config.apiKey}`
        },
        body: JSON.stringify({
          model: this.config.model,
          messages: [
            {
              role: 'user',
              content: prompt
            }
          ],
          temperature: this.config.temperature || 0.3,
          max_tokens: this.config.maxTokens || 2000
        })
      });

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`豆包AI调用失败: ${response.status} - ${errorText}`);
      }

      const data = await response.json();
      return data.choices?.[0]?.message?.content || '';
    } catch (error: any) {
      console.error('豆包AI翻译错误:', error);
      throw new Error(`豆包AI翻译失败: ${error.message}`);
    }
  }
}

/**
 * DeepSeek服务提供者
 */
class DeepSeekAIProvider implements AIProvider {
  name = 'deepseek';

  private config: any;

  constructor(config: any) {
    this.config = config;
  }

  translate(text: string, targetLang: string, langMap: Record<string, string>): Promise<string> {
    const prompt = buildTranslatePrompt(text, targetLang, langMap);
    return this.callAI(prompt);
  }

  private async callAI(prompt: string): Promise<string> {
    try {
      const response = await fetch(this.config.endpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${this.config.apiKey}`
        },
        body: JSON.stringify({
          model: this.config.model || 'deepseek-chat',
          messages: [
            {
              role: 'user',
              content: prompt
            }
          ],
          temperature: this.config.temperature || 0.3,
          max_tokens: this.config.maxTokens || 2000
        })
      });

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`DeepSeek调用失败: ${response.status} - ${errorText}`);
      }

      const data = await response.json();
      return data.choices?.[0]?.message?.content || '';
    } catch (error: any) {
      console.error('DeepSeek翻译错误:', error);
      throw new Error(`DeepSeek翻译失败: ${error.message}`);
    }
  }
}

/**
 * AI服务工厂
 */
export class AIServiceFactory {
  private static providers: Record<string, new (config: any) => AIProvider> = {
    zhipu: ZhipuAIProvider,
    doubao: DoubaoAIProvider,
    deepseek: DeepSeekAIProvider
  };

  static createProvider(providerType: string, config: any): AIProvider {
    const ProviderClass = this.providers[providerType];
    if (!ProviderClass) {
      throw new Error(`不支持的AI服务提供者: ${providerType}`);
    }
    return new ProviderClass(config);
  }
}

/**
 * AI翻译服务
 */
export class AITranslateService {
  private aiConfigServices: AiConfigServices;

  constructor() {
    this.aiConfigServices = new AiConfigServices();
  }

  /**
   * 翻译文本
   * @param text 要翻译的文本
   * @param targetLang 目标语言代码
   * @param provider 指定的AI服务提供者（可选）
   */
  async translate(text: string, targetLang: string): Promise<string> {
    if (!text || text.trim() === '') {
      throw new Error('翻译内容不能为空');
    }

    // 获取AI配置
    const aiConfig = await this.aiConfigServices.findDefaultConfig();

    if (!aiConfig) {
      throw new Error('未找到可用的AI配置，请先配置AI服务');
    }

    return this.translateWithConfig(text, targetLang, aiConfig);
  }

  /**
   * 批量翻译
   * @param texts 要翻译的文本数组
   * @param targetLang 目标语言代码
   * @param provider 指定的AI服务提供者（可选）
   */
  async batchTranslate(texts: string[], targetLang: string): Promise<string[]> {
    const results: string[] = [];
    for (const text of texts) {
      const translated = await this.translate(text, targetLang);
      results.push(translated);
    }
    return results;
  }

  /**
   * 使用指定配置进行翻译
   */
  private async translateWithConfig(text: string, targetLang: string, config: any): Promise<string> {
    if (config.status !== '1') {
      throw new Error('AI配置未启用');
    }

    const langMap = await getLangMap();
    const provider = AIServiceFactory.createProvider(config.provider, config.configValue);
    return provider.translate(text, targetLang, langMap);
  }

  /**
   * 获取可用的AI服务提供者列表
   */
  async getAvailableProviders(): Promise<string[]> {
    const configs = await this.aiConfigServices.findAllEnabled();
    const providers = new Set<string>();
    configs.forEach(config => {
      if (config.status === '1') {
        providers.add(config.provider);
      }
    });
    return Array.from(providers);
  }
}
