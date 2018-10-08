// Dependencies
// =============================================================

var express = require("express");
// var fs = require('fs');

// if the .env.sample file hasn't been copied to the .env file, pull in the sample
// if (!fs.existsSync(".env")) {
//   fs.writeFileSync(".env", fs.readFileSync(".env.sample"));
// }

require('dotenv').config();

// Sets up the Express App
// =============================================================
var app = express();
var PORT = process.env.PORT || 3005;

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