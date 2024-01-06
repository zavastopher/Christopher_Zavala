// Necessary imports
const express = require ('express');

// Create the app and get the port from the environment
const app = express();
const PORT = 80

// Set the directory for static resources and add the urlencoded middleware
app.use(express.static(__dirname));
app.use(express.urlencoded({extended: true}));

// Import the routes defined in routes.js
const routes = require ('./routes');
app.use(routes);

// Declare the port we are listening on, viewable in the docker container for frontend
app.listen(PORT, () => console.log(`Server listiening on port: ${PORT}`));