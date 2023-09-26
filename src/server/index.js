const createStreamLog = require('../infrastructure/logger')
const CONST = require('../utils/config')
require('../utils/HandleError')
const app = require('./app')

/**
 * Iniciar o serviço de cotação
 * @author Fellipe Maia
 */
function startServer() {
  return createStreamLog()
    .then(({ logger, stopStreamLog }) => {
      global.logger = logger
      global.stopStreamLog = stopStreamLog
      return app
        .start()
        .then(() => {
          return mapEventCloseSystem()
        })
        .catch(error => {
          const message = 'Error durante a inicialização do sistema'
          const handleError = new HandleError({ message, error })
          logger.error(handleError.toJsonLog())
          logger.debug(handleError)
          process.exit(CONST.EXIT_STATUS.Failure)
        })
    })
    .catch(error => {
      const message = 'Error ao iniciar o serviço de log.'
      const handleError = new HandleError({ message, error })
      console.error(handleError.toJsonLog())
      console.debug(handleError)
      process.exit(CONST.EXIT_STATUS.Failure)
    })
}

/**
 * Criar a monitoria dos eventos de fechamento de processo
 * passando como callback a função callbackStopSystem
 * @author Fellipe Maia
 * @returns Promise com sucesso casos eventos seja criado
 * || Promise com falha casos ocorra falha na criação dos eventos
 */
function mapEventCloseSystem() {
  try {
    CONST.EXIT_SIGNALS.forEach(sig => {
      process.on(sig, callbackStopSystem)
    })
    return Promise.resolve(true)
  } catch (error) {
    return Promise.reject(error)
  }
}

/**
 * Callback responsável a função stopServer para finalizar o servidor
 * @author Fellipe Maia
 */
function callbackStopSystem() {
  return stopServer()
    .then(() => {
      logger.info(`Serviço finalizado com sucesso`)
    })
    .catch(error => {
      const message = 'Error ao tentar finalizar o sistema'
      const handleError = new HandleError({ message, error })
      logger.error(handleError.toJsonLog())
      logger.debug(handleError)
      return Promise.resolve(true)
    })
    .then(() => {
      return stopStreamLog()
    })
    .catch(error => {
      const handleError = new HandleError({ error })
      console.error(handleError.toJsonLog())
      console.debug(handleError)
      return Promise.resolve(true)
    })
    .then(() => {
      process.exit(0)
    })
}

/**
 * Responsável por desconectar os serviços utilizados para que não ocorra perda de informação
 * @author Fellipe Maia
 * @returns Promise com sucesso casos os serviços seja desconectados
 * || Promise com falha casos ocorra falha na desconexão os serviços
 */
function stopServer() {
  return app.stop().catch(error => {
    const message = 'Error durante a finalização do Express'
    throw new HandleError({ message, error })
  })
}

startServer()
