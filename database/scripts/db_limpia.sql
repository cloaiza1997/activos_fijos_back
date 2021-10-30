-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.20-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para gestion_activos
DROP DATABASE IF EXISTS `gestion_activos`;
CREATE DATABASE IF NOT EXISTS `gestion_activos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `gestion_activos`;

-- Volcando estructura para tabla gestion_activos.assets
DROP TABLE IF EXISTS `assets`;
CREATE TABLE IF NOT EXISTS `assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_asset_group` int(11) NOT NULL,
  `id_asset_type` int(11) NOT NULL,
  `asset_number` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_brand` int(11) NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serial_number` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entry_date` date NOT NULL,
  `init_value` decimal(11,2) DEFAULT NULL,
  `residual_value` decimal(11,2) NOT NULL,
  `current_value` decimal(11,2) NOT NULL,
  `use_life` int(11) NOT NULL,
  `id_maintenance_frequence` int(11) NOT NULL,
  `maintenance_date` date DEFAULT NULL,
  `id_purchase_item` int(11) DEFAULT NULL,
  `id_status` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_parameters_assets_id_asset_g` (`id_asset_group`),
  KEY `fk_parameters_assets_id_asset_t` (`id_asset_type`),
  KEY `fk_parameters_assets_id_brand` (`id_brand`),
  KEY `fk_parameters_assets_id_mainten` (`id_maintenance_frequence`),
  KEY `fk_purch_item_assets_id_purchas` (`id_purchase_item`),
  KEY `fk_parameters_assets_id_status` (`id_status`),
  CONSTRAINT `fk_parameters_assets_id_asset_g` FOREIGN KEY (`id_asset_group`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_assets_id_asset_t` FOREIGN KEY (`id_asset_type`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_assets_id_brand` FOREIGN KEY (`id_brand`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_assets_id_mainten` FOREIGN KEY (`id_maintenance_frequence`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_assets_id_status` FOREIGN KEY (`id_status`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_purch_item_assets_id_purchas` FOREIGN KEY (`id_purchase_item`) REFERENCES `purch_items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.assets: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.attachments
DROP TABLE IF EXISTS `attachments`;
CREATE TABLE IF NOT EXISTS `attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_app_key` int(11) NOT NULL,
  `id_register` int(11) NOT NULL COMMENT 'Relación l+ogica',
  `file_name` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_parameters_attachment_id_app_key` (`id_app_key`),
  CONSTRAINT `fk_parameters_attachment_id_app_key` FOREIGN KEY (`id_app_key`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.attachments: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.certificates
DROP TABLE IF EXISTS `certificates`;
CREATE TABLE IF NOT EXISTS `certificates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_deliver_user` int(11) NOT NULL,
  `id_deliver_area` int(11) NOT NULL,
  `delivered_at` date DEFAULT current_timestamp(),
  `id_receiver_user` int(11) NOT NULL,
  `id_receiver_area` int(11) NOT NULL,
  `received_at` date DEFAULT NULL,
  `id_creator_user` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_approver_user` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `id_status` int(11) NOT NULL,
  `id_parent` int(11) DEFAULT NULL,
  `observations` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_users_certificat_id_receive` (`id_receiver_user`),
  KEY `fk_users_certificat_id_creator` (`id_creator_user`),
  KEY `fk_parameters_certificat_id_area` (`id_deliver_area`),
  KEY `fk_parameters_certificat_id_status` (`id_status`),
  KEY `fk_certificat_certificat_id_parent` (`id_parent`),
  KEY `fk_users_certificat_id_deliver` (`id_deliver_user`),
  KEY `fk_parameters_certificat_id_receive` (`id_receiver_area`),
  KEY `fk_users_certificat_id_approve` (`id_approver_user`),
  CONSTRAINT `fk_certificat_certificat_id_parent` FOREIGN KEY (`id_parent`) REFERENCES `certificates` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_certificat_id_area` FOREIGN KEY (`id_deliver_area`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_certificat_id_receive` FOREIGN KEY (`id_receiver_area`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_certificat_id_status` FOREIGN KEY (`id_status`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_certificat_id_approve` FOREIGN KEY (`id_approver_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_certificat_id_creator` FOREIGN KEY (`id_creator_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_certificat_id_deliver` FOREIGN KEY (`id_deliver_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_certificat_id_receive` FOREIGN KEY (`id_receiver_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.certificates: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `certificates` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.certi_details
DROP TABLE IF EXISTS `certi_details`;
CREATE TABLE IF NOT EXISTS `certi_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_certificate` int(11) NOT NULL,
  `id_asset` int(11) NOT NULL,
  `asset_number` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serial_number` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observations` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_physical_status` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_certificat_certi_deta_id_certifi` (`id_certificate`),
  KEY `fk_assets_certi_deta_id_asset` (`id_asset`),
  KEY `fk_parameters_certi_deta_id_physica` (`id_physical_status`),
  CONSTRAINT `fk_assets_certi_deta_id_asset` FOREIGN KEY (`id_asset`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_certificat_certi_deta_id_certifi` FOREIGN KEY (`id_certificate`) REFERENCES `certificates` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_certi_deta_id_physica` FOREIGN KEY (`id_physical_status`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.certi_details: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `certi_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `certi_details` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.depreciation_revaluation
DROP TABLE IF EXISTS `depreciation_revaluation`;
CREATE TABLE IF NOT EXISTS `depreciation_revaluation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_action_type` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `observations` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_status` int(11) NOT NULL,
  `id_parent` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_parameters_depre_reva_id_action_` (`id_action_type`),
  KEY `fk_users_depre_reva_id_user` (`id_user`),
  KEY `fk_depre_reva_depre_reva_id_parent` (`id_parent`),
  KEY `fk_parameters_depre_reva_id_status` (`id_status`),
  CONSTRAINT `fk_depre_reva_depre_reva_id_parent` FOREIGN KEY (`id_parent`) REFERENCES `depreciation_revaluation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_depre_reva_id_action_` FOREIGN KEY (`id_action_type`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_depre_reva_id_status` FOREIGN KEY (`id_status`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_depre_reva_id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.depreciation_revaluation: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `depreciation_revaluation` DISABLE KEYS */;
/*!40000 ALTER TABLE `depreciation_revaluation` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.depre_reval_details
DROP TABLE IF EXISTS `depre_reval_details`;
CREATE TABLE IF NOT EXISTS `depre_reval_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_depre_reval` int(11) NOT NULL,
  `id_asset` int(11) NOT NULL,
  `old_value` decimal(11,2) NOT NULL,
  `new_value` decimal(11,2) NOT NULL,
  `observations` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL COMMENT 'En caso de que el proceso sea una reversa\n',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_assets_dep_rev_de_id_asset` (`id_asset`),
  KEY `fk_dep_rev_de_dep_rev_de_id_parent` (`id_parent`),
  KEY `fk_depre_reva_dep_rev_de_id_depre_r` (`id_depre_reval`),
  CONSTRAINT `fk_assets_dep_rev_de_id_asset` FOREIGN KEY (`id_asset`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dep_rev_de_dep_rev_de_id_parent` FOREIGN KEY (`id_parent`) REFERENCES `depre_reval_details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_depre_reva_dep_rev_de_id_depre_r` FOREIGN KEY (`id_depre_reval`) REFERENCES `depreciation_revaluation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.depre_reval_details: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `depre_reval_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `depre_reval_details` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.derecognitions
DROP TABLE IF EXISTS `derecognitions`;
CREATE TABLE IF NOT EXISTS `derecognitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_status` int(11) NOT NULL,
  `observations` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL,
  `id_creator_user` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_approver_user` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_users_derecognit_id_creator` (`id_creator_user`),
  KEY `fk_parameters_derecognit_id_status` (`id_status`),
  KEY `fk_derecognit_derecognit_id_parent` (`id_parent`),
  KEY `fk_users_derecognit_id_approve` (`id_approver_user`),
  CONSTRAINT `fk_derecognit_derecognit_id_parent` FOREIGN KEY (`id_parent`) REFERENCES `derecognitions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_derecognit_id_status` FOREIGN KEY (`id_status`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_derecognit_id_approve` FOREIGN KEY (`id_approver_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_derecognit_id_creator` FOREIGN KEY (`id_creator_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.derecognitions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `derecognitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `derecognitions` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.derec_details
DROP TABLE IF EXISTS `derec_details`;
CREATE TABLE IF NOT EXISTS `derec_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_derecognition` int(11) NOT NULL,
  `id_asset` int(11) NOT NULL,
  `id_reason` int(11) NOT NULL,
  `observations` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_assets_derec_deta_id_asset` (`id_asset`),
  KEY `fk_parameters_derec_deta_id_reason` (`id_reason`),
  KEY `fk_derecognit_derec_deta_id_derecog` (`id_derecognition`),
  KEY `fk_derec_deta_derec_deta_id_parent` (`id_parent`),
  CONSTRAINT `fk_assets_derec_deta_id_asset` FOREIGN KEY (`id_asset`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_derec_deta_derec_deta_id_parent` FOREIGN KEY (`id_parent`) REFERENCES `derec_details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_derecognit_derec_deta_id_derecog` FOREIGN KEY (`id_derecognition`) REFERENCES `derecognitions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_derec_deta_id_reason` FOREIGN KEY (`id_reason`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.derec_details: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `derec_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `derec_details` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.inventories
DROP TABLE IF EXISTS `inventories`;
CREATE TABLE IF NOT EXISTS `inventories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_status` int(11) NOT NULL,
  `observations` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_users_inventorie_id_user` (`id_user`),
  KEY `fk_parameters_inventorie_id_status` (`id_status`),
  CONSTRAINT `fk_parameters_inventorie_id_status` FOREIGN KEY (`id_status`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_inventorie_id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.inventories: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `inventories` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventories` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.inven_details
DROP TABLE IF EXISTS `inven_details`;
CREATE TABLE IF NOT EXISTS `inven_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_inventory` int(11) NOT NULL,
  `id_asset` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_inventorie_inven_deta_id_invento` (`id_inventory`),
  KEY `fk_assets_inven_deta_id_asset` (`id_asset`),
  CONSTRAINT `fk_assets_inven_deta_id_asset` FOREIGN KEY (`id_asset`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventorie_inven_deta_id_invento` FOREIGN KEY (`id_inventory`) REFERENCES `inventories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.inven_details: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `inven_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `inven_details` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.logs
DROP TABLE IF EXISTS `logs`;
CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) DEFAULT NULL,
  `id_register` int(11) DEFAULT NULL COMMENT 'Relación lógica',
  `id_app_key` int(11) NOT NULL,
  `description` varchar(5000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client` enum('WEB','MOBILE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_parameters_logs_id_app_key` (`id_app_key`),
  KEY `fk_users_logs_id_user` (`id_user`),
  CONSTRAINT `fk_parameters_logs_id_app_key` FOREIGN KEY (`id_app_key`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_logs_id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.logs: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.maintenances
DROP TABLE IF EXISTS `maintenances`;
CREATE TABLE IF NOT EXISTS `maintenances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_status` int(11) NOT NULL,
  `id_type` int(11) NOT NULL,
  `observations` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_users_maintenanc_id_user` (`id_user`),
  KEY `fk_parameters_maintenanc_id_status` (`id_status`),
  KEY `fk_parameters_maintenanc_id_type` (`id_type`),
  CONSTRAINT `fk_parameters_maintenanc_id_status` FOREIGN KEY (`id_status`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_maintenanc_id_type` FOREIGN KEY (`id_type`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_maintenanc_id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.maintenances: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `maintenances` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.maint_details
DROP TABLE IF EXISTS `maint_details`;
CREATE TABLE IF NOT EXISTS `maint_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_maintenance` int(11) NOT NULL,
  `id_asset` int(11) NOT NULL,
  `executed_at` date DEFAULT NULL,
  `observations` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_maintenanc_maint_deta_id_mainten` (`id_maintenance`),
  KEY `fk_assets_maint_deta_id_asset` (`id_asset`),
  CONSTRAINT `fk_assets_maint_deta_id_asset` FOREIGN KEY (`id_asset`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_maintenanc_maint_deta_id_mainten` FOREIGN KEY (`id_maintenance`) REFERENCES `maintenances` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.maint_details: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `maint_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `maint_details` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.maint_responsibles
DROP TABLE IF EXISTS `maint_responsibles`;
CREATE TABLE IF NOT EXISTS `maint_responsibles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_maintenance` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_provider` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_users_maint_resp_id_user` (`id_user`),
  KEY `fk_providers_maint_resp_id_provide` (`id_provider`),
  KEY `fk_maintenanc_maint_resp_id_mainten` (`id_maintenance`),
  CONSTRAINT `fk_maintenanc_maint_resp_id_mainten` FOREIGN KEY (`id_maintenance`) REFERENCES `maintenances` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_providers_maint_resp_id_provide` FOREIGN KEY (`id_provider`) REFERENCES `providers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_maint_resp_id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.maint_responsibles: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `maint_responsibles` DISABLE KEYS */;
/*!40000 ALTER TABLE `maint_responsibles` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.outboxes
DROP TABLE IF EXISTS `outboxes`;
CREATE TABLE IF NOT EXISTS `outboxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_app_key` int(11) NOT NULL,
  `id_email_template` int(11) DEFAULT NULL,
  `from` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Correos separdos por ;',
  `cc` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bcc` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` varchar(10000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_parameters_outboxes_id_app_key` (`id_app_key`),
  KEY `fk_parameters_outboxes_id_email_t` (`id_email_template`),
  CONSTRAINT `fk_parameters_outboxes_id_app_key` FOREIGN KEY (`id_app_key`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_outboxes_id_email_t` FOREIGN KEY (`id_email_template`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.outboxes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `outboxes` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.parameters
DROP TABLE IF EXISTS `parameters`;
CREATE TABLE IF NOT EXISTS `parameters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_parent` int(11) DEFAULT NULL,
  `parameter_key` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_val` decimal(11,5) DEFAULT NULL,
  `str_val` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_editable` tinyint(1) NOT NULL DEFAULT 0,
  `is_editable_details` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_parameters_parameters_id_parent` (`id_parent`),
  CONSTRAINT `fk_parameters_parameters_id_parent` FOREIGN KEY (`id_parent`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.parameters: ~193 rows (aproximadamente)
/*!40000 ALTER TABLE `parameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `parameters` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.providers
DROP TABLE IF EXISTS `providers`;
CREATE TABLE IF NOT EXISTS `providers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_document_type` int(11) NOT NULL,
  `document_number` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_city` int(11) NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observations` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_parameters_providers_id_city` (`id_city`),
  KEY `fk_parameters_providers_id_documen` (`id_document_type`),
  CONSTRAINT `fk_parameters_providers_id_city` FOREIGN KEY (`id_city`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_providers_id_documen` FOREIGN KEY (`id_document_type`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.providers: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.purchases
DROP TABLE IF EXISTS `purchases`;
CREATE TABLE IF NOT EXISTS `purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_provider` int(11) NOT NULL,
  `id_requesting_user` int(11) NOT NULL,
  `delivery_date` date NOT NULL,
  `delivery_address` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_city` int(11) NOT NULL,
  `sub_total` decimal(11,2) NOT NULL,
  `iva` decimal(11,2) NOT NULL,
  `total` decimal(11,2) NOT NULL,
  `id_status` int(11) NOT NULL,
  `id_payment_method` int(11) NOT NULL,
  `payment_days` int(5) DEFAULT NULL,
  `observations` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_creator_user` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_approver_user` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `id_updater_user` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_providers_purchases_id_provide` (`id_provider`),
  KEY `fk_users_purchases_id_request` (`id_requesting_user`),
  KEY `fk_parameters_purchases_id_status` (`id_status`),
  KEY `fk_parameters_purchases_id_payment` (`id_payment_method`),
  KEY `fk_users_purchases_id_creator` (`id_creator_user`),
  KEY `fk_users_purchases_id_approve` (`id_approver_user`),
  KEY `fk_users_purchases_id_updater` (`id_updater_user`),
  KEY `fk_parameters_purchases_id_city` (`id_city`),
  CONSTRAINT `fk_parameters_purchases_id_city` FOREIGN KEY (`id_city`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_purchases_id_payment` FOREIGN KEY (`id_payment_method`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_purchases_id_status` FOREIGN KEY (`id_status`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_providers_purchases_id_provide` FOREIGN KEY (`id_provider`) REFERENCES `providers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_purchases_id_approve` FOREIGN KEY (`id_approver_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_purchases_id_creator` FOREIGN KEY (`id_creator_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_purchases_id_request` FOREIGN KEY (`id_requesting_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_purchases_id_updater` FOREIGN KEY (`id_updater_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.purchases: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.purch_items
DROP TABLE IF EXISTS `purch_items`;
CREATE TABLE IF NOT EXISTS `purch_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_purchase` int(11) NOT NULL,
  `product` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_value` decimal(11,2) NOT NULL,
  `total_value` decimal(11,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_purchases_purch_item_id_purchas` (`id_purchase`),
  CONSTRAINT `fk_purchases_purch_item_id_purchas` FOREIGN KEY (`id_purchase`) REFERENCES `purchases` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.purch_items: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `purch_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `purch_items` ENABLE KEYS */;

-- Volcando estructura para tabla gestion_activos.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_document_type` int(11) NOT NULL,
  `document_number` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signature` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `must_change_password` tinyint(1) NOT NULL DEFAULT 0,
  `id_role` int(11) NOT NULL,
  `id_area` int(11) NOT NULL,
  `id_position` int(11) NOT NULL,
  `id_status` int(11) NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `document_number` (`document_number`),
  KEY `fk_parameters_users_id_role` (`id_role`),
  KEY `fk_parameters_users_id_area` (`id_area`),
  KEY `fk_parameters_users_id_status` (`id_status`),
  KEY `fk_parameters_users_id_positio` (`id_position`),
  KEY `fk_parameters_users_id_documen` (`id_document_type`),
  CONSTRAINT `fk_parameters_users_id_area` FOREIGN KEY (`id_area`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_users_id_documen` FOREIGN KEY (`id_document_type`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_users_id_positio` FOREIGN KEY (`id_position`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_users_id_role` FOREIGN KEY (`id_role`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parameters_users_id_status` FOREIGN KEY (`id_status`) REFERENCES `parameters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla gestion_activos.users: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
