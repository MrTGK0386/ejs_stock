const express = require('express');
const router = express.Router();
const Stock = require('../models/').mfgs_stock;
const User = require('../models').mfgs_users;
const {where} = require("sequelize");

function isAuthenticated(req, res, next) {
    if (!req.user) {
        return res.redirect('/auth/login');
    }
    next();
}

function isAdmin(req, res, next) {
    if (!req.user.admin) {
        return res.status(403).render('unauthorized');
    }
    next();
}

router.get('/', isAuthenticated, (req, res) => {
    res.render('index', {email: req.user.email, admin: req.user.admin , buttonValue: null});
});

router.get('/dashboard',isAuthenticated, async(req, res) => {
        const pagetitle = "Gestionnaire de stock"
        //console.log(rows[1].nom_produit); //Pour atteindre les propriété des produits il suffit de demander la ligne à laquelle il sont puis afficher le paramètre qui nous interesse
        res.render('index.ejs', {email: req.user.email, admin: req.user.admin, pagetitle: pagetitle});
})

router.get('/dashboard/admin', isAuthenticated, isAdmin, async (req, res) => {
    const rows = await User.findAll()
    const pagetitle = "Administration";
    res.render('adminpage.ejs', {email: req.user.email, admin: req.user.admin, rows: rows, pagetitle: pagetitle});

})

router.get('/dashboard/stock', isAuthenticated, async (req, res) => {
   const rows = await Stock.findAll()
   const pagetitle = "Visualisation des stock";
   res.render('stock',{rows: rows, pagetitle: pagetitle})

})

router.get('/dashboard/sortie', isAuthenticated, async (req, res) => {
        const pagetitle = "Sortir du stock";
        res.render('sortie',{pagetitle: pagetitle})
})

router.get('/dashboard/entree', isAuthenticated, async (req, res) => {

        const pagetitle = "Entrer dans le stock";
        res.render('entree',{pagetitle: pagetitle})

})

router.get('/dashboard/scanning', isAuthenticated, async (req, res) => {

        const pagetitle = "Scanner";
        res.render('scanning',{pagetitle: pagetitle});
})


module.exports = router;