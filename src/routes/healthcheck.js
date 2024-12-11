import express from 'express'

const router = express.Router()

/**
 * @GET /api/healthcheck
 */
router.get('/', (req, res) => {
  res.json({ message: 'OK' })
})

export default router
