const express = require('express');
const db = require('../DBConnect.js');
const router = express.Router();


module.exports = router;

// View all media in a list
router.get('/:userId', (req, res) => {
    const userId = req.params.userId;

    const query1 = "SELECT ListId FROM List WHERE UserId = ?";
    const query2 = "SELECT * FROM MediaList WHERE ListId = ?";

    db.query(query1, [userId]).then(results => {
        const listId = results.results[0].ListId;

        db.query(query2, [listId]).then(results => {
            return res.status(200).json({data: results});
        })
    })
});

// Get info about a user list
router.get('/:userId/watchlist', (req, res) => {
    const userId = req.params.userId;

    const query1 = "SELECT ListId FROM List WHERE UserId = ?";
    const query2 = "SELECT ListId, Name, CAST(Description AS CHAR) AS Description, UserId FROM List WHERE ListId = ?";

    db.query(query1, [userId]).then(results => {
        const listId = results.results[0].ListId;

        db.query(query2, [listId]).then(results => {
            return res.status(200).json({data: results});
        })
    })
});

// Make new media list
router.post('/:userId', (req, res) => {
    const userId = req.params.userId;
    const list = req.body;

    const query = "INSERT INTO List (Name, Description, UserId) VALUES (?, ?, ?)";
    
    db.query(query,[list.name,list.description, userId]).then(results => {
        return res.status(200).json({data: results});
    });
    
});

// Add media to a list
router.post('/:userId/watchlist', (req, res) => {
    const userId = req.params.userId;
    const mediaId = req.body.mediaId;

    const query1 = "SELECT ListId FROM List WHERE UserId = ?";
    const query2 = "INSERT INTO MediaList (ListId, MediaId) VALUES (?, ?)";

    db.query(query1, [userId]).then(results => {
        const listId = results.results[0].ListId;

        db.query(query2, [listId, mediaId]).then(results => {
            return res.status(200).json({data: results});
        })
    }) 
});

// Remove media from list
router.delete('/:userId/watchlist/:mediaId', (req, res) => {
    const userId = req.params.userId;
    const mediaId = req.params.mediaId;

    const query1 = "SELECT ListId FROM List WHERE UserId = ?";
    const query2 = "DELETE FROM MediaList WHERE ListId = ? AND MediaId = ?";

    db.query(query1, [userId]).then(results => {
        const listId = results.results[0].ListId;

        db.query(query2, [listId, mediaId]).then(results => {
            return res.status(200).json({data: results});
        })
    }) 
});

// Delete list
router.delete('/:userId', (req, res) => {
    const userIdId = req.params.userId;

    const query1 = "SELECT ListId FROM List WHERE UserId = ?";
    const query2 = "DELETE FROM List WHERE ListId = ?";
    
    db.query(query1, [userId]).then(results => {
        const listId = results.results[0].ListId;

        db.query(query2, [listId]).then(results => {
            return res.status(200).json({data: results});
        })
    }) 
});