-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           11.4.4-MariaDB - mariadb.org binary distribution
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour mfgs
CREATE DATABASE IF NOT EXISTS `mfgs` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `mfgs`;

-- Listage de la structure de table mfgs. mfgs_command
CREATE TABLE IF NOT EXISTS `mfgs_command` (
  `id_command` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `num_command` varchar(80) DEFAULT NULL,
  `nom_produit` varchar(255) NOT NULL,
  `appellation` varchar(255) NOT NULL,
  `qte` int(11) NOT NULL,
  `prix` int(11) NOT NULL,
  `total` int(11) GENERATED ALWAYS AS (`prix` * `qte`) VIRTUAL,
  `fournisseur` varchar(50) DEFAULT NULL,
  `destination` varchar(50) DEFAULT NULL,
  `recu` int(11) NOT NULL DEFAULT 0,
  `sortie` int(11) NOT NULL DEFAULT 0,
  `num_bl` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_command`),
  UNIQUE KEY `num_bl` (`num_bl`),
  KEY `nom_produit` (`nom_produit`),
  KEY `appellation` (`appellation`),
  KEY `fournisseur` (`fournisseur`),
  KEY `destination` (`destination`),
  CONSTRAINT `mfgs_command_ibfk_1` FOREIGN KEY (`nom_produit`) REFERENCES `mfgs_stock` (`nom_produit`),
  CONSTRAINT `mfgs_command_ibfk_2` FOREIGN KEY (`appellation`) REFERENCES `mfgs_stock` (`appellation`),
  CONSTRAINT `mfgs_command_ibfk_3` FOREIGN KEY (`fournisseur`) REFERENCES `mfgs_fournisseur` (`nom_fournisseur`),
  CONSTRAINT `mfgs_command_ibfk_4` FOREIGN KEY (`destination`) REFERENCES `mfgs_destination` (`nom_destination`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table mfgs.mfgs_command : ~2 rows (environ)
INSERT INTO `mfgs_command` (`id_command`, `date`, `num_command`, `nom_produit`, `appellation`, `qte`, `prix`, `fournisseur`, `destination`, `recu`, `sortie`, `num_bl`) VALUES
	(2, '2023-08-09', 'er842er', 'Borne CISCO IP DECT 210 Multi-Cell Base Station', 'station d\'accueil pour téléphone sans fil / station d\'accueil pour téléphone VoIP avec ID d\'appelant - IP-DECT - (conférence) à trois capacité d\'appel - SIP, SRTP', 5, 453, 'KEYPROLINE', 'CMJL', 0, 0, '5413521698'),
	(3, '2023-08-16', '4534534', 'Tablette Samsung Galaxy Tab A8', 'Samsung Galaxy Tab A8 10.5"" 32 Go Wifi Gris (FR version)', 45, 453, 'XEFI', 'SIEGE', 0, 0, NULL);

-- Listage de la structure de table mfgs. mfgs_destination
CREATE TABLE IF NOT EXISTS `mfgs_destination` (
  `id_destination` int(11) NOT NULL AUTO_INCREMENT,
  `nom_destination` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_destination`),
  UNIQUE KEY `nom_destination` (`nom_destination`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table mfgs.mfgs_destination : ~7 rows (environ)
INSERT INTO `mfgs_destination` (`id_destination`, `nom_destination`) VALUES
	(1, 'AUD-PEZ'),
	(7, 'CMJL'),
	(3, 'DENT-GRI'),
	(4, 'ESA-PEZ'),
	(2, 'OPT-PEZ'),
	(5, 'SIEGE'),
	(6, 'VA');

-- Listage de la structure de table mfgs. mfgs_entree
CREATE TABLE IF NOT EXISTS `mfgs_entree` (
  `id_entree` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `serie` varchar(250) DEFAULT NULL,
  `nom_produit` varchar(255) NOT NULL,
  `appellation` varchar(255) NOT NULL,
  `num_bl` varchar(50) DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_entree`),
  KEY `nom_produit` (`nom_produit`),
  KEY `appellation` (`appellation`),
  KEY `num_bl` (`num_bl`),
  KEY `user` (`user`),
  CONSTRAINT `mfgs_entree_ibfk_1` FOREIGN KEY (`nom_produit`) REFERENCES `mfgs_stock` (`nom_produit`),
  CONSTRAINT `mfgs_entree_ibfk_2` FOREIGN KEY (`appellation`) REFERENCES `mfgs_stock` (`appellation`),
  CONSTRAINT `mfgs_entree_ibfk_3` FOREIGN KEY (`num_bl`) REFERENCES `mfgs_command` (`num_bl`),
  CONSTRAINT `mfgs_entree_ibfk_4` FOREIGN KEY (`user`) REFERENCES `mfgs_users` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table mfgs.mfgs_entree : ~2 rows (environ)
INSERT INTO `mfgs_entree` (`id_entree`, `date`, `serie`, `nom_produit`, `appellation`, `num_bl`, `user`) VALUES
	(1, '2023-08-18 14:31:50', '48485efze5', 'Chargeur Iphone USB-C lighting', 'TECHTEK Batteries Compatible avec [Doro] 1350, 1361, 6520, 6530, DFC-0160, Primo 401, Primo 805, pour [Brondi] Amico AMPLI VOX, Amico Schlicht, Simple Friend remplace DBR-800B, pour W11 FBA', '5413521698', 'et.garcia@mfgs.fr'),
	(2, '2023-08-18 14:34:45', '48485efze5', 'Chargeur Iphone USB-C lighting', 'TECHTEK Batteries Compatible avec [Doro] 1350, 1361, 6520, 6530, DFC-0160, Primo 401, Primo 805, pour [Brondi] Amico AMPLI VOX, Amico Schlicht, Simple Friend remplace DBR-800B, pour W11 FBA', '5413521698', 'et.garcia@mfgs.fr');

-- Listage de la structure de table mfgs. mfgs_fournisseur
CREATE TABLE IF NOT EXISTS `mfgs_fournisseur` (
  `id_fournisseur` int(11) NOT NULL AUTO_INCREMENT,
  `nom_fournisseur` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_fournisseur`),
  UNIQUE KEY `nom_fournisseur` (`nom_fournisseur`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table mfgs.mfgs_fournisseur : ~12 rows (environ)
INSERT INTO `mfgs_fournisseur` (`id_fournisseur`, `nom_fournisseur`) VALUES
	(3, 'ACCORD DISTRIBUTION'),
	(2, 'AMAZON'),
	(12, 'COSIUM'),
	(7, 'DISTRIMED'),
	(6, 'INGELAN'),
	(4, 'KEYPROLINE'),
	(9, 'NUMATIC'),
	(8, 'NXO'),
	(11, 'OPTICON'),
	(10, 'SAMSUNG'),
	(5, 'SECOMP'),
	(1, 'XEFI');

-- Listage de la structure de table mfgs. mfgs_sortie
CREATE TABLE IF NOT EXISTS `mfgs_sortie` (
  `id_sortie` int(11) NOT NULL AUTO_INCREMENT,
  `id_entree` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  `serie` varchar(250) DEFAULT NULL,
  `nom_produit` varchar(255) NOT NULL,
  `appellation` varchar(255) NOT NULL,
  `num_bl` varchar(50) DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_sortie`),
  KEY `id_entree` (`id_entree`),
  KEY `nom_produit` (`nom_produit`),
  KEY `appellation` (`appellation`),
  KEY `num_bl` (`num_bl`),
  KEY `user` (`user`),
  CONSTRAINT `mfgs_sortie_ibfk_1` FOREIGN KEY (`id_entree`) REFERENCES `mfgs_entree` (`id_entree`),
  CONSTRAINT `mfgs_sortie_ibfk_2` FOREIGN KEY (`nom_produit`) REFERENCES `mfgs_stock` (`nom_produit`),
  CONSTRAINT `mfgs_sortie_ibfk_3` FOREIGN KEY (`appellation`) REFERENCES `mfgs_stock` (`appellation`),
  CONSTRAINT `mfgs_sortie_ibfk_4` FOREIGN KEY (`num_bl`) REFERENCES `mfgs_command` (`num_bl`),
  CONSTRAINT `mfgs_sortie_ibfk_5` FOREIGN KEY (`user`) REFERENCES `mfgs_users` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table mfgs.mfgs_sortie : ~1 rows (environ)
INSERT INTO `mfgs_sortie` (`id_sortie`, `id_entree`, `date`, `serie`, `nom_produit`, `appellation`, `num_bl`, `user`) VALUES
	(1, 1, '2023-08-18 14:31:59', '48485efze5', 'Chargeur Iphone USB-C lighting', 'BENFEI Adaptateur Displayport vers HDMI, convertisseur DP (Display Port) mâle vers Hdmi Femelle', '5413521698', 'hotline@mfgs.fr');

-- Listage de la structure de table mfgs. mfgs_stock
CREATE TABLE IF NOT EXISTS `mfgs_stock` (
  `id_stock` int(11) NOT NULL AUTO_INCREMENT,
  `nom_produit` varchar(255) NOT NULL,
  `appellation` varchar(255) NOT NULL,
  `prix` int(11) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `stock_min` int(11) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_stock`),
  UNIQUE KEY `nom_produit` (`nom_produit`),
  UNIQUE KEY `appellation` (`appellation`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table mfgs.mfgs_stock : ~156 rows (environ)
INSERT INTO `mfgs_stock` (`id_stock`, `nom_produit`, `appellation`, `prix`, `stock`, `stock_min`, `createdAt`, `updatedAt`) VALUES
	(1, 'Adaptateur DP vers HDMI', 'BENFEI Adaptateur Displayport vers HDMI, convertisseur DP (Display Port) mâle vers Hdmi Femelle', 7, 11, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(2, 'ADAPTATEUR MINI DP VERS DP', 'Silkland Adaptateur Mini DP 1.4 vers DP 8K@60Hz 4K@144Hz, Adaptateur Thunderbolt 2 Nylon avec HDR HBR3 G-Sync FreeSync, Adaptateur Mini DisplayPort Displayport 1.4 pour Laptop MacBook iMac Moniteur VR', 12, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(3, 'AIO ELITEONE 800 G6', 'HP ELITEONE 800 G6 - i5 - 8Go ram - 256Go SSD - Wifi - Win 10 Pro 64bits - 23,8 pouces', 0, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(4, 'AIO HP ProOne 600 G6', 'HP ProOne 600 G6 - I5 - 256 Gb - 8Gb - 22""', 869, 5, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(5, 'AIO ProOne 600 G2', 'HP ProOne 600 G2', 0, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(6, 'AIO ProONE 800 G6', 'HP ProOne 800 G6 - i5 - 8Go ram', 939, 3, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(7, 'Alimentation 12V 1A', 'DEATTI 12V 1A Adaptateur d\'alimentation du Transformateur, pour 12V', 8, 6, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(8, 'ATEN VS192', 'ATEN VS192 Répartiteur 2 Ports 4K DisplayPort ', 114, 10, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(9, 'BARRE SON ELEGANCE', 'BARRE SON ELEGANCE', 0, 6, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(10, 'Batteire Toshiba Pro C70-A', 'Green Cell Batterie pour Toshiba Satellite Pro C70-A-140 C70-A-148 C70-A-14V C70-A-14W C70-A-14X C70-A-152 C70-A-153 C70-A-155 C70-A-159 C70-A-15L Portable (4400mAh 10.8V Noir)', 40, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(11, 'Batterie DORO 1361', 'TECHTEK Batteries Compatible avec [Doro] 1350, 1361, 6520, 6530, DFC-0160, Primo 401, Primo 805, pour [Brondi] Amico AMPLI VOX, Amico Schlicht, Simple Friend remplace DBR-800B, pour W11 FBA', 13, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(12, 'Borne CISCO IP DECT 210 Multi-Cell Base Station', 'station d\'accueil pour téléphone sans fil / station d\'accueil pour téléphone VoIP avec ID d\'appelant - IP-DECT - (conférence) à trois capacité d\'appel - SIP, SRTP', 0, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(13, 'Cable alim 3m Noir', 'Goobay 96036 Câble de raccordement pour appareils froids - fiche à contact de protection (type F, CEE 7/7) vers prise d\'appareil C13 (raccordement pour appareils froids), 3m noir', 9, 10, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(14, 'Cable Alim Blc IEC 3 M', 'Goobay 95141 Câble de raccordement pour appareils froids - fiche à contact de protection (type F, CEE 7/7) > prise d\'appareil C13 (raccordement pour appareils froids), 3 m, blanc', 9, 10, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(15, 'Cable d\'alimentation Prise C13 - 230V - Blanc 5M', 'Câble d\'alimentation Prise C13 - 230V - Blanc 5M', 6, 9, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(16, 'Cable Datalogic', 'Datalogic Câble pour transfert de données Datalogic -2 m USB pour douchette', 9, 3, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(17, 'Câble de sécurité antivol Portable', 'Câble de sécurité antivol en acier pour ordinateur portable de 110 cm, Avec verrou et fente de sécurité, KENSINGTON, Verrou à clés,2 clés incluses, revêtement en PVC', 6, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(18, 'Câble de Sécurité Surface Pro', 'Kensington Câble de Sécurité pour Surface Pro avec Verrouillage Non Invasif Robuste et Câble en Acier Carbone - 1,8 m', 24, 24, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(19, 'Cable DP', 'lanberg env.-dpdp 10cc-BK DisplayPort 1.1 A 0030 (19 Broches) vers fiche DisplayPort (19 Broches) 4 K Câble 3 m Noir ', 5, 9, 3, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(20, 'Câble HDMI Blanc 5m', 'Câble HDMI Blanc 5m', 17, 9, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(21, 'CABLE RJ45 - BLANC 1.50M', 'CABLE RJ45 - 1.50M', 3, 17, 10, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(22, 'CABLE RJ45 BLANC - 1M', 'CABLE RJ45 BLANC - 1M', 2, 10, 10, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(23, 'Câble USB-A vers Micro USB-B Blanc 5m', 'Câble USB-A vers Micro USB-B Blanc 5m', 4, 9, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(24, 'Câble USB-A vers USB-B Blanc 5M', 'Câble USB-A vers USB-B Blanc 5M', 6, 9, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(25, 'Câble USB-C Samsung', 'Samsung Câble USB 15W Noir, USB-A vers USB-C, 1,5m, Version FR', 7, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(26, 'Camera Anlapus', 'Anlapus Caméra de Surveillance HD 1080P 24PCS LEDs IR Objectif 3,6mm - Caméra Surveillance Extérieure de Rechange du Système de Sécurité CCTV', 19, 5, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(27, 'Caméra ZOSI 1080P', 'ZOSI 1080P Caméra de Surveillance Extérieure, Vision Nocturne 24 m, Imperméable IP66, Câble BNC et Alimentation Fournis', 40, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(28, 'CAREPACK 3ANS', 'CAREPACK 3ANS SUR SITE', 52, 56, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(29, 'CAREPACK Z1', 'CAREPACK Z1 3 ANS', 12, 3, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(30, 'Carte SD 4Go', 'Gigastone 4 Go SDHC Carte Mémoire', 27, 3, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(31, 'CASQUE - ENVOLVE65 Mono', 'Casque Jabra Evolve 65 Mono Casque supra-auriculaire sans fil - Casque certifié Microsoft avec batterie longue durée - Adaptateur Bluetooth USB - Noir', 124, 7, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(32, 'Changeur AAOTOKK BNC à RJ45', 'Changeur AAOTOKK BNC à RJ45', 21, 8, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(33, 'Chargeur ASUS  W16-045n3b', 'Chargeur ASUS W16-045n3b', 16, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(34, 'Chargeur Iphone USB-C lighting', ' Chargeur Iphone USB-C lighting - 2m cable', 13, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(35, 'Chargeur Samsung', 'Samsung - Chargeur Rapide Secteur USB type C - Noir (Version d\'import Europe)', 9, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(36, 'Clavier Blc', 'Clavier médical Blanc  AK-C8100F-FU1-W/FR sans fils IP65', 14, 5, 3, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(37, 'Clavier et Souris sans Fil Grapheme Blanc', 'BlueElement - Pack Clavier et Souris sans Fil Grapheme - Wireless avec Smart Dongle - Clics Silencieux - Design Ultra Slim - Ergonomique - Rechargeable - Blanc - AZERTY FR ', 39, 9, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(38, 'clavier filaire', 'clavier filaire HP', 0, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(39, 'Clavier/Souris HP SLIM Clavier Souris ss fils', 'HP 235 Slim Clavier Souris ss fils', 32, 36, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(40, 'ClavierSurface  noir', 'Clavier House Microsoft noir', 99, 17, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(41, 'Clv/Souris Joyaccess', 'Clv/Souris ss fils rechargeable Joyaccess', 0, 11, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(42, 'Coque Garegce Tel A12/M12 + Verre', 'Garegce Coque pour Samsung Galaxy A12/Samsung Galaxy M12 avec 1 x Verre Trempé, Coque Transparente Ultra Fine Samsung A12/ M12, Silicone TPU Souple Housse Galaxy A12/M12-6.5 Pouces - Transparente ', 8, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(43, 'Coque ICOVERI Iphone 12 Pro Max', 'ICOVERI Coque magnétique en Silicone pour iPhone 12 Pro Max Étui de Protection pour téléphone Portable Compatible avec Les Accessoires Magsafe et Chargeur Inalmabrico pour iPhone 12 Pro Max. Noir ', 16, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(44, 'Coque Iphone 12 Pro', 'Spigen Ultra Hybrid Coque Compatible avec iPhone 12 Compatible avec iPhone 12 Pro - Noir Mat', 12, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(45, 'Coque Ornato  Iphone 11 ', 'ORNARTO Coque iPhone 11, Coque en Silicone (pour iPhone 11) (6,1"") avec 2 Verres Trempés, Étui iPhone 11 Protection Complète, Housse au Bord Carré Antichoc - Noir ', 17, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(46, 'Coque protect S20FE', 'LK Coque pour Samsung Galaxy S20 FE 4G/ 5G, 3 Verre Trempé Protection écran & 1 Caméra Protecteur, Antichoc et Anti-Rayures Silicone Clair Samsung', 10, 3, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(47, 'Coque Protection Tel A12-M12', 'AURSTORE Coque pour Samsung Galaxy A12, pour Samsung Galaxy M12, Housse Etui Samsung A12 en Transparent Silicone TPU Souple [Bumper avec Coins Renforcé], Protection Antichoc Claire', 5, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(48, 'Coque SEYMAC Tab A7 Lite', 'Coque SEYMAC stock Coque pour Samsung Galaxy Tab A7 Lite', 22, 5, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(49, 'Coque SYMAC TABA8', 'SEYMAC stock Coque pour Samsung Galaxy Tab A8 10.5\'\' avec Protecteur D\'écran Porte-Stylo [Dragonne Rotative à 360] et Support, Coque Antichoc pour S', 21, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(50, 'Coque TECHGEAR Galaxy TAB A8', 'TECHGEAR Utility Coque Compatible avec Samsung Galaxy Tab A8 2021 10.5 Pouces (SM-X200/SM-X205) Rigide, Protection Anti Choc avec Support Pivotant 360', 19, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(51, 'Coque TECHGEAR TAB A7 Lite noir', 'Coque TECHGEAR Utility Compatible avec Samsung Galaxy Tab A7 Lite 2021 8.7 Pouces (SM-T220/T225) Rigide, Protection Anti Choc avec Support Pivotant 360 Degrés, Bandoulière Épaule et Prise Main - Noir', 17, 45, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(52, 'Cordon RJ45 Blanc 0,5M ref 21991226', 'Cordon RJ45 Blanc 0,5M  cat.6 (Classe E) S/FTP ref 21991226', 2, 30, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(53, 'Cordon RJ45 Blanc 1,5M ref 21990717', 'Cordon RJ45 Blanc 1,5M cat.6 (Classe E) S/FTP ref 21990717', 3, 50, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(54, 'Cordon RJ45 Jaune 1M ref 21991232', 'Cordon RJ45 Jaune 1M cat.6 (Classe E) S/FTP ref 21991232', 3, 10, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(55, 'Cordon RJ45 Vert 1M ref 21991233', 'Cordon RJ45 Vert 1M Cat. 6 (Classe E) S/FTP  ref 21991233', 3, 10, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(56, 'DIGIHUB', 'DIGIHUB pour Surface 7 Pro', 750, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(57, 'DIVISEUR OPTIQUE AUDIO', 'LiNKFOR Diviseur Audio Optique 1x3 SPDIF Diviseur Optique Toslink avec 1 PCS Cable Optique Alliage d\'aluminium 1 en 3 Support LPCM 2.0 DTS Dolby-AC3 C', 19, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(58, 'Ecran E2222HS', 'Ecran Dell E2222HS - 21,5"" - HDMI - DP - VGA - VESA 100', 159, 3, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(59, 'Ecran E22G4', 'Ecran HP 22"" E22G4', 0, 41, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(60, 'Ecran E24G4', 'Ecran HP 24""', 179, 8, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(61, 'Ecran HP E24 G5', 'Ecran HP E24 G5 - 23,8"" - HDMI DisplayPort - USB-c', 149, 18, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(62, 'Ecran HP M32f', 'Ecran HP M32f - M-series - écran LED - Full HD (1080p) - 32"" (2H5M7AA)', 229, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(63, 'Ecran iiYama X2483HSU', 'Ecran  iiYama X2483HSU - 24""', 0, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(64, 'Ecran iiYama XB2483HSU-B3 Noir', 'iiYama XB2483HSU-B3 Ecran 24 pouces Noir', 161, 2, 5, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(65, 'Ecran iiYama XB2483HSU-B3 WHITE', 'Ecran iiYama XB2483HSU-B3 WHITE', 0, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(66, 'Ecran iiyama XUB2294HSU-W1', 'Ecran  iiyama XUB2294HSU-W1 - 22"" - 1920 X 1080 Full HD', 159, 33, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(67, 'Ecran V7', 'Ecran V7 LED 23,8"" - HDMI -VGA - DP - Pied réglable', 199, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(68, 'HAUT PARLEUR BUREAU', 'HAUT PARLEUR BUREAU', 0, 4, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(69, 'Haut Parleur Trust Remo ', 'Trust Remo Enceinte PC USB 2.0, 16 Watt, Alimentation USB, Système Audio avec Jack 3,5 mm, Plug and Play, Speaker pour Ordinateur Portable, PC - Noir', 16, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(70, 'HDD Seagate Exos 7E8 ST2000NM001A ', 'Disque dur Seagate Exos 7E8 ST2000NM001A 2 To interne 3.5', 109, 12, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(71, 'HDD WD Red WD30EFAX', 'HDD WD Red WD30EFAX 3,5"" - 5400 Trs - 3 To - SATA', 89, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(72, 'HDD WDS200T1R0A - 2To', 'Disque dur 2To - SSD - 2,5"" SATA WDS200T1R0A', 179, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(73, 'HDD Western Digital WD20EFRX-RFB', 'HDD Western Digital WD20EFRX-RFB WD Red 2TB 24x7, Red, 3.5"", 2000 Go, 5400', 130, 3, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(74, 'HP Carte Gigabit Ethernet', 'HP Carte Gigabit Ethernet - 10/100/1000Base-T PCI-Express', 29, 2, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(75, 'HUB USB 10 PORTS', 'LogiLink UA0096 Hub USB 2.0 10 Ports 3,5 A Noir', 45, 3, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(76, 'HUB USB 3.0 USB et adapt USB-C - 4ports', 'Hub USB 3.0 Adaptateur USB 4 en 1 Ultra-Slim 5Gbps Hub USB C Compatible avec Mac Pro, PS4, MacBook Air, Surface Pro, XPS et Autres Ordinateurs Portables', 8, 53, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(77, 'HUB USB 4 ports _ in USB-USB C', 'Hub USB C, 4 ports mini USB avec adaptateur USB C vers USB, concentrateur d\'extension USB C pour ordinateur portable (3 USB 2.0, 1 USB 3.0), Surface Pro, XPS et PC (argent)', 5, 19, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(78, 'HUB USB 7', 'HUB USB 7 ports', 0, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(79, 'i-tec C31DUALDPDOCKPD', 'Station d\'accueil i-tec C31DUALDPDOCKPD', 117, 1, 5, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(80, 'I-TEC CADUAL4KDOCK', 'Thunderbolt 3 Dual Display Docking Station + Power Delivery 85W 5 USB-A 2 HDMI - 2 DP - 1 RJ45 - 1 USB-C - 1 Jack 3,5', 0, 21, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(81, 'Lecteur code barre MS9540', 'Douchettes Honeywell MS9540', 110, 10, 5, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(82, 'Lecteur code barre OPTICON NLV-5201', 'Lecteur code barre OPTICON NLV-5201-USB-HID', 135, 7, 3, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(83, 'Lecteur code barre TD1120-BK-65K1', 'Douchette Datalogic TD1120-BK-65K1', 0, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(84, 'Lecteur fente SSC-TINY', 'Lecteur de cartes monofente SSC-TINY - PC-SC et CCID', 29, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(85, 'Lecteur Mono LITEO ', 'Lecteur de cartes monofente LITEO - PS-SC et  CCID', 19, 483, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(86, 'Moniteur IOCOMMANDO 10""', 'IOCOMMANDO Moniteur couleur 10,1 pouces TFT LCD Full HD 1024 x 600 BNC/AVI/VGA/entrée HDMI, compatible PC, DVD, TV, caméra de surveillance et camér', 63, 5, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(87, 'Onduleur EATON 5P 1150I', 'Onduleur EATON 5P 1150I Rack 1U Line Interactive', 589, 4, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(88, 'Onduleur Elipse ECO 800', 'Eaton Onduleur Ellipse ECO 800 USB IEC - Puissance 800VA (4 prises IEC, Parasurtenseur, Batterie)', 109, -1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(89, 'Onduleur Ellipse 650 FR', 'Onduleurs Eaton Ellipse 650 FR', 80, 3, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(90, 'Pack Office 2021', 'Microsoft Office HOME AND BUSINESS 2021', 229, 25, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(91, 'Pack Office standard', 'Pack Office standard', 229, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(92, 'PC Prodesk 400 G4', 'HP Prodesk 400 G4', 0, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(93, 'PC PRODESK 400 G6', 'HP Prodesk 400 G6 (i5 - 8Go ram - 256Go SSD', 46, 0, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(94, 'PC PRODESK 400 G7', 'HP Prodesk 400 G7 (i5 - 16Go ram - 512 Go SSD)', 719, 0, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(95, 'PC PRODESK 400 G9', 'HP PRODESK 400 G9 mini desktop I5 12500T - 8Go Ram - 256Go SSD - Windows 11 Pro', 599, 43, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(96, 'PC Z1', 'HP Z1 (i7 - 2+ 16Go ram + 256Go SSD + graveur dvd)', 1119, 7, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(97, 'PC Z2 G5', 'HP Workstation Z2 G5 - Format tour - Intel Core i7 10700 - Windows 10 Pro - 16 Go RAM - 512 SSD', 959, 1, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(98, 'PORTABLE DRAGONFLY G3', 'HP Elite Dragonfly G3 Notebook Intel Core i5 1235U / 1.3 GHz - Evo - Tactile 13.5"" IPS écran tactile HP SureView Reflect 1920 x 1280 -- Win 10 Pro 64 bits (comprend Licence Win 11 Pro) - Carte graphique Intel Iris Xe - 16 Go RAM - 512 Go SSD NVMe, TLC, H', 1449, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(99, 'PORTABLE Probook 430 G8 - i5 - 8Go - 256 Go SSD', 'Probook 430 G8 - i5 - 8Go - 256 Go SSD', 789, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(100, 'PORTABLE Probook 430 G8 - i7 - 16Go - 512 Go SSD', 'Probook 430 G8 - Intel Core  i7 - 16Go de ram - 512 Go SSD', 969, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(101, 'PORTABLE PROBOOK 450 G6', 'Probook 450 G6', 450, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(102, 'PORTABLE Probook 450 G7', 'Probook 450 G7', 0, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(103, 'PORTABLE Probook 450 G8 ', 'HP Probook 450 G8 - I5 - 8Go Ram - 256 SSD', 679, 10, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(104, 'PORTABLE ProBook 450 G9', 'ProBook 450 G9 - I5 1235U/1,3GHz- Iris Xe Graphics - win10Pro - 8Go ram- 256 Go SSD - 15.6"" - 1920x1080 Full HD - wifi 6E', 1, 1, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(105, 'PORTABLE Zbook Firefly 15 G8', 'HP Zbook Firefly 15 G8 - i7 1165G7 / 2.8Ghz - Win 11Pro - T500 4Go - 16Go Ram - 512 Go SSD - 15.6""', 1439, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(106, 'Qnap TS-453D', 'NAS Qnap TS-453D - 4 baies - sata - Ram 8Go', 645, 3, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(107, 'QNAP TS-464-4G', 'Nas Qnap Systems RS-464-4G HDD & SSD - intel celeron - 4Gi ram', 569, 4, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(108, 'Saccoche 15.6""', 'DOMISO 15-15,6 Pouces Imperméable Housse de Protection Ordinateur Portable avec Port de Chargeur USB Externe Sacoche Bandoulière pour Ultrabook/Netb', 21, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(109, 'SCANNER Epson DS-70', 'Scanner Epson DS-70', 119, 27, 5, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(110, 'SET-2', 'Lecteur CV SET-2 Olaqin', 99, 14, 5, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(111, 'Souris Blc', 'Souris médical Blanc sans fils AK-PMT2LB-FS-W IP68', 49, 2, 3, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(112, 'Souris EGO R-GO HE droitier', 'R-Go HE mouse- Souris ergonomique - Modèle Vertical- Sans fil - Pour Droitier', 70, 0, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(113, 'Souris Ergo Trust', 'Trust Verto Souris sans Fil, USB, Verticale, Ergonomique, 800/1200/1600 DPI, 4 Boutons, LED, Prévention Syndrome de la Souris et Epicondylite, pour D', 21, 0, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(114, 'SPLITTER eSynic- 1 IN HDMI - 2 OUT HDMI', 'eSynic Splitter HDMI 2 Ports Commutateur HDMI Répartiteur Une Entrée Source à Deux Sorties Amplificateur Supporter 3D Full HD 1080P HDTV', 15, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(115, 'Station d\'accueil HP G5 essential', 'Station d\'accueil HP G5 essential', 0, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(116, 'Stylet Microsoft  noir Surface', 'Stylet Microsoft noir Surface', 79, 19, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(117, 'Support 17031117', '17031117 - Support ecran double bras 5 axes Exam Audition', 164, 3, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(118, 'Support 17031147', '17031147 - Support Ecran 5 axes grommet PV OPT', 149, 3, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(119, 'Support 17031149', '17031149 support table 4 axes grommet PV OPT', 115, 4, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(120, 'Support 17031178', '17031178 Support mural 4 axes Oreille PV', 149, 4, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(121, 'Support 2 Ecrans', 'HUANUO Support Ecran PC 2 Ecran Ultra-Large de 15 à 35 Pouces, Bras pour Écran PC à Ressort à Gaz avec Câble USB, Bras Ecran PC à Mouvement Complet Pesant Jusqu\'à 12 kg', 103, 5, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(122, 'Support Ergotron HX Wall', 'Support Ergotron HX Wall Mount Monitor Arm - Kit de Montage (Bras articulé, Support Mural, Pivot, matériel de Fixation, Port d\'extension) pour Moniteur - Blanc - Taille d\'écran : jusqu\'à 42 Pouces - montable', 209, 1, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(123, 'Support HP ProOne G6 VESA', 'Support HP ProOne G6 VESA', 1, -7, 2, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(124, 'Support ONKRON G100 WHT', 'Support ONKRON G100 WHT', 83, 11, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(125, 'Support Onkron G160 WHT', 'ONKRON G160 WHT Bras pour Moniteur, Support de Bureau pour Deux écrans Ordinateur de 13 à 27 Pouces Blanc', 105, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(126, 'Support ProperAV Support mural à bras pivotant', 'ProperAV Support mural à bras pivotant Blanc', 0, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(127, 'Support Rotule 17991125', 'Support Rotule ref 17991125 - Value Fixation murale 3 pivots', 0, 2, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(128, 'Support VESA SLEEVE V3', 'HP Dual VESA Sleeve v3', 16, 17, 3, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(129, 'Switch ARUBA 1930 24 Ports', 'ARUBA Instant on 1930 24 Ports 4SFP/SFP + swithc', 179, 5, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(130, 'Switch ARUBA ON 1930 24G POE', 'Aruba Instant On 1930 24G 4SFP+ PoE+ (195W) Switch', 319, 5, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(131, 'Switch HPE 1820 24 POE 24 ports', 'Switch HPE 1820 24 POE 24 ports (185w)', 229, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(132, 'SWITCH NETGEAR (GS305EPP)', 'NETGEAR (GS305EPP) Switch Ethernet PoE 5 Ports RJ45 Gigabit (10/100/1000), Serie Plus Manageable PoE+, switch RJ45 avec 4 Ports PoE+ 120 W', 76, 0, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(133, 'SWITCH NETGEAR (GS308EPP)', 'NETGEAR (GS308EPP) Switch Ethernet PoE 8 Ports RJ45 Gigabit (10/100/1000), Serie Plus Manageable PoE, switch RJ45 avec 8 Ports PoE+ 124 W', 98, 1, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(134, 'Tablette Galaxy Tab S6 Lite ', 'Samsung Galaxy Tab S6 Lite Tablette Android 10 64 Go bleu ', 0, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(135, 'Tablette Samsung Book Cover EF-BP610', 'Samsung Book Cover EF-BP610 Protection à rabat pour tablette', 0, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(136, 'Tablette Samsung Galaxy Tab A8', 'Samsung Galaxy Tab A8 10.5"" 32 Go Wifi Gris (FR version)', 214, 0, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(137, 'Tablette STU430', 'STU6430 Tablette Signature Wacom', 0, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(138, 'Tablette Surface Pro 7', 'Tablette Microsoft Surface Pro 7', 749, 12, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(139, 'Tablette Tab A7', 'Samsung Galaxy Tab A7 Lite 64 Go 4G Gris (FR version)', 233, 52, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(140, 'Tablette X-PEN G430S', 'Tablette signature X-PEN G430S', 24, 35, 5, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(141, 'Tel CISCO CP-6871', 'Téléphone Fixe CISCO CP-6871', 0, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(142, 'Tel CISCO IP DECT Phone 6825', 'Extension du combiné sans fil - avec Interface Bluetooth - DECT - SIP - 2 lignes', 0, 60, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(143, 'Tel GALAXY A12', 'Samsung Galaxy A12 - Smartphone 32GB, 3GB RAM, Dual Sim, Black', 147, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(144, 'TEL GALAXY M12', 'Samsung Galaxy M12 - 64Go - Smartphone Android débloqué - Version Française - Noir ', 159, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(145, 'Tel Gigaset AS470 Solo', 'Gigaset AS470 Solo - Téléphone Fixe sans Fil - Noir', 29, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(146, 'TEL MURAL OMNI', 'Ornin T102 Trimline Téléphone filaire Fixation murale Blanc ', 12, 0, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(147, 'TEL S20', 'Samsung Galaxy S20 FE SM-G780GZBDEUE Smartphone 16,5 cm (6.5"") Double SIM 4G USB Type-C 6 Go 128 Go 4500 mAh Marine', 410, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(148, 'TELECOMMANDE POINTEUR', 'Skaaisont Telecommande Ordinateur Powerpoint, Pointeur Powerpoint du Présentateur avec Hyperlien et Contrôle du Volume, 2.4 GHz USB pour Présentation, Enseignement, Bureau, Conférence,etc', 8, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(149, 'Verre Protec Iphone 12 Pro Max', 'JETech Verre Trempé pour iPhone 12 Pro Max 6,7 Pouces avec Protection d\'Objectif de Caméra Arrière, Film Protection Écran, 2 Pièces Chacun', 8, 2, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(150, 'Verre protect Samsung A12 -  A02S', ' Lot de 2, Verre Trempé pour Samsung Galaxy A12, Galaxy A02S, Film Protection écran - Anti Rayures - sans Bulles d\'air -Ultra Résistant (0,33mm HD Ultra Transparent) Dureté 9H Glass', 4, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(151, 'WD Red SA500 SATA SSD', 'WD Red SA500 NAS SATA SSD', 0, 12, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(152, 'Webcam', 'WEBCAM', 0, 3, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(153, 'WEBCAM C270', 'WEBCAM LOGITECH C270', 29, 1, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(154, 'Webcam HD MCL SAMAR', 'Webcam HD MCL SAMAR', 16, 6, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(155, 'TEL SAMSUNG A13', 'Samsung Galaxy A13 EU-DS-64-4-5G-bu Galaxy A13 5G EU 64/4GB Blue', 148, 3, 0, '2024-06-28 07:54:08', '2024-06-28 07:54:08'),
	(157, 'test', 'test', 69, 2, 1, '2024-06-28 07:54:08', '2024-06-28 07:54:08');

-- Listage de la structure de table mfgs. mfgs_users
CREATE TABLE IF NOT EXISTS `mfgs_users` (
  `id_users` int(11) NOT NULL AUTO_INCREMENT,
  `password` blob NOT NULL,
  `email` varchar(255) NOT NULL,
  `salt` blob NOT NULL,
  `dsio` tinyint(1) DEFAULT 0,
  `admin` tinyint(1) DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id_users`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table mfgs.mfgs_users : ~4 rows (environ)
INSERT INTO `mfgs_users` (`id_users`, `password`, `email`, `salt`, `dsio`, `admin`, `createdAt`, `updatedAt`) VALUES
	(1, _binary 0x05eddd0e9781aee4b2db953b06fea2721d032cacd3ab58e476144e8a47b4d54d, 'a', _binary 0xdea7665fde63e5313e77b7ed1a5aa2c2, 1, 1, '2024-05-17 14:14:52', '2024-05-17 14:14:52'),
	(2, _binary 0x10e2042b6a12abcee042110466ff42b88edf992c63389a5d1752d2c533f9ee71, 'b', _binary 0xace21eeb8af3cc1fafa42a3562fe4282, 1, 1, '2024-05-17 14:19:43', '2024-05-17 14:19:43'),
	(3, _binary 0x0e9b7401829efa1c1aca6ba61add87e6af1fb2e7efdfb57efca11c8714628b6f, 'et.garcia@mfgs.fr', _binary 0xc525508db0133ef17bfd96c361782bfa, 1, 1, '2024-06-20 10:20:10', '2024-06-20 10:20:10'),
	(4, _binary 0xae49722bb36777549a13faeda01a030dff035c833e4abf78cc1d7f87a1ebf719, 'hotline@mfgs.fr', _binary 0x107de4ee8ef4b00a679cd23e478f0bff, 1, 0, '2024-11-27 11:29:26', '2024-11-27 11:29:26');

-- Listage de la structure de table mfgs. sequelizemeta
CREATE TABLE IF NOT EXISTS `sequelizemeta` (
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Listage des données de la table mfgs.sequelizemeta : ~1 rows (environ)
INSERT INTO `sequelizemeta` (`name`) VALUES
	('20240628074714-add-timestamp-to-mfgs_stock.js');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
