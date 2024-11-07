import express from 'express'
import { uploadVideo } from '../services/video-service'

const router = express.Router()

/**
 * @POST /api/video
 */
router.post('/', (req, res) => {
  uploadVideo()
})

export default router
