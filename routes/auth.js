const express = require('express');
const nodemailer = require('nodemailer');
const crypto = require('crypto');
const passport = require('passport');
const LocalStrategy = require('passport-local');
const User = require('../models').mfgs_users;
const {underscoredIf} = require("sequelize/lib/utils");
const router = express.Router();

//--- Création du mailer Nodemailer ---//
const transporter = nodemailer.createTransport({
    host: 'smtp.office365.com', //smtp de l'entreprise
    port: 587,
    secure: false,
    auth: {
        user: 'scan@mfgs.fr', //adresse de l'envoyeur
        pass: '34Sc@n34!', //mot de passe de l'envoyeur
    },
    tls: {
        cipher: 'SSLv3' //stratégie de sécurité
    }
});

//--- test de connexion au smtp (c'est long en général) ---//
transporter.verify(function (error, success){
    if (error) {
        console.log(error);
    } else {
        console.log("Les SMTP est prêt pour envoyer des mails")
    }
});

//--- Middleware Passport qui contrôle la connexion des uilisateur ---//
passport.use(new LocalStrategy(async function verify(username, password, done) {
    try {
        const user = await User.findOne({where: { email: username}}); //test de vérification d'existence dans la db
        if (!user) {
            return done(null, false, { message: 'Email incorrect' });
        }

        //Hachage du mdp
        crypto.pbkdf2(password, user.salt, 310000, 32, 'sha256', async function(err, hashedPassword){
           if (err) { return done(err); }

           //Controle dans la db du hash du mdp et du user
           if (!crypto.timingSafeEqual(user.password, hashedPassword)) {
               return done(null, false, { message: 'Mot de passe incorrect' });
           }

           return done(null,user)
        })

    } catch (e) {
        return done(e);
    }
}));

//Récupération des informations de l'utilisateur dans la DB et création d'une variable passport associé
passport.serializeUser((user, done) => {
    //console.log('Je serialize cet utilisateur :',user);
    if (user && user.id_users) {
        done(null, user.id_users);
    } else {
        done(new Error('Utilisateur non valide pour la sérialisation'));
    }
});

//Ajout de la variable passport précédement créée dans la Session Express
passport.deserializeUser((id, done) => {
    //console.log('Je Deserialize cet ID :',id);
    User.findByPk(id).then(user => {
        done(null, user);
    })
})

router.post('/login', passport.authenticate('local', { //Utilisation du middleware passport lors de la requête formulaie,redirecton en fonction du résultat
    successRedirect: '/dashboard',
    failureRedirect: '/auth/login?failed=1',
}))


router.get('/login', (req, res) => {
    const failed = req.query.failed;
    res.render('login', {failed: failed});
})

router.post('/signup', async (req, res) => { //Application du formulaire de création utilisateur
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
    //Ces variables permettent le remplissage automatique et la vérification d'accés sur la page Signup
    const failed = req.query.failed;
    const fromMail = req.query.fromMail;
    const DSIO_status = req.query.DSIO_status;
    const ADMIN_status = req.query.ADMIN_status;
    const email = req.query.email;

    res.render('signup', {failed: failed, email: email, ADMIN_status: ADMIN_status, DSIO_status: DSIO_status, fromMail: fromMail});
})

router.post('/accountAsk',  (req, res) => { //Action après le formulaire de demande de compte
    //console.log("requête reçu", req.body);

    //Transfert des valeur du formulaire dans des variable
    let DSIO_status = req.body.DSIO_status;
    let ADMIN_status = req.body.ADMIN_status;
    const email = req.body.email;

    if (DSIO_status == undefined){ //traduction des case vide en Non et Oui si la case est coché
        DSIO_status = "Non"
    } else {
        DSIO_status = "Oui"
    }
    if (ADMIN_status == undefined) {
        ADMIN_status = "Non"
    } else {
        ADMIN_status = "Oui"
    }

    //Création de l'URL de redirection en fonction information rentrée par l'utilisateur
    const url = `http://localhost:34090/auth/signup?email=${encodeURIComponent(email)}&ADMIN_status=${encodeURIComponent(ADMIN_status)}&DSIO_status=${encodeURIComponent(DSIO_status)}&fromMail=true`;



    var askMail = { //Création d'un email dynamique et remplissage avec les valeurs du formulaire
        from: "scan@mfgs.fr",
        to: "et.garcia@mfgs.fr",
        subject: "Demande de création de compte | Stock MFGS",
        text: `Pourriez vous créer un compte dans le stock pour ${email} avec le status Admin : ${ADMIN_status} et le status membre de la DSI : ${DSIO_status}`,
        html:  `
        <!DOCTYPE html>
        <html lang="fr">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Demande de création de compte</title>
        </head>
        <body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; margin: 0; padding: 0; background-color: #f4f4f4;">
            <div style="width: 80%; margin: auto; overflow: hidden; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
                <div style="text-align: center; background: #e10613; color: #fff; padding: 10px 0; border-radius: 8px 8px 0 0;">
                    <h1 style="margin: 0; font-size: 24px;">Demande de création de compte</h1>
                </div>
                <div style="padding: 20px;">
                    <p>Bonjour,</p>
                    <p>Vous avez reçu une demande de création de compte. Veuillez trouver ci-dessous les détails :</p>
                    <ul>
                        <li>Email du demandeur : ${email}</li>
                        <li>Besoin de droit administrateur : ${ADMIN_status}</li>
                        <li>Membre du service informatique : ${DSIO_status}</li>
                    </ul>
                    <div style="text-align: center; margin: 20px 0;">
                        <a href="${url}" style="background: #28a745; color: #fff; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-size: 16px; display: inline-block;">Créer le compte</a>
                    </div>
                    <p>Merci,</p>
                </div>
            </div>
        </body>
        </html>
    `, // Code du mail en HTML avec un bouton de redirection, CSS en inline
    }

    transporter.sendMail(askMail, (error, info)=>{ //Envoie du mail
        if(error){
            console.log(error);
        } else {
            console.log('Message envoyé : %s', info.messageId);
        }
    });

    res.render('validAsk'); //Renvoie sur la page de confirmation
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

router.get('/unauthorized', (req, res) => {
    res.render('unauthorized');
})


module.exports = router;