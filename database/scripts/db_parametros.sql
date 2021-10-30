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

-- Volcando datos para la tabla gestion_activos.parameters: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `parameters` DISABLE KEYS */;
INSERT INTO `parameters` (`id`, `id_parent`, `parameter_key`, `name`, `num_val`, `str_val`, `is_active`, `is_editable`, `is_editable_details`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'APP_KEY', 'Identificador que representa un módulo o proceso del sistema', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(2, NULL, 'ASSET_BRAND', 'Marcas de los activos', NULL, NULL, 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(3, NULL, 'ASSET_GROUP', 'Grupos de activos', NULL, NULL, 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(4, NULL, 'ASSET_MAINTENANCE_FREQUENCE', 'Frecuencia del mantenimiento de un activo', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(5, NULL, 'ASSET_STATUS', 'Estado de un activo fijo', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(6, NULL, 'ASSET_UPDATE_COST', 'Tipo de acción que afecta el costo del activo', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(7, NULL, 'ASSET_UPDATE_COST_STATUS', 'Estados para los procesos de depreciación y revaluación', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(8, NULL, 'CERTIFICATES_ASSET_STATUS', 'Estado físico del activo a entregar', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(9, NULL, 'CERTIFICATES_STATUS', 'Estados de las actas', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(10, NULL, 'COMPANY_AREAS', 'Áreas de la compañía', NULL, NULL, 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(11, NULL, 'COMPANY_INFO', 'Información de la compañía', NULL, NULL, 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(12, NULL, 'COMPANY_POSITIONS', 'Cargos de la compañía', NULL, NULL, 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(13, NULL, 'DEPARTMENTS', 'Departamentos de Colombia', NULL, NULL, 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(14, NULL, 'DERECOGNITION_REASONS', 'Motivos para dar de baja a un activo', NULL, NULL, 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(15, NULL, 'DERECOGNITION_STATUS', 'Estados que puede tener un proceso de baja de activos', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(16, NULL, 'DOCUMENT_TYPE', 'Tipos de documentos de identidad', NULL, NULL, 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(17, NULL, 'EMAILS_TEMPLATES', 'Plantillas para el envío de correos', NULL, NULL, 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(18, NULL, 'GENERIC_AREA_MANAGEMENT_ASSETS', 'Identificador de un área genérica en el sistema que solo es utilizada para indicar que un activo no ', 195.00000, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(19, NULL, 'GENERIC_USER_MANAGEMENT_ASSETS', 'Identificador de un usuario genérico en el sistema que solo es utilizado para indicar que un activo ', 1.00000, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(20, NULL, 'INVENTORY_STATUS', 'Estados que puede tener un proceso de inventario de activos', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(21, NULL, 'IVA', 'IVA', 0.19000, NULL, 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(22, NULL, 'MAINTENANCE_STATUS', 'Estados que puede tener un proceso de mantenimiento de activos', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(23, NULL, 'MAINTENANCE_TYPE', 'Tipos de mantenimiento', NULL, NULL, 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(24, NULL, 'PAYMENT_METHODS', 'Métodos de pago', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(25, NULL, 'PURCHASE_STATUS', 'Estados que puede tener una orden de compra', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(26, NULL, 'SENDER_EMAIL', 'Email remitente de los mensajes', NULL, 'email@email.com', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(27, NULL, 'SENDER_EMAIL_FROM', 'Nombre del remitente de correos', NULL, 'Activos Fijos Modern Soflutions', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(28, NULL, 'SMMLV', 'SMMLV del año en curso', 908526.00000, NULL, 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(29, NULL, 'USER_ROLE', 'Roles de los usuarios del sistema', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(30, NULL, 'USER_STATUS', 'Estados de los usuarios del sistema', NULL, NULL, 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(31, NULL, 'ASSET_AMOUNT', 'Valor para considerar un bien como activo fijo', 700000.00000, NULL, 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(32, NULL, 'ASSET_DEPRECATION_RESIDUAL_VALUE', 'Valor residual para la depreciación en porcentaje', 0.05000, NULL, 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(100, 1, 'ASSETS', '', NULL, 'Activos', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(101, 1, 'ATTATCHMENTS', '', NULL, 'Adjuntos', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(102, 1, 'AUTH', '', NULL, 'Autenticación', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(103, 1, 'CERTIFICATES', '', NULL, 'Actas', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(104, 1, 'DEPRECATIONS', '', NULL, 'Depreciaciones', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(105, 1, 'DERECOGNITIONS', '', NULL, 'Bajas', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(106, 1, 'INVENTORIES', '', NULL, 'Inventarios', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(107, 1, 'MAINTENANCES', '', NULL, 'Mantenimientos', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(108, 1, 'PARAMETERS', '', NULL, 'Parámetros', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(109, 1, 'PROVIDERS', '', NULL, 'Proveedores', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(110, 1, 'PURCHASES', '', NULL, 'Compras', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(111, 1, 'REVALUATIONS', '', NULL, 'Revaluaciones', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(112, 1, 'USERS', '', NULL, 'Usuarios', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(113, 2, '', '', NULL, 'Apple', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(114, 2, '', '', NULL, 'Asus', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(115, 2, '', '', NULL, 'Diseñar Modulares', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(116, 2, '', '', NULL, 'HP', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(117, 2, '', '', NULL, 'Huawei', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(118, 2, '', '', NULL, 'Lenovo', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(119, 2, '', '', NULL, 'LG', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(120, 2, '', '', NULL, 'Logitech', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(121, 2, '', '', NULL, 'Motorola', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(122, 2, '', '', NULL, 'Ricoh', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(123, 2, '', '', NULL, 'Samsung', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(124, 2, '', '', NULL, 'Unitec', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(125, 2, '', '', NULL, 'Wacom', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(126, 3, 'ASSET_GROUP_LANDS', 'Ítems del grupo de activos de terrenos', 1.00000, 'Terrenos', 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(127, 3, 'ASSET_GROUP_BUILDINGS', 'Ítems del grupo de activos de construcciones y edificaciones', 2.00000, 'Construcciones y edificaciones', 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(128, 3, 'ASSET_GROUP_MACHINERY_EQUIPMENT', 'Ítems del grupo de activos de maquinaria y equipo', 3.00000, 'Maquinaria y equipo', 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(129, 3, 'ASSET_GROUP_OFFICE_EQUIPMENT', 'Ítems del grupo de activos de equipo de oficina', 4.00000, 'Equipo de oficina', 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(130, 3, 'ASSET_GROUP_COMPUTER_COMMUNICATION_EQUIPMENT', 'Ítems del grupo de activos de equipo de computación y comunicación', 5.00000, 'Equipo de computación y comunicación', 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(131, 3, 'ASSET_GROUP_TRANSPORTATION', 'Ítems del grupo de activos de flota y equipo de transporte', 6.00000, 'Flota y equipo de transporte', 1, 0, 1, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(132, 126, '', '', NULL, 'Lote', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(133, 127, '', '', NULL, 'Apartamento', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(134, 127, '', '', NULL, 'Casa', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(135, 127, '', '', NULL, 'Edificio', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(136, 127, '', '', NULL, 'Oficina', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(137, 128, '', '', NULL, 'Aire acondicionado', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(138, 128, '', '', NULL, 'Cafetera', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(139, 128, '', '', NULL, 'Caja fuerte', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(140, 128, '', '', NULL, 'Cámara de seguridad', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(141, 128, '', '', NULL, 'DVR', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(142, 128, '', '', NULL, 'Horno microondas', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(143, 128, '', '', NULL, 'Planta de alimentación', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(144, 128, '', '', NULL, 'UPS', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(145, 129, '', '', NULL, 'Escritorio', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(146, 129, '', '', NULL, 'Impresora', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(147, 129, '', '', NULL, 'Mesa', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(148, 129, '', '', NULL, 'Proyector', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(149, 129, '', '', NULL, 'Rack', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(150, 129, '', '', NULL, 'Silla', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(151, 129, '', '', NULL, 'Tablero', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(152, 130, '', '', NULL, 'Celular', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(153, 130, '', '', NULL, 'Computador de escritorio', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(154, 130, '', '', NULL, 'Computador portátil', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(155, 130, '', '', NULL, 'Monitor', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(156, 130, '', '', NULL, 'Tablet', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(157, 130, '', '', NULL, 'Tablet digitalizadora', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(158, 130, '', '', NULL, 'Teléfono', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(159, 130, '', '', NULL, 'Torre', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(160, 131, '', '', NULL, 'Bicicleta', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(161, 131, '', '', NULL, 'Camión', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(162, 131, '', '', NULL, 'Camioneta', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(163, 131, '', '', NULL, 'Carro', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(164, 131, '', '', NULL, 'Moto', 1, 1, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(165, 4, 'ASSET_MAINTENANCE_ANNUAL', '', 12.00000, 'Anual', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(166, 4, 'ASSET_MAINTENANCE_BIANNUAL', '', 6.00000, 'Semestral', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(167, 4, 'ASSET_MAINTENANCE_BIMONTHLY', '', 2.00000, 'Bimestral', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(168, 4, 'ASSET_MAINTENANCE_MONTHLY', '', 1.00000, 'Mensual', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(169, 4, 'ASSET_MAINTENANCE_NOT_REQUIRE', '', 0.00000, 'No requiere', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(170, 4, 'ASSET_MAINTENANCE_QUARTERLY', '', 3.00000, 'Trimestral', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(171, 5, 'ASSET_ASSIGNED', '', NULL, 'Asignado', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(172, 5, 'ASSET_DECOMMISSIONED', '', NULL, 'Dado de baja', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(173, 5, 'ASSET_UNASSIGNED', '', NULL, 'Sin asignar', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(174, 6, 'ASSET_DEPRECIATION', '', NULL, 'Depreciación', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(175, 6, 'ASSET_REVALUATION', '', NULL, 'Revaluación', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(176, 7, 'ASSET_UPDATE_COST_IN_PROCESS', '', NULL, 'En Proceso', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(177, 7, 'ASSET_UPDATE_COST_EXECUTED', '', NULL, 'Ejecutada', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(178, 7, 'ASSET_UPDATE_COST_REVERSED', '', NULL, 'Reversada', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(179, 7, 'ASSET_UPDATE_COST_CANCELLED', '', NULL, 'Anulada', 1, 0, 0, '2021-10-29 21:03:54', '2021-10-29 21:03:54'),
	(180, 9, 'CERTIFICATE_IN_PROCESS', '', NULL, 'En Proceso', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(181, 9, 'CERTIFICATE_CHECKING', '', NULL, 'En Revisión', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(182, 9, 'CERTIFICATE_APPROVED', '', NULL, 'Aprobada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(183, 9, 'CERTIFICATE_REJECTED', '', NULL, 'Rechazada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(184, 9, 'CERTIFICATE_SIGNATURE_PROCESS', '', NULL, 'En Proceso de Firma', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(185, 9, 'CERTIFICATE_ACTIVE', '', NULL, 'Activa', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(186, 9, 'CERTIFICATE_INACTIVE', '', NULL, 'Inactiva', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(187, 9, 'CERTIFICATE_CANCELLED', '', NULL, 'Anulada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(188, 8, '', '', NULL, 'Buen estado', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(189, 8, '', '', NULL, 'Deteriorado', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(190, 8, '', '', NULL, 'Mal estado', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(191, 8, '', '', NULL, 'Dañado', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(192, 10, '', '', NULL, 'Contabilidad', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(193, 10, '', '', NULL, 'Desarrollo', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(194, 10, '', '', NULL, 'Diseño', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(195, 10, '', '', NULL, 'Soporte', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(196, 10, '', '', NULL, 'Gerencia', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(197, 12, '', '', NULL, 'Gerente', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(198, 12, '', '', NULL, 'Director(a) Creativo(a)', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(199, 12, '', '', NULL, 'Contador(a)', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(200, 12, '', '', NULL, 'Desarrollador(a)', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(201, 12, '', '', NULL, 'Diseñador(a)', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(202, 12, '', '', NULL, 'Ejecutivo(a)', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(203, 13, '', '', 76.00000, 'Valle del Cauca', 1, 1, 1, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(204, 203, '', '', 76001.00000, 'Cali', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(205, 14, '', '', NULL, 'Daño', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(206, 14, '', '', NULL, 'Desuso', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(207, 14, '', '', NULL, 'Deterioro', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(208, 14, '', '', NULL, 'Error de registro', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(209, 14, '', '', NULL, 'Obsolescencia', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(210, 14, '', '', NULL, 'Pérdida', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(211, 14, '', '', NULL, 'Robo', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(212, 14, '', '', NULL, 'Venta', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(213, 14, '', '', NULL, 'Vida útil', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(214, 15, 'DERECOGNITION_IN_PROCESS', '', NULL, 'En Proceso', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(215, 15, 'DERECOGNITION_CHECKING', '', NULL, 'En Revisión', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(216, 15, 'DERECOGNITION_APPROVED', '', NULL, 'Aprobada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(217, 15, 'DERECOGNITION_REJECTED', '', NULL, 'Rechazada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(218, 15, 'DERECOGNITION_EXECUTED', '', NULL, 'Ejecutada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(219, 15, 'DERECOGNITION_REVERSED', '', NULL, 'Reversada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(220, 15, 'DERECOGNITION_CANCELLED', '', NULL, 'Anulada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(221, 20, 'INVENTORY_IN_PROCESS', '', NULL, 'En Proceso', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(222, 20, 'INVENTORY_FINISHED', '', NULL, 'Finalizado', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(223, 22, 'MAINTENANCE_IN_PROCESS', '', NULL, 'En Proceso', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(224, 22, 'MAINTENANCE_FINISHED', '', NULL, 'Finalizado', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(225, 22, 'MAINTENANCE_CANCELLED', '', NULL, 'Anulado', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(226, 23, '', '', NULL, 'Adaptativo', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(227, 23, '', '', NULL, 'Correctivo', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(228, 23, '', '', NULL, 'Predictivo', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(229, 23, '', '', NULL, 'Preventivo', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(230, 24, 'CREDIT_PAYMENT', '', NULL, 'Crédito', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(231, 24, 'EFFECTIVE_PAYMENT', '', NULL, 'Efectivo', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(232, 25, 'PURCHASE_STATUS_IN_PROCESS', '', NULL, 'En Proceso', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(233, 25, 'PURCHASE_STATUS_CHECKING', '', NULL, 'En Revisión', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(234, 25, 'PURCHASE_STATUS_CANCELLED', '', NULL, 'Anulada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(235, 25, 'PURCHASE_STATUS_APPROVED', '', NULL, 'Aprobada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(236, 25, 'PURCHASE_STATUS_REJECTED', '', NULL, 'Rechazada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(237, 25, 'PURCHASE_STATUS_CLOSED', '', NULL, 'Cerrada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(238, 25, 'PURCHASE_STATUS_FINISHED', '', NULL, 'Finalizada', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(239, 29, 'USER_ROLE_ADMIN', '', NULL, 'Administrador', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(240, 29, 'USER_ROLE_APPROVER', '', NULL, 'Aprobador', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(241, 29, 'USER_ROLE_RESPONSIBLE', '', NULL, 'Responsable', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(242, 30, 'USER_STATUS_ACTIVE', '', NULL, 'Activo', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(243, 30, 'USER_STATUS_INACTIVE', '', NULL, 'Inactivo', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(244, 30, 'USER_STATUS_LOCKED', '', NULL, 'Bloqueado', 1, 0, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(245, 11, 'COMPANY_NAME', '', NULL, 'Modern Soflutions', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(246, 11, 'COMPANY_DOCUMENT_NUMBER', '', NULL, '901378835 - 4', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(247, 11, 'COMPANY_ADDRESS', '', NULL, 'Cl. 23 Nte # 3-33 OF. 606, Ed. Peñas Blancas', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(248, 11, 'COMPANY_PHONE_NUMBER', '', NULL, '3197648512', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(249, 11, 'COMPANY_CITY_ID', '', 203.00000, NULL, 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(250, 16, '', '', NULL, 'CC', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(251, 16, '', '', NULL, 'CE', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(252, 16, '', '', NULL, 'TI', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(253, 16, '', '', NULL, 'NIT', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(254, 16, '', '', NULL, 'PAS', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(255, 17, 'EMAIL_TEMPLATE_HEADER', '', NULL, '<div style="margin: 10px 0px;"><img src="https://lh5.googleusercontent.com/pUafnUNY7Zhn9pJx-91xd4GSx1kEgwAw2IYFkA_bslIirCxlp0ZlE_yISwXu625mBYwDeLcumQFyAX9rnElf=w1920-h977-rw" style="width: 100%;" /></div>', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(256, 17, 'EMAIL_TEMPLATE_FOOTER', '', NULL, '<div style="margin: 10px 0px;"><p style="font-size: 12px;">Mensaje generado automáticamente por el <b> Sistema de Gestión de Activos </b> de <b> Modern Soflutions </b>. Por favor no responda a este email.</p></div>', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(257, 17, 'EMAIL_TEMPLATE_RECOVERY_PASSWORD_USER', 'Solicitud de recuperación de contraseña', NULL, '<div><h1>Hola {{name}}</h1><p>Solicitaste un cambio de contraseña. Si no fuiste tu quién solicitó el cambio por favor comunícate con el adminstrador del sistema.</p><p>Se ha generado la siguiente clave temporal que deberás utilizar para tu siguiente inicio de sesión. Luego de iniciada la sesión deberás de generar una nueva contraseña.</p><h3>Nueva contraseña: {{password}}</h3></div>', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(258, 17, 'EMAIL_TEMPLATE_PURCHASE_APPROVED', 'Aprobación orden de compra [{{id_order}}]', NULL, '<div><p>La orden de compra Nº {{id_order}} ha sido aprovada por {{approver_name}} el {{approved_at}}.</p></div>', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(259, 17, 'EMAIL_TEMPLATE_CERTIFICATE_APPROVED', 'Aprobación acta de movimiento [{{id_certificate}}]', NULL, '<div><p>El acta de movimiento Nº {{id_certificate}} ha sido aprobada por {{approver_name}} el {{approved_at}}.</p></div>', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(260, 17, 'EMAIL_TEMPLATE_CERTIFICATE_SIGNATURE_PENDING', 'Firma de acta de movimiento [{{id_certificate}}]', NULL, '<div><p>Se solicita la firma de recibido para el acta de movimiento Nº {{id_certificate}}.</p></div>', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(261, 17, 'EMAIL_TEMPLATE_CERTIFICATE_ACTIVE', 'Acta de movimiento [{{id_certificate}}] firmada', NULL, '<div><p>El responsable {{name}} ha firmado el recibido del acta de movimiento Nº {{id_certificate}}.</p></div>', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(262, 17, 'EMAIL_TEMPLATE_DERECOGNITIOIN_APPROVED', 'Aprobación acta de proceso de baja de activos [{{id_derecognition}}]', NULL, '<div><p>El proceso de baja de activos Nº {{id_derecognition}} ha sido aprobada por {{approver_name}} el {{approved_at}}.</p></div>', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55'),
	(263, 17, 'EMAIL_TEMPLATE_USER_PASSWORD', 'Generación de contraseña', NULL, '<div><h1>Hola {{name}}</h1><p>El administrador del sistema le ha generado la siguiente contraseña, la cual debe de ser cambiada en el siguiente inicio de sesión.</p><h3>Nueva contraseña: {{password}}</h3></div>', 1, 1, 0, '2021-10-29 21:03:55', '2021-10-29 21:03:55');
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
