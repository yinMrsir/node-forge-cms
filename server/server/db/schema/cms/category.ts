import { int, mysqlTable, varchar, char, json } from 'drizzle-orm/mysql-core';
import { columnsHelpers } from '../../columns.helpers';

// 定义分类表结构（支持新闻和产品分类）
export const categoryTable = mysqlTable('category', {
  categoryId: int('category_id').autoincrement().primaryKey().notNull(),
  // 分类名称（多语言）
  categoryName: json('category_name').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 分类描述（多语言）
  description: json('description').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 关键词（多语言，用于SEO）
  keywords: json('keywords').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 分类类型：1=新闻分类, 2=产品分类
  categoryType: char('category_type', { length: 1 }).notNull(),
  // 父级分类ID（0=顶级分类）
  parentCategoryId: int('parent_category_id').default(0),
  // 树形路径（如 "1.2.3."，用于快速查询层级）
  mpath: varchar('mpath', { length: 255 }),
  // URL路径标识（如 works, infos）
  urlKey: varchar('url_key', { length: 100 }).unique(),
  // 模板类型（news, products, page 等）
  templateType: varchar('template_type', { length: 50 }),
  // 详情页模板类型（news-detail, products-detail 等）
  detailTemplateType: varchar('detail_template_type', { length: 50 }),
  // 重定向地址
  redirectUrl: varchar('redirect_url', { length: 255 }),
  // 显示排序
  orderNum: int('order_num').default(0),
  // 是否推荐：0=否, 1=是
  isRecommend: char('is_recommend', { length: 1 }).default('0'),
  // 状态：0=草稿, 1=发布, 2=下架
  status: char('status', { length: 1 }).default('0'),
  // 删除标志：0=未删除, 2=已删除
  delFlag: char('del_flag', { length: 1 }).default('0'),
  ...columnsHelpers
});

// 定义分类类型
export type Category = typeof categoryTable.$inferSelect;
export type NewCategory = typeof categoryTable.$inferInsert;
