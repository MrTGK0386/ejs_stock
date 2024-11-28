const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('mfgs_entree', {
    id_entree: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    date: {
      type: DataTypes.DATE,
      allowNull: false
    },
    serie: {
      type: DataTypes.STRING(250),
      allowNull: true
    },
    nom_produit: {
      type: DataTypes.STRING(255),
      allowNull: false,
      references: {
        model: 'mfgs_stock',
        key: 'nom_produit'
      }
    },
    appellation: {
      type: DataTypes.STRING(255),
      allowNull: false,
      references: {
        model: 'mfgs_stock',
        key: 'appellation'
      }
    },
    num_bl: {
      type: DataTypes.STRING(50),
      allowNull: true,
      references: {
        model: 'mfgs_command',
        key: 'num_bl'
      }
    },
    user: {
      type: DataTypes.STRING(100),
      allowNull: true,
      references: {
        model: 'mfgs_users',
        key: 'email'
      }
    }
  }, {
    sequelize,
    tableName: 'mfgs_entree',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id_entree" },
        ]
      },
      {
        name: "nom_produit",
        using: "BTREE",
        fields: [
          { name: "nom_produit" },
        ]
      },
      {
        name: "appellation",
        using: "BTREE",
        fields: [
          { name: "appellation" },
        ]
      },
      {
        name: "num_bl",
        using: "BTREE",
        fields: [
          { name: "num_bl" },
        ]
      },
      {
        name: "user",
        using: "BTREE",
        fields: [
          { name: "user" },
        ]
      },
    ]
  });
};
