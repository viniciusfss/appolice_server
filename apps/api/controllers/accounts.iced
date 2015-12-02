express = require 'express'
router = express.Router()

dbName = 'account'

router.get '/', (req, res, next) ->
  # req.app.locals['db']
  res.jsonp 'hello': 'world'

# TODO: validations.
router.put '/create', (req, res, next) ->
  console.log 'PUT request on: /account/create'
  console.log req.body
  if req.body._id? and req.body.email? and req.body.password?
    account = req.app.parent.locals['db'](dbName)
    account.put req.body, (error, body) ->
      if error  # Problem.
        console.log error
        res.status(error.status).jsonp 'error': error.status
      else
        console.log body
        res.jsonp 'ok': true
  else
    res.status(400).jsonp 'error': 'Empty field'

module.exports = router
