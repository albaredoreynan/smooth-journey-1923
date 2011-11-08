-- MySQL dump 10.13  Distrib 5.1.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: rrbs_development
-- ------------------------------------------------------
-- Server version	5.1.41-3ubuntu12.10

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
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,1,'Ortigas','1234567','Home Depot, Ortigas','2011-09-13 12:44:18','2011-09-13 12:44:18'),(2,1,'Greenbelt','2345678','Greenbelt 2','2011-09-13 12:44:47','2011-09-13 12:44:47');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (0,'Food','Meat, Poultry, etc.',0,'2011-07-29 01:50:54','2011-07-29 01:50:54'),(1,'Liquor','Alcoholic beverages',0,'2011-07-29 01:51:23','2011-07-29 01:51:23'),(2,'Beverages','Sodas, teas, non alcoholic beverages',0,'2011-07-29 01:51:50','2011-07-29 01:51:50');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `categorysales`
--

LOCK TABLES `categorysales` WRITE;
/*!40000 ALTER TABLE `categorysales` DISABLE KEYS */;
INSERT INTO `categorysales` VALUES (209,NULL,3,100,10,1000,10000,'2011-09-12 16:44:42','2011-09-12 16:44:42','2011-09-12',50,20,1,720,NULL),(210,NULL,1,1,1,1,1,'2011-09-13 03:32:30','2011-09-13 03:32:30','2011-09-13',1,1,1,1,NULL);
/*!40000 ALTER TABLE `categorysales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` VALUES (1,'Buffalo Wings','Ortigas','123456789','2011-09-08 21:56:26','2011-09-08 21:56:26');
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `conversions`
--

LOCK TABLES `conversions` WRITE;
/*!40000 ALTER TABLE `conversions` DISABLE KEYS */;
/*!40000 ALTER TABLE `conversions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `csrows`
--

LOCK TABLES `csrows` WRITE;
/*!40000 ALTER TABLE `csrows` DISABLE KEYS */;
INSERT INTO `csrows` VALUES (10,4,1,'2011-09-16 23:09:05','2011-09-16 23:09:05',0),(11,4,1,'2011-09-16 23:09:05','2011-09-16 23:09:05',1),(12,4,1,'2011-09-16 23:09:05','2011-09-16 23:09:05',2),(13,5,2,'2011-09-16 23:17:21','2011-09-16 23:17:21',0),(14,5,2,'2011-09-16 23:17:21','2011-09-16 23:17:21',1),(15,5,2,'2011-09-16 23:17:21','2011-09-16 23:17:21',2);
/*!40000 ALTER TABLE `csrows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Kitchen',1,'2011-09-15 20:25:35','2011-09-15 20:25:35'),(2,'Dining Area',1,'2011-09-15 20:26:06','2011-09-15 20:26:06');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `ecrows`
--

LOCK TABLES `ecrows` WRITE;
/*!40000 ALTER TABLE `ecrows` DISABLE KEYS */;
INSERT INTO `ecrows` VALUES (28,9,1,10,2,'2011-10-03 16:45:35','2011-10-03 16:45:35'),(29,9,2,20,2,'2011-10-03 16:45:35','2011-10-03 16:45:35'),(30,9,3,30,2,'2011-10-03 16:45:35','2011-10-03 16:45:35'),(34,11,1,10,5,'2011-10-04 03:10:55','2011-10-04 03:10:55'),(35,11,2,20,5,'2011-10-04 03:10:55','2011-10-04 03:10:55'),(36,11,3,30,5,'2011-10-04 03:10:55','2011-10-04 03:10:55'),(40,13,1,10,4,'2011-10-04 03:22:10','2011-10-04 03:22:10'),(41,13,2,20,4,'2011-10-04 03:22:10','2011-10-04 03:22:10'),(42,13,3,30,4,'2011-10-04 03:22:10','2011-10-04 03:22:10'),(43,14,1,10,4,'2011-10-04 04:15:28','2011-10-04 04:15:28'),(44,14,2,20,5,'2011-10-04 04:15:28','2011-10-04 04:15:28'),(45,14,3,30,5,'2011-10-04 04:15:28','2011-10-04 04:15:28');
/*!40000 ALTER TABLE `ecrows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Zor','Abad',1,'2011-07-29',1,1,'2006-07-29',20,'09151975674','111','111','Don Antonio Heights','2011-07-29 02:00:49','2011-07-29 02:00:49'),(2,'Bia','Esmero',1,'2011-07-29',1,1,'2011-07-29',19,'9999999','111','111','Tandang Sora QC','2011-07-29 02:01:54','2011-07-29 02:01:54'),(3,'Jobelle Anne','Azur',1,'2011-09-12',0,1,'2011-09-12',20,'20','20','20','somewhere','2011-09-12 16:21:14','2011-09-12 16:21:14');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `endcounts`
--

LOCK TABLES `endcounts` WRITE;
/*!40000 ALTER TABLE `endcounts` DISABLE KEYS */;
INSERT INTO `endcounts` VALUES (9,'2011-10-01','2011-10-03','2011-10-03 16:45:35','2011-10-03 16:45:35',0),(11,'2011-10-01','2011-10-04','2011-10-04 03:10:55','2011-10-04 03:10:55',0),(13,'2011-10-01','2011-10-04','2011-10-04 03:22:10','2011-10-04 03:22:10',0),(14,'2011-11-01','2011-11-04','2011-10-04 04:15:28','2011-10-04 04:15:28',0),(15,NULL,NULL,'2011-10-12 17:54:11','2011-10-12 17:54:11',NULL),(16,NULL,NULL,'2011-10-12 17:55:30','2011-10-12 17:55:30',NULL),(17,NULL,NULL,'2011-10-12 17:55:50','2011-10-12 17:55:50',NULL);
/*!40000 ALTER TABLE `endcounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `inventoryitems`
--

LOCK TABLES `inventoryitems` WRITE;
/*!40000 ALTER TABLE `inventoryitems` DISABLE KEYS */;
INSERT INTO `inventoryitems` VALUES (1,'Chicken Wings','1',1,10,'2011-09-08 23:22:37','2011-09-08 23:22:37','Food',2),(2,'Bread','1',3,20,'2011-09-08 23:22:57','2011-09-08 23:22:57','Food',7),(3,'Soy Sauce','1',2,30,'2011-09-08 23:23:21','2011-09-08 23:23:21','Food',7);
/*!40000 ALTER TABLE `inventoryitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES (1,'Cook',1,'2011-09-15 20:31:50','2011-09-15 20:31:50'),(2,'Server',2,'2011-09-15 20:32:01','2011-09-15 20:32:01');
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `purchaseitems`
--

LOCK TABLES `purchaseitems` WRITE;
/*!40000 ALTER TABLE `purchaseitems` DISABLE KEYS */;
INSERT INTO `purchaseitems` VALUES (10,'2011-09-19',1234,1,1,1,'KG',10,100,1000,'VAT-Inclusive',107.143,892.857,'2011-09-19 12:21:27','2011-09-19 12:21:27',0),(11,'2011-09-19',1234,2,2,1,'KG',10,100,1000,'VAT-Exclusive',120,1000,'2011-09-19 12:23:14','2011-09-20 17:06:36',1),(12,'2011-09-19',1234,1,1,1,'KG',10,100,1000,'VAT-Exempted',0,1000,'2011-09-19 12:23:35','2011-09-20 13:25:15',0),(14,'2011-09-20',1234,1,1,1,'KG',10,100,1000,'VAT-Exclusive',120,1000,'2011-09-20 17:32:36','2011-09-20 17:32:36',1);
/*!40000 ALTER TABLE `purchaseitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `purchaserows`
--

LOCK TABLES `purchaserows` WRITE;
/*!40000 ALTER TABLE `purchaserows` DISABLE KEYS */;
INSERT INTO `purchaserows` VALUES (24,14,1,1,10,100,1000,'VAT-Exclusive',120,1000,'2011-09-24 07:38:41','2011-09-24 07:38:41'),(25,15,1,1,10,100,1000,'VAT-Inclusive',107.143,892.857,'2011-09-25 15:06:39','2011-09-25 15:06:39'),(27,17,1,2,10,100,1000,'VAT-Inclusive',107.143,892.857,'2011-09-29 14:38:50','2011-09-29 14:38:50'),(28,17,2,2,20,200,4000,'VAT-Exclusive',480,4000,'2011-09-29 14:38:50','2011-09-29 14:38:50'),(29,18,1,1,20,200,4000,'VAT-Exclusive',480,4000,'2011-10-04 03:18:39','2011-10-04 03:18:39'),(33,21,1,1,10,100,1000,'VAT-Exempted',0,1000,'2011-10-14 04:10:17','2011-10-14 04:10:17'),(37,25,3,2,10,50,500,'VAT-Inclusive',53.5714,446.429,'2011-10-16 10:34:08','2011-10-16 10:34:08'),(38,26,2,1,10,50,500,'VAT-Inclusive',53.5714,446.429,'2011-10-16 10:34:50','2011-10-16 10:34:50');
/*!40000 ALTER TABLE `purchaserows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
INSERT INTO `purchases` VALUES (14,'2011-09-25',1234,1,1,0,'2011-09-24 07:38:41','2011-09-24 07:38:41'),(15,'2011-09-25',1235,1,1,0,'2011-09-25 15:06:39','2011-09-25 15:06:39'),(17,'2011-09-29',1233,2,1,0,'2011-09-29 14:38:50','2011-09-29 14:38:50'),(18,'2011-10-04',6754,1,1,0,'2011-10-04 03:18:39','2011-10-04 03:18:39'),(21,'2011-10-14',5654,1,1,0,'2011-10-14 04:10:17','2011-10-14 04:16:23'),(25,'2011-10-16',3786,2,2,1,'2011-10-16 10:34:08','2011-10-16 10:34:08'),(26,'2011-10-16',6750,1,1,1,'2011-10-16 10:34:50','2011-10-16 10:34:50');
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reporttemplates`
--

LOCK TABLES `reporttemplates` WRITE;
/*!40000 ALTER TABLE `reporttemplates` DISABLE KEYS */;
INSERT INTO `reporttemplates` VALUES (1,'Purchases Report','','2011-09-12 14:07:12','2011-09-12 14:07:12'),(2,'Daily Sales Report','','2011-09-12 14:14:15','2011-09-12 14:14:15');
/*!40000 ALTER TABLE `reporttemplates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `restaurantcategories`
--

LOCK TABLES `restaurantcategories` WRITE;
/*!40000 ALTER TABLE `restaurantcategories` DISABLE KEYS */;
INSERT INTO `restaurantcategories` VALUES (1,'Buffalo Wings Category List',1,'2011-09-08 22:26:12','2011-09-08 22:26:12');
/*!40000 ALTER TABLE `restaurantcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,1234,'Buffalo Wings',1,'',NULL,'2011-09-08 22:05:36','2011-09-08 22:05:36');
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Store Manager','2011-09-15 20:20:16','2011-09-15 20:20:16'),(2,'Server','2011-09-15 20:20:25','2011-09-15 20:20:25'),(3,'Cook','2011-09-15 20:20:31','2011-09-15 20:20:31'),(4,'Janitor','2011-09-15 20:20:40','2011-09-15 20:20:40');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (4,1,1,1,'2011-09-16',1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,'2011-09-16 23:09:05','2011-09-16 23:09:05',0),(5,3,2,2,'2011-09-16',2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,'2011-09-16 23:17:21','2011-09-16 23:17:21',0);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20110922003442'),('20110922004326'),('20110922011552'),('20111016135842');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `settlement_sales`
--

LOCK TABLES `settlement_sales` WRITE;
/*!40000 ALTER TABLE `settlement_sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `settlement_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `settlement_types`
--

LOCK TABLES `settlement_types` WRITE;
/*!40000 ALTER TABLE `settlement_types` DISABLE KEYS */;
INSERT INTO `settlement_types` VALUES (1,'Comp 91','2011-08-03 01:36:05','2011-08-03 01:36:05'),(2,'Comp 92','2011-08-03 01:36:15','2011-08-03 01:36:15'),(3,'Comp 93','2011-08-03 01:36:27','2011-08-03 01:36:27'),(4,'Comp 94','2011-08-03 01:36:39','2011-08-03 01:36:39'),(5,'Comp 95','2011-08-03 01:36:49','2011-08-03 01:36:49'),(6,'Comp 96','2011-08-03 01:37:00','2011-08-03 01:37:00'),(7,'Comp 97','2011-08-03 01:37:08','2011-08-03 01:37:08'),(8,'Delivery','2011-08-03 01:39:15','2011-08-03 01:39:15'),(9,'Credit Card','2011-08-03 02:00:56','2011-08-03 02:00:56'),(10,'CASH','2011-08-03 02:01:10','2011-08-03 02:01:10'),(11,'Gift Certificate','2011-08-03 02:01:26','2011-08-03 02:01:26');
/*!40000 ALTER TABLE `settlement_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `ssrows`
--

LOCK TABLES `ssrows` WRITE;
/*!40000 ALTER TABLE `ssrows` DISABLE KEYS */;
INSERT INTO `ssrows` VALUES (1,1,1,'2011-09-16','2011-09-16',4),(2,2,1,'2011-09-16','2011-09-16',4),(3,3,1,'2011-09-16','2011-09-16',4),(4,4,1,'2011-09-16','2011-09-16',4),(5,5,1,'2011-09-16','2011-09-16',4),(6,6,1,'2011-09-16','2011-09-16',4),(7,7,1,'2011-09-16','2011-09-16',4),(8,8,1,'2011-09-16','2011-09-16',4),(9,9,1,'2011-09-16','2011-09-16',4),(10,10,1,'2011-09-16','2011-09-16',4),(11,11,1,'2011-09-16','2011-09-16',4),(12,1,2,'2011-09-16','2011-09-16',5),(13,2,2,'2011-09-16','2011-09-16',5),(14,3,2,'2011-09-16','2011-09-16',5),(15,4,2,'2011-09-16','2011-09-16',5),(16,5,2,'2011-09-16','2011-09-16',5),(17,6,2,'2011-09-16','2011-09-16',5),(18,7,2,'2011-09-16','2011-09-16',5),(19,8,2,'2011-09-16','2011-09-16',5),(20,9,2,'2011-09-16','2011-09-16',5),(21,10,2,'2011-09-16','2011-09-16',5),(22,11,2,'2011-09-16','2011-09-16',5);
/*!40000 ALTER TABLE `ssrows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `subcategories`
--

LOCK TABLES `subcategories` WRITE;
/*!40000 ALTER TABLE `subcategories` DISABLE KEYS */;
INSERT INTO `subcategories` VALUES (1,'Meat','',0,'2011-07-29 03:14:58','2011-07-29 03:14:58'),(2,'Poultry','',0,'2011-07-29 03:15:41','2011-07-29 03:15:41'),(3,'Beer','',1,'2011-07-29 03:15:59','2011-07-29 03:15:59'),(4,'Wine','',1,'2011-07-29 03:16:54','2011-07-29 03:16:54'),(5,'Iced Tea','',2,'2011-07-29 03:17:10','2011-07-29 03:17:10'),(6,'Soda','',2,'2011-07-29 03:17:24','2011-07-29 03:17:24'),(7,'Food other','',0,'2011-10-12 12:25:07','2011-10-12 12:25:07');
/*!40000 ALTER TABLE `subcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,1,'San Miguel','sanmiguel@gmail.com','Ortigas','Supplier of hotdogs and beer.','1234567','2011-09-13 13:00:36','2011-09-13 13:00:36'),(2,1,'Magnolia','magnolia@gmail.com','Makati City','Ice cream, butter','1234567','2011-09-14 19:37:25','2011-09-14 19:39:30');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` VALUES (1,'KG','2011-09-08 23:11:52','2011-09-08 23:11:52'),(2,'L','2011-09-08 23:11:59','2011-09-08 23:11:59'),(3,'Piece(s)','2011-09-08 23:12:09','2011-09-08 23:12:09');
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2011-11-08  1:31:34
