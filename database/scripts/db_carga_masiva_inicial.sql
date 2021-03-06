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
  `init_value` decimal(20,2) DEFAULT NULL,
  `residual_value` decimal(20,2) NOT NULL,
  `current_value` decimal(20,2) NOT NULL,
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
INSERT INTO `assets` (`id`, `id_asset_group`, `id_asset_type`, `asset_number`, `name`, `description`, `id_brand`, `model`, `serial_number`, `entry_date`, `init_value`, `residual_value`, `current_value`, `use_life`, `id_maintenance_frequence`, `maintenance_date`, `id_purchase_item`, `id_status`, `created_at`, `updated_at`) VALUES
	(1, 130, 154, '130-154-000001', 'Computador', 'Core i5, 16 GB RAM, 1 TB SSD, 14’’', 114, 'X441U', '000-000-0000', '2020-12-14', 2975000.00, 148750.00, 2975000.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(2, 130, 154, '130-154-000002', 'Computador', 'Core i7, 16 GB RAM, 1 TB SSD, 14’’', 114, 'Zenbook', '000-000-0000', '2020-12-14', 5162500.00, 258125.00, 5162500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(3, 130, 154, '130-154-000003', 'Computador', 'Core i9, 16 GB RAM, 1 TB SSD, 14’’', 114, 'Rog', '000-000-0000', '2020-12-14', 10325000.00, 516250.00, 10325000.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(4, 130, 154, '130-154-000004', 'Computador', 'Core i9, 16 GB RAM, 1 TB SSD, 14’’', 114, 'Rog', '000-000-0000', '2020-12-14', 10325000.00, 516250.00, 10325000.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(5, 130, 154, '130-154-000005', 'Computador', 'Core i9, 16 GB RAM, 1 TB SSD, 14’’', 114, 'Rog', '000-000-0000', '2020-12-14', 10325000.00, 516250.00, 10325000.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(6, 130, 154, '130-154-000006', 'Computador', 'Core i7, 16 GB RAM, 1 TB SSD, 14’’', 114, 'Zenbook', '000-000-0000', '2020-12-14', 5162500.00, 258125.00, 5162500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(7, 130, 154, '130-154-000007', 'Computador', 'Core i7, 16 GB RAM, 1 TB SSD, 14’’', 114, 'Zenbook', '000-000-0000', '2020-12-14', 5162500.00, 258125.00, 5162500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(8, 130, 154, '130-154-000008', 'Computador', 'Core i7, 16 GB RAM, 1 TB SSD, 14’’', 114, 'Zenbook', '000-000-0000', '2020-12-14', 5162500.00, 258125.00, 5162500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(9, 130, 154, '130-154-000009', 'Computador', 'Core i5, 8 GB RAM, 500 GB SSD, 14’’', 114, 'X555', '000-000-0000', '2020-12-14', 2800000.00, 140000.00, 2800000.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(10, 130, 154, '130-154-000010', 'Computador', 'Core i5, 8 GB RAM, 500 GB SSD, 14’’', 114, 'X555', '000-000-0000', '2020-12-14', 2800000.00, 140000.00, 2800000.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(11, 130, 155, '130-155-000011', 'Monitor', '24 \' IPS', 123, 'LS24F', '000-000-0000', '2020-12-14', 1137500.00, 56875.00, 1137500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(12, 130, 155, '130-155-000012', 'Monitor', '24 \' IPS', 123, 'LS24F', '000-000-0000', '2020-12-14', 1137500.00, 56875.00, 1137500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(13, 130, 155, '130-155-000013', 'Monitor', '24 \' IPS', 123, 'LS24F', '000-000-0000', '2020-12-14', 1137500.00, 56875.00, 1137500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(14, 130, 155, '130-155-000014', 'Monitor', '24 \' IPS', 123, 'LS24F', '000-000-0000', '2020-12-14', 1137500.00, 56875.00, 1137500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(15, 130, 155, '130-155-000015', 'Monitor', '24 \' IPS', 123, 'LS24F', '000-000-0000', '2020-12-14', 1137500.00, 56875.00, 1137500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(16, 130, 155, '130-155-000016', 'Monitor', '24 \' IPS', 123, 'LS24F', '000-000-0000', '2020-12-14', 1137500.00, 56875.00, 1137500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(17, 130, 155, '130-155-000017', 'Monitor', '24 \' IPS', 123, 'LS24F', '000-000-0000', '2020-12-14', 1137500.00, 56875.00, 1137500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(18, 130, 155, '130-155-000018', 'Monitor', '24 \' IPS', 123, 'LS24F', '000-000-0000', '2020-12-14', 1137500.00, 56875.00, 1137500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(19, 130, 155, '130-155-000019', 'Monitor', '24 \' IPS', 123, 'LS24F', '000-000-0000', '2020-12-14', 1137500.00, 56875.00, 1137500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(20, 130, 155, '130-155-000020', 'Monitor', '24 \' IPS', 123, 'LS24F', '000-000-0000', '2020-12-14', 1137500.00, 56875.00, 1137500.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(21, 130, 153, '130-153-000021', 'Mouse/Teclado', 'Combo', 120, 'MK 230 o 220', '000-000-0000', '2020-12-14', 140000.00, 7000.00, 140000.00, 2, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(22, 130, 153, '130-153-000022', 'Mouse/Teclado', 'Combo', 120, 'MK 230 o 220', '000-000-0000', '2020-12-14', 140000.00, 7000.00, 140000.00, 2, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(23, 130, 153, '130-153-000023', 'Mouse/Teclado', 'Combo', 120, 'MK 230 o 220', '000-000-0000', '2020-12-14', 140000.00, 7000.00, 140000.00, 2, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(24, 130, 153, '130-153-000024', 'Mouse/Teclado', 'Combo', 120, 'MK 230 o 220', '000-000-0000', '2020-12-14', 140000.00, 7000.00, 140000.00, 2, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(25, 130, 153, '130-153-000025', 'Mouse/Teclado', 'Combo', 120, 'MK 230 o 220', '000-000-0000', '2020-12-14', 140000.00, 7000.00, 140000.00, 2, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(26, 130, 153, '130-153-000026', 'Mouse/Teclado', 'Combo', 120, 'MK 230 o 220', '000-000-0000', '2020-12-14', 140000.00, 7000.00, 140000.00, 2, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(27, 130, 153, '130-153-000027', 'Mouse/Teclado', 'Combo', 120, 'MK 230 o 220', '000-000-0000', '2020-12-14', 140000.00, 7000.00, 140000.00, 2, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(28, 130, 153, '130-153-000028', 'Mouse/Teclado', 'Combo', 120, 'MK 230 o 220', '000-000-0000', '2020-12-14', 140000.00, 7000.00, 140000.00, 2, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(29, 130, 153, '130-153-000029', 'Mouse/Teclado', 'Combo', 120, 'MK 230 o 220', '000-000-0000', '2020-12-14', 140000.00, 7000.00, 140000.00, 2, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(30, 130, 153, '130-153-000030', 'Mouse/Teclado', 'Combo', 120, 'MK 230 o 220', '000-000-0000', '2020-12-14', 140000.00, 7000.00, 140000.00, 2, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(31, 130, 156, '130-156-000031', 'Tableta', '', 125, 'Intuos', '000-000-0000', '2020-12-14', 997500.00, 49875.00, 997500.00, 2, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(32, 130, 156, '130-156-000032', 'Tableta', '', 125, 'Intuos', '000-000-0000', '2020-12-14', 997500.00, 49875.00, 997500.00, 2, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(33, 130, 156, '130-156-000033', 'Tableta', '', 125, 'Intuos', '000-000-0000', '2020-12-14', 997500.00, 49875.00, 997500.00, 2, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(34, 130, 153, '130-153-000034', 'Diadema', '', 120, 'H390', '000-000-0000', '2020-12-14', 218750.00, 10937.00, 218750.00, 2, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(35, 130, 153, '130-153-000035', 'Diadema', '', 120, 'H390', '000-000-0000', '2020-12-14', 218750.00, 10937.00, 218750.00, 2, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(36, 130, 153, '130-153-000036', 'Diadema', '', 120, 'H390', '000-000-0000', '2020-12-14', 218750.00, 10937.00, 218750.00, 2, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(37, 130, 153, '130-153-000037', 'Diadema', '', 120, 'H390', '000-000-0000', '2020-12-14', 218750.00, 10937.00, 218750.00, 2, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(38, 130, 153, '130-153-000038', 'Diadema', '', 120, 'H390', '000-000-0000', '2020-12-14', 218750.00, 10937.00, 218750.00, 2, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(39, 130, 153, '130-153-000039', 'Diadema', '', 120, 'H390', '000-000-0000', '2020-12-14', 218750.00, 10937.00, 218750.00, 2, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(40, 130, 153, '130-153-000040', 'Diadema', '', 120, 'H390', '000-000-0000', '2020-12-14', 218750.00, 10937.00, 218750.00, 2, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(41, 130, 153, '130-153-000041', 'Diadema', '', 120, 'H390', '000-000-0000', '2020-12-14', 218750.00, 10937.00, 218750.00, 2, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(42, 130, 153, '130-153-000042', 'Diadema', '', 120, 'H390', '000-000-0000', '2020-12-14', 218750.00, 10937.00, 218750.00, 2, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(43, 130, 153, '130-153-000043', 'Diadema', '', 120, 'H390', '000-000-0000', '2020-12-14', 218750.00, 10937.00, 218750.00, 2, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(44, 128, 144, '128-144-000044', 'UPS', '1000 KVA', 124, '', '000-000-0000', '2020-12-14', 1225000.00, 61250.00, 1225000.00, 5, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(45, 129, 145, '129-145-000045', 'Escritorio', '', 115, '', '000-000-0000', '2020-12-14', 376250.00, 18812.00, 376250.00, 10, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(46, 129, 145, '129-145-000046', 'Escritorio', '', 115, '', '000-000-0000', '2020-12-14', 376250.00, 18812.00, 376250.00, 10, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(47, 129, 145, '129-145-000047', 'Escritorio', '', 115, '', '000-000-0000', '2020-12-14', 376250.00, 18812.00, 376250.00, 10, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(48, 129, 145, '129-145-000048', 'Escritorio', '', 115, '', '000-000-0000', '2020-12-14', 376250.00, 18812.00, 376250.00, 10, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(49, 129, 145, '129-145-000049', 'Escritorio', '', 115, '', '000-000-0000', '2020-12-14', 376250.00, 18812.00, 376250.00, 10, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(50, 129, 145, '129-145-000050', 'Escritorio', '', 115, '', '000-000-0000', '2020-12-14', 376250.00, 18812.00, 376250.00, 10, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(51, 129, 145, '129-145-000051', 'Escritorio', '', 115, '', '000-000-0000', '2020-12-14', 376250.00, 18812.00, 376250.00, 10, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(52, 129, 145, '129-145-000052', 'Escritorio', '', 115, '', '000-000-0000', '2020-12-14', 376250.00, 18812.00, 376250.00, 10, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(53, 129, 145, '129-145-000053', 'Escritorio', '', 115, '', '000-000-0000', '2020-12-14', 376250.00, 18812.00, 376250.00, 10, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(54, 129, 145, '129-145-000054', 'Escritorio', '', 115, '', '000-000-0000', '2020-12-14', 376250.00, 18812.00, 376250.00, 10, 169, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(55, 129, 150, '129-150-000055', 'Silla', '', 115, '', '000-000-0000', '2020-12-14', 350000.00, 17500.00, 350000.00, 10, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(56, 129, 150, '129-150-000056', 'Silla', '', 115, '', '000-000-0000', '2020-12-14', 350000.00, 17500.00, 350000.00, 10, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(57, 129, 150, '129-150-000057', 'Silla', '', 115, '', '000-000-0000', '2020-12-14', 350000.00, 17500.00, 350000.00, 10, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(58, 129, 150, '129-150-000058', 'Silla', '', 115, '', '000-000-0000', '2020-12-14', 350000.00, 17500.00, 350000.00, 10, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(59, 129, 150, '129-150-000059', 'Silla', '', 115, '', '000-000-0000', '2020-12-14', 350000.00, 17500.00, 350000.00, 10, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(60, 129, 150, '129-150-000060', 'Silla', '', 115, '', '000-000-0000', '2020-12-14', 350000.00, 17500.00, 350000.00, 10, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(61, 129, 150, '129-150-000061', 'Silla', '', 115, '', '000-000-0000', '2020-12-14', 350000.00, 17500.00, 350000.00, 10, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(62, 129, 150, '129-150-000062', 'Silla', '', 115, '', '000-000-0000', '2020-12-14', 350000.00, 17500.00, 350000.00, 10, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(63, 129, 150, '129-150-000063', 'Silla', '', 115, '', '000-000-0000', '2020-12-14', 350000.00, 17500.00, 350000.00, 10, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(64, 129, 150, '129-150-000064', 'Silla', '', 115, '', '000-000-0000', '2020-12-14', 350000.00, 17500.00, 350000.00, 10, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(65, 129, 147, '129-147-000065', 'Mesa', '', 115, '', '000-000-0000', '2020-12-14', 700000.00, 35000.00, 700000.00, 10, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(66, 130, 156, '130-156-000066', 'Tableta', '', 118, 'Smart Yoga', '000-000-0000', '2020-12-14', 1575000.00, 78750.00, 1575000.00, 2, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(67, 130, 156, '130-156-000067', 'Tableta', '', 118, 'Smart Yoga', '000-000-0000', '2020-12-14', 1575000.00, 78750.00, 1575000.00, 2, 165, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(68, 129, 146, '129-146-000068', 'Impresora', 'Multifuncional 45ppm', 122, 'Im430f', '000-000-0000', '2020-12-14', 3500000.00, 175000.00, 3500000.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(69, 129, 146, '129-146-000069', 'Impresora', 'Color', 122, 'Mp C307spf', '000-000-0000', '2020-12-14', 8750000.00, 437500.00, 8750000.00, 5, 166, NULL, NULL, 173, '2022-02-15 14:04:28', '2022-02-15 14:04:28');
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
INSERT INTO `attachments` (`id`, `id_app_key`, `id_register`, `file_name`, `is_active`, `created_at`, `updated_at`) VALUES
	(2, 112, 2, '00000000000000_USERS_2_sara_admin.png', 1, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(3, 112, 3, '00000000000000_USERS_3_sebastián_aprobador.png', 1, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(4, 112, 4, '00000000000000_USERS_4_cristian_responsable.png', 1, '2022-02-15 14:04:28', '2022-02-15 14:04:28');
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
  `old_value` decimal(20,2) NOT NULL,
  `new_value` decimal(20,2) NOT NULL,
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
  `num_val` decimal(20,2) DEFAULT NULL,
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

-- Volcando datos para la tabla gestion_activos.parameters: ~196 rows (aproximadamente)
/*!40000 ALTER TABLE `parameters` DISABLE KEYS */;
INSERT INTO `parameters` (`id`, `id_parent`, `parameter_key`, `name`, `num_val`, `str_val`, `is_active`, `is_editable`, `is_editable_details`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'APP_KEY', 'Identificador que representa un módulo o proceso del sistema', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(2, NULL, 'ASSET_BRAND', 'Marcas de los activos', NULL, NULL, 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(3, NULL, 'ASSET_GROUP', 'Grupos de activos', NULL, NULL, 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(4, NULL, 'ASSET_MAINTENANCE_FREQUENCE', 'Frecuencia del mantenimiento de un activo', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(5, NULL, 'ASSET_STATUS', 'Estado de un activo fijo', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(6, NULL, 'ASSET_UPDATE_COST', 'Tipo de acción que afecta el costo del activo', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(7, NULL, 'ASSET_UPDATE_COST_STATUS', 'Estados para los procesos de depreciación y revaluación', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(8, NULL, 'CERTIFICATES_ASSET_STATUS', 'Estado físico del activo a entregar', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(9, NULL, 'CERTIFICATES_STATUS', 'Estados de las actas', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(10, NULL, 'COMPANY_AREAS', 'Áreas de la compañía', NULL, NULL, 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(11, NULL, 'COMPANY_INFO', 'Información de la compañía', NULL, NULL, 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(12, NULL, 'COMPANY_POSITIONS', 'Cargos de la compañía', NULL, NULL, 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(13, NULL, 'DEPARTMENTS', 'Departamentos de Colombia', NULL, NULL, 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(14, NULL, 'DERECOGNITION_REASONS', 'Motivos para dar de baja a un activo', NULL, NULL, 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(15, NULL, 'DERECOGNITION_STATUS', 'Estados que puede tener un proceso de baja de activos', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(16, NULL, 'DOCUMENT_TYPE', 'Tipos de documentos de identidad', NULL, NULL, 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(17, NULL, 'EMAILS_TEMPLATES', 'Plantillas para el envío de correos', NULL, NULL, 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(18, NULL, 'GENERIC_AREA_MANAGEMENT_ASSETS', 'Identificador de un área genérica en el sistema que solo es utilizada para indicar que un activo no ', 195, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(19, NULL, 'GENERIC_USER_MANAGEMENT_ASSETS', 'Identificador de un usuario genérico en el sistema que solo es utilizado para indicar que un activo ', 1, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(20, NULL, 'INVENTORY_STATUS', 'Estados que puede tener un proceso de inventario de activos', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(21, NULL, 'IVA', 'IVA', 0.19, NULL, 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(22, NULL, 'MAINTENANCE_STATUS', 'Estados que puede tener un proceso de mantenimiento de activos', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(23, NULL, 'MAINTENANCE_TYPE', 'Tipos de mantenimiento', NULL, NULL, 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(24, NULL, 'PAYMENT_METHODS', 'Métodos de pago', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(25, NULL, 'PURCHASE_STATUS', 'Estados que puede tener una orden de compra', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(26, NULL, 'SENDER_EMAIL', 'Email remitente de los mensajes', NULL, 'activos.fijos.ms@gmail.com', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(27, NULL, 'SENDER_EMAIL_FROM', 'Nombre del remitente de correos', NULL, 'Activos Fijos Modern Soflutions', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(28, NULL, 'SMMLV', 'SMMLV del año en curso', 1000000, NULL, 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(29, NULL, 'USER_ROLE', 'Roles de los usuarios del sistema', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(30, NULL, 'USER_STATUS', 'Estados de los usuarios del sistema', NULL, NULL, 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(31, NULL, 'ASSET_AMOUNT', 'Valor para considerar un bien como activo fijo', 1000000, NULL, 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(32, NULL, 'ASSET_DEPRECATION_RESIDUAL_VALUE', 'Valor residual para la depreciación en porcentaje', 0.05, NULL, 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(100, 1, 'ASSETS', '', NULL, 'Activos', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(101, 1, 'ATTATCHMENTS', '', NULL, 'Adjuntos', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(102, 1, 'AUTH', '', NULL, 'Autenticación', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(103, 1, 'CERTIFICATES', '', NULL, 'Actas', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(104, 1, 'DEPRECATIONS', '', NULL, 'Depreciaciones', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(105, 1, 'DERECOGNITIONS', '', NULL, 'Bajas', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(106, 1, 'INVENTORIES', '', NULL, 'Inventarios', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(107, 1, 'MAINTENANCES', '', NULL, 'Mantenimientos', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(108, 1, 'PARAMETERS', '', NULL, 'Parámetros', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(109, 1, 'PROVIDERS', '', NULL, 'Proveedores', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(110, 1, 'PURCHASES', '', NULL, 'Compras', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(111, 1, 'REVALUATIONS', '', NULL, 'Revaluaciones', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(112, 1, 'USERS', '', NULL, 'Usuarios', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(113, 2, '', '', NULL, 'Apple', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(114, 2, '', '', NULL, 'Asus', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(115, 2, '', '', NULL, 'Diseñar Modulares', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(116, 2, '', '', NULL, 'HP', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(117, 2, '', '', NULL, 'Huawei', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(118, 2, '', '', NULL, 'Lenovo', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(119, 2, '', '', NULL, 'LG', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(120, 2, '', '', NULL, 'Logitech', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(121, 2, '', '', NULL, 'Motorola', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(122, 2, '', '', NULL, 'Ricoh', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(123, 2, '', '', NULL, 'Samsung', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(124, 2, '', '', NULL, 'Unitec', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(125, 2, '', '', NULL, 'Wacom', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(126, 3, 'ASSET_GROUP_LANDS', 'Ítems del grupo de activos de terrenos', 1, 'Terrenos', 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(127, 3, 'ASSET_GROUP_BUILDINGS', 'Ítems del grupo de activos de construcciones y edificaciones', 2, 'Construcciones y edificaciones', 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(128, 3, 'ASSET_GROUP_MACHINERY_EQUIPMENT', 'Ítems del grupo de activos de maquinaria y equipo', 3, 'Maquinaria y equipo', 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(129, 3, 'ASSET_GROUP_OFFICE_EQUIPMENT', 'Ítems del grupo de activos de equipo de oficina', 4, 'Equipo de oficina', 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(130, 3, 'ASSET_GROUP_COMPUTER_COMMUNICATION_EQUIPMENT', 'Ítems del grupo de activos de equipo de computación y comunicación', 5, 'Equipo de computación y comunicación', 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(131, 3, 'ASSET_GROUP_TRANSPORTATION', 'Ítems del grupo de activos de flota y equipo de transporte', 6, 'Flota y equipo de transporte', 1, 0, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(132, 126, '', '', NULL, 'Lote', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(133, 127, '', '', NULL, 'Apartamento', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(134, 127, '', '', NULL, 'Casa', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(135, 127, '', '', NULL, 'Edificio', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(136, 127, '', '', NULL, 'Oficina', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(137, 128, '', '', NULL, 'Aire acondicionado', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(138, 128, '', '', NULL, 'Cafetera', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(139, 128, '', '', NULL, 'Caja fuerte', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(140, 128, '', '', NULL, 'Cámara de seguridad', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(141, 128, '', '', NULL, 'DVR', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(142, 128, '', '', NULL, 'Horno microondas', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(143, 128, '', '', NULL, 'Planta de alimentación', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(144, 128, '', '', NULL, 'UPS', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(145, 129, '', '', NULL, 'Escritorio', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(146, 129, '', '', NULL, 'Impresora', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(147, 129, '', '', NULL, 'Mesa', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(148, 129, '', '', NULL, 'Proyector', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(149, 129, '', '', NULL, 'Rack', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(150, 129, '', '', NULL, 'Silla', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(151, 129, '', '', NULL, 'Tablero', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(152, 130, '', '', NULL, 'Celular', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(153, 130, '', '', NULL, 'Computador de escritorio', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(154, 130, '', '', NULL, 'Computador portátil', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(155, 130, '', '', NULL, 'Monitor', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(156, 130, '', '', NULL, 'Tablet', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(157, 130, '', '', NULL, 'Tablet digitalizadora', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(158, 130, '', '', NULL, 'Teléfono', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(159, 130, '', '', NULL, 'Torre', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(160, 131, '', '', NULL, 'Bicicleta', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(161, 131, '', '', NULL, 'Camión', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(162, 131, '', '', NULL, 'Camioneta', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(163, 131, '', '', NULL, 'Carro', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(164, 131, '', '', NULL, 'Moto', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(165, 4, 'ASSET_MAINTENANCE_ANNUAL', '', 12, 'Anual', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(166, 4, 'ASSET_MAINTENANCE_BIANNUAL', '', 6, 'Semestral', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(167, 4, 'ASSET_MAINTENANCE_BIMONTHLY', '', 2, 'Bimestral', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(168, 4, 'ASSET_MAINTENANCE_MONTHLY', '', 1, 'Mensual', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(169, 4, 'ASSET_MAINTENANCE_NOT_REQUIRE', '', 0, 'No requiere', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(170, 4, 'ASSET_MAINTENANCE_QUARTERLY', '', 3, 'Trimestral', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(171, 5, 'ASSET_ASSIGNED', '', NULL, 'Asignado', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(172, 5, 'ASSET_DECOMMISSIONED', '', NULL, 'Dado de baja', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(173, 5, 'ASSET_UNASSIGNED', '', NULL, 'Sin asignar', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(174, 6, 'ASSET_DEPRECIATION', '', NULL, 'Depreciación', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(175, 6, 'ASSET_REVALUATION', '', NULL, 'Revaluación', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(176, 7, 'ASSET_UPDATE_COST_IN_PROCESS', '', NULL, 'En Proceso', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(177, 7, 'ASSET_UPDATE_COST_EXECUTED', '', NULL, 'Ejecutada', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(178, 7, 'ASSET_UPDATE_COST_REVERSED', '', NULL, 'Reversada', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(179, 7, 'ASSET_UPDATE_COST_CANCELLED', '', NULL, 'Anulada', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(180, 9, 'CERTIFICATE_IN_PROCESS', '', NULL, 'En Proceso', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(181, 9, 'CERTIFICATE_CHECKING', '', NULL, 'En Revisión', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(182, 9, 'CERTIFICATE_APPROVED', '', NULL, 'Aprobada', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(183, 9, 'CERTIFICATE_REJECTED', '', NULL, 'Rechazada', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(184, 9, 'CERTIFICATE_SIGNATURE_PROCESS', '', NULL, 'En Proceso de Firma', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(185, 9, 'CERTIFICATE_ACTIVE', '', NULL, 'Activa', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(186, 9, 'CERTIFICATE_INACTIVE', '', NULL, 'Inactiva', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(187, 9, 'CERTIFICATE_CANCELLED', '', NULL, 'Anulada', 1, 0, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(188, 8, '', '', NULL, 'Buen estado', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(189, 8, '', '', NULL, 'Deteriorado', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(190, 8, '', '', NULL, 'Mal estado', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(191, 8, '', '', NULL, 'Dañado', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(192, 10, '', '', NULL, 'Contabilidad', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(193, 10, '', '', NULL, 'Desarrollo', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(194, 10, '', '', NULL, 'Diseño', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(195, 10, '', '', NULL, 'Soporte', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(196, 10, '', '', NULL, 'Gerencia', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(197, 12, '', '', NULL, 'Gerente', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(198, 12, '', '', NULL, 'Director(a) Creativo(a)', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(199, 12, '', '', NULL, 'Contador(a)', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(200, 12, '', '', NULL, 'Desarrollador(a)', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(201, 12, '', '', NULL, 'Diseñador(a)', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(202, 12, '', '', NULL, 'Ejecutivo(a)', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(203, 13, '', '', 76, 'Valle del Cauca', 1, 1, 1, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(204, 203, '', '', 76001, 'Cali', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(205, 14, '', '', NULL, 'Daño', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(206, 14, '', '', NULL, 'Desuso', 1, 1, 0, '2022-02-15 14:04:27', '2022-02-15 14:04:27'),
	(207, 14, '', '', NULL, 'Deterioro', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(208, 14, '', '', NULL, 'Error de registro', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(209, 14, '', '', NULL, 'Obsolescencia', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(210, 14, '', '', NULL, 'Pérdida', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(211, 14, '', '', NULL, 'Robo', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(212, 14, '', '', NULL, 'Venta', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(213, 14, '', '', NULL, 'Vida útil', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(214, 15, 'DERECOGNITION_IN_PROCESS', '', NULL, 'En Proceso', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(215, 15, 'DERECOGNITION_CHECKING', '', NULL, 'En Revisión', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(216, 15, 'DERECOGNITION_APPROVED', '', NULL, 'Aprobada', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(217, 15, 'DERECOGNITION_REJECTED', '', NULL, 'Rechazada', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(218, 15, 'DERECOGNITION_EXECUTED', '', NULL, 'Ejecutada', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(219, 15, 'DERECOGNITION_REVERSED', '', NULL, 'Reversada', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(220, 15, 'DERECOGNITION_CANCELLED', '', NULL, 'Anulada', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(221, 20, 'INVENTORY_IN_PROCESS', '', NULL, 'En Proceso', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(222, 20, 'INVENTORY_FINISHED', '', NULL, 'Finalizado', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(223, 22, 'MAINTENANCE_IN_PROCESS', '', NULL, 'En Proceso', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(224, 22, 'MAINTENANCE_FINISHED', '', NULL, 'Finalizado', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(225, 22, 'MAINTENANCE_CANCELLED', '', NULL, 'Anulado', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(226, 23, '', '', NULL, 'Adaptativo', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(227, 23, '', '', NULL, 'Correctivo', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(228, 23, '', '', NULL, 'Predictivo', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(229, 23, '', '', NULL, 'Preventivo', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(230, 24, 'CREDIT_PAYMENT', '', NULL, 'Crédito', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(231, 24, 'EFFECTIVE_PAYMENT', '', NULL, 'Efectivo', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(232, 25, 'PURCHASE_STATUS_IN_PROCESS', '', NULL, 'En Proceso', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(233, 25, 'PURCHASE_STATUS_CHECKING', '', NULL, 'En Revisión', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(234, 25, 'PURCHASE_STATUS_CANCELLED', '', NULL, 'Anulada', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(235, 25, 'PURCHASE_STATUS_APPROVED', '', NULL, 'Aprobada', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(236, 25, 'PURCHASE_STATUS_REJECTED', '', NULL, 'Rechazada', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(237, 25, 'PURCHASE_STATUS_CLOSED', '', NULL, 'Cerrada', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(238, 25, 'PURCHASE_STATUS_FINISHED', '', NULL, 'Finalizada', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(239, 29, 'USER_ROLE_ADMIN', '', NULL, 'Administrador', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(240, 29, 'USER_ROLE_APPROVER', '', NULL, 'Aprobador', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(241, 29, 'USER_ROLE_RESPONSIBLE', '', NULL, 'Responsable', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(242, 30, 'USER_STATUS_ACTIVE', '', NULL, 'Activo', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(243, 30, 'USER_STATUS_INACTIVE', '', NULL, 'Inactivo', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(244, 30, 'USER_STATUS_LOCKED', '', NULL, 'Bloqueado', 1, 0, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(245, 11, 'COMPANY_NAME', '', NULL, 'Modern Soflutions', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(246, 11, 'COMPANY_DOCUMENT_NUMBER', '', NULL, '901378835 - 4', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(247, 11, 'COMPANY_ADDRESS', '', NULL, 'Cl. 23 Nte # 3-33 OF. 606, Ed. Peñas Blancas', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(248, 11, 'COMPANY_PHONE_NUMBER', '', NULL, '3197648512', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(249, 11, 'COMPANY_CITY_ID', '', 203, NULL, 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(250, 16, '', '', NULL, 'CC', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(251, 16, '', '', NULL, 'CE', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(252, 16, '', '', NULL, 'TI', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(253, 16, '', '', NULL, 'NIT', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(254, 16, '', '', NULL, 'PAS', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(255, 17, 'EMAIL_TEMPLATE_HEADER', '', NULL, '<div style="margin: 10px 0px;"><img src="https://cloaiza1997.github.io/CristianLoaiza/logo_grande.png" style="width: 100%;" /></div>', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(256, 17, 'EMAIL_TEMPLATE_FOOTER', '', NULL, '<div style="margin: 10px 0px;"><p style="font-size: 12px;">Mensaje generado automáticamente por el <b> Sistema de Gestión de Activos </b> de <b> Modern Soflutions </b>. Por favor no responda a este email.</p></div>', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(257, 17, 'EMAIL_TEMPLATE_RECOVERY_PASSWORD_USER', 'Solicitud de recuperación de contraseña', NULL, '<div><h1>Hola {{name}}</h1><p>Solicitaste un cambio de contraseña. Si no fuiste tu quién solicitó el cambio por favor comunícate con el adminstrador del sistema.</p><p>Se ha generado la siguiente clave temporal que deberás utilizar para tu siguiente inicio de sesión. Luego de iniciada la sesión deberás de generar una nueva contraseña.</p><h3>Nueva contraseña: {{password}}</h3></div>', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(258, 17, 'EMAIL_TEMPLATE_PURCHASE_APPROVED', 'Aprobación orden de compra [{{id_order}}]', NULL, '<div><p>La orden de compra Nº {{id_order}} ha sido aprobada por {{approver_name}} el {{approved_at}}.</p></div>', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(259, 17, 'EMAIL_TEMPLATE_CERTIFICATE_APPROVED', 'Aprobación acta de movimiento [{{id_certificate}}]', NULL, '<div><p>El acta de movimiento Nº {{id_certificate}} ha sido aprobada por {{approver_name}} el {{approved_at}}.</p></div>', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(260, 17, 'EMAIL_TEMPLATE_CERTIFICATE_SIGNATURE_PENDING', 'Firma de acta de movimiento [{{id_certificate}}]', NULL, '<div><p>Se solicita la firma de recibido para el acta de movimiento Nº {{id_certificate}}.</p></div>', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(261, 17, 'EMAIL_TEMPLATE_CERTIFICATE_ACTIVE', 'Acta de movimiento [{{id_certificate}}] firmada', NULL, '<div><p>El responsable {{name}} ha firmado el recibido del acta de movimiento Nº {{id_certificate}}.</p></div>', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(262, 17, 'EMAIL_TEMPLATE_DERECOGNITIOIN_APPROVED', 'Aprobación acta de proceso de baja de activos [{{id_derecognition}}]', NULL, '<div><p>El proceso de baja de activos Nº {{id_derecognition}} ha sido aprobada por {{approver_name}} el {{approved_at}}.</p></div>', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(263, 17, 'EMAIL_TEMPLATE_USER_PASSWORD', 'Generación de contraseña', NULL, '<div><h1>Hola {{name}}</h1><p>El administrador del sistema le ha generado la siguiente contraseña, la cual debe de ser cambiada en el siguiente inicio de sesión.</p><h3>Nueva contraseña: {{password}}</h3></div>', 1, 1, 0, '2022-02-15 14:04:28', '2022-02-15 14:04:28');
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
INSERT INTO `providers` (`id`, `id_document_type`, `document_number`, `name`, `address`, `id_city`, `email`, `phone_number`, `observations`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 253, '0000000001', 'Proveedor de prueba 1', 'Calle # 123', 204, 'proveedor@proveedor.com', '300000000', '', 1, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(2, 253, '0000000002', 'Proveedor de prueba 2', 'Calle # 123', 204, 'proveedor@proveedor.com', '300000000', '', 1, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(3, 253, '0000000003', 'Proveedor de prueba 3', 'Calle # 123', 204, 'proveedor@proveedor.com', '300000000', '', 1, '2022-02-15 14:04:28', '2022-02-15 14:04:28');
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
  `sub_total` decimal(20,2) NOT NULL,
  `iva` decimal(20,2) NOT NULL,
  `total` decimal(20,2) NOT NULL,
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
  `unit_value` decimal(20,2) NOT NULL,
  `total_value` decimal(20,2) NOT NULL,
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
INSERT INTO `users` (`id`, `id_document_type`, `document_number`, `name`, `last_name`, `display_name`, `email`, `phone_number`, `signature`, `password`, `must_change_password`, `id_role`, `id_area`, `id_position`, `id_status`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 253, '0000000000', 'Usuario del Sistema', '', '', '', '', '', '', 0, 239, 196, 197, 243, NULL, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(2, 250, '123', 'Sara', 'Zuluaga', 'Sara_Admin', 'kla-1997@hotmail.com', '300000000', '00000000000000_USERS_2_sara_admin.png', '$2y$10$v2ymdojUz6jmK/QmPdTkaOHdo8gp2DPGzxBnPdki3wW1sjgXxmzLa', 0, 239, 196, 197, 242, NULL, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(3, 250, '456', 'Sebastián', 'Henao', 'Sebastián_Aprobador', 'cristian97loaiza@gmail.com', '300000000', '00000000000000_USERS_3_sebastián_aprobador.png', '$2y$10$v2ymdojUz6jmK/QmPdTkaOHdo8gp2DPGzxBnPdki3wW1sjgXxmzLa', 0, 240, 196, 197, 242, NULL, '2022-02-15 14:04:28', '2022-02-15 14:04:28'),
	(4, 250, '789', 'Cristian', 'Loaiza', 'Cristian_Responsable', 'cristianaloaiza@estudiante.uniajc.edu.co', '300000000', '00000000000000_USERS_4_cristian_responsable.png', '$2y$10$v2ymdojUz6jmK/QmPdTkaOHdo8gp2DPGzxBnPdki3wW1sjgXxmzLa', 0, 241, 196, 197, 242, NULL, '2022-02-15 14:04:28', '2022-02-15 14:04:28');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
