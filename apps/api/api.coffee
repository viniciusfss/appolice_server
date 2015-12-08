express = require 'express'
passport = require 'passport'
tokenStrat = require('passport-accesstoken').Strategy

accounts = require './controllers/accounts'
User = require './models/user'

path = require 'path'

api = express()
api.set 'views', path.join __dirname, 'views'


passport.use new tokenStrat(
  (token, done) ->
    user = new User
    user.exists token, (error, result) ->
      return done error if error
      return done null, false if result is false
      return done null, true
)

api.use '/account', accounts

module.exports = api
