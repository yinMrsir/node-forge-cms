import { mysqlTable, varchar, json, int } from 'drizzle-orm/mysql-core';
import { columnsHelpers } from '../../columns.helpers';

export const jsonConfigTable = mysqlTable('json_config', {
  /* 参数主键 */
  jsonConfigId: int('json_config_id').primaryKey().autoincrement(),

  /* 参数键名 */
  configKey: varchar('config_key', { length: 100 }).default(''),

  /* 参数键值 */
  configValue: json().default({}),

  ...columnsHelpers
});

export type JsonConfig = typeof jsonConfigTable.$inferSelect;
export type NewJsonConfig = typeof jsonConfigTable.$inferInsert;
