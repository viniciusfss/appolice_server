express = require 'express'
router = express.Router()

dbName = 'account'

router.get '/', (req, res, next) ->
  # req.app.locals['db']
  res.jsonp 'hello': 'world'

router.put '/create', (req, res, next) ->
  if req.body._id? and req.body.email? and req.body.password?
    # Validations
    # ID validation: allow only numbers
    req.body._id = req.body._id.replace(/\D+/g, '')
    console.log 'PUT request on: /account/create'
    console.log req.body
    account = req.app.parent.locals['db'](dbName)
    account.put req.body, (error, body) ->
      if error  # Problem.
        console.log error
        res.status(error.status).jsonp 'error': error.status
      else
        console.log body
        res.jsonp 'ok': true
  else
    console.log 'PUT request on: /account/create FAILED'
    res.status(400).jsonp 'error': 'Empty field'

module.exports = router
