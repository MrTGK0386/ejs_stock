const express = require('express');
const router = express.Router();

//

router.get('/', (req, res) => {
    if (req.user) {
        res.render('index', {email: req.user.email, admin: req.user.admin , buttonValue: null});
    } else {
        res.redirect('/auth/login');
    }
});

router.get('/test', (req, res) => {
    res.render('signup', {email: "test", admin: 1});
})

router.get('/dashboard', (req, res) => {
    if (req.user) {
        console.log("User is", req.user);
        res.render('index.ejs', {email: req.user.email, admin: req.user.admin, buttonValue: null});
    }  else {
        res.redirect('/auth/login');
    }

})


module.exports = router;