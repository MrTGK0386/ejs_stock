const express = require('express');
const router = express.Router();
const Stock = require('../models/').mfgs_stock;
const User = require('../models').mfgs_users;
const {where} = require("sequelize");

router.post('/deleteUser', async (req, res) => {
    if (req.user) {
        const admin = req.user.admin;
        const userid = req.params.userid;
        console.log(userid,req.user);
        const userToDelete = User.findByPk(userid);

        console.log(userToDelete+'Post OK')

        if (admin === 1 || userid) {

            await userToDelete.destroy();

        } else {
            res.render('unauthorized', {});
        }
    }
})


module.exports = router;