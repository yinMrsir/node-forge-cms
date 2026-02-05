// 获取域名
export function getDomainFromUrl(url?: string) {
  const pattern = /^(https?:\/\/)?(?:www\.)?([^/?#]+)/i;
  const match = url?.match(pattern);
  if (match && match.length > 2) {
    return match[2];
  }
  return null;
}

// 数组中随机取n个元素
export function getRandomElements(arr: any[], n: number) {
  n = Math.min(n, arr.length);
  const result = [];
  const copy = [...arr]; // 创建一个副本以避免修改原数组
  for (let i = 0; i < n; i++) {
    const j = Math.floor(Math.random() * copy.length);
    result.push(copy.splice(j, 1)[0]);
  }
  return result;
}
