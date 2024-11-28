const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('mfgs_fournisseur', {
    id_fournisseur: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    nom_fournisseur: {
      type: DataTypes.STRING(50),
      allowNull: true,
      unique: "nom_fournisseur"
    }
  }, {
    sequelize,
    tableName: 'mfgs_fournisseur',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id_fournisseur" },
        ]
      },
      {
        name: "nom_fournisseur",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "nom_fournisseur" },
        ]
      },
    ]
  });
};
