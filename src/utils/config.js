const path = require('path')

exports.APP = process.env.npm_package_name
exports.SYSTEM_PATH = path.resolve()
exports.ENV = process.env.ENVIRONMENT || 'DEV'
exports.PORT = process.env.PORT || 5001

exports.EXIT_STATUS = { Failure: 1, Success: 0 }
exports.EXIT_SIGNALS = ['SIGINT', 'SIGTERM', 'SIGQUIT']
exports.PATH_LOG = process.env.PATH_LOG || 'logs'

exports.DB_NAME = process.env.DB_NAME
exports.DB_USER = process.env.DB_USER
exports.DB_PASSWORD = process.env.DB_PASSWORD
exports.DB_HOST = process.env.DB_HOST
exports.DB_PORT = process.env.DB_PORT
