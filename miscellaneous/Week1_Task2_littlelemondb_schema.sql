-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: littlelemondb
-- ------------------------------------------------------
-- Server version	8.0.36

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
  `BookingID` int NOT NULL AUTO_INCREMENT,
  `BookingDate` date DEFAULT NULL,
  `BookingTableNo` int DEFAULT NULL,
  `Customers_CustomerID` varchar(11) NOT NULL,
  `Staff_EmployeeID` int NOT NULL,
  PRIMARY KEY (`BookingID`),
  KEY `fk_Bookings_Customers_idx` (`Customers_CustomerID`),
  KEY `fk_Bookings_Staff1_idx` (`Staff_EmployeeID`),
  CONSTRAINT `fk_Bookings_Customers` FOREIGN KEY (`Customers_CustomerID`) REFERENCES `customers` (`CustomerID`),
  CONSTRAINT `fk_Bookings_Staff1` FOREIGN KEY (`Staff_EmployeeID`) REFERENCES `staff` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `CustomerID` varchar(11) NOT NULL,
  `CustomerName` varchar(255) DEFAULT NULL,
  `CustomerEmail` varchar(100) DEFAULT NULL,
  `CustomerPhone` int DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deliveries`
--

DROP TABLE IF EXISTS `deliveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliveries` (
  `DeliveryID` int NOT NULL AUTO_INCREMENT,
  `DeliveryDate` varchar(45) DEFAULT NULL,
  `DeliveryStatus` varchar(45) DEFAULT NULL,
  `Locations_LocationID` int NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  KEY `fk_Deliveries_Locations1_idx` (`Locations_LocationID`),
  CONSTRAINT `fk_Deliveries_Locations1` FOREIGN KEY (`Locations_LocationID`) REFERENCES `locations` (`LocationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `LocationID` int NOT NULL AUTO_INCREMENT,
  `LocationAddress` varchar(255) DEFAULT NULL,
  `LocationCity` varchar(45) DEFAULT NULL,
  `LocationCountry` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`LocationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_orders`
--

DROP TABLE IF EXISTS `menu_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_orders` (
  `Orders_OrderID` varchar(11) NOT NULL,
  `Menu_MenuID` int NOT NULL,
  KEY `fk_Menu_Orders_Menu1_idx` (`Menu_MenuID`),
  KEY `fk_Menu_Orders_Orders1_idx` (`Orders_OrderID`),
  CONSTRAINT `fk_Menu_Orders_Menu1` FOREIGN KEY (`Menu_MenuID`) REFERENCES `menuitems` (`MenuItemID`),
  CONSTRAINT `fk_Menu_Orders_Orders1` FOREIGN KEY (`Orders_OrderID`) REFERENCES `orders` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menuitems`
--

DROP TABLE IF EXISTS `menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitems` (
  `MenuItemID` int NOT NULL AUTO_INCREMENT,
  `MenuItemName` varchar(100) DEFAULT NULL,
  `MenuItemType` varchar(100) DEFAULT NULL,
  `MenuItemCuisine` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`MenuItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` varchar(11) NOT NULL,
  `Quantity` varchar(45) DEFAULT NULL,
  `OrderCost` varchar(45) DEFAULT NULL,
  `Deliveries_DeliveryID` int NOT NULL,
  `Customers_CustomerID` varchar(11) NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `fk_Orders_Deliveries1_idx` (`Deliveries_DeliveryID`),
  KEY `fk_Orders_Customers1_idx` (`Customers_CustomerID`),
  CONSTRAINT `fk_Orders_Customers1` FOREIGN KEY (`Customers_CustomerID`) REFERENCES `customers` (`CustomerID`),
  CONSTRAINT `fk_Orders_Deliveries1` FOREIGN KEY (`Deliveries_DeliveryID`) REFERENCES `deliveries` (`DeliveryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `EmployeeID` int NOT NULL AUTO_INCREMENT,
  `EmployeeName` varchar(255) DEFAULT NULL,
  `EmployeeRole` varchar(45) DEFAULT NULL,
  `EmployeeSalary` int DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-31 20:28:41
