import { int, mysqlTable, varchar, char, json, datetime } from 'drizzle-orm/mysql-core';
import { columnsHelpers } from '../../columns.helpers';
import { relations } from 'drizzle-orm';
import { categoryTable } from './category';

// 定义新闻表结构
export const newsTable = mysqlTable('news', {
  newsId: int('news_id').autoincrement().primaryKey().notNull(),
  // 标题（多语言）
  title: json('title').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 内容（多语言，富文本HTML）
  content: json('content').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 摘要（多语言）
  summary: json('summary').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 关键词（多语言，用于SEO）
  keywords: json('keywords').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 分类ID（外键）
  categoryId: int('category_id').references(() => categoryTable.categoryId),
  // 封面图URL
  coverImage: varchar('cover_image', { length: 500 }),
  // 作者
  author: varchar('author', { length: 50 }),
  // 来源
  source: varchar('source', { length: 100 }),
  // 是否置顶：0=否, 1=是
  isTop: char('is_top', { length: 1 }).default('0'),
  // 是否推荐：0=否, 1=是
  isRecommend: char('is_recommend', { length: 1 }).default('0'),
  // 浏览量
  viewCount: int('view_count').default(0),
  // 发布时间
  publishTime: datetime('publish_time', { mode: 'string' }),
  // 状态：0=草稿, 1=发布, 2=下架
  status: char('status', { length: 1 }).default('0'),
  // 删除标志：0=未删除, 2=已删除
  delFlag: char('del_flag', { length: 1 }).default('0'),
  ...columnsHelpers
});

// 定义关系
export const newsRelations = relations(newsTable, ({ one }) => ({
  category: one(categoryTable, {
    fields: [newsTable.categoryId],
    references: [categoryTable.categoryId]
  })
}));

// 定义新闻类型
export type News = typeof newsTable.$inferSelect;
export type NewNews = typeof newsTable.$inferInsert;
