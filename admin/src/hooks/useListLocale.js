import { listLocale } from '@/api/system/i18n';
export const useListLocale = () => {
  const locales = ref([]);
  const objectLocale = ref({});
  listLocale({ status: 0 }).then(data => {
    locales.value = data.data;
    objectLocale.value = locales.value.reduce((acc, cur) => {
      acc[cur.code] = cur.name;
      return acc;
    }, {});
  });

  return { locales, objectLocale };
};
