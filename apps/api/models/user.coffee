mongoose = require 'mongoose'
Schema = mongoose.Schema
bcrypt = require 'bcryptjs'
jwt = require 'jsonwebtoken'

# Schema is not fixed!
userSchema = new Schema {
  id: type: String, unique: true
  password: String
  tokens: [
    id: String, client: String
  ]
  name: String
  email: type: String, lowercase: true
  active: type: Boolean, default: true
  clients: [ type: Schema.Types.ObjectId, ref: 'User' ] # Clients
  broker: type: Schema.Types.ObjectId, ref: 'User' # Broker
  policies: [
    isForCar: Boolean
    title: String
    subtitle: String
    value: Number
    file: Buffer # There are limitation on saving files on MongoDB.
    brand: String
    model: String
    plate: String
    productionYear: Number
    modelYear: Number
    colour: String
    driver: String
  ]
}

userSchema.methods.hashPassword = (pass, cb) ->
  return cb 'Callback not a function' unless typeof cb is 'function'
  return bcrypt.hash pass, 10, (error, hashedPassword) ->
    return cb error if error
    console.log hashedPassword
    return cb undefined, hashedPassword

userSchema.methods.validatePassword = (pass, cb) ->
  return cb 'Callback not a function' unless typeof cb is 'function'
  return bcrypt.compare pass, this.password, (error, result) ->
    return cb error if error
    return cb 'Invalid password' if result is false
    return cb undefined, true if result is true

userSchema.methods.generateToken = (client, cb) ->
  return cb 'Callback not a function' unless typeof cb is 'function'
  user = this
  return jwt.sign(
    {id: user.id}, user.password, {expiresIn: '14d'}, (token) ->
      user.tokens.push {id: token, client: client or 'web'}
      user.save (error, result) ->
        return cb error if error
        return cb undefined, token
  )

userSchema.methods.validadeToken = (token, cb) ->
  return cb 'Callback not a function' unless typeof cb is 'function'
  user = this
  for tk in user.tokens
    if tk.id is token
      return jwt.verify tk.id, user.password, (error, result) ->
        return cb error if error
        return cb undefined, true

module.exports = mongoose.model 'User', userSchema
