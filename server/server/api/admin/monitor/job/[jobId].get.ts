import { jobServices } from '~~/server/services/admin/monitor/job/job.services';

export default defineEventHandler(async event => {
  const jobId = getRouterParam(event, 'jobId');
  if (!jobId) {
    throw createError({ statusCode: 400, message: '参数错误' });
  }
  const data = await jobServices.oneJob(jobId);
  return createApiResponse(data);
});
