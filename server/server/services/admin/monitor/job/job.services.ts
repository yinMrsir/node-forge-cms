import * as schedule from 'node-schedule';
import { and, desc, eq, inArray } from 'drizzle-orm';
import dayjs from 'dayjs';
import isoWeek from 'dayjs/plugin/isoWeek.js';
import { Storage } from 'unstorage';
import { Job, jobTable, NewJob } from '~~/server/db/schema/monitor/job';
import { JobLog, jobLogTable } from '~~/server/db/schema/monitor/jobLog';
import { queryParams } from '~~/server/db/query.helper';
import { EMAIL_KEY } from '~~/server/contants/redis.contant';

dayjs.extend(isoWeek);

export class JobServices {
  private static instance: any;
  private readonly jobs: any;
  private redis: Storage;

  [key: string]: any;
  private constructor() {
    this.redis = useStorage('redis');
    this.jobs = {};
  }

  public static getInstance(): JobServices {
    if (!JobServices.instance) {
      JobServices.instance = new JobServices();
    }
    return JobServices.instance;
  }

  async init() {
    const jobList = await this.findAllJob({ status: '0' });
    for (const job of jobList) {
      await this.start(job);
    }
  }

  async addJob(job: NewJob) {
    this.hasMethod(job.invokeTarget);
    const [jobItem] = await db.insert(jobTable).values(job).$returningId();
    if (job.status === '0') {
      await this.start({
        jobId: jobItem.jobId,
        ...job
      } as Job);
    }
  }

  async updateJob(job: Job) {
    await db.update(jobTable).set(job).where(eq(jobTable.jobId, job.jobId));
    const jobItem = (await this.oneJob(job.jobId)) as Job;
    if (jobItem.status === '0') {
      await this.stop(jobItem);
      await this.start(jobItem);
    } else {
      await this.stop(jobItem);
    }
  }

  async jobList(params?: Partial<Job> & queryParams) {
    const { pageNum = 1, limit = 10 } = params || {};
    const offset = (pageNum - 1) * limit;

    const whereList = [];
    if (params?.status) {
      whereList.push(eq(jobTable.status, params.status));
    }
    const where = and(...whereList);

    const rowQuery = db.query.jobTable.findMany({ where, offset, limit });
    const totalQuery = db.$count(jobTable, where);

    const [rows, total] = await Promise.all([rowQuery, totalQuery]);
    return {
      rows,
      total
    };
  }

  /* 查找所有的定时任务 */
  findAllJob(params: Partial<Job>) {
    const whereList = [];
    if (params.status) {
      whereList.push(eq(jobTable.status, params.status));
    }
    const where = and(...whereList);
    return db.query.jobTable.findMany({ where });
  }

  oneJob(jobId: number | string) {
    return db.query.jobTable.findFirst({
      where: eq(jobTable.jobId, Number(jobId))
    });
  }

  async changeStatus(jobId: number, status: string) {
    await db.update(jobTable).set({ status }).where(eq(jobTable.jobId, jobId));
    const job = (await this.oneJob(jobId)) as Job;
    if (status === '0') {
      await this.stop(job);
      await this.start(job);
    } else {
      await this.stop(job);
    }
  }

  async start(job: Job) {
    this.jobs[job.jobName] = schedule.scheduleJob(job.cronExpression as string, async () => {
      const { funName, argumens } = this.hasMethod(job.invokeTarget);
      try {
        // @ts-ignore
        await this[funName](argumens);
        await this.addTaskLog(job, '', '执行任务成功', '0');
      } catch (error: any) {
        await this.addTaskLog(job, error.message, '执行任务失败', '1');
      }
    });
    console.info(`启动定时任务：${job.jobName}`);
    await this.addTaskLog(job, '', '启动任务成功', '0');
  }

  async stop(job: Job) {
    if (this.jobs[job.jobName]) {
      try {
        this.jobs[job.jobName].cancel();
        await this.addTaskLog(job, '', '停止任务成功', '0');
      } catch (error) {
        await this.addTaskLog(job, error, '停止任务失败', '1');
        throw createError({ statusCode: 400, message: String(error) });
      }
    }
  }

  async once(job: Job) {
    try {
      const { funName, argumens } = this.hasMethod(job.invokeTarget);
      // @ts-ignore
      await this[funName](argumens);
      await this.addTaskLog(job, '', '执行任务成功', '0');
    } catch (error) {
      await this.addTaskLog(job, error, '执行任务失败', '1');
      throw createError({ statusCode: 400, message: String(error) });
    }
  }

  // 写入日志
  async addTaskLog(job: Job, error: any, jobMessage = '', status = '0') {
    await db.insert(jobLogTable).values({
      jobName: job.jobName,
      jobGroup: job.jobGroup,
      invokeTarget: job.invokeTarget,
      jobMessage,
      status,
      exceptionInfo: String(error),
      createTime: new Date()
    });
    // 如果执行失败，发送邮件提醒
    if (status === '1') {
      try {
        const emailRedis = await this.redis.getItem(`${EMAIL_KEY}:${job.jobName}`);
        if (!emailRedis) {
          await sendEmail({
            to: '542968439@qq.com',
            subject: '定时任务执行失败',
            text: `定时任务：${job.jobName}，执行失败，错误信息：${error}`
          });
          await this.redis.setItem(`${EMAIL_KEY}:${job.jobName}`, 1, {
            ttl: 60 * 60 * 2
          });
        }
      } catch (e) {
        console.info('发送邮件：', e);
      }
    }
  }

  /* 测试执行 */
  async testOnce(jobName: string, date: string) {
    await this[jobName](date);
  }

  /* 删除任务 */
  async deleteJob(jobIdArr: number[] | string[]) {
    const where = inArray(
      jobTable.jobId,
      jobIdArr.map(item => Number(item))
    );
    const jobs = await db.query.jobTable.findMany({ where });
    for (const job of jobs) {
      await this.stop(job);
    }
    return db.delete(jobTable).where(where);
  }

  /* 分页查询任务调度日志 */
  async jobLogList(params?: Partial<JobLog> & queryParams) {
    const { pageNum = 1, limit = 10 } = params || {};
    const offset = (pageNum - 1) * limit;

    const whereList = [];
    if (params?.jobName) {
      whereList.push(eq(jobLogTable.jobName, params.jobName));
    }
    const where = and(...whereList);

    const rowsQuery = db.query.jobLogTable.findMany({
      where,
      offset,
      limit,
      orderBy: [desc(jobLogTable.createTime)]
    });
    const totalQuery = db.$count(jobLogTable, where);

    const [rows, total] = await Promise.all([rowsQuery, totalQuery]);
    return {
      rows,
      total
    };
  }

  /* 清空日志 */
  cleanJobLog() {
    return db.delete(jobLogTable);
  }

  /* 判断方法是否存在 */
  hasMethod(methodName: string) {
    if (!(methodName.includes('(') && methodName.includes(')'))) {
      throw createError({ statusCode: 400, message: '方法格式错误' });
    }
    const funName = methodName.match(/(\S*)\(/)?.[1];
    if (!funName) throw createError({ statusCode: 400, message: '调用方法格式错误' });
    if (funName && !Object.prototype.hasOwnProperty.call(this.constructor.prototype, funName)) {
      throw createError({ statusCode: 400, message: '方法不存在' });
    }
    // eslint-disable-next-line no-eval
    const argumens = eval('[' + methodName.match(/\((\S*)\)/)?.[1] + ']');
    return {
      funName,
      argumens
    };
  }

  test(params: any[]) {
    console.log(params);
  }
}

const jobServices = JobServices.getInstance();
export { jobServices };
