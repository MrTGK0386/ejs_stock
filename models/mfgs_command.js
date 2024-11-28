const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('mfgs_command', {
    id_command: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    date: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    num_command: {
      type: DataTypes.STRING(80),
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
    qte: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    prix: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    total: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    fournisseur: {
      type: DataTypes.STRING(50),
      allowNull: true,
      references: {
        model: 'mfgs_fournisseur',
        key: 'nom_fournisseur'
      }
    },
    destination: {
      type: DataTypes.STRING(50),
      allowNull: true,
      references: {
        model: 'mfgs_destination',
        key: 'nom_destination'
      }
    },
    recu: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    sortie: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    num_bl: {
      type: DataTypes.STRING(50),
      allowNull: true,
      unique: "num_bl"
    }
  }, {
    sequelize,
    tableName: 'mfgs_command',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id_command" },
        ]
      },
      {
        name: "num_bl",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "num_bl" },
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
        name: "fournisseur",
        using: "BTREE",
        fields: [
          { name: "fournisseur" },
        ]
      },
      {
        name: "destination",
        using: "BTREE",
        fields: [
          { name: "destination" },
        ]
      },
    ]
  });
};
