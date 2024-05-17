const express = require('express');
const crypto = require('crypto');
const passport = require('passport');
const LocalStrategy = require('passport-local');
const User = require('../models/User');
const router = express.Router();

passport.use(new LocalStrategy(async function verify(username, password, done) {
    try {
        const user = await User.findOne({where: { email: username}});
        if (!user) {
            return done(null, true, { message: 'Email incorrect' });
        }

        crypto.pbkdf2(password, user.salt, 310000, 32, 'sha512', async function(err, hashedPassword){
           if (err) { return done(err); }

           if (!crypto.timingSafeEqual(user.password, hashedPassword)) {
               return done(null, true, { message: 'Mot de passe incorrect' });
           }

           return done(null,user)
        })


    } catch (e) {
        return done(e);
    }
}));

passport.serializeUser((user, done) => {
    done(null, {id : user.id_users, email : user.email, admin : user.admin, dsio: user.dsio});
})
passport.deserializeUser((user, done) => {
    User.findByPk(user.id).then(user => {
        done(null, user);
    })
})

router.post('/login', passport.authenticate('local', {
    successRedirect: '/dashboard',
    failureRedirect: '/auth/login?failed=1',
}))


router.get('/login', (req, res) => {
    const failed = req.query.failed;
    res.render('login', {failed: failed});
})

/*
ancienne route, crash après l'enregistrement d'un nouvel utilisateur
router.post('/signup', (req, res) => {
    let salt = crypto.randomBytes(16);

    crypto.pbkdf2(req.body.password, salt, 310000, 32, 'sha256', async function(err, hashedPassword){
        if (err) {console.log('error while ashing the password'); res.redirect('/auth/signup?failed=ash');}

        try {
            const DSIO_Status = req.body.DSIO_status === 'on';
            const ADMIN_Status = req.body.ADMIN_status === 'on';
            const user = await User.create({email: req.body.email, password: hashedPassword.toString("base64"), salt:salt.toString("base64"), dsio: DSIO_Status, admin: ADMIN_Status});

            req.login(user, function(err) {
                if (err) {
                    console.log(err);
                    res.redirect('/auth/login?failed=login');}
                res.redirect('/')

            })
        } catch (e) {
            console.log('undefined error while creating the user',e)
            res.redirect('/auth/signup?failed=notUnique');
        }
    })
}) */

router.post('/signup', async (req, res) => {
    try {
        let salt = crypto.randomBytes(16);
        const hashedPassword = crypto.pbkdf2Sync(req.body.password, salt, 310000, 32, 'sha256');
        const DSIO_Status = req.body.DSIO_status === 'on';
        const ADMIN_Status = req.body.ADMIN_status === 'on';
        const user = await User.create({ email: req.body.email, password: hashedPassword, salt: salt, dsio: DSIO_Status, admin: ADMIN_Status });

        // Si aucune erreur n'a été rencontrée, redirigez l'utilisateur
        return res.redirect('/');
    } catch (e) {
        return res.redirect('/auth/signup?failed=notUnique');
    }
});
router.get('/signup', (req, res) => {
    const failed = req.query.failed;
    res.render('signup', {failed: failed});
})
router.post('/logout', (req, res) => {
    res.render('logout');
})


module.exports = router;