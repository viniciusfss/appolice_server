PouchDB = require 'pouchdb'
bcrypt = require 'bcryptjs'
uid = require('rand-token').uid
db = new PouchDB process.env.COUCHDBPATH + 'account'

class User
  # This schema is not fixed
  constructor: () ->

  getToken: (id, pass, client, cb) ->
    # Retuns a token. If no token is found, we generate one, with client as ID.
    return undefined unless typeof cb is 'function'
    self = @
    @byID id, (error, user) ->
      return cb error if error
      self.comparePassword pass, (error, result) ->
        return cb error if error
        if result is true
          unless user.tokens
            return self.setToken client, (error, result) ->
              return cb error if error
              return cb undefined, result
          return cb undefined, user.tokens[(client or 'web')]
        else
          console.log 'Result is False'
          return cb 'Passwords does not match'

  byID: (id, cb) ->
    # Get the user object. If no user is found, we return an error status.
    return undefined unless typeof cb is 'function'

    id = id.replace(/\D+/g, '') # Validation
    self = @
    db.get id, (error, user) ->
      return cb error.status if error

      self._id = user._id
      self._rev = user._rev
      self.email = user.email unless user.email is undefined
      self.password = user.password unless user.password is undefined
      self.tokens = user.tokens unless user.tokens is undefined
      self.children = user.children unless user.children is undefined
      self.parent = user.parent unless user.parent is undefined

      return cb undefined, self

  save: (cb) ->
    # Does validations and saves user in the database.
    # Also return a fresh copy from database.

    return undefined unless typeof cb is 'function'
    return cb 'Missing ID' if @_id is undefined

    @_id = @_id.replace(/\D+/g, '') # Validation
    self = @
    db.put self, (error, result) ->
      return cb error.status if error
      console.log 'Saving user ID: ' + self._id
      self.byID result.id, (error, user) ->
        return cb error if error
        return cb undefined, self

  hashPassword: (pass, cb) ->
    # Hashes a password. Returns the hashed password.
    return undefined unless typeof cb is 'function'
    bcrypt.hash pass, 10, (error, hashedPassword) ->
      return cb 'Could not hash password' if error
      return cb undefined, hashedPassword

  comparePassword: (pass, cb) ->
    # Compares the password and the hashed password.
    return undefined unless typeof cb is 'function'
    # This either returns an error, or true/false
    bcrypt.compare pass, @password, (error, result) ->
      return cb 'Error comparing passwords!' if error
      return cb 'Passwords does not match' if result is false
      return cb undefined, result

  setToken: (client, cb) ->
    # Sets a token with client and returns it
    return undefined unless typeof cb is 'function'

    @tokens = {} unless @tokens
    @tokens.android = uid 40 if client is 'android' and not @tokens.android
    @tokens.ios = uid 40 if client is 'ios' and not @tokens.ios
    @tokens.web = uid 40 if not client? and not @tokens.web
    @save (error, user) ->
      return cb error if error
      return cb undefined, user.tokens[(client or 'web')]

module.exports = User
