import express from 'express'

const router = express.Router()

/**
 * @GET /api/info
 */
router.get('/', (req, res) => {
  res.json({
    meeting_id: 3,
    title: '회의 제목',
    meeting_date: '2024-10-15T10:30:00Z',
    participants: '홍길동, 이순신',
    video_url: 'https://example.com/video',
    summary: '회의 내용 요약',
  })
})

export default router
