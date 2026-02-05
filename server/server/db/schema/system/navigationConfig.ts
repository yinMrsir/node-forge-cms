import { mysqlTable, varchar, int, json, char } from 'drizzle-orm/mysql-core';
import { columnsHelpers } from '../../columns.helpers';

export const navigationConfigTable = mysqlTable('navigation_config', {
  /* 主键 */
  id: int('id').primaryKey().autoincrement(),

  /* 显示名称 */
  displayName: json('display_name').default({ zh: '', en: '' }),

  /* web端链接地址 */
  webUrl: varchar('web_url', { length: 500 }).notNull(),

  /* 移动端专用链接 */
  mobileUrl: varchar('mobile_url', { length: 500 }),

  /* 图片 */
  imgUrl: varchar('img_url', { length: 500 }),

  /* 是否在新窗口打开 */
  isNewWindow: char('is_new_window').default('0'),

  /* 是否启用 */
  isEnabled: char('is_enabled').default('0'),

  /* 排序权重 */
  sortOrder: int('sort_order').default(0),

  ...columnsHelpers
});

export type NavigationConfig = typeof navigationConfigTable.$inferSelect;
export type NewNavigationConfig = typeof navigationConfigTable.$inferInsert;
