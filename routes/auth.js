const express = require('express');
const nodemailer = require('nodemailer');
const crypto = require('crypto');
const passport = require('passport');
const LocalStrategy = require('passport-local');
const User = require('../models/User');
const {underscoredIf} = require("sequelize/lib/utils");
const router = express.Router();

const transporter = nodemailer.createTransport({
    host: 'smtp.office365.com',
    port: 587,
    secure: false,
    auth: {
        user: 'scan@mfgs.fr',
        pass: '34Sc@n34!',
    },
    tls: {
        cipher: 'SSLv3'
    }
});

transporter.verify(function (error, success){
    if (error) {
        console.log(error);
    } else {
        console.log("Les SMTP est prêt pour envoyer des mails")
    }
});

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
    //console.log('Je serialize cet utilisateur :',user);
    if (user && user.id_users) {
        done(null, user.id_users);
    } else {
        done(new Error('Utilisateur non valide pour la sérialisation'));
    }
});

passport.deserializeUser((id, done) => {
    //console.log('Je Deserialize cet ID :',id);
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

router.post('/accountAsk',  (req, res) => {
    console.log("requête reçu", req.body);

    let DSIO_status = req.body.DSIO_status;
    let ADMIN_status = req.body.ADMIN_status;
    const email = req.body.email;

    if (DSIO_status == undefined){
        DSIO_status = "off"
    }
    if (ADMIN_status == undefined) {
        ADMIN_status = "off"
    }

    var askMail = {
        from: "scan@mfgs.fr",
        to: "hotline@mfgs.fr",
        subject: "Demande de création de compte | Stock MFGS",
        text: `Pourriez vous créer un compte dans le stock pour ${email} avec le status Admin : ${ADMIN_status} et le status membre de la DSI : ${DSIO_status}`,
    }

    transporter.sendMail(askMail, (error, info)=>{
        if(error){
            console.log(error);
        } else {
            console.log('Message envoyé : %s', info.messageId);
        }
    });

    res.render('validAsk');
});

router.get('/accountAsk', (req, res) => {
    const failed = req.query.failed;
    res.render('accountAsk', {failed: failed});
})
router.get('/logout', (req, res, next) => {
    req.logout(function(err) {
        if (err) { return next(err)}
        console.log ('Logged out')
        res.redirect('/');
    })
})


module.exports = router;