import { int, mysqlTable, char, varchar, json } from 'drizzle-orm/mysql-core';
import { columnsHelpers } from '../../columns.helpers';

// 定义SEO配置表结构
export const seoTable = mysqlTable('seo', {
  id: int('id').autoincrement().primaryKey().notNull(),
  // 页面类型：home, news, products, about等
  pageType: varchar('page_type', { length: 50 }).notNull(),
  // 页面标识，用于区分具体页面
  pageKey: varchar('page_key', { length: 100 }),
  // SEO标题（多语言）
  title: json('title').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 关键词（多语言）
  keywords: json('keywords').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 页面描述（多语言）
  description: json('description').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // Open Graph 分享标题（多语言）
  ogTitle: json('og_title').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // Open Graph 分享描述（多语言）
  ogDescription: json('og_description').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // Open Graph 分享图片
  ogImage: varchar('og_image', { length: 500 }),
  // 删除标志：0=未删除, 2=已删除
  delFlag: char('del_flag', { length: 1 }).default('0'),
  ...columnsHelpers
});

// 定义SEO配置类型
export type Seo = typeof seoTable.$inferSelect;
export type NewSeo = typeof seoTable.$inferInsert;
