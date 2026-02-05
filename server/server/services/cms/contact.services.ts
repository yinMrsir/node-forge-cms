import { and, eq, desc, inArray, like } from 'drizzle-orm';
import { queryParams } from '~~/server/db/query.helper';
import { Contact, contactTable, NewContact } from '~~/server/db/schema/cms/contact';

export class ContactServices {
  /* ========== Public Methods ========== */

  /* 提交联系表单 */
  async submit(contact: NewContact) {
    try {
      await db.insert(contactTable).values({
        ...contact,
        createTime: new Date(),
        updateTime: new Date()
      });
    } catch (error) {
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  /* ========== Admin Methods ========== */

  /* 分页查询 */
  async list(params: queryParams & { name?: string; status?: string }) {
    const { pageNum = 1, limit = 10 } = params || {};
    const offset = (pageNum - 1) * limit;

    const whereList = [eq(contactTable.delFlag, '0')];
    if (params.name) {
      whereList.push(like(contactTable.name, `%${params.name}%`));
    }
    if (params.status) {
      whereList.push(eq(contactTable.status, params.status));
    }
    const where = and(...whereList);

    const [rows, total] = await Promise.all([
      db.query.contactTable.findMany({
        where,
        limit,
        offset,
        orderBy: [desc(contactTable.createTime)]
      }),
      db.$count(contactTable, where)
    ]);

    return { rows, total };
  }

  /* 通过ID查询 */
  findById(contactId: number) {
    return db.query.contactTable.findFirst({
      where: eq(contactTable.contactId, contactId)
    });
  }

  /* 批量删除 */
  async delete(contactIdArr: string[]) {
    await db
      .update(contactTable)
      .set({ delFlag: '2' })
      .where(inArray(contactTable.contactId, contactIdArr.map(Number)));
  }

  /* 修改状态 */
  async changeStatus(contactId: number, status: string, handleRemark?: string) {
    const updateData: any = { status };
    if (handleRemark) {
      updateData.handleRemark = handleRemark;
    }
    await db.update(contactTable).set(updateData).where(eq(contactTable.contactId, contactId));
  }
}
