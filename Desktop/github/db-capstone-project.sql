-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: little_lemondb
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `BookingID` int NOT NULL,
  `BookingDate` datetime NOT NULL,
  `TableNumber` int NOT NULL,
  `CustomerID` varchar(45) NOT NULL,
  PRIMARY KEY (`BookingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerdetails`
--

DROP TABLE IF EXISTS `customerdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerdetails` (
  `CustomerID` int NOT NULL,
  `CustomerName` varchar(45) NOT NULL,
  `ContactNumber` int NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Bookings_BookingID` int NOT NULL,
  `Orders_OrderID` int NOT NULL,
  PRIMARY KEY (`CustomerID`,`Bookings_BookingID`,`Orders_OrderID`),
  KEY `fk_CustomerDetails_Bookings_idx` (`Bookings_BookingID`),
  KEY `fk_CustomerDetails_Orders1_idx` (`Orders_OrderID`),
  CONSTRAINT `fk_CustomerDetails_Bookings` FOREIGN KEY (`Bookings_BookingID`) REFERENCES `bookings` (`BookingID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_CustomerDetails_Orders1` FOREIGN KEY (`Orders_OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerdetails`
--

LOCK TABLES `customerdetails` WRITE;
/*!40000 ALTER TABLE `customerdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `customerdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `MenuID` int NOT NULL,
  `Category` varchar(45) NOT NULL,
  `ItemName` varchar(45) NOT NULL,
  `Price` decimal(5,2) NOT NULL,
  `Orders_has_Menu_Orders_OrderID` int NOT NULL,
  `Orders_has_Menu_Menu_MenuID` int NOT NULL,
  PRIMARY KEY (`MenuID`,`Orders_has_Menu_Orders_OrderID`,`Orders_has_Menu_Menu_MenuID`),
  KEY `fk_Menu_Orders_has_Menu1_idx` (`Orders_has_Menu_Orders_OrderID`,`Orders_has_Menu_Menu_MenuID`),
  CONSTRAINT `fk_Menu_Orders_has_Menu1` FOREIGN KEY (`Orders_has_Menu_Orders_OrderID`, `Orders_has_Menu_Menu_MenuID`) REFERENCES `orders_has_menu` (`Orders_OrderID`, `Menu_MenuID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdeliverystatus`
--

DROP TABLE IF EXISTS `orderdeliverystatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdeliverystatus` (
  `DeliveryStatusID` int NOT NULL,
  `DeliveryDate` datetime NOT NULL,
  `DeliveryStatus` varchar(45) NOT NULL,
  `OrderID` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`DeliveryStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdeliverystatus`
--

LOCK TABLES `orderdeliverystatus` WRITE;
/*!40000 ALTER TABLE `orderdeliverystatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderdeliverystatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL,
  `OrderDate` datetime NOT NULL,
  `Quantity` decimal(5,2) NOT NULL,
  `TotalCost` decimal(5,2) NOT NULL,
  `CustomerID` int NOT NULL,
  `StaffID` int NOT NULL,
  `OrderDeliveryStatus_DeliveryStatusID` int NOT NULL,
  `Orders_has_Menu_Orders_OrderID` int NOT NULL,
  `Orders_has_Menu_Menu_MenuID` int NOT NULL,
  PRIMARY KEY (`OrderID`,`OrderDeliveryStatus_DeliveryStatusID`,`Orders_has_Menu_Orders_OrderID`,`Orders_has_Menu_Menu_MenuID`),
  KEY `fk_Orders_OrderDeliveryStatus1_idx` (`OrderDeliveryStatus_DeliveryStatusID`),
  KEY `fk_Orders_Orders_has_Menu1_idx` (`Orders_has_Menu_Orders_OrderID`,`Orders_has_Menu_Menu_MenuID`),
  CONSTRAINT `fk_Orders_OrderDeliveryStatus1` FOREIGN KEY (`OrderDeliveryStatus_DeliveryStatusID`) REFERENCES `orderdeliverystatus` (`DeliveryStatusID`),
  CONSTRAINT `fk_Orders_Orders_has_Menu1` FOREIGN KEY (`Orders_has_Menu_Orders_OrderID`, `Orders_has_Menu_Menu_MenuID`) REFERENCES `orders_has_menu` (`Orders_OrderID`, `Menu_MenuID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_has_menu`
--

DROP TABLE IF EXISTS `orders_has_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_has_menu` (
  `Orders_OrderID` int NOT NULL,
  `Menu_MenuID` int NOT NULL,
  PRIMARY KEY (`Orders_OrderID`,`Menu_MenuID`),
  KEY `fk_Orders_has_Menu_Menu1_idx` (`Menu_MenuID`),
  KEY `fk_Orders_has_Menu_Orders1_idx` (`Orders_OrderID`),
  CONSTRAINT `fk_Orders_has_Menu_Menu1` FOREIGN KEY (`Menu_MenuID`) REFERENCES `menu` (`MenuID`),
  CONSTRAINT `fk_Orders_has_Menu_Orders1` FOREIGN KEY (`Orders_OrderID`) REFERENCES `orders` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_has_menu`
--

LOCK TABLES `orders_has_menu` WRITE;
/*!40000 ALTER TABLE `orders_has_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_has_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staffinformation`
--

DROP TABLE IF EXISTS `staffinformation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staffinformation` (
  `StaffID` int NOT NULL,
  `StaffName` varchar(45) NOT NULL,
  `Role` varchar(45) NOT NULL,
  `Salary` decimal(5,2) NOT NULL,
  `Orders_OrderID` int NOT NULL,
  PRIMARY KEY (`StaffID`,`Orders_OrderID`),
  KEY `fk_StaffInformation_Orders1_idx` (`Orders_OrderID`),
  CONSTRAINT `fk_StaffInformation_Orders1` FOREIGN KEY (`Orders_OrderID`) REFERENCES `orders` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staffinformation`
--

LOCK TABLES `staffinformation` WRITE;
/*!40000 ALTER TABLE `staffinformation` DISABLE KEYS */;
/*!40000 ALTER TABLE `staffinformation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-17 10:52:07
