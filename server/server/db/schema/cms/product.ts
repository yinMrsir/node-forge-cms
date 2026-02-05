import { int, mysqlTable, varchar, char, json } from 'drizzle-orm/mysql-core';
import { columnsHelpers } from '../../columns.helpers';
import { relations } from 'drizzle-orm';
import { categoryTable } from './category';

// 定义产品表结构
export const productTable = mysqlTable('product', {
  productId: int('product_id').autoincrement().primaryKey().notNull(),
  // 产品名称（多语言）
  productName: json('product_name').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 产品描述（多语言，富文本HTML）
  description: json('description').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 产品简介（多语言）
  summary: json('summary').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 关键词（多语言，用于SEO）
  keywords: json('keywords').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 分类ID（外键）
  categoryId: int('category_id').references(() => categoryTable.categoryId),
  // 主图URL
  mainImage: varchar('main_image', { length: 500 }),
  // 产品多图（JSON数组）
  images: varchar('images', { length: 500 }).default(''),
  // 产品规格参数（JSON对象，灵活存储）
  specifications: json('specifications').$type<Record<string, any>>().default({}),
  // 是否推荐：0=否, 1=是
  isRecommend: char('is_recommend', { length: 1 }).default('0'),
  // 是否新品：0=否, 1=是
  isNew: char('is_new', { length: 1 }).default('0'),
  // 浏览量
  viewCount: int('view_count').default(0),
  // 状态：0=草稿, 1=发布, 2=下架
  status: char('status', { length: 1 }).default('0'),
  // 删除标志：0=未删除, 2=已删除
  delFlag: char('del_flag', { length: 1 }).default('0'),
  ...columnsHelpers
});

// 定义关系
export const productRelations = relations(productTable, ({ one }) => ({
  category: one(categoryTable, {
    fields: [productTable.categoryId],
    references: [categoryTable.categoryId]
  })
}));

// 定义产品类型
export type Product = typeof productTable.$inferSelect;
export type NewProduct = typeof productTable.$inferInsert;
