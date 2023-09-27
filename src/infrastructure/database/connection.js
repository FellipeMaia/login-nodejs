const pg = require('pg')

const CONST = require('../../utils/config')

const opts = {
  host: CONST.DB_HOST,
  port: CONST.DB_PORT,
  database: CONST.DB_NAME,
  user: CONST.DB_USER,
  password: CONST.DB_PASSWORD
}

let pool = null
let connection = null

function start() {
  pool = new pg.Pool(opts)

  return pool
    .connect()
    .then(_connection => {
      connection = _connection

      console.log('aqui')
      logger.info('Start connection database', {
        host: `${opts.host}:${opts.host}/${opts.database}`
      })
      return Promise.resolve()
    })
    .catch(err => {
      throw new HandleError({
        message: 'HandleError: Error start connection',
        error: err
      })
    })
}

function stop() {
  return pool
    .end()
    .then(() => {
      logger.info('Stop connection database')
    })
    .catch(err => {
      throw new HandleError({
        message: 'HandleError: Error stop connection: ',
        error: err
      })
    })
}

exports.start = start
exports.stop = stop
exports.connection = connection
