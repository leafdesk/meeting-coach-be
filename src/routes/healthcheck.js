import express from 'express'

const router = express.Router()

/**
 * @GET /nodejs/healthcheck
 */
router.get('/', (req, res) => {
  res.json({ message: 'OK' })
})

export default router
