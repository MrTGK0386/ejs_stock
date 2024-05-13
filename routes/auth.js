const express = require('express');
const crypto = require('crypto');
const passport = require('passport');
const localStrategy = require('passport-local').Strategy;
const User = require('../models/user');
const router = express.Router();

passport.use(new localStrategy(async function verify(username, password, done) {
    try {
        const user = await User.findOne({ where: {email: email}});
        if (!user) {
            return done(null, false, { message: 'User does not exist' });
        }

    } catch (e) {

    }
}));
router.get('/login', (req, res) => {
    res.render('login');
})

router.post('/signup', (req, res) => {
    let salt = crypto.randomBytes(16);
    crypto.pbkdf2(req.body.password, salt, 310000, 32, 'sha512', async function(err, hashedPassword){
        if (err) {res.redirect('/auth/signup?failed=ash');}

        try {
            const user = await User.create({email: req.body.email, password: hashedPassword, salt:salt, dsio: req.body.dsio, admin: req.body.admin});

            req.login(user, function(err) {
                if (err) {res.redirect('/auth/login?failed=login');}
                res.redirect('/')
            })
        } catch (e) {
            res.redirect('/auth/signup?failed=notUnique');
        }
    })
})
router.get('/logout', (req, res) => {
    res.render('logout');
})

module.exports = router;