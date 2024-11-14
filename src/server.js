import express from 'express'
import infoRoutes from './routes/info.js'
import feedbackRoutes from './routes/feedback.js'
import quizRoutes from './routes/quiz.js'

const app = express()
const PORT = 3000

// Use routes
app.use('/api/info', infoRoutes)
app.use('/api/feedback', feedbackRoutes)
app.use('/api/quiz', quizRoutes)

// 서버 시작
app.listen(PORT, '0.0.0.0', () => {
  console.log(`서버가 http://localhost:${PORT}에서 실행 중입니다.`)
})
