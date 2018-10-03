// Dependencies
// =============================================================
var express = require("express");
// var path = require("path");

// Sets up the Express App
// =============================================================
var app = express();
var PORT = process.env.PORT || 3005;

// Sets up the Express app to handle data parsing
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Routes
// =============================================================

// Basic route that sends the user first to the AJAX Page
app.get("/api", function(req, res) {
  res.statusCode = 200;
  res.send("success");
});

// Starts the server to begin listening
// =============================================================
app.listen(PORT, function() {
  console.log("API endpoint listening on PORT " + PORT);
});