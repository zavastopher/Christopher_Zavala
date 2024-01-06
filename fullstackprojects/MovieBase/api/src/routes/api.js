const express = require('express');
const tokenParse = require('cookie-parser');
const userRouter = require('./userRoutes.js');
const listRouter = require('./listRoutes.js');
const searchRouter = require('./searchRoutes.js');
const mediaRouter = require('./mediaRoutes.js');
const reviewRouter = require('./reviewRoutes.js');

const api = express.Router('/api');
api.use(express.urlencoded({extended: true}));
api.use(tokenParse());
api.use(express.json());
api.use("/users",userRouter);
api.use("/lists",listRouter);
api.use("/search",searchRouter);
api.use("/media",mediaRouter);
api.use("/reviews",reviewRouter);



module.exports = api;
