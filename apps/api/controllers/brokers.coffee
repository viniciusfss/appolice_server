express = require 'express'
passport = require 'passport'
User = require '../models/user'
Client = require '../models/user'
router = express.Router()

## Brokers

router.get '/',
passport.authenticate('token', session: false),
(req, res, next) ->
  console.log req.user.broker
  Client.findOne {_id: req.user.broker}, (error, broker) ->
    return res.status(400).jsonp error if error
    broker.password = undefined
    broker.tokens = undefined
    return res.jsonp broker

module.exports = router