/**
 * 转换访问量数值为 K/M 单位展示
 * @param {number} num - 原始访问量数值（如 1500、2500000）
 * @param {number} fixed - 保留小数位数，默认 1
 * @returns {string} 格式化后的字符串（如 1.5K、2.5M）
 */
export function formatViewCount(num: number, fixed = 2) {
  // 处理非数字/负数
  if (isNaN(num) || num < 0) return '0';

  // 十亿位（B）：≥1000000000
  if (num >= 1000000000) {
    return (num / 1000000000).toFixed(fixed) + 'B';
  }

  // 千位（K）：1000 - 999999
  if (num >= 1000 && num < 1000000) {
    return (num / 1000).toFixed(fixed) + 'K';
  }
  // 百万位（M）：≥1000000
  else if (num >= 1000000) {
    return (num / 1000000).toFixed(fixed) + 'M';
  }
  // 小于1000，直接返回原数
  else {
    return num.toString();
  }
}

/**
 * 转换月环比小数为百分比格式
 * @param {number|string} mom - 原始月环比值（如 -0.0521、0.1436、"0.0084"）
 * @param {number} fixed - 保留小数位数，默认 2（对应 -5.21%）
 * @returns {string} 格式化后的百分比字符串（如 "-5.21%"、"14.36%"、"0.84%"）
 */
export function formatMomToPercent(mom: number | string, fixed = 2) {
  // 1. 处理非数字/空值（兜底返回 0.00%）
  const num = Number(mom);
  if (isNaN(num)) {
    return '0.00%';
  }

  // 2. 转换为百分比数值（乘以 100）
  const percentNum = num * 100;

  // 3. 格式化：保留指定小数位，自动处理正负号
  const formatted = percentNum.toFixed(fixed);

  // 4. 拼接百分号（确保格式统一：如 -5.21%、14.36%、0.84%）
  return `${formatted}%`;
}

export function formatPrice(price: string, fixed = 2): string {
  // 1. 确保输入是数字
  const num = Number(price);
  if (isNaN(num)) {
    return '0.00%';
  }

  // 2. 转换为百分比数值（乘以 100）
  const percentNum = num * 1000000;

  // 3. 格式化：保留指定小数位，自动处理正负号
  return percentNum.toFixed(fixed);
}
