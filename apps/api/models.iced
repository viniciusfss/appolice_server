mongo = require 'mongoose'
Schema = mongo.schema

models = {
  user: () ->
    new Schema {

    }
}

module.exports = models
