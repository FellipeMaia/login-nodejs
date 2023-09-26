const path = require('path')

exports.APP = process.env.npm_package_name
exports.SYSTEM_PATH = path.resolve()
exports.ENV = process.env.ENVIRONMENT || 'DEV'
exports.PORT = process.env.PORT || 5001

exports.EXIT_STATUS = { Failure: 1, Success: 0 }
exports.EXIT_SIGNALS = ['SIGINT', 'SIGTERM', 'SIGQUIT']
exports.PATH_LOG = process.env.PATH_LOG || 'logs'
