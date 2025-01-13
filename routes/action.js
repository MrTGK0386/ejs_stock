const express = require('express');
const router = express.Router();
const Stock = require('../models/').mfgs_stock;
const User = require('../models').mfgs_users;
const {where} = require("sequelize");

function isAuthenticated(req, res, next) {
    if (!req.user) {
        return res.status(401).render('unauthorized');
    }
    next();
}

function isAdmin(req, res, next) {
    if (!req.user.admin) {
        return res.status(403).render('unauthorized');
    }
    next();
}


router.post('/deleteUser/:userid', isAuthenticated, isAdmin, async (req, res) => {
    try {
        const userid = req.params.userid;
        const userToDelete = await User.findByPk(userid);
        if (!userToDelete) {
            return res.status(404).render('404', {pagetitle: 'Erreur 404'});
        }

        await userToDelete.destroy();
        return res.status(200).redirect('/dashboard/admin');
    } catch (error) {
        console.error(`Erreur lors de la suppression de l'utilisateur`,error);
        return res.status(500).render('error',{pagetitle:'Erreur 500',error:'500'});
    }
})

router.post('/addUser/', isAuthenticated, isAdmin, async (req, res) => {
    try {
        document.location.href = '/auth/signup';
    } catch (error) {
        console.error(`Page signup inaccessible`,error);
        return res.status(500).render('error',{pagetitle:'Erreur 500',error:'500'});
    }
})

router.post('/updateUser/:userid', isAuthenticated, isAdmin, async (req, res) => {
    try {

    } catch (error) {
        console.error(`Erreur lors de la modification de l'utilisateur`,error);
        return res.status(500).render('error',{pagetitle:'Erreur 500',error:'500'});
    }
})

router.post('/renewPassword/:userid', isAuthenticated, isAdmin, async (req, res) => {
    try {

    } catch (error) {
        console.error(`Erreur lors de la néinitialisation du mot de passe`,error);
    }
})

module.exports = router;