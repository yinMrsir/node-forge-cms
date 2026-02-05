import dayjs from 'dayjs';
import { jobServices } from '~~/server/services/admin/monitor/job/job.services';

export default defineEventHandler(async event => {
  const body = await readBody(event);
  await jobServices.testOnce(body.jobName, dayjs(body.date).format('YYYY-MM-DD'));
  return createApiResponse(null);
});
