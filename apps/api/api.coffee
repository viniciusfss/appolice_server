express = require 'express'
tokenStrat = require('passport-accesstoken').Strategy

accounts = require './controllers/accounts'

path = require 'path'

api = express()
api.set 'views', path.join __dirname, 'views'

# api.use new tokenStrat(
#   (token, done) ->
#     true
# )

api.use '/account', accounts

module.exports = api
