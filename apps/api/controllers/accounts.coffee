express = require 'express'
bcrypt = require 'bcryptjs'
router = express.Router()

dbName = 'account'

router.get '/', (req, res, next) ->
  # req.app.locals['db']
  res.jsonp 'hello': 'world'

router.put '/create', (req, res, next) ->
  unless req.body._id? and req.body.email? and req.body.password?
    console.log 'PUT request on: /account/create FAILED'
    res.status(400).jsonp 'error': 'Empty field'
  else
    # Validations
    # ID validation: allow only numbers
    req.body._id = req.body._id.replace(/\D+/g, '')
    console.log 'PUT request on: /account/create'
    bcrypt.hash req.body.password, 10, (error, result) ->
      if error
        res.status(500).jsonp 'error': 'Kittens died today. Sorry! :<'
      else
        account = req.app.parent.locals['db'](dbName)
        req.body.password = result # Result is the hashed password
        console.log req.body
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
    res.status(400).jsonp 'error': 'Empty field'
  else
    console.log 'PUT request on: /account/token'
    account = req.app.parent.locals['db'](dbName)
    req.body._id = req.body._id.replace(/\D+/g, '') # Validation
    account.get req.body._id, (error, result) ->
      if error # Account not found
        console.log error
        res.status(error.status).jsonp 'error': error.status
      else
        console.log result

module.exports = router
