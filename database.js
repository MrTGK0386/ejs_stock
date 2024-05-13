const { Sequelize } = require("sequelize");

const sequelize = new Sequelize('mfgs','root','', {
    host: "localhost",
    port: "13306",
    dialect: "mariadb",
})

module.exports = sequelize;