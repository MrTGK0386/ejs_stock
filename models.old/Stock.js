const { Model, DataTypes} = require("sequelize");
const sequelize = require("../database");

class Stock extends Model {}

Stock.init({
        id_stock : {
            type: DataTypes.INTEGER,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true,
        },
        nom_produit : {
            type: DataTypes.STRING,
            allowNull: false,
            unique: true,
        },
        appellation : {
            type: DataTypes.STRING,
            allowNull: false,
        },
        prix : {
            type: DataTypes.FLOAT,
            allowNull: false,
        },
        stock : {
            type: DataTypes.INTEGER,
            allowNull: false,
        },
        stock_min : {
            type: DataTypes.INTEGER,
            allowNull: true,
            defaultValue: 0,
        }
        },
    {
        sequelize,
        modelName: "Stock",
        tableName: "mfgs_stock",
    })

module.exports = Stock;