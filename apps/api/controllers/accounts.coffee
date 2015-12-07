express = require 'express'
User = require '../models/user'
router = express.Router()

router.get '/', (req, res, next) ->
  # req.app.locals['db']
  res.jsonp 'hello': 'world'

router.put '/create', (req, res, next) ->
  unless req.body._id? and req.body.email? and req.body.password?
    console.log 'PUT request on: /account/create FAILED'
    return res.status(400).jsonp 'error': 'empty_field'

  console.log 'PUT request on: /account/create'
  user = new User
  user._id = req.body._id
  user.email = req.body.email
  user.hashPassword req.body.password, (error, hashedPassword) ->
    return res.status(500).jsonp 'error': error if error
    user.password = hashedPassword
    user.save (error, result) ->
      return res.status(error).jsonp 'error': error if error
      return res.jsonp 'ok': true

# router.get '/get/:id', (req, res, next) ->

router.put '/token', (req, res, next) ->
  unless req.body._id? and req.body.password?
    console.log 'PUT request on: /account/token FAILED'
    console.log req.body
    return res.status(400).jsonp 'error': 'empty_field'
#   else
  console.log 'PUT request on: /account/token'
  user = new User
  user.getToken(
    req.body._id,
    req.body.password,
    req.body.client, (error, token) ->
      return res.status(401).jsonp 'error': error if error
      return res.jsonp 'token': token
    )


module.exports = router
