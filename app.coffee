express = require 'express'
path = require 'path'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
csrf = require 'csurf'

# Configure there the PATH to the database
dbPath = 'http://localhost:5984/'
PouchDB = require 'pouchdb'

app = express()
# database setup
app.locals.db = (dbName) ->
  new PouchDB(dbPath + dbName)

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

# We need to disable CSRF for APIs

app.use '/api', api
app.use '/dashboard', dashboard
app.use csrf {cookie: true}
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
