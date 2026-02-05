import { int, mysqlTable, char, varchar, text } from 'drizzle-orm/mysql-core';
import { columnsHelpers } from '../../columns.helpers';

// 定义联系表单表结构
export const contactTable = mysqlTable('contact', {
  contactId: int('contact_id').autoincrement().primaryKey().notNull(),
  // 姓名
  name: varchar('name', { length: 100 }).notNull(),
  // 电话
  phone: varchar('phone', { length: 20 }),
  // 邮箱
  email: varchar('email', { length: 100 }),
  // 咨询主题
  subject: varchar('subject', { length: 50 }),
  // 留言内容
  message: text('message').notNull(),
  // 状态：0=未处理, 1=已处理
  status: char('status', { length: 1 }).default('0'),
  // 处理备注
  handleRemark: varchar('handle_remark', { length: 500 }),
  // 删除标志：0=未删除, 2=已删除
  delFlag: char('del_flag', { length: 1 }).default('0'),
  ...columnsHelpers
});

// 定义联系表单类型
export type Contact = typeof contactTable.$inferSelect;
export type NewContact = typeof contactTable.$inferInsert;
