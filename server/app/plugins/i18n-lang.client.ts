export default defineNuxtPlugin(nuxtApp => {
  const i18n = nuxtApp.$i18n as any;

  // Watch for locale changes and update HTML lang attribute
  nuxtApp.hook('app:mounted', () => {
    const updateHtmlLang = () => {
      const locale = i18n?.locale?.value || 'en';
      document.documentElement.lang = locale;

      // Set direction for RTL languages
      if (locale === 'ar') {
        document.documentElement.dir = 'rtl';
      } else {
        document.documentElement.dir = 'ltr';
      }
    };

    // Update initially
    updateHtmlLang();

    // Watch for locale changes
    if (i18n?.locale) {
      watch(i18n.locale, updateHtmlLang);
    }
  });
});
