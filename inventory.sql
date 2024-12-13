-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.27-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for inventory
CREATE DATABASE IF NOT EXISTS `inventory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `inventory`;

-- Dumping structure for table inventory.tb_invstock
CREATE TABLE IF NOT EXISTS `tb_invstock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `itemcode` varchar(255) NOT NULL,
  `partnum` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `unitcd` varchar(255) DEFAULT NULL,
  `updatedate` datetime(6) DEFAULT NULL,
  `userupdate` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKc1u6q7lvtahb9x71w32hw2smd` (`location`),
  KEY `FK_tb_invstock_tb_mas_itemcd` (`itemcode`),
  CONSTRAINT `FK_tb_invstock_tb_mas_itemcd` FOREIGN KEY (`itemcode`) REFERENCES `tb_mas_itemcd` (`itemcode`) ON UPDATE CASCADE,
  CONSTRAINT `FKc1u6q7lvtahb9x71w32hw2smd` FOREIGN KEY (`location`) REFERENCES `tb_mas_loc` (`loccd`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inventory.tb_invstock: ~4 rows (approximately)
INSERT INTO `tb_invstock` (`id`, `itemcode`, `partnum`, `quantity`, `unitcd`, `updatedate`, `userupdate`, `location`, `description`) VALUES
	(1, 'CCTV01', 'CCTV01', 10, '', '2024-12-05 13:58:16.000000', 'USER123', 'WH', NULL),
	(2, 'CCTV01', 'CTVWH', 5, '', '2024-12-05 08:41:53.000000', 'USER123', 'OFC1', NULL),
	(3, 'CCTV01', 'CTAS', 4, NULL, '2024-12-04 13:23:46.000000', 'USER123', 'KLINIC', NULL),
	(4, 'KL01', 'KL01', 1, 'PCS', '2024-12-05 08:18:44.000000', 'USER123', 'WH', NULL),
	(15, 'SPT01', 'SPT01', 10, 'PCS', '2024-12-05 13:34:42.000000', 'USER123', 'KLINIC', NULL),
	(16, 'LMP01', 'LMP01', 20, 'PCS', '2024-12-05 13:56:35.000000', 'USER123', 'WH', NULL);

-- Dumping structure for table inventory.tb_invstock_trans
CREATE TABLE IF NOT EXISTS `tb_invstock_trans` (
  `transno` bigint(20) NOT NULL AUTO_INCREMENT,
  `transaction_type` varchar(255) DEFAULT NULL,
  `itemcode` varchar(255) DEFAULT NULL,
  `unitcd` varchar(255) DEFAULT NULL,
  `qty_before` int(11) DEFAULT NULL,
  `qty_after` int(11) DEFAULT NULL,
  `trans_date` datetime(6) DEFAULT NULL,
  `trans_qty` int(11) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `dept_pickup` varchar(255) DEFAULT NULL,
  `pic_pickup` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transno`),
  KEY `FKpmyjhudqmkmfym9mho7eonyek` (`location`),
  CONSTRAINT `FKpmyjhudqmkmfym9mho7eonyek` FOREIGN KEY (`location`) REFERENCES `tb_mas_loc` (`loccd`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inventory.tb_invstock_trans: ~7 rows (approximately)
INSERT INTO `tb_invstock_trans` (`transno`, `transaction_type`, `itemcode`, `unitcd`, `qty_before`, `qty_after`, `trans_date`, `trans_qty`, `userid`, `dept_pickup`, `pic_pickup`, `location`) VALUES
	(39, 'outbound', 'KL01', 'PCS', 2, 1, '2024-12-05 08:18:44.000000', 1, 'USER123', NULL, NULL, 'WH'),
	(40, 'outbound', 'CCTV01', 'PCS', 20, 15, '2024-12-05 08:20:15.000000', 5, 'USER123', NULL, NULL, 'WH'),
	(41, 'outbound', 'CCTV01', '', 15, 13, '2024-12-05 08:33:36.000000', 2, 'USER123', NULL, NULL, 'WH'),
	(42, 'outbound', 'CCTV01', '', 10, 5, '2024-12-05 08:41:53.000000', 5, 'USER123', NULL, NULL, 'OFC1'),
	(43, 'inbound', 'SPT01', 'PCS', 0, 10, '2024-12-05 13:34:42.000000', 10, 'USER123', NULL, NULL, 'KLINIC'),
	(44, 'inbound', 'LMP01', 'PCS', 0, 20, '2024-12-05 13:56:35.000000', 20, 'USER123', NULL, NULL, 'WH'),
	(45, 'outbound', 'CCTV01', 'PCS', 13, 10, '2024-12-05 13:58:16.000000', 3, 'USER123', NULL, NULL, 'WH');

-- Dumping structure for table inventory.tb_mas_itemcd
CREATE TABLE IF NOT EXISTS `tb_mas_itemcd` (
  `itemcode` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `itemname` varchar(255) DEFAULT NULL,
  `partnum` varchar(255) DEFAULT NULL,
  `safetystock` varchar(255) DEFAULT NULL,
  `unitcd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`itemcode`),
  KEY `FK_tb_mas_itemcd_tb_mas_unit` (`unitcd`),
  CONSTRAINT `FK_tb_mas_itemcd_tb_mas_unit` FOREIGN KEY (`unitcd`) REFERENCES `tb_mas_unit` (`unitcd`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inventory.tb_mas_itemcd: ~14 rows (approximately)
INSERT INTO `tb_mas_itemcd` (`itemcode`, `description`, `itemname`, `partnum`, `safetystock`, `unitcd`) VALUES
	('CCTV01', 'CCTV', 'CCTV', '25ASF3112', '20', 'PCS'),
	('CH01', 'Danendra Yasar Adirajasa', 'Danendra Yasar Adirajasa', 'HFK23Hf', '10', 'PCS'),
	('GLU4448', 'Lem alat kerja', 'Lem', 'GLUE281341', '20', 'PCS'),
	('HP01', 'Denisatya Wiratama', 'Denisatya Wiratama', 'GMN21', '10', 'PCS'),
	('KL01', 'Kulkas', 'M Dawud', '21FSWC224', '10', 'PCS'),
	('LMP01', 'Lampu LED', 'Lampu', '12F2VGW', '10', 'PCS'),
	('LMP012', 'Lampu', 'Lampu', '12F2VGW', '10', 'PCS'),
	('MBL01', NULL, 'Mobil', NULL, '10', 'PCS'),
	('MN01', NULL, 'Monitor', NULL, '10', 'PCS'),
	('MS01', NULL, 'Mouse', NULL, '10', 'PCS'),
	('MTR01', NULL, 'Motor', NULL, '10', 'PCS'),
	('PC01', NULL, 'Komputer', NULL, '10', 'PCS'),
	('SPT01', '', 'SEPATU', 'ADD01', '10', 'PCS'),
	('TS01', '', 'Test 01', '', '2', 'PCS');

-- Dumping structure for table inventory.tb_mas_loc
CREATE TABLE IF NOT EXISTS `tb_mas_loc` (
  `loccd` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`loccd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inventory.tb_mas_loc: ~3 rows (approximately)
INSERT INTO `tb_mas_loc` (`loccd`, `location`) VALUES
	('KLINIC', 'Klinic Pegawai'),
	('OFC1', 'Main Office'),
	('WH', 'Warehouse');

-- Dumping structure for table inventory.tb_mas_unit
CREATE TABLE IF NOT EXISTS `tb_mas_unit` (
  `unitcd` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`unitcd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inventory.tb_mas_unit: ~3 rows (approximately)
INSERT INTO `tb_mas_unit` (`unitcd`, `description`) VALUES
	('CTN', 'Carton'),
	('PCS', 'Pieces'),
	('YD', 'Yard');

-- Dumping structure for table inventory.tb_user
CREATE TABLE IF NOT EXISTS `tb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `role` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inventory.tb_user: ~0 rows (approximately)
INSERT INTO `tb_user` (`id`, `username`, `password`, `role`) VALUES
	(1, 'admin', '$2a$12$LO8SJXsa32HkjJjIgnnLguuWpFCv1fuLoF8A9oKmDsZHeUJn2Y0KK', 'administrator');

-- Dumping structure for table inventory.tb_users
CREATE TABLE IF NOT EXISTS `tb_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inventory.tb_users: ~0 rows (approximately)

-- Dumping structure for table inventory.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inventory.user: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
