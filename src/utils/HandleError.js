class HandleError extends Error {
  constructor(obj = {}) {
    let { message = 'HandleError', error = null, status = 500, data = {} } = obj
    message = message + (error?.message ? ': ' + error.message : '')
    super(message)
    this.data = { ...(error?.data ?? {}), ...data }
    this.status = error?.status ?? status
    this.stack = this.stack + error?.stack ? '\n...\n' + error?.stack : ''
  }

  toJson() {
    return { message: this.message, ...this }
  }

  toJsonLog() {
    return { msg: this.message, ...this }
  }
}

global.HandleError = HandleError
