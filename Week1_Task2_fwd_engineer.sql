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
  `EmployeeRoleID` INT NOT NULL AUTO_INCREMENT,
  `EmployeeRole` VARCHAR(45) NULL,
  `EmployeeSalary` INT NULL,
  PRIMARY KEY (`EmployeeRoleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employees` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `EmployeeName` VARCHAR(255) NULL,
  `EmployeeRoles_EmployeeRoleID` INT NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  INDEX `fk_Employees_EmployeeRoles1_idx` (`EmployeeRoles_EmployeeRoleID` ASC) VISIBLE,
  CONSTRAINT `fk_Employees_EmployeeRoles1`
    FOREIGN KEY (`EmployeeRoles_EmployeeRoleID`)
    REFERENCES `LittleLemonDB`.`EmployeeRoles` (`EmployeeRoleID`)
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
-- Table `LittleLemonDB`.`LocationCities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`LocationCities` (
  `LocationCityID` INT NOT NULL AUTO_INCREMENT,
  `LocationCity` VARCHAR(100) NULL,
  PRIMARY KEY (`LocationCityID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`LocationCountries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`LocationCountries` (
  `LocationCountryID` INT NOT NULL AUTO_INCREMENT,
  `LocationCountry` VARCHAR(100) NULL,
  PRIMARY KEY (`LocationCountryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Locations` (
  `LocationID` INT NOT NULL AUTO_INCREMENT,
  `LocationAddress` VARCHAR(255) NULL,
  `LocationCities_LocationCityID` INT NOT NULL,
  `LocationCountries_LocationCountryID` INT NOT NULL,
  PRIMARY KEY (`LocationID`),
  INDEX `fk_Locations_LocationCities1_idx` (`LocationCities_LocationCityID` ASC) VISIBLE,
  INDEX `fk_Locations_LocationCountries1_idx` (`LocationCountries_LocationCountryID` ASC) VISIBLE,
  CONSTRAINT `fk_Locations_LocationCities1`
    FOREIGN KEY (`LocationCities_LocationCityID`)
    REFERENCES `LittleLemonDB`.`LocationCities` (`LocationCityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Locations_LocationCountries1`
    FOREIGN KEY (`LocationCountries_LocationCountryID`)
    REFERENCES `LittleLemonDB`.`LocationCountries` (`LocationCountryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Deliveries` (
  `DeliveryID` INT NOT NULL AUTO_INCREMENT,
  `DeliveryDate` VARCHAR(45) NULL,
  `DeliveryStatus` VARCHAR(45) NULL,
  `Locations_LocationID` INT NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `fk_Deliveries_Locations1_idx` (`Locations_LocationID` ASC) VISIBLE,
  CONSTRAINT `fk_Deliveries_Locations1`
    FOREIGN KEY (`Locations_LocationID`)
    REFERENCES `LittleLemonDB`.`Locations` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` VARCHAR(11) NOT NULL,
  `Quantity` VARCHAR(45) NULL,
  `OrderCost` VARCHAR(45) NULL,
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
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemID` INT NOT NULL AUTO_INCREMENT,
  `MenuItemName` VARCHAR(100) NULL,
  `MenuItemType` VARCHAR(100) NULL,
  `MenuItemCuisine` VARCHAR(100) NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu_Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu_Orders` (
  `Orders_OrderID` VARCHAR(11) NOT NULL,
  `Menu_MenuID` INT NOT NULL,
  INDEX `fk_Menu_Orders_Menu1_idx` (`Menu_MenuID` ASC) VISIBLE,
  INDEX `fk_Menu_Orders_Orders1_idx` (`Orders_OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_Orders_Menu1`
    FOREIGN KEY (`Menu_MenuID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemID`)
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
