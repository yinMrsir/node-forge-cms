import { and, eq, like, sql } from 'drizzle-orm';
import { SharedServices } from '~~/server/services/admin/share/shared.services';
import { Category, categoryTable, NewCategory } from '~~/server/db/schema/cms/category';

export class CategoryServices {
  private sharedServices: SharedServices;
  constructor() {
    this.sharedServices = new SharedServices();
  }

  /* ========== Admin Methods ========== */

  /* 新增分类 */
  async add(category: NewCategory & { parentId?: number }) {
    try {
      if (category.parentId) {
        category.parentCategoryId = category.parentId;
      }
      await db.transaction(async tx => {
        const [insertCategory] = await tx.insert(categoryTable).values(category).$returningId();
        // 计算mpath
        let mpath = `${String(insertCategory.categoryId)}.`;
        if (category.parentCategoryId) {
          const parent = await this.findById(category.parentCategoryId);
          if (parent && parent.mpath) {
            mpath = `${parent.mpath}${insertCategory.categoryId}.`;
          }
        }
        await tx.update(categoryTable).set({ mpath }).where(eq(categoryTable.categoryId, insertCategory.categoryId));
      });
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* 更新分类 */
  async update(category: Partial<Category & { parentId?: number }>) {
    try {
      if (category.parentId) {
        category.parentCategoryId = category.parentId;
      }
      // 查找父分类的mpath
      let mpath = `${String(category.categoryId)}.`;
      if (category.parentCategoryId) {
        const parent = await this.findById(category.parentCategoryId);
        if (parent) {
          // 防止移动到自己的子级
          if (parent.mpath?.split('.').map(Number).includes(Number(category.categoryId))) {
            throw createError({
              statusCode: 400,
              message: '不允许移动到自己的子级'
            });
          }
          if (parent.mpath) {
            mpath = `${parent.mpath}${category.categoryId}.`;
          }
        }
      }
      category.mpath = mpath;
      category.updateTime = new Date();
      delete category.createTime;
      await db
        .update(categoryTable)
        .set(category)
        .where(eq(categoryTable.categoryId, Number(category.categoryId)));
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* 分页查询分类 */
  async list(params: Partial<Category> & { pageNum?: number; limit?: number }) {
    const { pageNum = 1, limit = 10 } = params || {};
    const offset = (pageNum - 1) * limit;

    const whereList = [eq(categoryTable.delFlag, '0')];
    if (params.templateType) {
      whereList.push(eq(categoryTable.templateType, params.templateType));
    }
    if (params.status) {
      whereList.push(eq(categoryTable.status, params.status));
    }
    if (params.parentCategoryId) {
      whereList.push(eq(categoryTable.parentCategoryId, params.parentCategoryId));
    }
    if (params.delFlag) {
      whereList.push(eq(categoryTable.delFlag, params.delFlag));
    }
    if (params.isRecommend) {
      whereList.push(eq(categoryTable.isRecommend, params.isRecommend));
    }
    const where = and(...whereList);

    const [rows, total] = await Promise.all([
      db.query.categoryTable.findMany({
        where,
        limit,
        offset,
        orderBy: categoryTable.orderNum
      }),
      db.$count(categoryTable, where)
    ]);

    return { rows, total };
  }

  /* 查询分类树 */
  async treeselect(categoryType?: string) {
    const whereList = [eq(categoryTable.delFlag, '0')];
    if (categoryType) {
      whereList.push(eq(categoryTable.categoryType, categoryType));
    }
    const where = and(...whereList);

    const categoryArr = await db
      .select({
        id: categoryTable.categoryId,
        label: categoryTable.categoryName,
        parentId: sql`IFNULL(${categoryTable.parentCategoryId}, 0)`
      })
      .from(categoryTable)
      .where(where)
      .orderBy(categoryTable.orderNum);
    return this.sharedServices.handleTree(categoryArr);
  }

  /* 通过ID查询 */
  async findById(categoryId: number): Promise<Category | undefined> {
    const data = await db.query.categoryTable.findFirst({
      where: eq(categoryTable.categoryId, categoryId)
    });
    return data;
  }

  /* 删除分类（软删除） */
  async delete(categoryId: string, userName: string) {
    await db
      .update(categoryTable)
      .set({ delFlag: '2', updateBy: userName })
      .where(eq(categoryTable.categoryId, Number(categoryId)));
  }

  /* 修改状态 */
  async changeStatus(categoryId: number, status: string, updateBy: string) {
    await db.update(categoryTable).set({ status, updateBy }).where(eq(categoryTable.categoryId, categoryId));
  }

  /* 修改推荐 */
  async changeRecommend(categoryId: number, isRecommend: string, updateBy: string) {
    await db.update(categoryTable).set({ isRecommend, updateBy }).where(eq(categoryTable.categoryId, categoryId));
  }

  /* ========== Public Methods ========== */

  /* 根据 urlKey 获取栏目信息（用于动态路由） */
  async getByUrlKey(urlKey: string) {
    const category = await db.query.categoryTable.findFirst({
      where: and(eq(categoryTable.urlKey, urlKey), eq(categoryTable.status, '1'), eq(categoryTable.delFlag, '0'))
    });

    if (!category) {
      throw createError({
        statusCode: 404,
        statusMessage: 'Category not found or not published'
      });
    }

    return category;
  }

  /* 根据路径段查找栏目（支持多级栏目） */
  async getByPath(pathSegments: string[]) {
    if (!pathSegments || pathSegments.length === 0) {
      throw createError({
        statusCode: 400,
        statusMessage: 'Path segments are required'
      });
    }

    const lastSegment = pathSegments[pathSegments.length - 1];

    // 查找 urlKey 匹配最后一段的栏目
    const category = await db.query.categoryTable.findFirst({
      where: and(eq(categoryTable.urlKey, lastSegment), eq(categoryTable.status, '1'), eq(categoryTable.delFlag, '0'))
    });

    if (!category) {
      throw createError({
        statusCode: 404,
        statusMessage: 'Category not found'
      });
    }

    // 如果是单级路径，直接返回
    if (pathSegments.length === 1) {
      return category;
    }

    // 多级路径：验证层级关系是否匹配
    // 例如：/works/web-design 需要匹配 web-design 的父级是 works
    // 这里简化处理，假设 urlKey 的层级关系通过 parentCategoryId 维护
    // 实际项目中可能需要更复杂的路径验证逻辑

    // TODO: 可以在这里添加更严格的多级路径验证
    // 例如检查 mpath 或者递归检查父级关系

    return category;
  }

  /* 获取已发布的分类列表 */
  getPublishedList() {
    return db.query.categoryTable.findMany({
      where: and(eq(categoryTable.status, '1'), eq(categoryTable.delFlag, '0'), eq(categoryTable.parentCategoryId, 0)),
      orderBy: categoryTable.orderNum
    });
  }

  /* 获取分类树 */
  async getTree(categoryType: string) {
    const categories = await db
      .select({
        id: categoryTable.categoryId,
        label: categoryTable.categoryName,
        parentId: sql`IFNULL(${categoryTable.parentCategoryId}, 0)`
      })
      .from(categoryTable)
      .where(
        and(eq(categoryTable.status, '1'), eq(categoryTable.delFlag, '0'), eq(categoryTable.categoryType, categoryType))
      )
      .orderBy(categoryTable.orderNum);
    return this.sharedServices.handleTree(categories);
  }
}
