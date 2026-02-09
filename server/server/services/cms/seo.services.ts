import { eq, and, sql } from 'drizzle-orm';
import { Seo, NewSeo, seoTable } from '~~/server/db/schema/cms/seo';

export class SeoServices {
  /* 获取SEO配置 */
  async getByPage(pageType: string, pageKey?: string, columns?: any) {
    const whereList = [eq(seoTable.delFlag, '0'), eq(seoTable.pageType, pageType)];

    if (pageKey) {
      whereList.push(eq(seoTable.pageKey, pageKey));
    } else {
      whereList.push(sql`(${seoTable.pageKey} IS NULL OR ${seoTable.pageKey} = '')`);
    }

    const querys: any = {
      where: and(...whereList)
    };
    if (columns) {
      querys.columns = columns;
    }

    const data = await db.query.seoTable.findFirst(querys);

    return data;
  }

  /* 获取所有SEO配置列表（后台管理） */
  async list(params: { pageNum?: number; limit?: number; pageType?: string }) {
    const { pageNum = 1, limit = 10, pageType } = params || {};
    const offset = (pageNum - 1) * limit;

    const whereList = [eq(seoTable.delFlag, '0')];
    if (pageType) {
      whereList.push(eq(seoTable.pageType, pageType));
    }
    const where = and(...whereList);

    const [rows, total] = await Promise.all([
      db.query.seoTable.findMany({
        where,
        limit,
        offset,
        orderBy: seoTable.id
      }),
      db.$count(seoTable, where)
    ]);

    return { rows, total };
  }

  /* 新增SEO配置 */
  async add(seo: NewSeo) {
    try {
      await db.insert(seoTable).values(seo);
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* 更新SEO配置 */
  async update(seo: Partial<Seo>) {
    try {
      seo.updateTime = new Date();
      delete seo.createTime;
      await db
        .update(seoTable)
        .set(seo)
        .where(eq(seoTable.id, Number(seo.id)));
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* 通过ID查询 */
  async findById(id: number): Promise<Seo | undefined> {
    const data = await db.query.seoTable.findFirst({
      where: eq(seoTable.id, id)
    });
    return data;
  }

  /* 删除（软删除） */
  async delete(id: string, userName: string) {
    await db
      .update(seoTable)
      .set({ delFlag: '2', updateBy: userName })
      .where(eq(seoTable.id, Number(id)));
  }
}
