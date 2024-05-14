const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    if (req.user) {
        res.render('index', {username: req.user.email, admin: req.user.admin , buttonValue: null});
    } else {
        res.redirect('/auth/login');
    }
});

router.get('/test', (req, res) => {
    res.render('signup', {username: "test", admin: 1});
})


module.exports = router;