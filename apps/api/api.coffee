express = require 'express'
passport = require 'passport'
tokenStrat = require('passport-accesstoken').Strategy

accounts = require './controllers/accounts'
clients = require './controllers/clients'
policies = require './controllers/policies'
carPolicies = require './controllers/carPolicies'

User = require './models/user'

path = require 'path'

api = express()
api.set 'views', path.join __dirname, 'views'


passport.use new tokenStrat(
  (token, done) ->
    return done 'Empty token' unless token?
    User.findOne(
      {'tokens.id': token}, (error, user) ->
        return done error if error
        return done null, false unless user?
        return user.validadeToken token, (error, result) ->
          return done error if error
          return done null, user
    )
)

api.use '/account', accounts
api.use '/client', clients
api.use '/policy', policies
api.use '/car-policy', carPolicies

module.exports = api
