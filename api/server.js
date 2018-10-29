// Dependencies
// =============================================================
var express = require("express");

require('dotenv').config();

// Sets up the Express App
// =============================================================
var app = express();
var PORT = process.env.PORT || 3001;

// Sets up the Express app to handle data parsing
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// staticly serve the React build artifacts if NOT in development mode
if (process.env.NODE_ENV === "production") {
  console.log("Serving Static Build Content.");
  app.use(express.static("build"));
}

// Routes
// =============================================================

// Basic route
app.get("/api/test", function(req, res) {
  res.json({status: "success"});
});

// Starts the server to begin listening
// =============================================================
app.listen(PORT, function() {
  console.log("API endpoint listening on PORT " + PORT);
});