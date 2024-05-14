const express = require('express');
const crypto = require('crypto');
const passport = require('passport');
const localStrategy = require('passport-local');
const User = require('../models/user');
const router = express.Router();

passport.use(new localStrategy(async function verify(email, password, done) {
    try {
        const user = await User.findOne({ where: {email: email}});
        if (!user) {
            return done(null, false, { message: 'Email ou mot de passe incorrect' });
        }

        crypto.pbkdf2(password, user.salt, 310000, 32, 'sha512', async function(err, hashedPassword){
           if (err) { return done(err); }

           if (!crypto.timingSafeEqual(user.password, hashedPassword)) {
               return done(null, false, { message: 'Email ou mot de passe incorrect' });
           }

           return done(null,user)
        })

    } catch (e) {
        return done(e);
    }
}));

passport.serializeUser((user, done) => {
    done(null, user.id);
})
passport.deserializeUser((id, done) => {
    User.findByPk(id).then(user => {
        done(null, user);
    })
})

router.post('/login', passport.authenticate('local', {
    failureRedirect: '/auth/login?failed=notFound',
    successRedirect: '/',
}), (req, res) => {})

router.get('/login', (req, res) => {
    const failed = req.query.failed;
    res.render('login', {failed: failed});
})

router.post('/signup', (req, res) => {
    let salt = crypto.randomBytes(16);
    crypto.pbkdf2(req.body.password, salt, 310000, 32, 'sha512', async function(err, hashedPassword){
        if (err) {res.redirect('/auth/signup?failed=ash');}

        try {
            const user = await User.create({email: req.body.email, password: hashedPassword, salt:salt, dsio: req.body.DSIO_status, admin: req.body.ADMIN_status});

            req.login(user, function(err) {
                if (err) {res.redirect('/auth/login?failed=login');}
                res.redirect('/')
            })
        } catch (e) {
            res.redirect('/auth/signup?failed=notUnique');
        }
    })
})
router.get('/signup', (req, res) => {
    const failed = req.query.failed;
    res.render('signup', {failed: failed});
})
router.get('/logout', (req, res) => {
    res.render('logout');
})

module.exports = router;