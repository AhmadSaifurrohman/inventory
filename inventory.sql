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
  PRIMARY KEY (`id`),
  KEY `FKc1u6q7lvtahb9x71w32hw2smd` (`location`),
  KEY `FK_tb_invstock_tb_mas_itemcd` (`itemcode`),
  CONSTRAINT `FK_tb_invstock_tb_mas_itemcd` FOREIGN KEY (`itemcode`) REFERENCES `tb_mas_itemcd` (`itemcode`) ON UPDATE CASCADE,
  CONSTRAINT `FKc1u6q7lvtahb9x71w32hw2smd` FOREIGN KEY (`location`) REFERENCES `tb_mas_loc` (`loccd`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inventory.tb_invstock: ~9 rows (approximately)
INSERT INTO `tb_invstock` (`id`, `itemcode`, `partnum`, `quantity`, `unitcd`, `updatedate`, `userupdate`, `location`) VALUES
	(1, 'CCTV01', 'CCTV01', 20, '', '2024-12-04 12:59:54.000000', 'USER123', 'WH'),
	(2, 'CCTV01', 'CTVWH', 10, '', '2024-12-04 13:21:46.000000', 'USER123', 'OFC1'),
	(3, 'CCTV01', 'CTAS', 4, NULL, '2024-12-04 13:23:46.000000', 'USER123', 'KLINIC'),
	(4, 'KL01', 'KL01', 2, 'PCS', '2024-12-04 13:56:15.000000', 'USER123', 'WH'),
	(9, 'KL01', 'KL01', 10, 'CTN', '2024-12-04 14:05:10.000000', 'USER123', 'KLINIC'),
	(10, 'MTR01', 'MTR01', 20, 'YD', '2024-12-04 15:03:23.000000', 'USER123', 'WH'),
	(11, 'PC01', 'PC01', 2, 'PCS', '2024-12-04 15:08:12.000000', 'USER123', 'KLINIC'),
	(13, 'LMP012', 'LMP012', 2, 'PCS', '2024-12-04 15:11:29.000000', 'USER123', 'OFC1'),
	(14, 'SPT01', 'SPT01', 2, 'CTN', '2024-12-04 15:23:03.000000', 'USER123', 'KLINIC');

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inventory.tb_invstock_trans: ~31 rows (approximately)
INSERT INTO `tb_invstock_trans` (`transno`, `transaction_type`, `itemcode`, `unitcd`, `qty_before`, `qty_after`, `trans_date`, `trans_qty`, `userid`, `dept_pickup`, `pic_pickup`, `location`) VALUES
	(1, NULL, 'KB01', 'PCS', 0, 0, '2024-12-01 11:23:07.000000', 0, NULL, NULL, NULL, NULL),
	(2, NULL, 'KB01', 'PCS', 0, 0, '2024-12-01 11:24:05.000000', 0, NULL, NULL, NULL, NULL),
	(3, NULL, 'MS01', 'PCS', 0, 0, '2024-12-01 13:41:32.000000', 0, NULL, NULL, NULL, NULL),
	(4, NULL, 'LMP01', 'PCS', 0, 0, '2024-12-01 20:22:51.000000', 0, NULL, NULL, NULL, NULL),
	(5, 'inbound', 'PC01', 'PCS', 0, 0, '2024-12-02 21:22:56.000000', 0, NULL, NULL, NULL, 'OFC1'),
	(6, 'inbound', 'PC01', 'PCS', 0, 0, '2024-12-02 22:12:20.000000', 0, 'USER123', NULL, NULL, 'OFC1'),
	(7, 'inbound', 'KL01', 'PCS', 0, 0, '2024-12-02 22:27:58.000000', 0, 'USER123', NULL, NULL, 'OFC1'),
	(8, 'inbound', 'LMP012', 'PCS', 0, 0, '2024-12-02 22:38:51.000000', 0, 'USER123', NULL, NULL, 'OFC1'),
	(9, 'inbound', 'TS01', 'CTN', 0, 0, '2024-12-02 22:50:06.000000', 0, 'USER123', NULL, NULL, 'OFC1'),
	(10, 'inbound', 'TS01', 'CTN', 0, 0, '2024-12-02 22:55:17.000000', 0, 'USER123', NULL, NULL, 'WH'),
	(11, 'inbound', 'CH01', 'PCS', 0, 0, '2024-12-02 22:59:30.000000', 0, 'USER123', NULL, NULL, 'OFC1'),
	(12, 'inbound', 'CH01', 'PCS', 0, 0, '2024-12-02 23:04:27.000000', 0, 'USER123', NULL, NULL, 'WH'),
	(13, 'inbound', 'SPT01', 'YD', 0, 0, '2024-12-02 23:08:20.000000', 0, 'USER123', NULL, NULL, 'OFC1'),
	(14, 'inbound', 'TS01', 'YD', 0, 0, '2024-12-02 23:13:28.000000', 0, 'USER123', NULL, NULL, 'OFC1'),
	(15, 'inbound', 'MTR01', 'PCS', 0, 11, '2024-12-02 23:17:30.000000', 11, 'USER123', NULL, NULL, 'OFC1'),
	(16, 'inbound', 'MTR01', 'PCS', 11, 23, '2024-12-02 23:19:09.000000', 12, 'USER123', NULL, NULL, 'OFC1'),
	(18, 'inbound', 'MTR01', 'PCS', 0, 3, '2024-12-02 23:20:56.000000', 3, 'USER123', NULL, NULL, 'WH'),
	(19, 'inbound', 'CH01', 'CTN', 0, 4, '2024-12-03 09:32:17.000000', 4, 'USER123', NULL, NULL, 'OFC1'),
	(20, 'inbound', 'CH01', 'PCS', 0, 10, '2024-12-03 09:33:31.000000', 10, 'USER123', NULL, NULL, 'WH'),
	(21, 'inbound', 'CH01', 'CTN', 10, 12, '2024-12-03 10:04:35.000000', 2, 'USER123', NULL, NULL, 'WH'),
	(22, 'inbound', 'CH01', 'CTN', 0, 11, '2024-12-03 10:05:06.000000', 11, 'USER123', NULL, NULL, 'OFC1'),
	(23, 'inbound', 'CH01', 'CTN', 11, 12, '2024-12-03 10:51:05.000000', 1, 'USER123', NULL, NULL, 'OFC1'),
	(24, 'inbound', 'CCTV01', 'CTN', 0, 100, '2024-12-03 13:18:12.000000', 100, 'USER123', NULL, NULL, 'OFC1'),
	(25, 'inbound', 'KB01', 'PCS', 0, 10, '2024-12-04 12:28:17.000000', 10, 'USER123', NULL, NULL, 'OFC1'),
	(26, 'inbound', 'KB01', 'PCS', 0, 20, '2024-12-04 12:29:34.000000', 20, 'USER123', NULL, NULL, 'WH'),
	(27, 'inbound', 'CCTV01', 'PCS', 0, 5, '2024-12-04 12:29:56.000000', 5, 'USER123', NULL, NULL, 'KLINIC'),
	(28, 'inbound', 'KB01', 'PCS', 20, 20, '2024-12-04 12:30:44.000000', 0, 'USER123', NULL, NULL, 'WH'),
	(29, 'inbound', 'KB01', 'PCS', 0, 10, '2024-12-04 12:31:36.000000', 10, 'USER123', NULL, NULL, 'KLINIC'),
	(30, 'inbound', 'CCTV01', 'PCS', 0, 5, '2024-12-04 12:59:25.000000', 5, 'USER123', NULL, NULL, 'OFC1'),
	(31, 'inbound', 'CCTV01', '', 0, 20, '2024-12-04 12:59:54.000000', 20, 'USER123', NULL, NULL, 'WH'),
	(32, 'inbound', 'CCTV01', 'PCS', 0, 52, '2024-12-04 13:20:59.000000', 52, 'USER123', NULL, NULL, 'KLINIC'),
	(33, 'inbound', 'KL01', 'PCS', 0, 2, '2024-12-04 13:56:15.000000', 2, 'USER123', NULL, NULL, 'WH'),
	(34, 'inbound', 'KL01', 'CTN', 0, 10, '2024-12-04 14:05:10.000000', 10, 'USER123', NULL, NULL, 'KLINIC'),
	(35, 'inbound', 'MTR01', 'YD', 0, 20, '2024-12-04 15:03:23.000000', 20, 'USER123', NULL, NULL, 'WH'),
	(36, 'inbound', 'PC01', 'PCS', 0, 2, '2024-12-04 15:08:12.000000', 2, 'USER123', NULL, NULL, 'KLINIC'),
	(37, 'inbound', 'LMP012', 'PCS', 0, 2, '2024-12-04 15:11:29.000000', 2, 'USER123', NULL, NULL, 'OFC1'),
	(38, 'inbound', 'SPT01', 'CTN', 0, 2, '2024-12-04 15:23:03.000000', 2, 'USER123', NULL, NULL, 'KLINIC');

-- Dumping structure for table inventory.tb_mas_itemcd
CREATE TABLE IF NOT EXISTS `tb_mas_itemcd` (
  `itemcode` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `itemname` varchar(255) DEFAULT NULL,
  `partnum` varchar(255) DEFAULT NULL,
  `safetystock` varchar(255) DEFAULT NULL,
  `partnumber` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`itemcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inventory.tb_mas_itemcd: ~13 rows (approximately)
INSERT INTO `tb_mas_itemcd` (`itemcode`, `description`, `itemname`, `partnum`, `safetystock`, `partnumber`) VALUES
	('CCTV01', 'CCTV', 'CCTV', '25ASF3112', '20', NULL),
	('CH01', 'Danendra Yasar Adirajasa', 'Danendra Yasar Adirajasa', 'HFK23Hf', '1', NULL),
	('HP01', 'Denisatya Wiratama', 'Denisatya Wiratama', 'GMN21', '1', NULL),
	('KL01', 'Kulkas', 'M Dawud', '21FSWC224', '', NULL),
	('LMP01', '', 'Lampu', '12F2VGW', '2', NULL),
	('LMP012', 'Lampu', 'Lampu', '12F2VGW', '2', NULL),
	('MBL01', NULL, 'Mobil', NULL, '2', NULL),
	('MN01', NULL, 'Monitor', NULL, '2', NULL),
	('MS01', NULL, 'Mouse', NULL, NULL, NULL),
	('MTR01', NULL, 'Motor', NULL, NULL, NULL),
	('PC01', NULL, 'Komputer', NULL, NULL, NULL),
	('SPT01', '', 'SEPATU', 'ADD01', '10', NULL),
	('TS01', '', 'Test 01', '', '2', NULL);

-- Dumping structure for table inventory.tb_mas_loc
CREATE TABLE IF NOT EXISTS `tb_mas_loc` (
  `loccd` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`loccd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inventory.tb_mas_loc: ~2 rows (approximately)
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
