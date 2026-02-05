// 在指定位置插入空格符
import stringWidth from 'string-width';

export const insertNewLineAtPosition = (str: string, position: number) => {
  let part1 = '';
  let part2 = str;
  let currentWidth = 0;
  for (const char of Array.from(str)) {
    if (currentWidth + stringWidth(char) <= position) {
      part1 += char;
      part2 = part2.slice(1);
      currentWidth += stringWidth(char);
    } else {
      break;
    }
  }
  return part1 + '\n' + part2;
};

/**
 * 处理字符串为 URL 友好格式
 * 规则：1. 所有空格替换为 -  2. 去重连续的 -  3. 移除首尾 -  4. 过滤 URL 有害特殊字符
 * 示例："豆包 - 字节跳动旗下 AI 助手" → "豆包-字节跳动旗下-AI-助手"
 * @param str 待处理字符串
 * @returns URL友好字符串
 */
export function formatToUrlFriendly(str: string): string {
  if (typeof str !== 'string' || str.trim() === '') return '';

  // 步骤1：替换全角空格、制表符、换行符为半角空格
  let result = str.replace(/[\u3000\t\n\r]/g, ' ');
  // 步骤2：将所有空格（单个/多个）替换为 -
  result = result.replace(/\s+/g, '-');
  // 步骤3：去重连续的 -（避免 豆包--字节跳动 这种情况）
  result = result.replace(/-+/g, '-');
  // 步骤4：移除字符串首尾的 -
  result = result.replace(/^-|-$/g, '');
  // 步骤5：过滤 URL 有害特殊字符
  result = result.replaceAll('/', '').replaceAll('?', '').replaceAll('&', '');

  return result;
}
