const express = require('express');
const db = require('../DBConnect.js');
const router = express.Router();


module.exports = router;


// Search
router.post('/search', (req, res) => {
    const stype = req.body.filter;
    const svalue = req.body.search;
    const agg = req.body.aggType;
    if(!stype || !svalue) {
        return res.status(400).json({success: false, error: "Missing data"});
    }

    if(!agg) {
        db.query("CALL Search(?, ?, NULL);", [stype, svalue]).then(results => {
            return res.status(200).json({data: results.results[0]});
        });
    } else {
        db.query("CALL Search(?, ?, ?);", [stype, svalue, agg]).then(results => {
            return res.status(200).json({data: results.results[0]});
        });
    }
    
});

//Get all Media
router.get('/media', async (req, res) => {
    db.query("SELECT * FROM Media").then(results => {
        return res.status(200).json({data: results});
    });
})

// Get all Media Types
router.get('/mediatype', (req, res) => {
    db.query("SELECT * FROM MediaType").then(results => {
        return res.status(200).json({data: results});
    });
    
});

// Get all age ratings
router.get('/agerating', (req, res) => {
    db.query("SELECT * FROM AgeRatingType").then(results => {
        return res.status(200).json({data: results});
    });
    
});

// Get all Languages
router.get('/language', (req, res) => {
    db.query("SELECT * FROM Language").then(results => {
        return res.status(200).json({data: results});
    });
    
});







// Get all Streaming Services
router.get('/streaming', (req, res) => {
    db.query("SELECT * FROM StreamingService").then(results => {
        return res.status(200).json({data: results});
    });
    
});

// Get all Genres
router.get('/genre', (req, res) => {
    db.query("SELECT * FROM Genre").then(results => {
        return res.status(200).json({data: results});
    });
    
});