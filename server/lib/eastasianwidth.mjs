// ESM wrapper for eastasianwidth
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const eaw = require('eastasianwidth');

// Add default export for ESM compatibility
export default eaw;
export { eaw };

// Named exports for compatibility
export const eastAsianWidth = eaw.eastAsianWidth;
export const characterLength = eaw.characterLength;
export const length = eaw.length;
export const slice = eaw.slice;
