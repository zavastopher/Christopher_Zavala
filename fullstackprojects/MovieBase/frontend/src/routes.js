// Necessary imports
const express = require('express');
const routes = express.Router();
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');

// Set the paths for the static resources and templates
routes.use(express.static(__dirname));
const path = require('path');
const { rmSync } = require('fs');
const html_dir = path.join(__dirname, './template/');

// Parsers for cookies and body text
routes.use(cookieParser());
routes.use(bodyParser.urlencoded({ extended: false}));

routes.get('/', (_, res) => {
    res.sendFile(`${html_dir}search.html`);
})

routes.get('/signin', (_, res) => {
    res.sendFile(`${html_dir}signin.html`);
});

routes.get('/signup', (_, res) => {
    res.sendFile(`${html_dir}signup.html`);
});

routes.get('/movie-collection', (_, res) => {
    res.sendFile(`${html_dir}movie-collection.html`);
})

routes.get('/movie/:media-id', (_, res) => {
    res.sendFile(`${html_dir}movie.html`);
})

// Export this code to be used for other scripts
module.exports = routes;