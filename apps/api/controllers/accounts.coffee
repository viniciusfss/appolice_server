express = require 'express'
passport = require 'passport'
User = require '../models/user'
router = express.Router()
path = require 'path'
UPLOAD_PATH = 'public/img/users/'

multer = require 'multer'
upload = multer({dest: UPLOAD_PATH})

## Account: C R U x [No delete]


# Create a new user. No required authentication.
router.put '/create', (req, res, next) ->
  console.log req.body
  unless req.body.id? and req.body.email? and req.body.password?
    console.log 'PUT request on: /account/create FAILED'
    return res.status(400).jsonp 'error': 'empty_field'

  console.log 'PUT request on: /account/create'
  user = new User
  user.id = req.body.id.replace /\D+/g, ''
  user.email = req.body.email
  user.isBroker = true
  password = req.body.password
  user.hashPassword password, (error, hashedPassword) ->
    return res.status(400).jsonp error if error
    return (
      user.password = hashedPassword
      user.save (error, result) ->
        return res.status(400).jsonp error.message if error
        result.password = undefined
        result.__v = undefined
        return res.jsonp result
    )

router.put '/login', (req, res, next) ->
  unless req.body.id? and req.body.password?
    console.log 'PUT request on: /account/login FAILED'
    console.log req.body
    return res.status(400).jsonp 'Empty Field'

  console.log 'PUT request on: /account/login'
  id = req.body.id.replace /\D+/g, ''
  client = req.body.client or 'web'
  User.findOne {id: id}, (error, user) ->
    return res.status(500).jsonp error if error
    return res.status(404).jsonp 'Not found' unless user?
    return user.generateToken client, (error, token) ->
      return res.status(500).jsonp error if error
      return res.jsonp 'token': token

# Get user information. Authentication needed.
router.get '/',
passport.authenticate('token', session: false),
  (req, res, next) ->
    console.log 'GET request on: /account/'
    user = req.user
    user.password = undefined
    user.tokens = undefined
    user.__v = undefined
    return res.jsonp 'user': user

# Update account by ID. Authentication and ownership required.
router.put '/update',
[passport.authenticate('token', session: false), upload.single('file')],
(req, res, next) ->
    file = req.file
    me = req.user
    if req.file
      host = req.get('host')
      p1 = file.path.split(path.sep)
      p1.shift()
      p2 = [host].concat(p1)
      console.log p2
      p3 = p2.join('/')
      me.imgPath = req.protocol + "://" + p3

    me.name = req.body.name if req.body.name
    me.email = req.body.email if req.body.email
    me.location = req.body.location if req.body.location
    me.phone = req.body.phone if req.body.phone

    me.kindOfPolicies.carPolicy = if req.body.carPolicy is 'true' then true else false
    me.kindOfPolicies.workPolicy = if req.body.workPolicy is 'true' then true else false
    me.kindOfPolicies.devicePolicy = if req.body.devicePolicy is 'true' then true else false
    me.kindOfPolicies.travelPolicy = if req.body.travelPolicy is 'true' then true else false
    me.kindOfPolicies.lifePolicy = if req.body.lifePolicy is 'true' then true else false
    me.kindOfPolicies.propertyPolicy = if req.body.propertyPolicy is 'true' then true else false
    me.kindOfPolicies.personalPolicy = if req.body.personalPolicy is 'true' then true else false

    return me.save (error, result) ->
      return res.status(500).jsonp error if error
      return res.jsonp result


# router.get(
#   '/:token',
#   passport.authenticate('token', session: false),
#   (req, res, next) ->
#     user = new User
#     res.jsonp 'hello': 'RiotJS'
#   )

# router.put '/get/', (req, res, next) ->
#   unless req.body.token?
#     console.log 'PUT request on: /account/get FAILED'
#     return res.status(401).jsonp 'error': 'empty_field'

#   else
#     user = new User
#     user.byToken req.body.token, (error, users) ->
#       return res.status(404).jsonp 'error': error if error
#       for user in users
#         delete user.doc.password
#         delete user.doc._rev
#         delete user.doc.tokens
#         return res.jsonp 'ok': user.doc

# router.put '/exists', (req, res, next) ->
#   user = new User
#   user.exists req.body.token, (error, success) ->
#     return res.status(404).jsonp 'error': error if error
#     return res.jsonp 'ok': success

# router.put '/token', (req, res, next) ->
#   unless req.body._id? and req.body.password?
#     console.log 'PUT request on: /account/token FAILED'
#     console.log req.body
#     return res.status(400).jsonp 'error': 'empty_field'
# #   else
#   console.log 'PUT request on: /account/token'
#   user = new User
#   return user.getToken(
#     req.body._id,
#     req.body.password,
#     req.body.client, (error, token) ->
#       return res.status(401).jsonp 'error': error if error
#       return res.jsonp 'token': token
#     )


module.exports = router
