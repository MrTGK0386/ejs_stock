const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('mfgs_stock', {
    id_stock: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    nom_produit: {
      type: DataTypes.STRING(255),
      allowNull: false,
      unique: "nom_produit"
    },
    appellation: {
      type: DataTypes.STRING(255),
      allowNull: false,
      unique: "appellation"
    },
    prix: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    stock: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    stock_min: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'mfgs_stock',
    timestamps: true,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id_stock" },
        ]
      },
      {
        name: "nom_produit",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "nom_produit" },
        ]
      },
      {
        name: "appellation",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "appellation" },
        ]
      },
    ]
  });
};
