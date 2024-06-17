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
            console.log("utilisateur introuvable")
            return done(null, false, { message: 'Email incorrect' });
        }

        crypto.pbkdf2(password, user.salt, 310000, 32, 'sha256', async function(err, hashedPassword){
           if (err) { return done(err); }

           if (!crypto.timingSafeEqual(user.password, hashedPassword)) {
               return done(null, false, { message: 'Mot de passe incorrect' });
           }

           return done(null,user)
        })


    } catch (e) {
        return done(e);
    }
}));

passport.serializeUser((user, done) => {
    console.log('Je serialize cet utilisateur :',user);
    if (user && user.id_users) {
        done(null, user.id_users);
    } else {
        done(new Error('Utilisateur non valide pour la sérialisation'));
    }
});

passport.deserializeUser((id, done) => {
    console.log('Je Deserialize cet ID :',id);
    User.findByPk(id).then(user => {
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