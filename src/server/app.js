const express = require('express')
// const {v4: uuid} = require('uuid')

const routes = require('../routes')

const app = express()
let appServer = null

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.use(routes.halfChecked)

/**
 * Iniciar o servidor HTTP
 * @param {Number | String} port Porta que será aberta para acessar a API
 * @param {String} env Monstra em que ambiente esta sendo executado
 * @author Fellipe Maia
 * @returns Promise com sucesso caso a inicialização ocorra corretamente
 * || Promise com falha caso não inicie corretamente o servidor
 */
exports.start = (port = 5001) => {
  return new Promise((resolve, reject) => {
    try {
      appServer = app.listen(port, () => {
        logger.info(`Sistema iniciado port: ${port}`)
        resolve(true)
      })
    } catch (error) {
      const message = 'Error ao iniciar servidor HTTP'
      reject(new HandleError({ message, error }))
    }
  })
}

/**
 * Finalizar o servidor HTTP
 * @author Fellipe Maia
 * @returns Promise com sucesso caso a finalização ocorra corretamente
 * || Promise com falha caso não finalize corretamente o servidor
 */
exports.stop = () => {
  return new Promise((resolve, reject) => {
    try {
      if (!appServer) return resolve(true)
      appServer.closeIdleConnections()
      return resolve(true)
    } catch (error) {
      return reject(error)
    }
    // appServer.close(err => {
    //   if (err) return reject(err)
    //   logger.info('Servidor HTTP finalizado')
    //   return resolve(true)
    // })
  })
}
