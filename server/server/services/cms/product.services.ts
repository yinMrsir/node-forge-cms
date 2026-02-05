import { and, eq, like, desc, inArray, sql } from 'drizzle-orm';
import { queryParams } from '~~/server/db/query.helper';
import { Product, productTable, NewProduct } from '~~/server/db/schema/cms/product';
import { categoryTable } from '~~/server/db/schema/cms/category';

export class ProductServices {
  /* ========== Admin Methods ========== */

  /* 新增产品 */
  async add(product: NewProduct) {
    try {
      await db.insert(productTable).values({ ...product, createTime: new Date(), updateTime: new Date() });
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* 更新产品 */
  async update(product: Product) {
    try {
      const data = {
        ...product,
        updateTime: new Date()
      };
      if ('createTime' in data) {
        delete (data as any).createTime;
      }
      await db.update(productTable).set(data).where(eq(productTable.productId, product.productId));
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* 分页查询 */
  async list(params: Partial<Product> & queryParams) {
    const { pageNum = 1, limit = 10 } = params || {};
    const offset = (pageNum - 1) * limit;

    const whereList = [eq(productTable.delFlag, '0')];
    if (params.productName) {
      whereList.push(like(productTable.productName, `%${params.productName}%`));
    }
    if (params.categoryId) {
      whereList.push(eq(productTable.categoryId, params.categoryId));
    }
    if (params.status) {
      whereList.push(eq(productTable.status, params.status));
    }
    const where = and(...whereList);

    const [rows, total] = await Promise.all([
      db.query.productTable.findMany({
        where,
        limit,
        offset,
        with: {
          category: true
        },
        orderBy: [desc(productTable.createTime)]
      }),
      db.$count(productTable, where)
    ]);

    return { rows, total };
  }

  /* 通过ID查询 */
  findById(productId: number) {
    return db.query.productTable.findFirst({
      where: eq(productTable.productId, productId),
      with: {
        category: true
      }
    });
  }

  /* 批量删除 */
  async delete(productIdArr: string[]) {
    await db
      .update(productTable)
      .set({ delFlag: '2' })
      .where(inArray(productTable.productId, productIdArr.map(Number)));
  }

  /* 修改状态 */
  async changeStatus(productId: number, status: string, updateBy: string) {
    await db.update(productTable).set({ status, updateBy }).where(eq(productTable.productId, productId));
  }

  /* 修改推荐 */
  async changeRecommend(productId: number, isRecommend: string, updateBy: string) {
    await db.update(productTable).set({ isRecommend, updateBy }).where(eq(productTable.productId, productId));
  }

  /* 修改新品 */
  async changeNew(productId: number, isNew: string, updateBy: string) {
    await db.update(productTable).set({ isNew, updateBy }).where(eq(productTable.productId, productId));
  }

  /* 增加浏览量 */
  async incrementViewCount(productId: number) {
    await db.execute(sql`UPDATE product SET view_count = view_count + 1 WHERE product_id = ${productId}`);
  }

  /* ========== Public Methods ========== */

  /* 分页查询已发布产品（包含子分类） */
  async publicList(params: queryParams & { categoryId?: number; productName?: string; isRecommend?: string }) {
    const { pageNum = 1, limit = 10 } = params;
    const offset = (pageNum - 1) * limit;

    const whereList = [eq(productTable.status, '1'), eq(productTable.delFlag, '0')];

    if (params.isRecommend) {
      whereList.push(eq(productTable.isRecommend, params.isRecommend));
    }

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
        whereList.push(inArray(productTable.categoryId, categoryIds));
      } else {
        // 如果没有 mpath，只查询当前分类
        whereList.push(eq(productTable.categoryId, params.categoryId));
      }
    }
    if (params.productName) {
      whereList.push(like(productTable.productName, `%${params.productName}%`));
    }

    const where = and(...whereList);

    const [rows, total] = await Promise.all([
      db.query.productTable.findMany({
        where,
        limit: +limit,
        offset,
        columns: {
          productId: true,
          productName: true,
          summary: true,
          mainImage: true,
          viewCount: true,
          isNew: true,
          isRecommend: true,
          categoryId: true
        },
        with: {
          category: {
            columns: {
              categoryId: true,
              categoryName: true,
              mpath: true
            }
          }
        },
        orderBy: [desc(productTable.createTime)]
      }),
      db.$count(productTable, where)
    ]);

    return { rows, total };
  }

  /* 获取详情并增加浏览量 */
  async publicFindById(productId: number) {
    const product = await db.query.productTable.findFirst({
      where: and(eq(productTable.productId, productId), eq(productTable.status, '1'), eq(productTable.delFlag, '0')),
      with: {
        category: true
      }
    });

    if (product) {
      await db.execute(sql`UPDATE product SET view_count = view_count + 1 WHERE product_id = ${productId}`);
    }

    return product;
  }

  /* 获取推荐产品 */
  getRecommend(limit: number = 6) {
    return db.query.productTable.findMany({
      where: and(eq(productTable.status, '1'), eq(productTable.delFlag, '0'), eq(productTable.isRecommend, '1')),
      columns: {
        productId: true,
        productName: true,
        summary: true,
        mainImage: true,
        isNew: true
      },
      orderBy: [desc(productTable.createTime)],
      limit
    });
  }

  /* 获取新品 */
  getNew(limit: number = 6) {
    return db.query.productTable.findMany({
      where: and(eq(productTable.status, '1'), eq(productTable.delFlag, '0'), eq(productTable.isNew, '1')),
      columns: {
        productId: true,
        productName: true,
        summary: true,
        mainImage: true,
        isRecommend: true
      },
      orderBy: [desc(productTable.createTime)],
      limit
    });
  }
}
