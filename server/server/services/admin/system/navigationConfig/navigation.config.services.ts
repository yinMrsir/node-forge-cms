import { eq } from 'drizzle-orm';
import { navigationConfigTable } from '~~/server/db/schema/system/navigationConfig';
import type { NavigationConfig, NewNavigationConfig } from '~~/server/db/schema/system/navigationConfig';

export class NavigationConfigServices {
  /**
   * 获取所有导航配置
   */
  async findAll() {
    return await db.select().from(navigationConfigTable).orderBy(navigationConfigTable.sortOrder);
  }

  /**
   * 根据ID获取导航配置
   */
  async findById(id: number) {
    const result = await db.select().from(navigationConfigTable).where(eq(navigationConfigTable.id, id)).limit(1);

    return result[0] || null;
  }

  /**
   * 创建导航配置
   */
  async create(data: NewNavigationConfig) {
    const result = await db.insert(navigationConfigTable).values(data);

    return result;
  }

  /**
   * 更新导航配置
   */
  async update(id: number, data: Partial<NewNavigationConfig>) {
    const result = await db.update(navigationConfigTable).set(data).where(eq(navigationConfigTable.id, id));

    return result;
  }

  /**
   * 删除导航配置
   */
  async delete(id: number) {
    const result = await db.delete(navigationConfigTable).where(eq(navigationConfigTable.id, id));

    return result;
  }

  /**
   * 获取启用的导航配置
   */
  async findEnabled() {
    return await db
      .select()
      .from(navigationConfigTable)
      .where(eq(navigationConfigTable.isEnabled, '0'))
      .orderBy(navigationConfigTable.sortOrder);
  }

  /**
   * 分页查询导航配置
   */
  async findByPage(page: number = 1, pageSize: number = 10) {
    const offset = (page - 1) * pageSize;

    const rows = await db
      .select()
      .from(navigationConfigTable)
      .orderBy(navigationConfigTable.sortOrder)
      .limit(pageSize)
      .offset(offset);

    const total = await db.select({ count: navigationConfigTable.id }).from(navigationConfigTable);

    return {
      rows,
      total: total.length,
      page,
      pageSize
    };
  }
}
