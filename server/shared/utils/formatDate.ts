/**
 * 根据语言按不同地区显示日期
 * @param yearMonthStr - 年月字符串（YYYY-MM）
 * @param lang - 语言标签（如 zh、en、zh-CN、en-US）
 * @param isNumeric - 是否显示数字格式（如 2025/11），默认长名称（如 2025年11月）
 * @returns 格式化后的年月 | 错误提示
 */
export const formatYearMonth = (yearMonthStr: string, lang: string, isNumeric = false) => {
  // 1. 校验输入格式
  const reg = /^\d{4}-\d{2}$/;
  if (!reg.test(yearMonthStr)) return '无效格式';

  const parts = yearMonthStr.split('-');
  if (parts.length !== 2) return '月份无效';

  const year = Number(parts[0]);
  const month = Number(parts[1]);

  if (isNaN(year) || isNaN(month)) return '日期无效';
  if (month < 1 || month > 12) return '月份无效';

  // 2. 构造合法的 Date 对象
  const date = new Date(year, month - 1, 1);
  if (isNaN(date.getTime())) return '日期无效';

  // 3. 补全语言标签：为简化标签添加默认地区
  const langMap: Record<string, string> = {
    // 中文：默认中国大陆，可扩展台湾/香港
    zh: 'zh-CN',
    zh_cn: 'zh-CN',
    tw: 'zh-TW',
    zh_hk: 'zh-HK',
    // 英语：默认美国，可扩展英国/澳大利亚
    en: 'en-US',
    en_us: 'en-US',
    en_gb: 'en-GB',
    en_au: 'en-AU',
    // 其他常用简化标签补全
    fr: 'fr-FR', // 法语 → 法国
    de: 'de-DE', // 德语 → 德国
    ja: 'ja-JP', // 日语 → 日本
    ko: 'ko-KR', // 韩语 → 韩国
    es: 'es-ES', // 西班牙语 → 西班牙
    ru: 'ru-RU' // 俄语 → 俄罗斯
  };
  // 标准化语言标签（转小写、替换下划线为横杠）
  const normalizedLang = lang.trim().toLowerCase().replace('_', '-');
  // 优先使用补全后的标签，若未匹配则保留原标签
  const finalLang = langMap[normalizedLang] || normalizedLang;

  // 4. 国际化格式化
  return new Intl.DateTimeFormat(finalLang, {
    year: 'numeric',
    month: isNumeric ? '2-digit' : 'short'
  }).format(date);
};

/**
 * 根据语言按不同地区显示年月日
 * @param dateStr - 日期字符串（YYYY-MM-DD 或 YYYY-MM-DD HH:mm:ss）
 * @param lang - 语言标签（如 zh、en、zh-CN、en-US）
 * @param options - 格式化选项
 * @param options.showTime - 是否显示时间，默认 false
 * @param options.dateStyle - 日期样式（full、long、medium、short），默认 medium
 * @param options.timeStyle - 时间样式（full、long、medium、short），默认 short
 * @param options.isNumeric - 是否使用纯数字格式，默认 false
 * @returns 格式化后的日期时间 | 错误提示
 */
export const formatYearMonthDay = (
  dateStr: string,
  lang: string,
  options: {
    showTime?: boolean;
    dateStyle?: 'full' | 'long' | 'medium' | 'short';
    timeStyle?: 'full' | 'long' | 'medium' | 'short';
    isNumeric?: boolean;
  } = {}
) => {
  const { showTime = false, dateStyle = 'medium', timeStyle = 'short', isNumeric = false } = options;

  // 1. 校验并解析日期字符串
  let date: Date;

  // 尝试解析 YYYY-MM-DD 格式
  if (/^\d{4}-\d{2}-\d{2}$/.test(dateStr)) {
    const parts = dateStr.split('-');
    const year = Number(parts[0]);
    const month = Number(parts[1]) - 1; // 月份从0开始
    const day = Number(parts[2]);

    if (isNaN(year) || isNaN(month) || isNaN(day)) return '日期无效';
    if (month < 0 || month > 11) return '月份无效';
    if (day < 1 || day > 31) return '日期无效';

    date = new Date(year, month, day);
  }
  // 尝试解析 YYYY-MM-DD HH:mm:ss 格式
  else if (/^\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}$/.test(dateStr)) {
    const dateTimeParts = dateStr.split(' ');

    // 验证分割后的数组长度是否符合预期
    if (dateTimeParts.length < 2) {
      return '日期时间格式无效';
    }

    const dateParts = dateTimeParts[0].split('-');
    const timeParts = dateTimeParts[1].split(':');

    const year = Number(dateParts[0]);
    const month = Number(dateParts[1]) - 1;
    const day = Number(dateParts[2]);
    const hours = Number(timeParts[0]);
    const minutes = Number(timeParts[1]);
    const seconds = Number(timeParts[2]);

    if (isNaN(year) || isNaN(month) || isNaN(day)) return '日期无效';
    if (isNaN(hours) || isNaN(minutes) || isNaN(seconds)) return '时间无效';
    if (month < 0 || month > 11) return '月份无效';
    if (day < 1 || day > 31) return '日期无效';
    if (hours < 0 || hours > 23) return '小时无效';
    if (minutes < 0 || minutes > 59) return '分钟无效';
    if (seconds < 0 || seconds > 59) return '秒数无效';

    date = new Date(year, month, day, hours, minutes, seconds);
  }
  // 尝试直接解析（支持 ISO 格式等）
  else {
    date = new Date(dateStr);
  }

  if (isNaN(date.getTime())) return '日期无效';

  // 2. 补全语言标签
  const langMap: Record<string, string> = {
    zh: 'zh-CN',
    zh_cn: 'zh-CN',
    tw: 'zh-TW',
    zh_hk: 'zh-HK',
    en: 'en-US',
    en_us: 'en-US',
    en_gb: 'en-GB',
    en_au: 'en-AU',
    fr: 'fr-FR',
    de: 'de-DE',
    ja: 'ja-JP',
    ko: 'ko-KR',
    es: 'es-ES',
    ru: 'ru-RU'
  };

  const normalizedLang = lang.trim().toLowerCase().replace(/_/g, '-');
  const finalLang = langMap[normalizedLang] || normalizedLang;

  // 3. 国际化格式化
  if (isNumeric) {
    // 纯数字格式：2025/01/15 或 2025/01/15 14:30
    const dateOptions: Intl.DateTimeFormatOptions = {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit'
    };

    const timeOptions: Intl.DateTimeFormatOptions = {
      hour: '2-digit',
      minute: '2-digit'
    };

    if (showTime) {
      const dateFormatter = new Intl.DateTimeFormat(finalLang, dateOptions);
      const timeFormatter = new Intl.DateTimeFormat(finalLang, timeOptions);
      return `${dateFormatter.format(date)} ${timeFormatter.format(date)}`;
    }

    return new Intl.DateTimeFormat(finalLang, dateOptions).format(date);
  }

  // 使用 Intl 风格格式化
  const formatOptions: Intl.DateTimeFormatOptions = {};

  if (showTime) {
    formatOptions.dateStyle = dateStyle;
    formatOptions.timeStyle = timeStyle;
  } else {
    formatOptions.dateStyle = dateStyle;
  }

  return new Intl.DateTimeFormat(finalLang, formatOptions).format(date);
};
