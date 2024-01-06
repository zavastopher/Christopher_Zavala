const express = require('express');
const db = require('../DBConnect.js');
const router = express.Router();


module.exports = router;

// Write a Review
router.post('/:userId/:mediaId', (req, res) => {
    const userId = req.params.userId;
    const mediaId = req.params.mediaId;
    const review = req.body;

    const query = "INSERT INTO Review (Description, Rating, MediaId, UserId) VALUES (?, ?, ?, ?)";
    db.query(query,[review.description, review.rating, mediaId, userId ]).then(results => {
        return res.status(200).json({data: results});
    });
});

// Get a review
router.get('/:userId/:mediaId', (req, res) => {
    const userId = req.params.userId;
    const mediaId = req.params.mediaId;

    const query = "SELECT * FROM Review WHERE userId = ? AND mediaId = ?";
    db.query(query,[userId, mediaId]).then(results => {
        return res.status(200).json({data: results});
    });
});

// Edit a review
router.put('/:userId/:mediaId', (req, res) => {
    const userId = req.params.userId;
    const mediaId = req.params.mediaId;
    const review = req.body;

    const query = "UPDATE Review SET Description = ?, Rating = ? WHERE userId = ? AND mediaId = ?";
    db.query(query,[review.description, review.rating, userId, mediaId ]).then(results => {
        return res.status(200).json({data: results});
    });
});

// Get all reviews for a media
router.get('/:mediaId', (req, res) => {
    const mediaId = req.params.mediaId;
    const query = "SELECT * FROM moviebase.Review WHERE mediaId = ?";

    db.query(query,[mediaId]).then(results => {
        return res.status(200).json({data: results});
    });
    
});

// Delete a review
router.delete('/:reviewId', (req, res) => {
    const reviewId = req.params.mediaId;
    const query = "DELETE FROM Review WHERE reviewId = ?";

    db.query(query,[reviewId]).then(results => {
        return res.status(200).json({data: results});
    });
    
});
