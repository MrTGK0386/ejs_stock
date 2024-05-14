const express = require('express');
const crypto = require('crypto');
const passport = require('passport');
const localStrategy = require('passport-local');
const User = require('../models/User');
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
    console.log('Received signup request with data:', req.body);
    let salt = crypto.randomBytes(16);

    crypto.pbkdf2(req.body.password, salt, 310000, 32, 'sha256', async function(err, hashedPassword){
        if (err) {console.log('error while ashing the password'); res.redirect('/auth/signup?failed=ash');}

        try {
            const DSIO_Status = req.body.DSIO_status === 'on';
            const ADMIN_Status = req.body.ADMIN_status === 'on';
            const user = await User.create({email: req.body.email, password: hashedPassword.toString("base64"), salt:salt.toString("base64"), dsio: DSIO_Status, admin: ADMIN_Status});

            req.login(user, function(err) {
                if (err) {res.redirect('/auth/login?failed=login');}
                res.redirect('/')
            })
        } catch (e) {
            console.log('undefined error while creating the user',e)
            console.log(salt.toString('base64'),hashedPassword.toString('base64'));
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