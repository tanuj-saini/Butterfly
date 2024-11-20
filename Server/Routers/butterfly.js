const express = require("express");
const mongoose = require("mongoose");
const Butterfly = require("../Modules/butterfly");
const butterflyRouter = express.Router();
butterflyRouter.post("/api/butterflies", async (req, res) => {
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
butterflyRouter.get("/api/butterflies", async (req, res) => {
  try {
    // Get page and limit from query parameters with default values
    const page = parseInt(req.query.page) || 1; // default to page 1
    const limit = parseInt(req.query.limit) || 20; // default to 10 items per page

    // Calculate the number of documents to skip
    const skip = (page - 1) * limit;

    // Fetch butterflies with pagination
    const butterflies = await Butterfly.find().skip(skip).limit(limit);

    // Get the total count of butterflies for pagination information
    const total = await Butterfly.countDocuments();

    // Send paginated results along with pagination info
    res.json({
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
      data: butterflies,
    });
  } catch (error) {
    console.error("Error fetching butterflies:", error);
    res
      .status(500)
      .json({ error: "An error occurred while fetching the butterflies." });
  }
});
module.exports = butterflyRouter;
