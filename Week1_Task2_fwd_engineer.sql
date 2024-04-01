-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` VARCHAR(11) NOT NULL,
  `CustomerName` VARCHAR(255) NULL,
  `CustomerEmail` VARCHAR(100) NULL,
  `CustomerPhone` INT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`EmployeeRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`EmployeeRoles` (
  `EmployeeRole` VARCHAR(45) NOT NULL,
  `EmployeeSalary` INT NOT NULL,
  PRIMARY KEY (`EmployeeRole`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employees` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `EmployeeName` VARCHAR(255) NULL,
  `EmployeeRoles_EmployeeRole` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  INDEX `fk_Employees_EmployeeRoles1_idx` (`EmployeeRoles_EmployeeRole` ASC) VISIBLE,
  CONSTRAINT `fk_Employees_EmployeeRoles1`
    FOREIGN KEY (`EmployeeRoles_EmployeeRole`)
    REFERENCES `LittleLemonDB`.`EmployeeRoles` (`EmployeeRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `BookingDate` DATE NULL,
  `BookingTableNo` INT NULL,
  `Customers_CustomerID` VARCHAR(11) NOT NULL,
  `Staff_EmployeeID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `fk_Bookings_Customers_idx` (`Customers_CustomerID` ASC) VISIBLE,
  INDEX `fk_Bookings_Staff1_idx` (`Staff_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customers`
    FOREIGN KEY (`Customers_CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bookings_Staff1`
    FOREIGN KEY (`Staff_EmployeeID`)
    REFERENCES `LittleLemonDB`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`LocationRegions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`LocationRegions` (
  `LocationCountry` VARCHAR(100) NOT NULL,
  `LocationCity` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`LocationCity`, `LocationCountry`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Locations` (
  `LocationID` INT NOT NULL AUTO_INCREMENT,
  `LocationAddress` VARCHAR(255) NULL,
  `LocationRegions_LocationCity` VARCHAR(100) NOT NULL,
  `LocationRegions_LocationCountry` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`LocationID`),
  INDEX `fk_Locations_LocationRegions1_idx` (`LocationRegions_LocationCity` ASC, `LocationRegions_LocationCountry` ASC) VISIBLE,
  CONSTRAINT `fk_Locations_LocationRegions1`
    FOREIGN KEY (`LocationRegions_LocationCity` , `LocationRegions_LocationCountry`)
    REFERENCES `LittleLemonDB`.`LocationRegions` (`LocationCity` , `LocationCountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`DeliveryStatuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`DeliveryStatuses` (
  `DeliveryStatuses` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DeliveryStatuses`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Deliveries` (
  `DeliveryID` INT NOT NULL AUTO_INCREMENT,
  `DeliveryDate` VARCHAR(45) NULL,
  `DeliveryCost` DECIMAL(5,2) NULL,
  `Locations_LocationID` INT NOT NULL,
  `DeliveryStatuses_DeliveryStatuses` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `fk_Deliveries_Locations1_idx` (`Locations_LocationID` ASC) VISIBLE,
  INDEX `fk_Deliveries_DeliveryStatuses1_idx` (`DeliveryStatuses_DeliveryStatuses` ASC) VISIBLE,
  CONSTRAINT `fk_Deliveries_Locations1`
    FOREIGN KEY (`Locations_LocationID`)
    REFERENCES `LittleLemonDB`.`Locations` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Deliveries_DeliveryStatuses1`
    FOREIGN KEY (`DeliveryStatuses_DeliveryStatuses`)
    REFERENCES `LittleLemonDB`.`DeliveryStatuses` (`DeliveryStatuses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` VARCHAR(11) NOT NULL,
  `Quantity` INT NULL,
  `OrderCost` DECIMAL(6,2) NULL,
  `OrderSales` DECIMAL(6,2) NULL,
  `Discount` DECIMAL(5,2) NULL,
  `Deliveries_DeliveryID` INT NOT NULL,
  `Customers_CustomerID` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_Deliveries1_idx` (`Deliveries_DeliveryID` ASC) VISIBLE,
  INDEX `fk_Orders_Customers1_idx` (`Customers_CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Deliveries1`
    FOREIGN KEY (`Deliveries_DeliveryID`)
    REFERENCES `LittleLemonDB`.`Deliveries` (`DeliveryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`Customers_CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItemTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItemTypes` (
  `MenuItemType` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`MenuItemType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItemCuisines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItemCuisines` (
  `MenuItemCuisine` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`MenuItemCuisine`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemName` VARCHAR(100) NOT NULL,
  `MenuItemTypes_MenuItemType` VARCHAR(100) NOT NULL,
  `MenuItemCuisines_MenuItemCuisine` VARCHAR(100) NOT NULL,
  INDEX `fk_MenuItems_MenuItemTypes1_idx` (`MenuItemTypes_MenuItemType` ASC) VISIBLE,
  INDEX `fk_MenuItems_MenuItemCuisines1_idx` (`MenuItemCuisines_MenuItemCuisine` ASC) VISIBLE,
  PRIMARY KEY (`MenuItemName`),
  CONSTRAINT `fk_MenuItems_MenuItemTypes1`
    FOREIGN KEY (`MenuItemTypes_MenuItemType`)
    REFERENCES `LittleLemonDB`.`MenuItemTypes` (`MenuItemType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MenuItems_MenuItemCuisines1`
    FOREIGN KEY (`MenuItemCuisines_MenuItemCuisine`)
    REFERENCES `LittleLemonDB`.`MenuItemCuisines` (`MenuItemCuisine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu_Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu_Orders` (
  `MenuItems_MenuItemName` VARCHAR(100) NOT NULL,
  `Orders_OrderID` VARCHAR(11) NOT NULL,
  INDEX `fk_Menu_Orders_MenuItems1_idx` (`MenuItems_MenuItemName` ASC) VISIBLE,
  INDEX `fk_Menu_Orders_Orders1_idx` (`Orders_OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_Orders_MenuItems1`
    FOREIGN KEY (`MenuItems_MenuItemName`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Menu_Orders_Orders1`
    FOREIGN KEY (`Orders_OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
