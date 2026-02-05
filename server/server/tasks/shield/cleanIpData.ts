export default defineTask({
  meta: {
    name: 'shield:cleanIpData', // Match the name in scheduledTasks
    description: 'Clean old IP tracking data from nuxt-api-shield storage.'
  },
  async run() {
    const shieldStorage = useStorage('shield');
    const config = useRuntimeConfig().public.nuxtApiShield;

    // ipTTL is expected to be in seconds from config (module applies default if not set by user)
    const ipTTLseconds = config.ipTTL;

    if (!ipTTLseconds || ipTTLseconds <= 0) {
      console.log('[nuxt-api-shield] IP data cleanup (ipTTL) is disabled or invalid.');
      return { result: { cleanedCount: 0, status: 'disabled_or_invalid_ttl' } };
    }
    const ipTTLms = ipTTLseconds * 1000;

    const ipKeys = await shieldStorage.getKeys('ip:');
    const currentTime = Date.now();
    let cleanedCount = 0;

    for (const key of ipKeys) {
      const entry = (await shieldStorage.getItem(key)) as any | null;

      // Check if entry exists and has a numeric 'time' property
      if (entry && typeof entry.time === 'number') {
        if (currentTime - entry.time > ipTTLms) {
          await shieldStorage.removeItem(key);
          cleanedCount++;
        }
      } else {
        // Clean up entries that are null, not an object, or missing a numeric 'time'
        await shieldStorage.removeItem(key);
        cleanedCount++;
      }
    }

    console.log(`[nuxt-api-shield] Cleaned ${cleanedCount} old/malformed IP data entries.`);
    return { result: { cleanedCount } };
  }
});
