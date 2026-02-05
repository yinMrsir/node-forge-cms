module.exports = {
  apps: [
    {
      name: 'node_forge',
      port: '8888',
      exec_mode: 'fork', // cluster
      // instances: 'max',
      script: '.output/server/index.mjs',
      error_file: './logs/error.log',
      out_file: './logs/out.log',
      log_date_format: 'YYYY-MM-DD HH:mm Z'
    }
  ]
};
