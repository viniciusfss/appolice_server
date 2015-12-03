express = require 'express'
bcrypt = require 'bcryptjs'
uid = require('rand-token').uid
router = express.Router()

dbName = 'account'

router.get '/', (req, res, next) ->
  # req.app.locals['db']
  res.jsonp 'hello': 'world'

router.put '/create', (req, res, next) ->
  unless req.body._id? and req.body.email? and req.body.password?
    console.log 'PUT request on: /account/create FAILED'
    res.status(400).jsonp 'error': 'empty_field'
  else
    # Validations
    # ID validation: allow only numbers
    req.body._id = req.body._id.replace(/\D+/g, '')
    console.log 'PUT request on: /account/create'
    bcrypt.hash req.body.password, 10, (error, result) ->
      if error
        res.status(500).jsonp 'error': 'kittens_died_today'
      else
        account = req.app.parent.locals['db'](dbName)
        req.body.password = result # Result is the hashed password
        account.put req.body, (error, result) ->
          if error  # Problem.
            console.log error
            res.status(error.status).jsonp 'error': error.status
          else
            console.log result
            res.jsonp 'ok': true

router.put '/token', (req, res, next) ->
  unless req.body._id? and req.body.password?
    console.log 'PUT request on: /account/token FAILED'
    console.log req.body
    res.status(400).jsonp 'error': 'empty_field'
  else
    console.log 'PUT request on: /account/token'
    account = req.app.parent.locals['db'](dbName)
    req.body._id = req.body._id.replace(/\D+/g, '') # Validation
    # Step 1: Checking if account exists
    account.get req.body._id, (error, acc) ->
      if error # Account not found
        console.log error
        res.status(error.status).jsonp 'error': error.status
    # Account found
      console.log acc
      unless acc.password?
        return res.status(404).jsonp 'error': 'not_found'
      # Step 2: Compare password hashes.
      bcrypt.compare req.body.password, acc.password, (error, success) ->
        if error
          console.log error
          return res.status(500).jsonp 'error': 'kittens_died_today'

        if success is true
          # Passwords match. Now we need to give the guy a token
          client = req.body.client or 'web'
          token = uid(40)
          unless acc.tokens?
            acc.tokens = []
          acc.tokens.push {
            'token': token,
            'client': client
          }
          account.put acc, (error, result) ->
            if error? and error.status is 409
              return retryTokenOperation(req, res, acc)

            if error? and error.status isnt 409
              return res.status(error.status).jsonp 'error': error.status

            return res.jsonp 'token': token

        if success is false
          return res.status(401).jsonp 'error': 'wrong_user_or_pass'


retryTokenOperation = (req, res, acc) ->
  account = req.app.parent.locals['db'](dbName)
  account.get acc._id, (error, acc2) ->
    if error?
      return res.status(error.status).jsonp 'error': error.status

    acc2.tokens = acc.tokens
    account.put acc2, (error, result) ->
      if error? and error.status is 409
        console.log 'Error: too many tries.'
        return res.status(error.status).jsonp 'error': error.status

      return res.jsonp 'ok': true



module.exports = router
