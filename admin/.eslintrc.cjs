module.exports = {
  root: true,
  env: {
    browser: true,
    node: true
  },
  parser: 'vue-eslint-parser',
  parserOptions: {
    parser: '@typescript-eslint/parser'
  },
  extends: ['plugin:prettier/recommended'],
  plugins: [],
  rules: {
    'vue/no-v-html': 'off',
    'vue/multi-word-component-names': 0,
    'no-console': 'off'
  }
};
