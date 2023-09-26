const { Router } = require('express')

const routes = Router()

routes.get('/half-checked', (req, res) => {
  try {
    const response = { message: 'ok', status: 200 }
    res.status(response.status).json(response)
  } catch (error) {
    const data = { message: 'fail', status: 500 }
    const handleError = new HandleError({ error, status: data.status, data })
    res.status(data.status).send(data)
    logger.error(handleError.toJsonLog())
    logger.debug(handleError)
  }
})

module.exports = routes
