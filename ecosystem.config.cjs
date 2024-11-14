module.exports = {
  apps: [
    {
      name: 'meeting-coach-be',
      script: 'src/server.js',
      // 기타 설정...
    },
  ],
  deploy: {
    production: {
      user: 'ubuntu',
      host: '43.203.122.230',
      ref: 'origin/main',
      repo: 'git@github.com:leafdesk/meeting-coach-be.git',
      path: '/home/ubuntu/meeting-coach-be',
      'post-deploy':
        'pnpm install && pm2 startOrRestart ecosystem.config.cjs --env production',
    },
  },
}
