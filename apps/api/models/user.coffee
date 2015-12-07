PouchDB = require 'pouchdb'
bcrypt = require 'bcryptjs'
uid = require('rand-token').uid
db = new PouchDB process.env.COUCHDBPATH + 'account'

couchviews = {
  _id: '_design/account'
  views: {
    userByToken: {
      map: ((doc) ->
        for token in doc.tokens
          emit(token.id, token.client)).toString()
    }
  }
}

db.get couchviews._id, (error, result) ->
  if error
    if error.status is 404
      console.log 'Not found!'
      db.put couchviews, (error, result) ->
        if error
          if error.status is 409
            console.log 'Conflict? o.o'
          else
            console.log '1. Dunno error: ' + error

        console.log 'Putting new design view!'
    else
      console.log '2. Dunno error: ' + error.status
  else
    if result.views is couchviews.views
      console.log 'Okay, nothing to be done!'
    else
      result.views = couchviews.views
      console.log 'Updating design views!'
      db.put result, (error, result) ->
        console.log error if error
        console.log result

# Schema is not fixed!
class User
  constructor: () ->

  exists: (token, cb) ->
    # Returns true or false depending on Token existence
    return undefined unless typeof cb is 'function'
    return cb 'No token given' unless token
    db.query 'account/userByToken', {key: token}, (error, value) ->
      return cb error if error
      for e in value.rows
        return cb undefined, true
      return cb undefined, false

  getToken: (id, pass, client, cb) ->
    # Retuns a token. If no token is found, generates one.
    return undefined unless typeof cb is 'function'
    client = 'web' unless client
    @byID id, (error, user) ->
      return cb error if error
      user.comparePassword pass, (error, result) ->
        console.log 'Comparing passwords'
        return cb error if error
        if result is true
          user.tokens = [] unless user.tokens
          for token in user.tokens
            if token.client is client
              return cb undefined, token.id
          # We couldn't find a token.client that matches the client.
          # So we'll generate a new token.
          tk =
            id: uid 80
            client: client
          user.tokens.push tk
          user.save (error, upUser) ->
            return cb error if error
            return cb undefined, upUser
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

    @tokens = [] unless @tokens
    for token in tokens
      console.log token
      if token.client is client
        return cb undefined, token._id

    console.log 'YO!'
    @save (error, user) ->
      return cb error if error
      return cb undefined, user.tokens[(client or 'web')]

module.exports = User
