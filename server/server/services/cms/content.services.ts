import { and, eq, desc, inArray } from 'drizzle-orm';
import { queryParams } from '~~/server/db/query.helper';
import { Content, contentTable, NewContent } from '~~/server/db/schema/cms/content';

export class ContentServices {
  /* ========== Admin Methods ========== */

  /* 新增内容 */
  async add(content: NewContent) {
    try {
      await db.insert(contentTable).values({ ...content, createTime: new Date(), updateTime: new Date() });
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* 更新内容 */
  async update(content: Content) {
    try {
      const data = {
        ...content,
        updateTime: new Date()
      };

      if ('createTime' in data) {
        delete (data as any).createTime;
      }

      await db.update(contentTable).set(data).where(eq(contentTable.contentId, content.contentId));
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* 分页查询 */
  async list(params: queryParams & { categoryId?: number }) {
    const { pageNum = 1, limit = 10 } = params || {};
    const offset = (pageNum - 1) * limit;

    const whereList = [eq(contentTable.delFlag, '0')];
    if (params.categoryId) {
      whereList.push(eq(contentTable.categoryId, params.categoryId));
    }
    const where = and(...whereList);

    const [rows, total] = await Promise.all([
      db.query.contentTable.findMany({
        where,
        limit,
        offset,
        with: {
          category: true
        },
        orderBy: [desc(contentTable.createTime)]
      }),
      db.$count(contentTable, where)
    ]);

    return { rows, total };
  }

  /* 通过ID查询 */
  findById(contentId: number) {
    return db.query.contentTable.findFirst({
      where: eq(contentTable.contentId, contentId)
    });
  }

  /* 通过categoryId查询 */
  findByCategoryId(categoryId: number) {
    return db.query.contentTable.findFirst({
      where: eq(contentTable.categoryId, categoryId)
    });
  }

  /* 批量删除 */
  async delete(contentIdArr: string[]) {
    await db
      .update(contentTable)
      .set({ delFlag: '2' })
      .where(inArray(contentTable.contentId, contentIdArr.map(Number)));
  }

  /* ========== Public Methods ========== */

  /* 分页查询已发布内容 */
  async publicList(params: queryParams & { categoryId?: number }) {
    const { pageNum = 1, limit = 10 } = params;
    const offset = (pageNum - 1) * limit;

    const whereList = [eq(contentTable.delFlag, '0')];

    if (params.categoryId) {
      whereList.push(eq(contentTable.categoryId, params.categoryId));
    }

    const where = and(...whereList);

    const [rows, total] = await Promise.all([
      db.query.contentTable.findMany({
        where,
        limit: +limit,
        offset,
        with: {
          category: {
            columns: {
              categoryId: true,
              categoryName: true,
              urlKey: true
            }
          }
        },
        orderBy: [desc(contentTable.createTime)]
      }),
      db.$count(contentTable, where)
    ]);

    return { rows, total };
  }

  /* 获取详情 */
  async publicFindById(contentId: number) {
    return db.query.contentTable.findFirst({
      with: {
        category: true
      },
      where: and(eq(contentTable.contentId, contentId), eq(contentTable.delFlag, '0'))
    });
  }
}
