export default defineTask({
  meta: {
    name: 'shield:cleanBans', // Match the name in scheduledTasks
    description: 'Clean expired bans from nuxt-api-shield storage.'
  },
  async run() {
    const shieldStorage = useStorage('shield'); // Use your configured storage name

    // Only fetch keys that start with the 'ban:' prefix
    const banKeys = await shieldStorage.getKeys('ban:');

    let cleanedCount = 0;
    for (const key of banKeys) {
      const bannedUntilRaw = await shieldStorage.getItem(key);
      if (isActualBanTimestampExpired(bannedUntilRaw)) {
        await shieldStorage.removeItem(key);
        cleanedCount++;
      }
    }
    // console.log(`[nuxt-api-shield] Cleaned ${cleanedCount} expired ban(s).`);
    return { result: { cleanedCount } };
  }
});
