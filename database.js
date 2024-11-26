const { Sequelize } = require("sequelize");

const sequelize = new Sequelize('mfgs','stock_manager','51V6VIko', {
    host: "localhost",
    port: "13306",
    dialect: "mariadb",
})

module.exports = sequelize;