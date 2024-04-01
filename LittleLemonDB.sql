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
  CONSTRAINT `fk_Bookings_Staff1` FOREIGN KEY (`Staff_EmployeeID`) REFERENCES `employees` (`EmployeeID`)
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
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliveries`
--

DROP TABLE IF EXISTS `deliveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliveries` (
  `DeliveryID` int NOT NULL AUTO_INCREMENT,
  `DeliveryDate` varchar(45) DEFAULT NULL,
  `DeliveryCost` decimal(5,2) DEFAULT NULL,
  `Locations_LocationID` int NOT NULL,
  `DeliveryStatuses_DeliveryStatuses` varchar(45) NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  KEY `fk_Deliveries_Locations1_idx` (`Locations_LocationID`),
  KEY `fk_Deliveries_DeliveryStatuses1_idx` (`DeliveryStatuses_DeliveryStatuses`),
  CONSTRAINT `fk_Deliveries_DeliveryStatuses1` FOREIGN KEY (`DeliveryStatuses_DeliveryStatuses`) REFERENCES `deliverystatuses` (`DeliveryStatuses`),
  CONSTRAINT `fk_Deliveries_Locations1` FOREIGN KEY (`Locations_LocationID`) REFERENCES `locations` (`LocationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliveries`
--

LOCK TABLES `deliveries` WRITE;
/*!40000 ALTER TABLE `deliveries` DISABLE KEYS */;
/*!40000 ALTER TABLE `deliveries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliverystatuses`
--

DROP TABLE IF EXISTS `deliverystatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliverystatuses` (
  `DeliveryStatuses` varchar(45) NOT NULL,
  PRIMARY KEY (`DeliveryStatuses`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliverystatuses`
--

LOCK TABLES `deliverystatuses` WRITE;
/*!40000 ALTER TABLE `deliverystatuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `deliverystatuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employeeroles`
--

DROP TABLE IF EXISTS `employeeroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employeeroles` (
  `EmployeeRole` varchar(45) NOT NULL,
  `EmployeeSalary` int NOT NULL,
  PRIMARY KEY (`EmployeeRole`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employeeroles`
--

LOCK TABLES `employeeroles` WRITE;
/*!40000 ALTER TABLE `employeeroles` DISABLE KEYS */;
/*!40000 ALTER TABLE `employeeroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `EmployeeID` int NOT NULL AUTO_INCREMENT,
  `EmployeeName` varchar(255) DEFAULT NULL,
  `EmployeeRoles_EmployeeRole` varchar(45) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  KEY `fk_Employees_EmployeeRoles1_idx` (`EmployeeRoles_EmployeeRole`),
  CONSTRAINT `fk_Employees_EmployeeRoles1` FOREIGN KEY (`EmployeeRoles_EmployeeRole`) REFERENCES `employeeroles` (`EmployeeRole`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locationregions`
--

DROP TABLE IF EXISTS `locationregions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locationregions` (
  `LocationCountry` varchar(100) NOT NULL,
  `LocationCity` varchar(100) NOT NULL,
  PRIMARY KEY (`LocationCity`,`LocationCountry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locationregions`
--

LOCK TABLES `locationregions` WRITE;
/*!40000 ALTER TABLE `locationregions` DISABLE KEYS */;
/*!40000 ALTER TABLE `locationregions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `LocationID` int NOT NULL AUTO_INCREMENT,
  `LocationAddress` varchar(255) DEFAULT NULL,
  `LocationRegions_LocationCity` varchar(100) NOT NULL,
  `LocationRegions_LocationCountry` varchar(100) NOT NULL,
  PRIMARY KEY (`LocationID`),
  KEY `fk_Locations_LocationRegions1_idx` (`LocationRegions_LocationCity`,`LocationRegions_LocationCountry`),
  CONSTRAINT `fk_Locations_LocationRegions1` FOREIGN KEY (`LocationRegions_LocationCity`, `LocationRegions_LocationCountry`) REFERENCES `locationregions` (`LocationCity`, `LocationCountry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_orders`
--

DROP TABLE IF EXISTS `menu_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_orders` (
  `MenuItems_MenuItemName` varchar(100) NOT NULL,
  `Orders_OrderID` varchar(11) NOT NULL,
  KEY `fk_Menu_Orders_MenuItems1_idx` (`MenuItems_MenuItemName`),
  KEY `fk_Menu_Orders_Orders1_idx` (`Orders_OrderID`),
  CONSTRAINT `fk_Menu_Orders_MenuItems1` FOREIGN KEY (`MenuItems_MenuItemName`) REFERENCES `menuitems` (`MenuItemName`),
  CONSTRAINT `fk_Menu_Orders_Orders1` FOREIGN KEY (`Orders_OrderID`) REFERENCES `orders` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_orders`
--

LOCK TABLES `menu_orders` WRITE;
/*!40000 ALTER TABLE `menu_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitemcuisines`
--

DROP TABLE IF EXISTS `menuitemcuisines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitemcuisines` (
  `MenuItemCuisine` varchar(100) NOT NULL,
  PRIMARY KEY (`MenuItemCuisine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitemcuisines`
--

LOCK TABLES `menuitemcuisines` WRITE;
/*!40000 ALTER TABLE `menuitemcuisines` DISABLE KEYS */;
/*!40000 ALTER TABLE `menuitemcuisines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitems`
--

DROP TABLE IF EXISTS `menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitems` (
  `MenuItemName` varchar(100) NOT NULL,
  `MenuItemTypes_MenuItemType` varchar(100) NOT NULL,
  `MenuItemCuisines_MenuItemCuisine` varchar(100) NOT NULL,
  PRIMARY KEY (`MenuItemName`),
  KEY `fk_MenuItems_MenuItemTypes1_idx` (`MenuItemTypes_MenuItemType`),
  KEY `fk_MenuItems_MenuItemCuisines1_idx` (`MenuItemCuisines_MenuItemCuisine`),
  CONSTRAINT `fk_MenuItems_MenuItemCuisines1` FOREIGN KEY (`MenuItemCuisines_MenuItemCuisine`) REFERENCES `menuitemcuisines` (`MenuItemCuisine`),
  CONSTRAINT `fk_MenuItems_MenuItemTypes1` FOREIGN KEY (`MenuItemTypes_MenuItemType`) REFERENCES `menuitemtypes` (`MenuItemType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitems`
--

LOCK TABLES `menuitems` WRITE;
/*!40000 ALTER TABLE `menuitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `menuitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitemtypes`
--

DROP TABLE IF EXISTS `menuitemtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitemtypes` (
  `MenuItemType` varchar(100) NOT NULL,
  PRIMARY KEY (`MenuItemType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitemtypes`
--

LOCK TABLES `menuitemtypes` WRITE;
/*!40000 ALTER TABLE `menuitemtypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `menuitemtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` varchar(11) NOT NULL,
  `Quantity` int DEFAULT NULL,
  `OrderCost` decimal(6,2) DEFAULT NULL,
  `OrderSales` decimal(6,2) DEFAULT NULL,
  `Discount` decimal(5,2) DEFAULT NULL,
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
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-31 21:40:11
