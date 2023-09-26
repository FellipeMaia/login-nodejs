const fs = require('fs')
const path = require('path')
const pino = require('pino')
const pinoMultiStream = require('pino-multi-stream').multistream

const CONST = require('../utils/config')

const fsPromises = fs.promises

async function createStreamLog() {
  function createNameLog() {
    return `${new Date().toLocaleDateString().replace(/\//g, '-')}.log`
  }
  const pathLog = path.join(CONST.SYSTEM_PATH, CONST.PATH_LOG)

  const streamLog = await fsPromises
    .stat(pathLog)
    .catch(err => {
      if (err.code != 'ENOENT') throw err
      return fsPromises.mkdir(pathLog)
    })
    .then(() => {
      const nameLog = createNameLog()
      return fs.createWriteStream(path.join(pathLog, nameLog), { flags: 'a+' })
    })

  const stopStreamLog = () => {
    return new Promise((resolve, reject) => {
      if (!streamLog || streamLog?.closed) return resolve(true)
      streamLog.close(err => {
        err ? reject(err) : resolve(true)
      })
    })
  }

  const logger = pino(
    {
      formatters: {
        bindings() {
          return {
            Application: `${CONST.APP}`,
            environment: `${CONST.ENV}`
          }
        },
        level(label) {
          return { log_level: label.toUpperCase() }
        },
        messageKey: 'msg'
      },
      timestamp: function () {
        return `,"timestamp":"${new Date(Date.now()).toJSON()}"`
      } //() =>`,"data_time": "${new Date().toISOString()}"`,
    },
    pinoMultiStream([process.stdout, streamLog])
  )

  return { logger, stopStreamLog }
}

module.exports = createStreamLog
