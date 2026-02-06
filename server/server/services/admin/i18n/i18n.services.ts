import { eq, and, like, asc } from 'drizzle-orm';
import { i18nLocaleTable, i18nTranslationTable } from '~~/server/db/schema/system/i18n';
import type { NewI18nLocale, NewI18nTranslation } from '~~/server/db/schema/system/i18n';

export interface LocaleInfo {
  localeId: number;
  code: string;
  name: string;
  isDefault: string;
  icon: string;
  sortOrder: number;
  status: string;
}

export interface CreateLocaleDto {
  localeCode: string;
  localeName: string;
  icon?: string;
  sortOrder?: number;
  status?: string;
}

export interface UpdateLocaleDto {
  localeName?: string;
  icon?: string;
  sortOrder?: number;
  status?: string;
}

export interface I18nQuery {
  localeCode?: string;
  localeName?: string;
  status?: string;
  pageNum?: number;
  pageSize?: number;
}

export class I18nServices {
  /**
   * 获取所有可用的语言列表
   */
  async getLocales(status?: string) {
    const result = await db.query.i18nLocaleTable.findMany({
      columns: {
        localeId: true,
        localeCode: true,
        localeName: true,
        icon: true
      },
      where: eq(i18nLocaleTable.status, status || '0'),
      orderBy: [asc(i18nLocaleTable.sortOrder)]
    });
    return result;
  }

  /**
   * 分页查询语言列表
   */
  async getLocalesByPage(query: I18nQuery) {
    const { localeCode, localeName, status, pageNum = 1, pageSize = 10 } = query;
    const conditions = [];

    if (localeCode) {
      conditions.push(like(i18nLocaleTable.localeCode, `%${localeCode}%`));
    }
    if (localeName) {
      conditions.push(like(i18nLocaleTable.localeName, `%${localeName}%`));
    }
    if (status !== undefined) {
      conditions.push(eq(i18nLocaleTable.status, status));
    }

    const offset = (pageNum - 1) * pageSize;

    const rows = await db
      .select()
      .from(i18nLocaleTable)
      .where(conditions.length > 0 ? and(...conditions) : undefined)
      .orderBy(asc(i18nLocaleTable.sortOrder))
      .limit(pageSize)
      .offset(offset);

    // 获取总数
    const totalResult = await db
      .select({ count: i18nLocaleTable.localeId })
      .from(i18nLocaleTable)
      .where(conditions.length > 0 ? and(...conditions) : undefined);

    return {
      rows,
      total: totalResult.length,
      pageNum,
      pageSize
    };
  }

  /**
   * 根据ID获取语言
   */
  async getLocaleById(id: number) {
    const result = await db.select().from(i18nLocaleTable).where(eq(i18nLocaleTable.localeId, id)).limit(1);
    return result[0] || null;
  }

  /**
   * 根据代码获取语言
   */
  async getLocaleByCode(code: string) {
    const result = await db.query.i18nLocaleTable.findFirst({
      where: eq(i18nLocaleTable.localeCode, code)
    });
    return result;
  }

  /**
   * 创建新语言
   */
  async createLocale(dto: CreateLocaleDto) {
    // 检查是否已存在
    const existing = await this.getLocaleByCode(dto.localeCode);
    if (existing) {
      throw new Error(`Locale ${dto.localeCode} already exists`);
    }

    const data: NewI18nLocale = {
      localeCode: dto.localeCode,
      localeName: dto.localeName,
      icon: dto.icon || '',
      sortOrder: dto.sortOrder || 0,
      status: dto.status || '0',
      createTime: new Date(),
      updateTime: new Date()
    };

    await db.insert(i18nLocaleTable).values(data);
    return data;
  }

  /**
   * 更新语言
   */
  async updateLocale(id: number, dto: UpdateLocaleDto) {
    const existing = await this.getLocaleById(id);
    if (!existing) {
      throw new Error(`Locale not found`);
    }

    const data: Partial<NewI18nLocale> = {
      ...dto,
      updateTime: new Date()
    };

    await db.update(i18nLocaleTable).set(data).where(eq(i18nLocaleTable.localeId, id));
  }

