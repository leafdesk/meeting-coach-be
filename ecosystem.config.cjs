module.exports = {
  apps: [
    {
      name: 'nodejs',
      script: 'src/server.js',
    },
  ],
  deploy: {
    production: {
      user: 'ubuntu',
      host: '43.200.254.240',
      ref: 'origin/main',
      repo: 'git@github.com:leafdesk/nodejs.git',
      path: '/home/ubuntu/nodejs',
      'post-deploy':
        'pnpm install && pm2 startOrRestart ecosystem.config.cjs --env production',
    },
  },
}
