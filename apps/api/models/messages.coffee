mongoose = require 'mongoose'
Schema = mongoose.Schema

messageSchema = new Schema {
  from: Schema.Types.ObjectId, ref: 'User'
  to: Schema.Types.ObjectId, ref: 'User'
  text: String
}
