express = require 'express'
passport = require 'passport'
Client = require '../models/user'
router = express.Router()

# Get all policies from all clients
router.get '/',
passport.authenticate('token', session: false),
(req, res, next) ->
  Client.find {broker: req.user, active: true}, (error, clients) ->
    return res.status(400).jsonp error if error
    console.log clients
    policies = []
    for client in clients # Clear important fields
      clientPolicies = []
      for policy in client.policies
        if policy.isForCar isnt true
          clientPolicies.push policy
        
      data = {id: client.id, email: client.email, policies: clientPolicies}
      policies.push data
      
    console.log policies
    return res.jsonp policies

# Create a new policy on client with :id
router.put '/:id/new',
passport.authenticate('token', session: false),
(req, res, next) ->
  console.log req.body
  Client.findOne {id: req.params.id, broker: req.user}, (error, client) ->
    return res.status(400).jsonp error if error
    return res.status(404).jsonp 'not_found' if client is null
    client.policies.push req.body
    return client.save (error, result) ->
      return res.status(400).jsonp error if error
      return res.jsonp result


# Updates a policy on client with :id
router.put '/:id/edit',
  passport.authenticate('token', session: false),
  (req, res, next) ->
    Client.findOne {id: req.params.id, broker: req.user}, (error, client) ->
      return res.status(400).jsonp error if error
      return res.status(404).jsonp 'not_found' if client is null
      for policy, i in client.policies
        if (policy._id.toString()) is (req.body._id)
          policy.title = req.body.title
          policy.subtitle = req.body.subtitle
          policy.value = req.body.value
          client.policies[i] = policy
      return client.save (error, result) ->
        return res.status(400).jsonp error if error
        return res.jsonp result

#  client.policies
    #  return client.save (error, result) ->
    #    return res.status(400).jsonp error if error
    #    return res.jsonp result

module.exports = router