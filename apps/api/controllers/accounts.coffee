express = require 'express'
passport = require 'passport'
User = require '../models/user'
router = express.Router()

router.get(
  '/',
  passport.authenticate('token', session: false),
  (req, res, next) ->
    # req.app.locals['db']
    res.jsonp 'hello': 'world')

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

router.put '/get/', (req, res, next) ->
  unless req.body.token?
    console.log 'PUT request on: /account/get FAILED'
    return res.status(401).jsonp 'error': 'empty_field'

  else
    user = new User
    user.byToken req.body.token, (error, users) ->
      return res.status(404).jsonp 'error': error if error
      for user in users
        delete user.doc.password
        delete user.doc._rev
        delete user.doc.tokens
        return res.jsonp 'ok': user.doc

router.put '/exists', (req, res, next) ->
  user = new User
  user.exists req.body.token, (error, success) ->
    return res.status(404).jsonp 'error': error if error
    return res.jsonp 'ok': success

router.put '/token', (req, res, next) ->
  unless req.body._id? and req.body.password?
    console.log 'PUT request on: /account/token FAILED'
    console.log req.body
    return res.status(400).jsonp 'error': 'empty_field'
#   else
  console.log 'PUT request on: /account/token'
  user = new User
  return user.getToken(
    req.body._id,
    req.body.password,
    req.body.client, (error, token) ->
      return res.status(401).jsonp 'error': error if error
      return res.jsonp 'token': token
    )


module.exports = router
