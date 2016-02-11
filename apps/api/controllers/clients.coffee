express = require 'express'
passport = require 'passport'
Client = require '../models/user'
router = express.Router()

## Account: C R U x [No delete]


# Create a new client. Requires authentication
router.put '/create',
passport.authenticate('token', session: false),
(req, res, next) ->
  unless req.body.email? and req.body.id?
    return res.status(400).jsonp 'error': 'empty_field'

  client = new Client
  client.id = req.body.id.replace(/\D+/g, '')
  client.email = req.body.email
  client.broker = req.user
  Client.create client, (error, result) ->
    return res.status(409).jsonp 'conflict' if error.code is 11000
    req.user.clients.push client
    req.user.save (error, result) ->
      return res.jsonp error if error
      return res.jsonp 'ok': {'user': req.user, 'client': client}

# Returns the list of all clients registered by this broker
router.get '/',
passport.authenticate('token', session: false),
(req, res, next) ->
  Client.find {broker: req.user}, (error, clients) ->
    return res.status(400).jsonp error if error
    for client in clients
      client.password = undefined
      client.tokens = undefined
    return res.jsonp clients

# Returns the client registered by this broker.
router.get '/:id',
passport.authenticate('token', session: false),
(req, res, next) ->
  Client.findOne {id: req.params.id, broker: req.user}, (error, client) ->
    return res.status(400).jsonp error if error
    return res.status(404).jsonp 'not_found' if client is null
    client.password = undefined
    client.tokens = undefined
    return res.jsonp result

# Updates the client registered by this broker.
# Broker can only update the email and if the user is active or not.
router.put '/:id/update',
passport.authenticate('token', session: false),
(req, res, next) ->
  Client.findOne {id: req.params.id, broker: req.user}, (error, client) ->
    return res.status(400).jsonp error if error
    return res.status(404).jsonp 'not_found' if client is null
    client.active = req.body.active if req.body.active
    client.email = req.body.email if req.body.email
    return client.save (error, result) ->
      return res.status(400).jsonp error if error
      return res.jsonp result

# Creates a new message from broker to the client with :id
router.put '/:id/msg',
passport.authenticate('token', session: false),
(req, res, next) ->
  console.log req.body
  return res.status(400).jsonp 'no_msg' if req.body.text is ''
  return res.status(400).jsonp 'no_msg' if req.body.text is undefined
  return res.status(400).jsonp 'no_msg' if req.body.text is null
  Client.findOne {id: req.params.id, broker: req.user}, (error, client) ->
    return res.status(400).jsonp error if error
    return res.status(404).jsonp 'not_found' if client is null
    msg = {from: (req.user.name || req.user.email), text: req.body.text}
    client.messages.push msg
    client.save (error, result) ->
      return res.status(400).jsonp error if error
      console.log result.messages
      return res.jsonp result.messages

# Creates a new message from user to the broker
router.put '/msg',
passport.authenticate('token', session: false),
(req, res, next) ->
  console.log req.body
  return res.status(400).jsonp 'no_msg' if req.body.text is ''
  return res.status(400).jsonp 'no_msg' if req.body.text is undefined
  return res.status(400).jsonp 'no_msg' if req.body.text is null
  msg = {from: req.body.from, text: req.body.text}
  req.user.push msg
  req.user.save (error, result) ->
    return res.status(400).jsonp error if error
    return res.jsonp 'ok'


## CLIENT FIRST PASSWORD-LESS AUTHENTICATION
# First usage client login. To handle password creation on mobile app.
router.put '/passwordToken', (req, res, next) ->
  console.log req.body
  return res.status(400).jsonp 'Empty Field' unless req.body.username?
  client = req.body
  Client.findOne {id: req.body.username}, (error, brokerClient) ->
    return res.status(500).jsonp error if error
    return res.status(404).jsonp 'Not found' unless brokerClient?
    return res.status(400).jsonp 'Already has password' if brokerClient.password isnt undefined
    return brokerClient.generateTempToken client, (error, token) ->
      return res.status(400).jsonp error if error
      return res.jsonp 'token': token

# Save a new password on the database
router.put '/savePass', (req, res, next) ->
  console.log req.body
  Client.findOne {id: req.body.username, tempToken: req.body.tempToken}, (error, brokerClient) ->
    return res.status(500).jsonp error if error
    return res.status(404).jsonp 'Not found' unless brokerClient?
    return res.status(400).jsonp 'Already has password' if brokerClient.password isnt undefined
    return brokerClient.hashPassword req.body.password, (error, hashedPassword) ->
      return res.status(400).jsonp error if error
      return (
        brokerClient.password = hashedPassword
        brokerClient.save (error, result) ->
          return res.status(400).jsonp error.message if error
          result.password = undefined
          result.__v = undefined
          return res.jsonp result
      )

module.exports = router
