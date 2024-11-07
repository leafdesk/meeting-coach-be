import express from 'express'

const router = express.Router()

/**
 * @GET /api/feedback
 */
router.get('/', (req, res) => {
  res.json({
    meeting_id: 1,
    user_id: 2,
    motion_recognition: '손동작: 나쁨',
    gesture_recognition: '몸짓: 좋음',
    pitch_frequency_analysis: '주파수 분석: 안정적',
    feedback: '사용자의 참여 태도가 우수했습니다.',
  })
})

export default router
