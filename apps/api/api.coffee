express = require 'express'
accounts = require './controllers/accounts'

path = require 'path'

api = express()
api.set 'views', path.join __dirname, 'views'

api.use '/account', accounts

module.exports = api
