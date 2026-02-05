import { eq } from 'drizzle-orm';
import { jsonConfigTable } from '~~/server/db/schema/system/jsonConfig';
import type { NewJsonConfig } from '~~/server/db/schema/system/jsonConfig';

export class JsonConfigServices {
  /**
   * 获取所有JSON配置
   */
  async findAll() {
    return await db.select().from(jsonConfigTable);
  }

  /**
   * 根据ID获取JSON配置
   */
  async findById(id: number) {
    const result = await db.select().from(jsonConfigTable).where(eq(jsonConfigTable.jsonConfigId, id)).limit(1);

    return result[0] || null;
  }

  /**
   * 根据配置键名获取配置
   */
  async findByKey(configKey: string) {
    const result = await db.select().from(jsonConfigTable).where(eq(jsonConfigTable.configKey, configKey)).limit(1);

    return result[0] || null;
  }

  /**
   * 创建JSON配置
   */
  async create(data: NewJsonConfig) {
    const result = await db.insert(jsonConfigTable).values(data);

    return result;
  }

  /**
   * 更新JSON配置
   */
  async update(id: number, data: Partial<NewJsonConfig>) {
    const result = await db.update(jsonConfigTable).set(data).where(eq(jsonConfigTable.jsonConfigId, id));

    return result;
  }

  /**
   * 根据配置键名更新配置
   */
  async updateByKey(configKey: string, data: Partial<NewJsonConfig>) {
    const result = await db.update(jsonConfigTable).set(data).where(eq(jsonConfigTable.configKey, configKey));

    return result;
  }

  /**
   * 删除JSON配置
   */
  async delete(id: number) {
    const result = await db.delete(jsonConfigTable).where(eq(jsonConfigTable.jsonConfigId, id));

    return result;
  }

  /**
   * 根据配置键名删除配置
   */
  async deleteByKey(configKey: string) {
    const result = await db.delete(jsonConfigTable).where(eq(jsonConfigTable.configKey, configKey));

    return result;
  }

  /**
   * 分页查询JSON配置
   */
  async findByPage(page: number = 1, pageSize: number = 10) {
    const offset = (page - 1) * pageSize;

    const rows = await db.select().from(jsonConfigTable).limit(pageSize).offset(offset);

    const total = await db.select({ count: jsonConfigTable.jsonConfigId }).from(jsonConfigTable);

    return {
      rows,
      total: total.length,
      page,
      pageSize
    };
  }

  /**
   * 获取或创建配置（如果不存在则创建默认配置）
   */
  async getOrCreate(configKey: string, defaultValue: any = {}) {
    const existing = await this.findByKey(configKey);

    if (existing) {
      return existing;
    }

    await this.create({
      configKey,
      configValue: defaultValue
    });

    return await this.findByKey(configKey);
  }
}
