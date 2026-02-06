import { mysqlTable, int, varchar, json, mysqlEnum } from 'drizzle-orm/mysql-core';
import { columnsHelpers } from '../../columns.helpers';

// AI服务商类型枚举
export type AI_PROVIDER = 'zhipu' | 'doubao' | 'deepseek';

export const aiConfigTable = mysqlTable('ai_config', {
  /* 主键ID */
  aiConfigId: int('ai_config_id').primaryKey().autoincrement(),

  /* 配置名称（如：智谱AI-生产环境） */
  configName: varchar('config_name', { length: 100 }).notNull().default(''),

  /* AI服务商类型 */
  provider: mysqlEnum('provider', ['zhipu', 'doubao', 'deepseek']).notNull(),

  /* 配置键名（唯一标识，如：zhipu_prod） */
  configKey: varchar('config_key', { length: 100 }).notNull().unique(),

  /* JSON配置（存储API Key、端点URL、模型等） */
  configValue: json('config_value').notNull().default({}),

  /* 是否启用 */
  status: mysqlEnum('status', ['0', '1']).notNull().default('1'), // 1启用 0停用

  /* 是否默认配置 */
  isDefault: mysqlEnum('is_default', ['Y', 'N']).notNull().default('N'),

  /* 排序 */
  sortOrder: int('sort_order').notNull().default(0),

  ...columnsHelpers // remark, createBy, createTime, updateBy, updateTime
});

export type AiConfig = typeof aiConfigTable.$inferSelect;
export type NewAiConfig = typeof aiConfigTable.$inferInsert;

// AI配置值的类型定义
export interface AiConfigValue {
  apiKey: string;
  endpoint?: string;
  model?: string;
  temperature?: number;
  maxTokens?: number;
  [key: string]: any; // 允许其他自定义字段
}
