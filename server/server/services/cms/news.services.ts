import { and, eq, like, desc, inArray, sql, lt, gt } from 'drizzle-orm';
import { queryParams } from '~~/server/db/query.helper';
import { News, newsTable, NewNews } from '~~/server/db/schema/cms/news';
import { categoryTable } from '~~/server/db/schema/cms/category';

export class NewsServices {
  /* ========== Admin Methods ========== */

  /* 新增新闻 */
  async add(news: NewNews) {
    try {
      await db.insert(newsTable).values(news);
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* 更新新闻 */
  async update(news: News) {
    try {
      const data = {
        ...news,
        updateTime: new Date()
      };
      if ('createTime' in data) {
        delete (data as any).createTime;
      }
      await db.update(newsTable).set(news).where(eq(newsTable.newsId, news.newsId));
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* 分页查询 */
  async list(params: Partial<News> & queryParams) {
    const { pageNum = 1, limit = 10 } = params || {};
    const offset = (pageNum - 1) * limit;

    const whereList = [eq(newsTable.delFlag, '0')];
    if (params.title) {
      whereList.push(like(newsTable.title, `%${params.title}%`));
    }
    if (params.categoryId) {
      whereList.push(eq(newsTable.categoryId, params.categoryId));
    }
    if (params.status) {
      whereList.push(eq(newsTable.status, params.status));
    }
    const where = and(...whereList);

    const [rows, total] = await Promise.all([
      db.query.newsTable.findMany({
        where,
        limit,
        offset,
        with: {
          category: true
        },
        orderBy: [desc(newsTable.isTop), desc(newsTable.publishTime), desc(newsTable.createTime)]
      }),
      db.$count(newsTable, where)
    ]);

    return { rows, total };
  }

  /* 通过ID查询 */
  findById(newsId: number) {
    return db.query.newsTable.findFirst({
      where: eq(newsTable.newsId, newsId),
      with: {
        category: true
      }
    });
  }

  /* 批量删除 */
  async delete(newsIdArr: string[]) {
    await db
      .update(newsTable)
      .set({ delFlag: '2' })
      .where(inArray(newsTable.newsId, newsIdArr.map(Number)));
  }

  /* 修改状态 */
  async changeStatus(newsId: number, status: string, updateBy: string) {
    await db.update(newsTable).set({ status, updateBy }).where(eq(newsTable.newsId, newsId));
  }

  /* 修改置顶 */
  async changeTop(newsId: number, isTop: string, updateBy: string) {
    await db.update(newsTable).set({ isTop, updateBy }).where(eq(newsTable.newsId, newsId));
  }

  /* 修改推荐 */
  async changeRecommend(newsId: number, isRecommend: string, updateBy: string) {
    await db.update(newsTable).set({ isRecommend, updateBy }).where(eq(newsTable.newsId, newsId));
  }

  /* 增加浏览量 */
  async incrementViewCount(newsId: number) {
    await db.execute(sql`UPDATE news SET view_count = view_count + 1 WHERE news_id = ${newsId}`);
  }

  /* ========== Public Methods ========== */

  /* 分页查询已发布新闻 */
  async publicList(
    params: queryParams & { categoryId?: number; title?: string; isRecommend?: string; isTop?: string }
  ) {
    const { pageNum = 1, limit = 10 } = params;
    const offset = (pageNum - 1) * limit;

    const whereList = [eq(newsTable.status, '1'), eq(newsTable.delFlag, '0')];

    if (params.categoryId) {
      // 获取当前分类信息
      const category = await db.query.categoryTable.findFirst({
        where: eq(categoryTable.categoryId, params.categoryId),
        columns: { mpath: true }
      });

      if (category?.mpath) {
        // 查找所有子分类（mpath 以当前分类的 mpath 开头）
        const subCategories = await db
          .select({ categoryId: categoryTable.categoryId })
          .from(categoryTable)
          .where(
            and(
              like(categoryTable.mpath, `${category.mpath}%`),
              eq(categoryTable.status, '1'),
              eq(categoryTable.delFlag, '0')
            )
          );

        const categoryIds = subCategories.map(c => c.categoryId);
        whereList.push(inArray(newsTable.categoryId, categoryIds));
      } else {
        // 如果没有 mpath，只查询当前分类
        whereList.push(eq(newsTable.categoryId, params.categoryId));
      }
    }
    if (params.title) {
      whereList.push(like(newsTable.title, `%${params.title}%`));
    }
    if (params.isRecommend) {
      whereList.push(eq(newsTable.isRecommend, params.isRecommend));
    }
    if (params.isTop) {
      whereList.push(eq(newsTable.isTop, params.isTop));
    }

    const where = and(...whereList);

    const [rows, total] = await Promise.all([
      db.query.newsTable.findMany({
        where,
        limit: +limit,
        offset,
        columns: {
          newsId: true,
          title: true,
          summary: true,
          coverImage: true,
          publishTime: true,
          viewCount: true,
          categoryId: true
        },
        with: {
          category: {
            columns: {
              categoryId: true,
              categoryName: true,
              urlKey: true,
              mpath: true
            }
          }
        },
        orderBy: [desc(newsTable.isTop), desc(newsTable.publishTime)]
      }),
      db.$count(newsTable, where)
    ]);

    return { rows, total };
  }

  /* 获取详情并增加浏览量 */
  async publicFindById(newsId: number) {
    const news = await db.query.newsTable.findFirst({
      with: {
        category: true
      },
      where: and(eq(newsTable.newsId, newsId), eq(newsTable.status, '1'), eq(newsTable.delFlag, '0'))
    });

    if (news) {
      await db.execute(sql`UPDATE news SET view_count = view_count + 1 WHERE news_id = ${newsId}`);
    }

    return news;
  }

  /* 获取最新新闻 */
  getLatest(limit: number = 5) {
    return db.query.newsTable.findMany({
      where: and(eq(newsTable.status, '1'), eq(newsTable.delFlag, '0')),
      columns: {
        newsId: true,
        title: true,
        summary: true,
        coverImage: true,
        publishTime: true
      },
      orderBy: [desc(newsTable.publishTime)],
      limit
    });
  }

  /* 获取热门新闻（按浏览量） */
  getHot(limit: number = 5) {
    return db.query.newsTable.findMany({
      where: and(eq(newsTable.status, '1'), eq(newsTable.delFlag, '0')),
      columns: {
        newsId: true,
        title: true,
        summary: true,
        coverImage: true,
        publishTime: true,
        viewCount: true
      },
      orderBy: [desc(newsTable.viewCount)],
      limit
    });
  }

  /* 获取推荐新闻 */
  getRecommend(limit: number = 5) {
    return db.query.newsTable.findMany({
      where: and(eq(newsTable.status, '1'), eq(newsTable.delFlag, '0'), eq(newsTable.isRecommend, '1')),
      columns: {
        newsId: true,
        title: true,
        summary: true,
        coverImage: true,
        publishTime: true
      },
      orderBy: [desc(newsTable.publishTime)],
      limit
    });
  }

  /* 获取相关推荐新闻（同一分类下，排除当前新闻） */
  getRelated(newsId: number, categoryId: number, limit: number = 6) {
    return db.query.newsTable.findMany({
      where: and(
        eq(newsTable.status, '1'),
        eq(newsTable.delFlag, '0'),
        eq(newsTable.categoryId, categoryId),
        // 排除当前新闻
        sql`${newsTable.newsId} != ${newsId}`
      ),
      columns: {
        newsId: true,
        title: true,
        summary: true,
        coverImage: true,
        publishTime: true
      },
      with: {
        category: true
      },
      orderBy: [desc(newsTable.publishTime)],
      limit
    });
  }

  /* 获取上一篇/下一篇新闻（同一分类下，按发布时间排序） */
  async getAdjacentNews(newsId: number, categoryId: number) {
    const currentNews = await db.query.newsTable.findFirst({
      where: eq(newsTable.newsId, newsId),
      columns: { publishTime: true }
    });

    if (!currentNews) {
      return { prev: null, next: null };
    }

    const whereCondition = and(
      eq(newsTable.status, '1'),
      eq(newsTable.delFlag, '0'),
      eq(newsTable.categoryId, categoryId)
    );

    // 上一篇：发布时间小于当前新闻的最新一条（或ID小于当前ID的最大ID）
    const prev = await db.query.newsTable.findFirst({
      where: and(whereCondition, lt(newsTable.newsId, newsId)),
      columns: {
        newsId: true,
        title: true
      },
      with: { category: true },
      orderBy: [desc(newsTable.newsId)]
    });

    // 下一篇：发布时间大于当前新闻的最早一条（或ID大于当前ID的最小ID）
    const next = await db.query.newsTable.findFirst({
      where: and(whereCondition, gt(newsTable.newsId, newsId)),
      columns: {
        newsId: true,
        title: true
      },
      with: { category: true },
      orderBy: [newsTable.newsId]
    });

    return { prev, next };
  }
}