  /**
   * 删除语言
   */
  async deleteLocale(id: number) {
    const existing = await this.getLocaleById(id);
    if (!existing) {
      throw new Error(`Locale not found`);
    }

    // 不允许删除默认语言
    if (existing.isDefault === 'Y') {
      throw new Error(`Cannot delete default locale`);
    }

    // 删除语言的翻译内容
    await db.delete(i18nTranslationTable).where(eq(i18nTranslationTable.localeCode, existing.localeCode));

    // 删除语言
    await db.delete(i18nLocaleTable).where(eq(i18nLocaleTable.localeId, id));
  }

  /**
   * 获取指定语言的翻译内容（转换为嵌套对象格式）
   */
  async getLocaleContent(locale: string): Promise<object> {
    const translations = await db
      .select()
      .from(i18nTranslationTable)
      .where(eq(i18nTranslationTable.localeCode, locale));

    // 将扁平的键值对转换为嵌套对象
    const result: any = {};
    for (const item of translations) {
      this.setNestedValue(result, item.translationKey, item.translationValue);
    }

    return result;
  }

  /**
   * 更新指定语言的翻译内容（接收嵌套对象）
   */
  async updateLocaleContent(locale: string, content: object) {
    const flattened = this.flattenObject(content);

    // 先删除该语言的所有翻译
    await db.delete(i18nTranslationTable).where(eq(i18nTranslationTable.localeCode, locale));

    // 批量插入新的翻译
    if (flattened.size > 0) {
      const translations: NewI18nTranslation[] = [];
      for (const [key, value] of flattened.entries()) {
        const groupName = key.split('.')[0];
        translations.push({
          localeCode: locale,
          translationKey: key,
          translationValue: String(value),
          groupName,
          createTime: new Date(),
          updateTime: new Date()
        });
      }
      await db.insert(i18nTranslationTable).values(translations);
    }
  }

  /**
   * 获取指定语言的翻译列表（扁平格式，用于管理页面）
   */
  async getTranslationList(
    locale: string,
    query: { translationKey?: string; groupName?: string; pageNum?: number; pageSize?: number }
  ) {
    const { translationKey, groupName, pageNum = 1, pageSize = 10 } = query;
    const conditions = [eq(i18nTranslationTable.localeCode, locale)];

    if (translationKey) {
      conditions.push(like(i18nTranslationTable.translationKey, `%${translationKey}%`));
    }
    if (groupName) {
      conditions.push(eq(i18nTranslationTable.groupName, groupName));
    }

    const offset = (pageNum - 1) * pageSize;

    const rows = await db
      .select()
      .from(i18nTranslationTable)
      .where(and(...conditions))
      .orderBy(asc(i18nTranslationTable.groupName), asc(i18nTranslationTable.sortOrder))
      .limit(pageSize)
      .offset(offset);

    const totalResult = await db
      .select({ count: i18nTranslationTable.translationId })
      .from(i18nTranslationTable)
      .where(and(...conditions));

    return {
      rows,
      total: totalResult.length,
      pageNum,
      pageSize
    };
  }

  /**
   * 获取所有分组
   */
  async getGroups(locale: string): Promise<string[]> {
    const result = await db
      .selectDistinct({ groupName: i18nTranslationTable.groupName })
      .from(i18nTranslationTable)
      .where(eq(i18nTranslationTable.localeCode, locale))
      .orderBy(asc(i18nTranslationTable.groupName));

    return result.map(r => r.groupName).filter(g => g);
  }

  /**
   * 设置嵌套对象的值
   */
  private setNestedValue(obj: any, path: string, value: any) {
    const keys = path.split('.');
    let current = obj;
    for (let i = 0; i < keys.length - 1; i++) {
      const key = keys[i];
      if (!(key in current)) {
        current[key] = {};
      }
      current = current[key];
    }
    current[keys[keys.length - 1]] = value;
  }

  /**
   * 将嵌套对象扁平化
   */
  private flattenObject(obj: any, prefix = ''): Map<string, any> {
    const result = new Map<string, any>();

    function flatten(current: any, path: string) {
      for (const key in current) {
        const newPath = path ? `${path}.${key}` : key;
        if (typeof current[key] === 'object' && current[key] !== null && !Array.isArray(current[key])) {
          flatten(current[key], newPath);
        } else {
          result.set(newPath, current[key]);
        }
      }
    }

    flatten(obj, prefix);
    return result;
  }
}
