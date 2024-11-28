const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('mfgs_destination', {
    id_destination: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    nom_destination: {
      type: DataTypes.STRING(50),
      allowNull: true,
      unique: "nom_destination"
    }
  }, {
    sequelize,
    tableName: 'mfgs_destination',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id_destination" },
        ]
      },
      {
        name: "nom_destination",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "nom_destination" },
        ]
      },
    ]
  });
};
