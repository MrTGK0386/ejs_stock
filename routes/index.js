const express = require('express');
const router = express.Router();
const Stock = require('../models/mfgs_stock');
const User = require('../models/mfgs_users');
const {where} = require("sequelize");

//

router.get('/', (req, res) => {
    // Vérification d'authentification
    if (req.user) {
        res.render('index', {email: req.user.email, admin: req.user.admin , buttonValue: null});
    } else {
        res.redirect('/auth/login');
    }
});

router.get('/dashboard', async(req, res) => {
    if (req.user) {
        //Récupération de la table stock_mfgs
        //const rows = await Stock.findAll()
        const pagetitle = "Gestionnaire de stock"
        //console.log(rows[1].nom_produit); //Pour atteindre les propriété des produits il suffit de demander la ligne à laquelle il sont puis afficher le paramètre qui nous interesse
        res.render('index.ejs', {email: req.user.email, admin: req.user.admin, pagetitle: pagetitle});
    }  else {
        res.redirect('/auth/login');
    }

})

router.get('/dashboard/admin', async (req, res) => {
    if (req.user) {
        const rows = await User.findAll()
        const pagetitle = "Administration";
        if (req.user.admin) {
            res.render('adminpage.ejs', {email: req.user.email, admin: req.user.admin, rows: rows, pagetitle: pagetitle});
        }
        else {
            res.redirect('/auth/unauthorized');
        }
    } else {
        res.redirect('/auth/login');
    }
})

router.get('/dashboard/stock', async (req, res) => {
    if (req.user) {
        const rows = await Stock.findAll()
        const pagetitle = "Visualisation des stock";
        res.render('stock',{rows: rows, pagetitle: pagetitle})
    } else {
        res.redirect('/auth/login');
    }
})

router.get('/dashboard/sortie', async (req, res) => {
    if (req.user) {
        const pagetitle = "Sortir du stock";
        res.render('sortie',{pagetitle: pagetitle})
    } else {
        res.redirect('/auth/login');
    }
})

router.get('/dashboard/entree', async (req, res) => {
    if (req.user) {
        const pagetitle = "Entrer dans le stock";
        res.render('entree',{pagetitle: pagetitle})
    } else {
        res.redirect('/auth/login');
    }
})

router.get('/dashboard/scanning', async (req, res) => {
    if (req.user) {
        const pagetitle = "Scanner";
        res.render('scanning',{pagetitle: pagetitle});
    } else {
        res.redirect('/auth/login');
    }
})


module.exports = router;