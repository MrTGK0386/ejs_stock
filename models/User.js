const { Model, DataTypes} = require("sequelize");
const sequelize = require("../database");

class User extends Model {}

User.init({
    id_users : {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
    },
    password : {
        type: DataTypes.STRING,
        allowNull: false,
    },
    email : {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
    },
    salt : {
        type: DataTypes.STRING,
        allowNull: false,
    },
    dsio : {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
    },
    admin : {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
    }
    },
    {
        sequelize,
            modelName: "User",
        tableName: "mfgs_users",
})

module.exports = User