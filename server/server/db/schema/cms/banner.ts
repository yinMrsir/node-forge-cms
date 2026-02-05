import { int, mysqlTable, char, json, varchar } from 'drizzle-orm/mysql-core';
import { relations } from 'drizzle-orm';
import { columnsHelpers } from '../../columns.helpers';

// 定义轮播图表结构
export const bannerTable = mysqlTable('banner', {
  bannerId: int('banner_id').autoincrement().primaryKey().notNull(),
  // 标题（多语言）
  title: json('title').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 描述（多语言）
  description: json('description').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 图片URL
  imageUrl: varchar('image_url', { length: 500 }).notNull(),
  // 链接地址（可选）
  linkUrl: varchar('link_url', { length: 500 }),
  // 按钮文字（多语言，可选）
  buttonText: json('button_text').$type<{ zh: string; en: string }>().default({ zh: '', en: '' }),
  // 排序顺序
  orderNum: int('order_num').default(0),
  // 状态：0=禁用, 1=启用
  status: char('status', { length: 1 }).default('1'),
  // 删除标志：0=未删除, 2=已删除
  delFlag: char('del_flag', { length: 1 }).default('0'),
  ...columnsHelpers
});

// 定义轮播图类型
export type Banner = typeof bannerTable.$inferSelect;
export type NewBanner = typeof bannerTable.$inferInsert;
