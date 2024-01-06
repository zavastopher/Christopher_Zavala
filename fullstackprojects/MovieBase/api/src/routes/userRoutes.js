const express = require('express');
const db = require('../DBConnect.js');
const router = express.Router();

const {checkSession, stopSession, startSession} = require('../token.js');

module.exports = router;

// Create user vaildates the data and returns a success boolean
router.post('/createAccount', (req,res) => {
    if(!req.body.firstName || !req.body.lastName || !req.body.email || !req.body.password) {
        return res.status(400).json({success: false, error: "Missing data"});
    }
    else if(req.body.email.indexOf('@') === -1 || req.body.email.indexOf('.') === -1) {
        return res.status(400).json({success: false, error: "Please enter a valid email"});
    }
    else if(req.body.password.length > 100) {
        return res.status(400).json({success: false, error: "Please make password less than 100 characters"});
    }
    else {
        db.query("SELECT email FROM User WHERE email = (?)", [req.body.email])
        .then(response => {
            if (response.results.length === 0) {
                // Email not found, proceed with user creation
                return db.query("CALL CreateUser(?, ?, ?, ?)", [req.body.firstName, req.body.lastName, req.body.email, req.body.password]);
            }
    
            throw new Error("Email already registered with the system");
    
        })
        .then(_ => {
            // Send a success response
            res.status(200).json({ success: true });
        })
        .catch(error => {
            // Handle errors
            console.error(error);
            res.status(400).json({ success: false, error: error.message || "Internal server error" });
        });
    }


});

/**
 * API Method for logging in to the system
 */
router.post('/login', (req, res) => {
    if(!req.body.email || !req.body.password) {
        return res.status(400).json({success: false, error: "Missing data"});
    }

    if(req.body.email.indexOf('@') === -1 || req.body.email.indexOf('.') === -1 || req.body.password.length > 100) {
        return res.status(400).json({success: false, error: "Invalid email or password"});
    }

    db.query("SET @isVerifiedUser = FALSE;", [])
    .then(() => {
      // Call stored procedure
      return db.query("CALL VerifyUser(?, ?, @isVerifiedUser);", [req.body.email, req.body.password]);
    })
    .then(() => {
      // Retrieve the value of the variable
      return db.query("SELECT @isVerifiedUser as isVerifiedUser;", []);
    })
    .then((results) => {
      if (results.results[0].isVerifiedUser) {
        db.query("SELECT UserId FROM User WHERE Email = ?;", [req.body.email]).then(response => {
            startSession(req, res, {"email": req.body.email, "id": response.results[0].UserId});
            return res.status(200).json({data: results});
        })
      } else {
        // User is not verified, return an error response
        return res.status(400).json({ success: false, error: "Invalid email or password" });
      }
    })
    .catch((error) => {
      // Handle errors
      console.error(error);
      return res.status(500).json({ success: false, error: "Internal server error" });
    });

});

/**
 * Method logs the user out of the application
 */
router.post('/logout', (req, res) => {
    stopSession(req, res);
    res.json({success: true});
});

/**
 * Route checks the user token and returns the data stored in the token
 */
router.get('/getCurrentUser', checkSession, (req, res) => {
    return res.status(200).json(req.user);
});

router.get('/test', (req, res) => {
    db.query("SELECT * FROM CastCrew").then(results => {
        return res.status(200).json({data: results});
    });
    
});


// Get Profile Info
router.get('/:userId', (req, res) => {
    const userId = req.params.userId;
    const query = "SELECT * FROM User WHERE userId = ?";

    // TO DO: Implement security measures

    db.query(query,[userId]).then(results => {
        return res.status(200).json({data: results});
    });
    
});

// Edit First Name 
router.put('/firstName/:userId', (req, res) => {
    const userId = req.params.userId;
    const user = req.body;

    const query = "UPDATE User SET firstName = ? WHERE userId = ?";

    db.query(query,[user.firstName, userId]).then(results => {
        return res.status(200).json({data: results});
    });
    
});

// Edit Last Name
router.put('/lastName/:userId', (req, res) => {
    const userId = req.params.userId;
    const user = req.body;

    const query = "UPDATE User SET lastName = ? WHERE userId = ?";

    db.query(query,[user.lastName, userId]).then(results => {
        return res.status(200).json({data: results});
    });
    
});

// Edit Email
router.put('/email/:userId', (req, res) => {
    const userId = req.params.userId;
    const user = req.body;

    const query = "UPDATE User SET email = ? WHERE userId = ?";

    db.query(query,[user.email, userId]).then(results => {
        return res.status(200).json({data: results});
    });
    
});

// Edit Password
router.put('/password/:userId', (req, res) => {
    const userId = req.params.userId;
    const user = req.body;

    const query = "UPDATE User SET password = ? WHERE userId = ?";

    db.query(query,[user.password, userId]).then(results => {
        return res.status(200).json({data: results});
    });
    
});