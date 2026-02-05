// 魔术数：保持bigint原始类型（带n后缀）
const MAGIC_NUMBER = 987654321n;
// 默认容错值：同样为bigint类型
const DEFAULT_ID = 0n;

/**
 * 混淆id（修正类型注解，解决^运算符类型不兼容问题）
 * @param id 原始id（支持正数、超大数、数字字符串、undefined/null）
 * @returns 混淆后的十六进制字符串
 */
export function obfuscateId(id: number | bigint | string | undefined | null): string {
  // 步骤1：修正类型注解，统一使用小写bigint（原始类型）
  let validId: bigint; // 关键修正：BigInt → bigint

  // 步骤2：入参容错与类型转换
  if (id === undefined || id === null) {
    validId = DEFAULT_ID;
  } else {
    try {
      // BigInt()构造函数返回的是bigint原始类型，赋值给validId（bigint类型）兼容
      validId = BigInt(id);
    } catch (error) {
      throw new Error(`obfuscateId：传入的id "${id}" 无效，无法转换为大整数`);
    }
  }

  // 步骤3：位运算（此时所有变量均为bigint类型，^运算符正常工作）
  let obfuscated = validId ^ MAGIC_NUMBER; // 无类型报错
  obfuscated = (obfuscated << 3n) ^ 12345n; // 无类型报错

  // 步骤4：返回十六进制字符串
  return obfuscated.toString(16).toUpperCase();
}

/**
 * 解混淆id（同步修正类型注解，确保可逆）
 * @param obfuscatedId 混淆后的十六进制字符串
 * @returns 原始id（bigint类型）
 */
export function deObfuscateId(obfuscatedId: string | undefined | null): bigint {
  // 步骤1：入参容错
  if (obfuscatedId === undefined || obfuscatedId === null || obfuscatedId.trim() === '') {
    return DEFAULT_ID;
  }

  // 步骤2：修正类型注解，统一使用小写bigint
  let obfuscated: bigint; // 关键修正：BigInt → bigint

  // 步骤3：十六进制字符串转bigint
  try {
    obfuscated = BigInt(`0x${obfuscatedId.trim()}`);
  } catch (error) {
    throw new Error(`deObfuscateId：传入的混淆id "${obfuscatedId}" 无效，非合法十六进制字符串`);
  }

  // 步骤4：逆向位运算（类型一致，无报错）
  let rawId = obfuscated ^ 12345n; // 无类型报错
  rawId = rawId >> 3n; // 无类型报错
  rawId = rawId ^ MAGIC_NUMBER; // 无类型报错

  // 步骤5：返回bigint类型原始id
  return rawId;
}
