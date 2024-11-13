const mongoose = require("mongoose");

const butterflySchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  scientificName: {
    type: String,
    required: true,
    trim: true,
  },
  imageURL: {
    type: String,
    required: true,
  },
});

const Butterfly = mongoose.model("Butterfly", butterflySchema);
module.exports = Butterfly;
