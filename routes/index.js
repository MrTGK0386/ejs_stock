const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    if (req.user) {
        res.render('index', {username: req.user.email, admin: 1 , buttonValue: buttonValue});
    } else {
        res.redirect('/auth/login');
    }
});

router.get('/test', (req, res) => {
    res.render('signup', {username: "test", admin: 1});
})


module.exports = router;