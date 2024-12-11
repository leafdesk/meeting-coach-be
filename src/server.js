import express from 'express'
import healthCheckRoutes from './routes/healthcheck.js'

const app = express()
const PORT = 3000

// Use routes

app.use('/api/healthcheck', healthCheckRoutes)

// 서버 시작
app.listen(PORT, '0.0.0.0', () => {
  console.log(`서버가 http://localhost:${PORT}에서 실행 중입니다.`)
})
