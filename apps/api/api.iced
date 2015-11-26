express = require 'express'
routes = require './routes'

path = require 'path'

api = express()
api.set 'views', path.join __dirname, 'views'

api.use '/', routes

module.exports = api
