import express from 'express'

const router = express.Router()

/**
 * @GET /api/quiz
 */
router.get('/', (req, res) => {
  res.json({
    quiz_id: 1,
    meeting_id: 1,
    question: '이 회의에서 논의된 핵심 주제는 무엇인가요?',
    options: ['A', 'B', 'C', 'D'],
    correct_answer: 2,
  })
})

export default router
