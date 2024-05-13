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
        allowNull: true,
        unique: true,
    },
    salt : {
        type: DataTypes.STRING,
        allowNull: false,
    }
    },
    {
        sequelize,
            modelName: "User",
})