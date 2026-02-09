import { and, eq, desc, inArray, asc } from 'drizzle-orm';
import { queryParams } from '~~/server/db/query.helper';
import { Banner, bannerTable, NewBanner } from '~~/server/db/schema/cms/banner';

export class BannerServices {
  /* ========== Admin Methods ========== */

  /* 新增轮播图 */
  async add(banner: NewBanner) {
    try {
      await db.insert(bannerTable).values(banner);
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* 更新轮播图 */
  async update(banner: Banner) {
    try {
      const data = {
        ...banner,
        updateTime: new Date()
      };
      if ('createTime' in data) {
        delete (data as any).createTime;
      }
      await db.update(bannerTable).set(data).where(eq(bannerTable.bannerId, banner.bannerId));
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* 分页查询 */
  async list(params: queryParams & { status?: string }) {
    const { pageNum = 1, limit = 10 } = params || {};
    const offset = (pageNum - 1) * limit;

    const whereList = [eq(bannerTable.delFlag, '0')];
    if (params.status) {
      whereList.push(eq(bannerTable.status, params.status));
    }
    const where = and(...whereList);

    const [rows, total] = await Promise.all([
      db.query.bannerTable.findMany({
        where,
        limit,
        offset,
        orderBy: [asc(bannerTable.orderNum), desc(bannerTable.createTime)]
      }),
      db.$count(bannerTable, where)
    ]);

    return { rows, total };
  }

  /* 通过ID查询 */
  findById(bannerId: number) {
    return db.query.bannerTable.findFirst({
      where: eq(bannerTable.bannerId, bannerId)
    });
  }

  /* 批量删除 */
  async delete(bannerIdArr: string[]) {
    await db
      .update(bannerTable)
      .set({ delFlag: '2' })
      .where(inArray(bannerTable.bannerId, bannerIdArr.map(Number)));
  }

  /* 修改状态 */
  async changeStatus(bannerId: number, status: string, updateBy: string) {
    await db.update(bannerTable).set({ status, updateBy }).where(eq(bannerTable.bannerId, bannerId));
  }

  /* ========== Public Methods ========== */

  /* 获取启用的轮播图列表 */
  getActiveList(filterParams?: any) {
    const querys: any = {
      where: and(eq(bannerTable.status, '1'), eq(bannerTable.delFlag, '0')),
      orderBy: [asc(bannerTable.orderNum), desc(bannerTable.createTime)]
    };

    Object.keys(filterParams).forEach(key => {
      querys[key] = filterParams[key];
    });

    return db.query.bannerTable.findMany(querys);
  }
}
