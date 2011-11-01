-- MySQL dump 10.13  Distrib 5.5.9, for Win32 (x86)
--
-- Host: localhost    Database: rrbs_development
-- ------------------------------------------------------
-- Server version	5.5.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `rrbs_development`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `rrbs_development` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `rrbs_development`;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(11) DEFAULT NULL,
  `branch_location` varchar(255) DEFAULT NULL,
  `branch_contactNumber` varchar(255) DEFAULT NULL,
  `branch_address` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,1,'Ortigas','1234567','Home Depot, Ortigas','2011-09-13 12:44:18','2011-09-13 12:44:18'),(2,1,'Greenbelt','2345678','Greenbelt 2','2011-09-13 12:44:47','2011-09-13 12:44:47');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL,
  `category_description` text,
  `restaurant_category_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (0,'Food','Meat, Poultry, etc.',0,'2011-07-29 01:50:54','2011-07-29 01:50:54'),(1,'Liquor','Alcoholic beverages',0,'2011-07-29 01:51:23','2011-07-29 01:51:23'),(2,'Beverages','Sodas, teas, non alcoholic beverages',0,'2011-07-29 01:51:50','2011-07-29 01:51:50');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorysales`
--

DROP TABLE IF EXISTS `categorysales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorysales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cs_amount` float DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `vat` float DEFAULT NULL,
  `void` float DEFAULT NULL,
  `servicecharge` float DEFAULT NULL,
  `cs_revenue` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `cs_date` date DEFAULT NULL,
  `customer_count` int(11) DEFAULT NULL,
  `transaction_count` int(11) DEFAULT NULL,
  `save_as_draft` int(10) unsigned DEFAULT NULL,
  `cs_total_amount` float DEFAULT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `categorysales_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorysales`
--

