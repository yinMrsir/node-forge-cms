import { int, mysqlTable, char, json, varchar } from 'drizzle-orm/mysql-core';
import { relations } from 'drizzle-orm';
import { columnsHelpers } from '../../columns.helpers';
import { categoryTable } from './category';

// 定义内容表结构
export const contentTable = mysqlTable('content', {
  contentId: int('content_id').autoincrement().primaryKey().notNull(),
  // 内容（多语言，富文本HTML）
  content: json('content').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 描述（多语言，用于SEO）
  description: json('description').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 关键词（多语言，用于SEO）
  keywords: json('keywords').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 分类ID（外键）
  categoryId: int('category_id')
    .references(() => categoryTable.categoryId)
    .unique(),
  // 删除标志：0=未删除, 2=已删除
  delFlag: char('del_flag', { length: 1 }).default('0'),
  ...columnsHelpers
});

// 定义关系
export const contentRelations = relations(contentTable, ({ one }) => ({
  category: one(categoryTable, {
    fields: [contentTable.categoryId],
    references: [categoryTable.categoryId]
  })
}));

// 定义内容类型
export type Content = typeof contentTable.$inferSelect;
export type NewContent = typeof contentTable.$inferInsert;
