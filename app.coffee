express = require 'express'
path = require 'path'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
csrf = require 'csurf'
mongoose = require 'mongoose'
cors = require 'cors'

##### CONFIGURATION #####
# Configure there the PATH to the database

if process.env.OPENSHIFT_MONGODB_DB_PASSWORD
  connection_string = process.env.OPENSHIFT_MONGODB_DB_USERNAME + ":" +
    process.env.OPENSHIFT_MONGODB_DB_PASSWORD + "@" +
    process.env.OPENSHIFT_MONGODB_DB_HOST + ':' +
    process.env.OPENSHIFT_MONGODB_DB_PORT + '/' +
    process.env.OPENSHIFT_APP_NAME
  mongoose.connect 'mongodb://' + connection_string
else
  mongoose.connect 'mongodb://localhost/appolice'

app = express()

# view engine setup
app.set 'view engine', 'jade'
app.set 'views', path.join __dirname, 'views'
# uncomment after placing your favicon in /public
# app.use favicon "#{__dirname}/public/favicon.ico"
app.use logger 'dev'
app.use bodyParser.json()
app.use bodyParser.urlencoded
  extended: true
app.use cookieParser()
app.use express.static path.join __dirname, 'public'


# Include here the apps you want available

website = require './apps/website/website'
dashboard = require './apps/dashboard/dashboard'
api = require './apps/api/api'

# Allow CORS
app.use cors()
#app.use (req, res, next) ->
#  res.header("Access-Control-Allow-Origin", "*")
#  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")
#  next()

# We need to disable CSRF for APIs

# app.use csrf {cookie: false}
app.use '/api', api
app.use '/dashboard', dashboard
app.use '/', website

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error 'Not Found'
  err.status = 404
  next err

# error handlers

# development error handler
# will print stacktrace
if app.get('env') is 'development'
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message,
      error: err

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render 'error',
    message: err.message,
    error: {}

module.exports = app
