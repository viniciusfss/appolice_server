express = require 'express'
routes = require './routes'

path = require 'path'

dashboard = express()
dashboard.set 'views', path.join __dirname, 'views'
dashboard.use express.static path.join __dirname, 'public'
dashboard.use '/', routes

module.exports = dashboard
