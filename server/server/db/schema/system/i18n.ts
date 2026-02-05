import { mysqlTable, int, varchar, text } from 'drizzle-orm/mysql-core';
import { columnsHelpers } from '../../columns.helpers';

export const i18nLocaleTable = mysqlTable('i18n_locale', {
  /* 语言主键 */
  localeId: int('locale_id').primaryKey().autoincrement(),

  /* 语言代码（如: zh, en, ja） */
  localeCode: varchar('locale_code', { length: 10 }).notNull().unique(),

  /* 语言名称 */
  localeName: varchar('locale_name', { length: 50 }).notNull(),

  /* 是否默认语言 */
  isDefault: varchar('is_default', { length: 1 }).default('N'),

  /* 语言图标（可选） */
  icon: varchar('icon', { length: 100 }).default(''),

  /* 排序 */
  sortOrder: int('sort_order').default(0),

  /* 状态（0正常 1停用） */
  status: varchar('status', { length: 1 }).default('0'),
  ...columnsHelpers
});

export type I18nLocale = typeof i18nLocaleTable.$inferSelect;
export type NewI18nLocale = typeof i18nLocaleTable.$inferInsert;

export const i18nTranslationTable = mysqlTable('i18n_translation', {
  /* 翻译主键 */
  translationId: int('translation_id').primaryKey().autoincrement(),

  /* 语言代码 */
  localeCode: varchar('locale_code', { length: 10 }).notNull(),

  /* 翻译键（如: site.name, nav.home） */
  translationKey: varchar('translation_key', { length: 200 }).notNull(),

  /* 翻译值 */
  translationValue: text('translation_value').default(''),

  /* 分组（如: site, nav, home） */
  groupName: varchar('group_name', { length: 50 }).default(''),

  /* 排序 */
  sortOrder: int('sort_order').default(0),
  ...columnsHelpers
});

export type I18nTranslation = typeof i18nTranslationTable.$inferSelect;
export type NewI18nTranslation = typeof i18nTranslationTable.$inferInsert;
