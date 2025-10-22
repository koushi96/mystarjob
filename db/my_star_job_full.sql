-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: my_star_job
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `available_time_slots`
--

DROP TABLE IF EXISTS `available_time_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `available_time_slots` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_type_id` int NOT NULL,
  `venue_id` int NOT NULL,
  `session_date` date NOT NULL,
  `slot_time` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_type_id` (`session_type_id`,`venue_id`,`session_date`,`slot_time`),
  KEY `venue_id` (`venue_id`),
  CONSTRAINT `available_time_slots_ibfk_1` FOREIGN KEY (`session_type_id`) REFERENCES `session_type` (`id`),
  CONSTRAINT `available_time_slots_ibfk_2` FOREIGN KEY (`venue_id`) REFERENCES `exhibition_venue` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `available_time_slots`
--

LOCK TABLES `available_time_slots` WRITE;
/*!40000 ALTER TABLE `available_time_slots` DISABLE KEYS */;
INSERT INTO `available_time_slots` VALUES (1,1,1,'2025-05-24','10-11am'),(2,1,1,'2025-05-24','11-12pm'),(3,1,1,'2025-05-24','2-3pm'),(4,1,1,'2025-05-25','10-11am'),(5,1,1,'2025-05-25','11-12pm'),(6,1,1,'2025-05-25','2-3pm'),(11,1,2,'2025-06-14','10-11am'),(12,1,2,'2025-06-14','11-12pm'),(13,1,2,'2025-06-14','2-3pm'),(14,1,2,'2025-06-15','10-11am'),(15,1,2,'2025-06-15','11-12pm'),(16,1,2,'2025-06-15','2-3pm'),(21,1,3,'2025-07-05','10-11am'),(22,1,3,'2025-07-05','11-12pm'),(23,1,3,'2025-07-05','2-3pm'),(24,1,3,'2025-07-06','10-11am'),(25,1,3,'2025-07-06','11-12pm'),(26,1,3,'2025-07-06','2-3pm'),(7,2,1,'2025-05-24','3-4pm'),(8,2,1,'2025-05-24','4-5pm'),(9,2,1,'2025-05-25','3-4pm'),(10,2,1,'2025-05-25','4-5pm'),(17,2,2,'2025-06-14','3-4pm'),(18,2,2,'2025-06-14','4-5pm'),(19,2,2,'2025-06-15','3-4pm'),(20,2,2,'2025-06-15','4-5pm'),(27,2,3,'2025-07-07','3-4pm'),(28,2,3,'2025-07-07','4-5pm'),(29,2,3,'2025-07-08','3-4pm'),(30,2,3,'2025-07-08','4-5pm');
/*!40000 ALTER TABLE `available_time_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `jobTitle` varchar(100) DEFAULT NULL,
  `inquiries` text,
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,'Test','India','123456789','test@example.com','Test Co.','Dev','Just testing','2025-10-21 01:43:30'),(2,'Vinoth Sss Kumar','Malaysia','6599999999','kousshalya@gmail.com','Thinkfox Sdn Bhd','Software Developer','saa','2025-10-21 01:44:23'),(3,'Kousshalya Chandran','Malaysia','0103712517','kousshalya@gmail.com','Thinkfox Sdn Bhd','Software Developer','testets','2025-10-21 04:49:50');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exhibition_date`
--

DROP TABLE IF EXISTS `exhibition_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exhibition_date` (
  `id` int NOT NULL AUTO_INCREMENT,
  `venue_id` int NOT NULL,
  `exhibition_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `venue_id` (`venue_id`),
  CONSTRAINT `exhibition_date_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `exhibition_venue` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exhibition_date`
--

LOCK TABLES `exhibition_date` WRITE;
/*!40000 ALTER TABLE `exhibition_date` DISABLE KEYS */;
INSERT INTO `exhibition_date` VALUES (1,1,'2025-05-24'),(2,1,'2025-05-25'),(3,2,'2025-06-14'),(4,2,'2025-06-15'),(5,3,'2025-07-05'),(6,3,'2025-07-06'),(7,3,'2025-07-07'),(8,3,'2025-07-08');
/*!40000 ALTER TABLE `exhibition_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exhibition_venue`
--

DROP TABLE IF EXISTS `exhibition_venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exhibition_venue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `venue_city` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exhibition_venue`
--

LOCK TABLES `exhibition_venue` WRITE;
/*!40000 ALTER TABLE `exhibition_venue` DISABLE KEYS */;
INSERT INTO `exhibition_venue` VALUES (1,'Kuala Lumpur'),(2,'Pulau Pinang'),(3,'Johor Bahru');
/*!40000 ALTER TABLE `exhibition_venue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exhibitorlist`
--

DROP TABLE IF EXISTS `exhibitorlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exhibitorlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company` varchar(100) NOT NULL,
  `contactPerson` varchar(100) NOT NULL,
  `jobTitle` varchar(100) NOT NULL,
  `contactNumber` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `venue` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exhibitorlist`
--

LOCK TABLES `exhibitorlist` WRITE;
/*!40000 ALTER TABLE `exhibitorlist` DISABLE KEYS */;
INSERT INTO `exhibitorlist` VALUES (1,'Thinkfox Sdn Bhd','Kousshalya Chandran','Software Developer','6599999999','kousshalya@gmail.com','Pulau Pinang','2025-06-14','2025-10-21 05:05:01'),(2,'Thinkfox Sdn Bhd','Kousshalya Chandran','Software Developer','6599999999','kousshalya@gmail.com','2','2025-06-15','2025-10-21 16:44:38'),(3,'Thinkfox Sdn Bhd','Kousshalya Chandran','Software Developer','6599999999','kousshalya@gmail.com','3','2025-07-08','2025-10-21 16:45:06'),(4,'Thinkfox Sdn Bhd','Kousshalya Chandran','Software Developer','6599999999','kousshalya@gmail.com','3','2025-07-08','2025-10-21 16:45:20');
/*!40000 ALTER TABLE `exhibitorlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `company` varchar(100) NOT NULL,
  `contact_person` varchar(100) NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `contact_number` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `reserved_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_type`
--

DROP TABLE IF EXISTS `session_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_type`
--

LOCK TABLES `session_type` WRITE;
/*!40000 ALTER TABLE `session_type` DISABLE KEYS */;
INSERT INTO `session_type` VALUES (1,'job_matching'),(2,'career_talk');
/*!40000 ALTER TABLE `session_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_type_id` int NOT NULL,
  `venue_id` int NOT NULL,
  `session_date` date NOT NULL,
  `slot_time` varchar(50) NOT NULL,
  `company` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `session_type_id` (`session_type_id`),
  KEY `venue_id` (`venue_id`),
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`session_type_id`) REFERENCES `session_type` (`id`),
  CONSTRAINT `sessions_ibfk_2` FOREIGN KEY (`venue_id`) REFERENCES `exhibition_venue` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (5,1,2,'2025-06-15','10-11am','Babas'),(6,2,2,'2025-06-14','3-4pm','Thinkfox Sdn Bhd'),(7,1,3,'2025-07-05','10-11am','IJM');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-22  9:10:30