LOCK TABLES `categorysales` WRITE;
/*!40000 ALTER TABLE `categorysales` DISABLE KEYS */;
INSERT INTO `categorysales` VALUES (209,NULL,3,100,10,1000,10000,'2011-09-12 16:44:42','2011-09-12 16:44:42','2011-09-12',50,20,1,720,NULL),(210,NULL,1,1,1,1,1,'2011-09-13 03:32:30','2011-09-13 03:32:30','2011-09-13',1,1,1,1,NULL);
/*!40000 ALTER TABLE `categorysales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) DEFAULT NULL,
  `company_address` text,
  `company_number` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` VALUES (1,'Buffalo Wings','Ortigas','123456789','2011-09-08 21:56:26','2011-09-08 21:56:26');
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csrows`
--

DROP TABLE IF EXISTS `csrows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csrows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) NOT NULL,
  `cs_amount` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`sale_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csrows`
--

LOCK TABLES `csrows` WRITE;
/*!40000 ALTER TABLE `csrows` DISABLE KEYS */;
INSERT INTO `csrows` VALUES (10,4,1,'2011-09-16 23:09:05','2011-09-16 23:09:05',0),(11,4,1,'2011-09-16 23:09:05','2011-09-16 23:09:05',1),(12,4,1,'2011-09-16 23:09:05','2011-09-16 23:09:05',2),(13,5,2,'2011-09-16 23:17:21','2011-09-16 23:17:21',0),(14,5,2,'2011-09-16 23:17:21','2011-09-16 23:17:21',1),(15,5,2,'2011-09-16 23:17:21','2011-09-16 23:17:21',2);
/*!40000 ALTER TABLE `csrows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(255) DEFAULT NULL,
  `restaurant_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Kitchen',1,'2011-09-15 20:25:35','2011-09-15 20:25:35'),(2,'Dining Area',1,'2011-09-15 20:26:06','2011-09-15 20:26:06');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ecrows`
--

DROP TABLE IF EXISTS `ecrows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecrows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `endcount_id` int(11) DEFAULT NULL,
  `inventoryitem_id` int(11) DEFAULT NULL,
  `beginning_count` float DEFAULT NULL,
  `end_count` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ecrows`
--

LOCK TABLES `ecrows` WRITE;
/*!40000 ALTER TABLE `ecrows` DISABLE KEYS */;
INSERT INTO `ecrows` VALUES (28,9,1,10,2,'2011-10-03 16:45:35','2011-10-03 16:45:35'),(29,9,2,20,2,'2011-10-03 16:45:35','2011-10-03 16:45:35'),(30,9,3,30,2,'2011-10-03 16:45:35','2011-10-03 16:45:35'),(31,10,1,10,3,'2011-10-03 16:49:40','2011-10-03 16:49:40'),(32,10,2,20,3,'2011-10-03 16:49:40','2011-10-03 16:49:40'),(33,10,3,30,3,'2011-10-03 16:49:40','2011-10-03 16:49:40'),(34,11,1,10,5,'2011-10-04 03:10:55','2011-10-04 03:10:55'),(35,11,2,20,5,'2011-10-04 03:10:55','2011-10-04 03:10:55'),(36,11,3,30,5,'2011-10-04 03:10:55','2011-10-04 03:10:55'),(37,12,1,10,5,'2011-10-04 03:18:59','2011-10-04 03:18:59'),(38,12,2,20,5,'2011-10-04 03:18:59','2011-10-04 03:18:59'),(39,12,3,30,3,'2011-10-04 03:18:59','2011-10-04 03:18:59'),(40,13,1,10,4,'2011-10-04 03:22:10','2011-10-04 03:22:10'),(41,13,2,20,4,'2011-10-04 03:22:10','2011-10-04 03:22:10'),(42,13,3,30,4,'2011-10-04 03:22:10','2011-10-04 03:22:10'),(43,14,1,10,4,'2011-10-04 04:15:28','2011-10-04 04:15:28'),(44,14,2,20,5,'2011-10-04 04:15:28','2011-10-04 04:15:28'),(45,14,3,30,5,'2011-10-04 04:15:28','2011-10-04 04:15:28');
/*!40000 ALTER TABLE `ecrows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_firstName` varchar(255) DEFAULT NULL,
  `employee_lastName` varchar(255) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `employee_dateEmployed` date DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `employee_birthday` date DEFAULT NULL,
  `employee_age` int(11) DEFAULT NULL,
  `employee_contactNumber` varchar(255) DEFAULT NULL,
  `employee_sss` varchar(255) DEFAULT NULL,
  `employee_tin` varchar(255) DEFAULT NULL,
  `employee_address` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Zor','Abad',1,'2011-07-29',1,1,'2006-07-29',20,'09151975674','111','111','Don Antonio Heights','2011-07-29 02:00:49','2011-07-29 02:00:49'),(2,'Bia','Esmero',1,'2011-07-29',1,1,'2011-07-29',19,'9999999','111','111','Tandang Sora QC','2011-07-29 02:01:54','2011-07-29 02:01:54'),(3,'Jobelle Anne','Azur',1,'2011-09-12',0,1,'2011-09-12',20,'20','20','20','somewhere','2011-09-12 16:21:14','2011-09-12 16:21:14');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endcounts`
--

DROP TABLE IF EXISTS `endcounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endcounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `beginning_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `save_as_draft` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endcounts`
--

LOCK TABLES `endcounts` WRITE;
/*!40000 ALTER TABLE `endcounts` DISABLE KEYS */;
INSERT INTO `endcounts` VALUES (9,'2011-10-01','2011-10-03','2011-10-03 16:45:35','2011-10-03 16:45:35',0),(10,'2011-10-01','2011-10-03','2011-10-03 16:49:40','2011-10-03 16:49:40',0),(11,'2011-10-01','2011-10-04','2011-10-04 03:10:55','2011-10-04 03:10:55',0),(12,'2011-10-01','2011-10-04','2011-10-04 03:18:59','2011-10-04 03:18:59',1),(13,'2011-10-01','2011-10-04','2011-10-04 03:22:10','2011-10-04 03:22:10',0),(14,'2011-11-01','2011-11-04','2011-10-04 04:15:28','2011-10-04 04:15:28',0);
/*!40000 ALTER TABLE `endcounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventoryitems`
--

DROP TABLE IF EXISTS `inventoryitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventoryitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) DEFAULT NULL,
  `branch_id` varchar(255) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `beginning_count` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `item_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventoryitems`
--

LOCK TABLES `inventoryitems` WRITE;
/*!40000 ALTER TABLE `inventoryitems` DISABLE KEYS */;
INSERT INTO `inventoryitems` VALUES (1,'Chicken Wings','1',1,10,'2011-09-08 23:22:37','2011-09-08 23:22:37','Food'),(2,'Bread','1',3,20,'2011-09-08 23:22:57','2011-09-08 23:22:57','Food'),(3,'Soy Sauce','1',2,30,'2011-09-08 23:23:21','2011-09-08 23:23:21','Food');
/*!40000 ALTER TABLE `inventoryitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(255) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES (1,'Cook',1,'2011-09-15 20:31:50','2011-09-15 20:31:50'),(2,'Server',2,'2011-09-15 20:32:01','2011-09-15 20:32:01');
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaseitems`
--

DROP TABLE IF EXISTS `purchaseitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchaseitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_date` date DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `inventory_id` int(11) DEFAULT NULL,
  `purchase_unitCost` float DEFAULT NULL,
  `purchase_quantity` float DEFAULT NULL,
  `purchase_amount` float DEFAULT NULL,
  `vat_type` varchar(255) DEFAULT NULL,
  `vat_amount` float DEFAULT NULL,
  `net_amount` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `save_as_draft` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseitems`
--

LOCK TABLES `purchaseitems` WRITE;
/*!40000 ALTER TABLE `purchaseitems` DISABLE KEYS */;
INSERT INTO `purchaseitems` VALUES (10,'2011-09-19',1234,1,1,1,10,100,1000,'VAT-Inclusive',107.143,892.857,'2011-09-19 12:21:27','2011-09-19 12:21:27',0),(11,'2011-09-19',1234,2,2,1,10,100,1000,'VAT-Exclusive',120,1000,'2011-09-19 12:23:14','2011-09-20 17:06:36',1),(12,'2011-09-19',1234,1,1,1,10,100,1000,'VAT-Exempted',0,1000,'2011-09-19 12:23:35','2011-09-20 13:25:15',0),(14,'2011-09-20',1234,1,1,1,10,100,1000,'VAT-Exclusive',120,1000,'2011-09-20 17:32:36','2011-09-20 17:32:36',1);
/*!40000 ALTER TABLE `purchaseitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaserows`
--

DROP TABLE IF EXISTS `purchaserows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchaserows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_id` int(11) DEFAULT NULL,
  `inventoryitem_id` int(11) DEFAULT NULL,
  `purchase_unitCost` float DEFAULT NULL,
  `purchase_quantity` float DEFAULT NULL,
  `purchase_amount` float DEFAULT NULL,
  `vat_type` text,
  `vat_amount` float DEFAULT NULL,
  `net_amount` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaserows`
--

LOCK TABLES `purchaserows` WRITE;
/*!40000 ALTER TABLE `purchaserows` DISABLE KEYS */;
INSERT INTO `purchaserows` VALUES (24,14,1,10,100,1000,'VAT-Exclusive',120,1000,'2011-09-24 07:38:41','2011-09-24 07:38:41'),(25,15,1,10,100,1000,'VAT-Inclusive',107.143,892.857,'2011-09-25 15:06:39','2011-09-25 15:06:39'),(26,16,1,10,100,1000,'VAT-Inclusive',107.143,892.857,'2011-09-27 02:11:58','2011-09-27 02:11:58'),(27,17,1,10,100,1000,'VAT-Inclusive',107.143,892.857,'2011-09-29 14:38:50','2011-09-29 14:38:50'),(28,17,2,20,200,4000,'VAT-Exclusive',480,4000,'2011-09-29 14:38:50','2011-09-29 14:38:50'),(29,18,1,20,200,4000,'VAT-Exclusive',480,4000,'2011-10-04 03:18:39','2011-10-04 03:18:39'),(30,19,1,90,9,989,'VAT-Inclusive',105.964,883.036,'2011-10-04 06:02:36','2011-10-04 06:02:36'),(31,19,2,8687,89,909,'VAT-Exempted',0,909,'2011-10-04 06:02:36','2011-10-04 06:02:36');
/*!40000 ALTER TABLE `purchaserows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_date` date DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `save_as_draft` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
INSERT INTO `purchases` VALUES (14,'2011-09-25',1234,1,1,0,'2011-09-24 07:38:41','2011-09-24 07:38:41'),(15,'2011-09-25',1234,1,1,0,'2011-09-25 15:06:39','2011-09-25 15:06:39'),(16,'2011-09-27',1234,1,2,1,'2011-09-27 02:11:58','2011-09-27 02:15:44'),(17,'2011-09-29',1233,2,1,0,'2011-09-29 14:38:50','2011-09-29 14:38:50'),(18,'2011-10-04',6754,1,1,0,'2011-10-04 03:18:39','2011-10-04 03:18:39'),(19,'2011-10-04',9789,1,1,1,'2011-10-04 06:02:36','2011-10-04 06:02:36');
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporttemplates`
--

DROP TABLE IF EXISTS `reporttemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reporttemplates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_name` varchar(255) DEFAULT NULL,
  `report_description` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporttemplates`
--

LOCK TABLES `reporttemplates` WRITE;
/*!40000 ALTER TABLE `reporttemplates` DISABLE KEYS */;
INSERT INTO `reporttemplates` VALUES (1,'Purchases Report','','2011-09-12 14:07:12','2011-09-12 14:07:12'),(2,'Daily Sales Report','','2011-09-12 14:14:15','2011-09-12 14:14:15');
/*!40000 ALTER TABLE `reporttemplates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurantcategories`
--

DROP TABLE IF EXISTS `restaurantcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurantcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_listName` varchar(255) DEFAULT NULL,
  `restaurant_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurantcategories`
--

LOCK TABLES `restaurantcategories` WRITE;
/*!40000 ALTER TABLE `restaurantcategories` DISABLE KEYS */;
INSERT INTO `restaurantcategories` VALUES (1,'Buffalo Wings Category List',1,'2011-09-08 22:26:12','2011-09-08 22:26:12');
/*!40000 ALTER TABLE `restaurantcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) DEFAULT NULL,
  `restaurant_name` varchar(255) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `restaurant_description` text,
  `currency_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,1234,'Buffalo Wings',1,'',NULL,'2011-09-08 22:05:36','2011-09-08 22:05:36');
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Store Manager','2011-09-15 20:20:16','2011-09-15 20:20:16'),(2,'Server','2011-09-15 20:20:25','2011-09-15 20:20:25'),(3,'Cook','2011-09-15 20:20:31','2011-09-15 20:20:31'),(4,'Janitor','2011-09-15 20:20:40','2011-09-15 20:20:40');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `vat` float DEFAULT NULL,
  `void` float DEFAULT NULL,
  `date` date DEFAULT NULL,
  `revenue_ss` float DEFAULT NULL,
  `customer_count` int(11) DEFAULT NULL,
  `transaction_count` int(11) DEFAULT NULL,
  `gross_total_ss` float DEFAULT NULL,
  `net_total_ss` float DEFAULT NULL,
  `dinein_cc` int(11) DEFAULT NULL,
  `dinein_tc` int(11) DEFAULT NULL,
  `dinein_ppa` float DEFAULT NULL,
  `delivery_sales` float DEFAULT NULL,
  `delivery_tc` int(11) DEFAULT NULL,
  `delivery_pta` float DEFAULT NULL,
  `takeout_tc` int(11) DEFAULT NULL,
  `takeout_pta` float DEFAULT NULL,
  `total_amount_cs` float DEFAULT NULL,
  `total_revenue_cs` float DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `service_charge` float DEFAULT NULL,
  `save_as_draft` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `dinein_pta` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (4,1,1,1,'2011-09-16',1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,'2011-09-16 23:09:05','2011-09-16 23:09:05',0),(5,3,2,2,'2011-09-16',2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,'2011-09-16 23:17:21','2011-09-16 23:17:21',0);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20110922003442'),('20110922004326'),('20110922011552');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settlement_sales`
--

DROP TABLE IF EXISTS `settlement_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settlement_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `vat` float DEFAULT NULL,
  `void` float DEFAULT NULL,
  `ss_date` date DEFAULT NULL,
  `ss_revenue` float DEFAULT NULL,
  `customerCount` int(11) DEFAULT NULL,
  `transactionCount` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `customer_type` int(10) unsigned DEFAULT NULL,
  `gross_total` float DEFAULT NULL,
  `net_total` float DEFAULT NULL,
  `save_as_draft` int(10) unsigned NOT NULL,
  `dinein_cc` int(10) unsigned NOT NULL,
  `dinein_tc` int(10) unsigned NOT NULL,
  `dinein_ppa` float NOT NULL,
  `dinein_pta` float NOT NULL,
  `delivery_sales` float NOT NULL,
  `delivery_tc` float NOT NULL,
  `delivery_pta` float NOT NULL,
  `takeout_tc` int(10) unsigned NOT NULL,
  `takeout_pta` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settlement_sales`
--

LOCK TABLES `settlement_sales` WRITE;
/*!40000 ALTER TABLE `settlement_sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `settlement_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settlement_types`
--

DROP TABLE IF EXISTS `settlement_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settlement_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `st_name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settlement_types`
--

LOCK TABLES `settlement_types` WRITE;
/*!40000 ALTER TABLE `settlement_types` DISABLE KEYS */;
INSERT INTO `settlement_types` VALUES (1,'Comp 91','2011-08-03 01:36:05','2011-08-03 01:36:05'),(2,'Comp 92','2011-08-03 01:36:15','2011-08-03 01:36:15'),(3,'Comp 93','2011-08-03 01:36:27','2011-08-03 01:36:27'),(4,'Comp 94','2011-08-03 01:36:39','2011-08-03 01:36:39'),(5,'Comp 95','2011-08-03 01:36:49','2011-08-03 01:36:49'),(6,'Comp 96','2011-08-03 01:37:00','2011-08-03 01:37:00'),(7,'Comp 97','2011-08-03 01:37:08','2011-08-03 01:37:08'),(8,'Delivery','2011-08-03 01:39:15','2011-08-03 01:39:15'),(9,'Credit Card','2011-08-03 02:00:56','2011-08-03 02:00:56'),(10,'CASH','2011-08-03 02:01:10','2011-08-03 02:01:10'),(11,'Gift Certificate','2011-08-03 02:01:26','2011-08-03 02:01:26');
/*!40000 ALTER TABLE `settlement_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ssrows`
--

DROP TABLE IF EXISTS `ssrows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssrows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `settlement_type_id` int(10) unsigned DEFAULT NULL,
  `ss_amount` float DEFAULT NULL,
  `created_at` date NOT NULL,
  `updated_at` date NOT NULL,
  `sale_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ssrows`
--

LOCK TABLES `ssrows` WRITE;
/*!40000 ALTER TABLE `ssrows` DISABLE KEYS */;
INSERT INTO `ssrows` VALUES (1,1,1,'2011-09-16','2011-09-16',4),(2,2,1,'2011-09-16','2011-09-16',4),(3,3,1,'2011-09-16','2011-09-16',4),(4,4,1,'2011-09-16','2011-09-16',4),(5,5,1,'2011-09-16','2011-09-16',4),(6,6,1,'2011-09-16','2011-09-16',4),(7,7,1,'2011-09-16','2011-09-16',4),(8,8,1,'2011-09-16','2011-09-16',4),(9,9,1,'2011-09-16','2011-09-16',4),(10,10,1,'2011-09-16','2011-09-16',4),(11,11,1,'2011-09-16','2011-09-16',4),(12,1,2,'2011-09-16','2011-09-16',5),(13,2,2,'2011-09-16','2011-09-16',5),(14,3,2,'2011-09-16','2011-09-16',5),(15,4,2,'2011-09-16','2011-09-16',5),(16,5,2,'2011-09-16','2011-09-16',5),(17,6,2,'2011-09-16','2011-09-16',5),(18,7,2,'2011-09-16','2011-09-16',5),(19,8,2,'2011-09-16','2011-09-16',5),(20,9,2,'2011-09-16','2011-09-16',5),(21,10,2,'2011-09-16','2011-09-16',5),(22,11,2,'2011-09-16','2011-09-16',5);
/*!40000 ALTER TABLE `ssrows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategories`
--

DROP TABLE IF EXISTS `subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subcategory_name` varchar(255) DEFAULT NULL,
  `subcategory_description` text,
  `category_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategories`
--

LOCK TABLES `subcategories` WRITE;
/*!40000 ALTER TABLE `subcategories` DISABLE KEYS */;
INSERT INTO `subcategories` VALUES (1,'Beef','',0,'2011-07-29 03:14:58','2011-07-29 03:14:58'),(2,'Chicken','',0,'2011-07-29 03:15:41','2011-07-29 03:15:41'),(3,'Beer','',1,'2011-07-29 03:15:59','2011-07-29 03:15:59'),(4,'Wine','',1,'2011-07-29 03:16:54','2011-07-29 03:16:54'),(5,'Iced Tea','',2,'2011-07-29 03:17:10','2011-07-29 03:17:10'),(6,'Soda','',2,'2011-07-29 03:17:24','2011-07-29 03:17:24');
/*!40000 ALTER TABLE `subcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_id` int(11) DEFAULT NULL,
  `supplier_name` varchar(255) DEFAULT NULL,
  `supplier_email` varchar(255) DEFAULT NULL,
  `supplier_address` text,
  `supplier_description` text,
  `supplier_number` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,1,'San Miguel','sanmiguel@gmail.com','Ortigas','Supplier of hotdogs and beer.','1234567','2011-09-13 13:00:36','2011-09-13 13:00:36'),(2,1,'Magnolia','magnolia@gmail.com','Makati City','Ice cream, butter','1234567','2011-09-14 19:37:25','2011-09-14 19:39:30');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` VALUES (1,'KG','2011-09-08 23:11:52','2011-09-08 23:11:52'),(2,'L','2011-09-08 23:11:59','2011-09-08 23:11:59'),(3,'Piece(s)','2011-09-08 23:12:09','2011-09-08 23:12:09');
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(128) NOT NULL DEFAULT '',
  `password_salt` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'zorinamaika@gmail.com','7df97cbffd6ea363f02b2178e57721534fbb4269','YYitnWbKOi7jQomZjw0C',NULL,NULL,NULL,2,'2011-09-07 09:10:15','2011-09-07 09:05:31','127.0.0.1','127.0.0.1','2011-09-07 09:02:04','2011-09-07 09:10:15');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-10-11 18:15:54
