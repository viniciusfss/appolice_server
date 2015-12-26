express = require 'express'
passport = require 'passport'
User = require '../models/user'
router = express.Router()

# Get all policies from all clients
router.get '/',
passport.authenticate('token', session: false),
(req, res, next) ->
  Client.find {broker: req.user}, (error, clients) ->
    return res.status(400).jsonp error if error
    return res.jsonp clients.policies

# Create a new policy on client with :id
router.put '/:id/new',
passport.authenticate('token', session: false),
(req, res, next) ->
  Client.findOne {id: req.params.id, broker: req.user}, (error, client) ->
    return res.status(400).jsonp error if error
    return res.status(404).jsonp 'not_found' if result is null
    client.policies.push req.body
    return client.save (error, result) ->
      return res.status(400).jsonp error if error
      return res.jsonp result

module.exports = router