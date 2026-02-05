import { DictServices } from '~~/server/services/admin/system/dict/dict.services';

const dictServices = new DictServices();

export default defineEventHandler(async event => {
  const query = getQuery(event);
  const data = await dictServices.typeList(query);
  return createApiResponse(data);
});
