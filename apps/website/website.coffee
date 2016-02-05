express = require 'express'
routes = require './routes'

path = require 'path'

website = express()
website.set 'views', path.join __dirname, 'views'

website.use '/', routes

module.exports = website
