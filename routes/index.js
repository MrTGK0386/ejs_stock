const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    if (req.user) {
        res.render('index', {username: req.user.email, admin: 1 , buttonValue: buttonValue});
    } else {
        res.redirect('/auth/login');
    }
});


module.exports = router;