const express = require("express");
const mongoose = require("mongoose");
const Butterfly = require("../Modules/butterfly");
const butterflyRouter = express.Router();
app.post("/api/butterflies", async (req, res) => {
  try {
    const { name, scientificName, imageURL } = req.body;

    // Create a new butterfly document
    const butterfly = new Butterfly({
      name,
      scientificName,
      imageURL,
    });

    // Save the butterfly to the database
    const savedButterfly = await butterfly.save();

    // Respond with the saved document
    res.status(201).json(savedButterfly);
  } catch (error) {
    console.error("Error saving butterfly:", error);
    res
      .status(500)
      .json({ error: "An error occurred while saving the butterfly." });
  }
});
module.exports = butterflyRouter;
