import { like, eq, and, not, inArray } from 'drizzle-orm';
import { aiConfigTable } from '~~/server/db/schema/system/aiConfig';
import type { NewAiConfig, AI_PROVIDER } from '~~/server/db/schema/system/aiConfig';

export class AiConfigServices {
  /**
   * 新增AI配置
   */
  async add(body: NewAiConfig) {
    // 检查configKey唯一性
    const existing = await this.findByConfigKey(body.configKey);
    if (existing) {
      throw createError({ statusCode: 400, message: '配置键名已存在' });
    }

    // 如果设置为默认配置，需要清除同provider的其他默认配置
    if (body.isDefault === 'Y') {
      await this.clearDefaultByProvider(body.provider);
    }

    return db.insert(aiConfigTable).values(body);
  }

  /**
   * 更新AI配置
   */
  async update(body: NewAiConfig & { aiConfigId: number }) {
    // 检查configKey唯一性（排除自身）
    const existing = await this.findByConfigKey(body.configKey, body.aiConfigId);
    if (existing) {
      throw createError({ statusCode: 400, message: '配置键名已存在' });
    }

    // 如果设置为默认配置，需要清除同provider的其他默认配置
    if (body.isDefault === 'Y') {
      await this.clearDefaultByProvider(body.provider, body.aiConfigId);
    }

    return db.update(aiConfigTable).set(body).where(eq(aiConfigTable.aiConfigId, body.aiConfigId));
  }

  /**
   * 删除配置
   */
  delete(aiConfigIdArr: number[] | string[]) {
    return db.delete(aiConfigTable).where(
      inArray(
        aiConfigTable.aiConfigId,
        aiConfigIdArr.map(item => Number(item))
      )
    );
  }

  /**
   * 分页查询
   */
  async list(params: any = {}) {
    const { pageNum = 1, limit = 10 } = params || {};
    const offset = (pageNum - 1) * limit;

    const whereList = [];

    // 配置名称模糊查询
    if (params.configName) {
      whereList.push(like(aiConfigTable.configName, `%${params.configName}%`));
    }

    // 服务商类型过滤
    if (params.provider) {
      whereList.push(eq(aiConfigTable.provider, params.provider));
    }

    // 配置键名模糊查询
    if (params.configKey) {
      whereList.push(like(aiConfigTable.configKey, `%${params.configKey}%`));
    }

    // 状态过滤
    if (params.status) {
      whereList.push(eq(aiConfigTable.status, params.status));
    }

    // 是否默认过滤
    if (params.isDefault) {
      whereList.push(eq(aiConfigTable.isDefault, params.isDefault));
    }

    const where = and(...whereList);

    const rowsQuery = db.query.aiConfigTable.findMany({
      where,
      limit,
      offset,
      orderBy: [aiConfigTable.sortOrder, aiConfigTable.aiConfigId]
    });
    const totalQuery = db.$count(aiConfigTable, where);

    const [rows, total] = await Promise.all([rowsQuery, totalQuery]);

    return {
      rows,
      total
    };
  }

  /**
   * 根据ID获取配置
   */
  async findById(aiConfigId: number) {
    return await db.query.aiConfigTable.findFirst({
      where: eq(aiConfigTable.aiConfigId, aiConfigId)
    });
  }

  /**
   * 根据configKey获取配置
   */
  async findByConfigKey(configKey: string, excludeId?: number) {
    const whereList = [eq(aiConfigTable.configKey, configKey)];
    if (excludeId) {
      whereList.push(not(eq(aiConfigTable.aiConfigId, excludeId)));
    }
    const where = and(...whereList);
    return await db.query.aiConfigTable.findFirst({
      where
    });
  }

  /**
   * 查询默认配置
   */
  findDefaultConfig() {
    return db.query.aiConfigTable.findFirst({
      where: eq(aiConfigTable.isDefault, 'Y')
    });
  }

  /**
   * 根据provider获取配置列表
   */
  async findByProvider(provider: AI_PROVIDER) {
    return await db.query.aiConfigTable.findMany({
      where: eq(aiConfigTable.provider, provider),
      orderBy: [aiConfigTable.sortOrder, aiConfigTable.aiConfigId]
    });
  }

  /**
   * 获取指定provider的默认配置
   */
  async findDefault(provider: AI_PROVIDER) {
    return await db.query.aiConfigTable.findFirst({
      where: and(eq(aiConfigTable.provider, provider), eq(aiConfigTable.isDefault, 'Y'), eq(aiConfigTable.status, '1'))
    });
  }

  /**
   * 启用/停用配置
   */
  updateStatus(aiConfigId: number, status: '0' | '1') {
    return db
      .update(aiConfigTable)
      .set({ status, updateTime: new Date() })
      .where(eq(aiConfigTable.aiConfigId, aiConfigId));
  }

  /**
   * 设置默认配置
   */
  async setDefault(aiConfigId: number, provider: AI_PROVIDER) {
    // 清除同provider的其他默认配置
    await this.clearDefaultByProvider(provider, aiConfigId);

    // 设置当前配置为默认
    return db
      .update(aiConfigTable)
      .set({ isDefault: 'Y', status: '1', updateTime: new Date() })
      .where(eq(aiConfigTable.aiConfigId, aiConfigId));
  }

  /**
   * 清除指定provider的默认配置（排除指定ID）
   */
  private clearDefaultByProvider(provider: AI_PROVIDER, excludeId?: number) {
    const whereList = [eq(aiConfigTable.provider, provider), eq(aiConfigTable.isDefault, 'Y')];
    if (excludeId) {
      whereList.push(not(eq(aiConfigTable.aiConfigId, excludeId)));
    }
    const where = and(...whereList);

    return db.update(aiConfigTable).set({ isDefault: 'N', updateTime: new Date() }).where(where);
  }

  /**
   * 批量更新排序
   */
  updateSortOrder(items: Array<{ aiConfigId: number; sortOrder: number }>) {
    const updatePromises = items.map(item =>
      db
        .update(aiConfigTable)
        .set({ sortOrder: item.sortOrder, updateTime: new Date() })
        .where(eq(aiConfigTable.aiConfigId, item.aiConfigId))
    );
    return Promise.all(updatePromises);
  }

  /**
   * 获取所有启用的配置
   */
  async findAllEnabled() {
    return await db.query.aiConfigTable.findMany({
      where: eq(aiConfigTable.status, '1'),
      orderBy: [aiConfigTable.sortOrder, aiConfigTable.aiConfigId]
    });
  }
}
