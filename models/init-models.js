var DataTypes = require("sequelize").DataTypes;
var _mfgs_command = require("./mfgs_command");
var _mfgs_destination = require("./mfgs_destination");
var _mfgs_entree = require("./mfgs_entree");
var _mfgs_fournisseur = require("./mfgs_fournisseur");
var _mfgs_sortie = require("./mfgs_sortie");
var _mfgs_stock = require("./mfgs_stock");
var _mfgs_users = require("./mfgs_users");
var _sequelizemeta = require("./sequelizemeta");

function initModels(sequelize) {
  var mfgs_command = _mfgs_command(sequelize, DataTypes);
  var mfgs_destination = _mfgs_destination(sequelize, DataTypes);
  var mfgs_entree = _mfgs_entree(sequelize, DataTypes);
  var mfgs_fournisseur = _mfgs_fournisseur(sequelize, DataTypes);
  var mfgs_sortie = _mfgs_sortie(sequelize, DataTypes);
  var mfgs_stock = _mfgs_stock(sequelize, DataTypes);
  var mfgs_users = _mfgs_users(sequelize, DataTypes);
  var sequelizemeta = _sequelizemeta(sequelize, DataTypes);

  mfgs_entree.belongsTo(mfgs_command, { as: "num_bl_mfgs_command", foreignKey: "num_bl"});
  mfgs_command.hasMany(mfgs_entree, { as: "mfgs_entrees", foreignKey: "num_bl"});
  mfgs_sortie.belongsTo(mfgs_command, { as: "num_bl_mfgs_command", foreignKey: "num_bl"});
  mfgs_command.hasMany(mfgs_sortie, { as: "mfgs_sorties", foreignKey: "num_bl"});
  mfgs_command.belongsTo(mfgs_destination, { as: "destination_mfgs_destination", foreignKey: "destination"});
  mfgs_destination.hasMany(mfgs_command, { as: "mfgs_commands", foreignKey: "destination"});
  mfgs_sortie.belongsTo(mfgs_entree, { as: "id_entree_mfgs_entree", foreignKey: "id_entree"});
  mfgs_entree.hasMany(mfgs_sortie, { as: "mfgs_sorties", foreignKey: "id_entree"});
  mfgs_command.belongsTo(mfgs_fournisseur, { as: "fournisseur_mfgs_fournisseur", foreignKey: "fournisseur"});
  mfgs_fournisseur.hasMany(mfgs_command, { as: "mfgs_commands", foreignKey: "fournisseur"});
  mfgs_command.belongsTo(mfgs_stock, { as: "nom_produit_mfgs_stock", foreignKey: "nom_produit"});
  mfgs_stock.hasMany(mfgs_command, { as: "mfgs_commands", foreignKey: "nom_produit"});
  mfgs_command.belongsTo(mfgs_stock, { as: "appellation_mfgs_stock", foreignKey: "appellation"});
  mfgs_stock.hasMany(mfgs_command, { as: "appellation_mfgs_commands", foreignKey: "appellation"});
  mfgs_entree.belongsTo(mfgs_stock, { as: "nom_produit_mfgs_stock", foreignKey: "nom_produit"});
  mfgs_stock.hasMany(mfgs_entree, { as: "mfgs_entrees", foreignKey: "nom_produit"});
  mfgs_entree.belongsTo(mfgs_stock, { as: "appellation_mfgs_stock", foreignKey: "appellation"});
  mfgs_stock.hasMany(mfgs_entree, { as: "appellation_mfgs_entrees", foreignKey: "appellation"});
  mfgs_sortie.belongsTo(mfgs_stock, { as: "nom_produit_mfgs_stock", foreignKey: "nom_produit"});
  mfgs_stock.hasMany(mfgs_sortie, { as: "mfgs_sorties", foreignKey: "nom_produit"});
  mfgs_sortie.belongsTo(mfgs_stock, { as: "appellation_mfgs_stock", foreignKey: "appellation"});
  mfgs_stock.hasMany(mfgs_sortie, { as: "appellation_mfgs_sorties", foreignKey: "appellation"});
  mfgs_entree.belongsTo(mfgs_users, { as: "user_mfgs_user", foreignKey: "user"});
  mfgs_users.hasMany(mfgs_entree, { as: "mfgs_entrees", foreignKey: "user"});
  mfgs_sortie.belongsTo(mfgs_users, { as: "user_mfgs_user", foreignKey: "user"});
  mfgs_users.hasMany(mfgs_sortie, { as: "mfgs_sorties", foreignKey: "user"});

  return {
    mfgs_command,
    mfgs_destination,
    mfgs_entree,
    mfgs_fournisseur,
    mfgs_sortie,
    mfgs_stock,
    mfgs_users,
    sequelizemeta,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
