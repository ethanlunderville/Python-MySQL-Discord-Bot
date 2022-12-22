-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema multimediadb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `multimediadb` ;

-- -----------------------------------------------------
-- Schema multimediadb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `multimediadb` DEFAULT CHARACTER SET utf8 ;
USE `multimediadb` ;

-- -----------------------------------------------------
-- Table `multimediadb`.`Warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Warehouse` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Warehouse` (
  `idWarehouse` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(400) NULL,
  PRIMARY KEY (`idWarehouse`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Product` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Product` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `brand` VARCHAR(45) NULL,
  `price` DECIMAL(20,2) NULL,
  `name` VARCHAR(100) NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`idProduct`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`User` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `itemsbought` INT NULL DEFAULT 0,
  `recent_post_time` DATETIME NULL,
  `banned` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Shoppingcart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Shoppingcart` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Shoppingcart` (
  `idShoppingcart` INT NOT NULL AUTO_INCREMENT,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idShoppingcart`),
  INDEX `fk_Shoppingcart_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Shoppingcart_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `multimediadb`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`ShoppingcartProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`ShoppingcartProduct` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`ShoppingcartProduct` (
  `idShoppingcartProduct` INT NOT NULL AUTO_INCREMENT,
  `Shoppingcart_idShoppingcart` INT NOT NULL,
  `Product_idProduct` INT NOT NULL,
  PRIMARY KEY (`idShoppingcartProduct`),
  INDEX `fk_ShoppingcartProduct_Shoppingcart1_idx` (`Shoppingcart_idShoppingcart` ASC) VISIBLE,
  INDEX `fk_ShoppingcartProduct_Product1_idx` (`Product_idProduct` ASC) VISIBLE,
  CONSTRAINT `fk_ShoppingcartProduct_Shoppingcart1`
    FOREIGN KEY (`Shoppingcart_idShoppingcart`)
    REFERENCES `multimediadb`.`Shoppingcart` (`idShoppingcart`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ShoppingcartProduct_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `multimediadb`.`Product` (`idProduct`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Shipmentmethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Shipmentmethod` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Shipmentmethod` (
  `idShipmentmethod` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idShipmentmethod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Orders` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Orders` (
  `idOrders` INT NOT NULL AUTO_INCREMENT,
  `Shipmentmethod_idShipmentmethod` INT NOT NULL,
  `User_idUser` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `total` DECIMAL(20,2) NULL,
  PRIMARY KEY (`idOrders`),
  INDEX `fk_Orders_Shipmentmethod1_idx` (`Shipmentmethod_idShipmentmethod` ASC) VISIBLE,
  INDEX `fk_Orders_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Shipmentmethod1`
    FOREIGN KEY (`Shipmentmethod_idShipmentmethod`)
    REFERENCES `multimediadb`.`Shipmentmethod` (`idShipmentmethod`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Orders_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `multimediadb`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`WarehouseProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`WarehouseProduct` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`WarehouseProduct` (
  `idWarehouseProduct` INT NOT NULL AUTO_INCREMENT,
  `Product_idProduct` INT NOT NULL,
  `Warehouse_idWarehouse` INT NOT NULL,
  PRIMARY KEY (`idWarehouseProduct`),
  INDEX `fk_ShoppingcartProduct_Product_idx` (`Product_idProduct` ASC) VISIBLE,
  INDEX `fk_ShoppingcartProduct_Warehouse1_idx` (`Warehouse_idWarehouse` ASC) VISIBLE,
  CONSTRAINT `fk_ShoppingcartProduct_Product`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `multimediadb`.`Product` (`idProduct`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ShoppingcartProduct_Warehouse1`
    FOREIGN KEY (`Warehouse_idWarehouse`)
    REFERENCES `multimediadb`.`Warehouse` (`idWarehouse`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`OrdersProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`OrdersProduct` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`OrdersProduct` (
  `idOrdersProduct` INT NOT NULL AUTO_INCREMENT,
  `Orders_idOrders` INT NOT NULL,
  `Product_idProduct` INT NOT NULL,
  PRIMARY KEY (`idOrdersProduct`),
  INDEX `fk_OrdersProduct_Orders1_idx` (`Orders_idOrders` ASC) VISIBLE,
  INDEX `fk_OrdersProduct_Product1_idx` (`Product_idProduct` ASC) VISIBLE,
  CONSTRAINT `fk_OrdersProduct_Orders1`
    FOREIGN KEY (`Orders_idOrders`)
    REFERENCES `multimediadb`.`Orders` (`idOrders`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_OrdersProduct_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `multimediadb`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Plane`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Plane` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Plane` (
  `idPlane` INT NOT NULL AUTO_INCREMENT,
  `Shipmentmethod_idShipmentmethod` INT NOT NULL,
  `Airline` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPlane`, `Shipmentmethod_idShipmentmethod`),
  INDEX `fk_Plane_Shipmentmethod1_idx` (`Shipmentmethod_idShipmentmethod` ASC) VISIBLE,
  CONSTRAINT `fk_Plane_Shipmentmethod1`
    FOREIGN KEY (`Shipmentmethod_idShipmentmethod`)
    REFERENCES `multimediadb`.`Shipmentmethod` (`idShipmentmethod`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Car`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Car` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Car` (
  `idCar` INT NOT NULL AUTO_INCREMENT,
  `Shipmentmethod_idShipmentmethod` INT NOT NULL,
  `license` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idCar`, `Shipmentmethod_idShipmentmethod`),
  INDEX `fk_Car_Shipmentmethod1_idx` (`Shipmentmethod_idShipmentmethod` ASC) VISIBLE,
  CONSTRAINT `fk_Car_Shipmentmethod1`
    FOREIGN KEY (`Shipmentmethod_idShipmentmethod`)
    REFERENCES `multimediadb`.`Shipmentmethod` (`idShipmentmethod`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Paymentmethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Paymentmethod` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Paymentmethod` (
  `idPaymentmethod` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idPaymentmethod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Crypto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Crypto` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Crypto` (
  `idCrypto` INT NOT NULL AUTO_INCREMENT,
  `Paymentmethod_idPaymentmethod` INT NOT NULL,
  `hash` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCrypto`, `Paymentmethod_idPaymentmethod`),
  INDEX `fk_Crypto_Paymentmethod1_idx` (`Paymentmethod_idPaymentmethod` ASC) VISIBLE,
  CONSTRAINT `fk_Crypto_Paymentmethod1`
    FOREIGN KEY (`Paymentmethod_idPaymentmethod`)
    REFERENCES `multimediadb`.`Paymentmethod` (`idPaymentmethod`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Bank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Bank` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Bank` (
  `idBank` INT NOT NULL AUTO_INCREMENT,
  `Paymentmethod_idPaymentmethod` INT NOT NULL,
  `cardnumber` VARCHAR(16) NULL,
  `securitycode` VARCHAR(3) NULL,
  PRIMARY KEY (`idBank`, `Paymentmethod_idPaymentmethod`),
  INDEX `fk_Bank_Paymentmethod1_idx` (`Paymentmethod_idPaymentmethod` ASC) VISIBLE,
  CONSTRAINT `fk_Bank_Paymentmethod1`
    FOREIGN KEY (`Paymentmethod_idPaymentmethod`)
    REFERENCES `multimediadb`.`Paymentmethod` (`idPaymentmethod`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Role` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Role` (
  `idRole` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idRole`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Roleuser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Roleuser` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Roleuser` (
  `idRoleuser` INT NOT NULL AUTO_INCREMENT,
  `Role_idRole` INT NOT NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idRoleuser`),
  INDEX `fk_Roleuser_Role1_idx` (`Role_idRole` ASC) VISIBLE,
  INDEX `fk_Roleuser_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Roleuser_Role1`
    FOREIGN KEY (`Role_idRole`)
    REFERENCES `multimediadb`.`Role` (`idRole`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Roleuser_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `multimediadb`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Banneduser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Banneduser` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Banneduser` (
  `idBanneduser` INT NOT NULL AUTO_INCREMENT,
  `User_idUser` INT NOT NULL,
  `ban_removal_date` DATETIME NOT NULL,
  PRIMARY KEY (`idBanneduser`, `User_idUser`),
  INDEX `fk_Banneduser_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Banneduser_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `multimediadb`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Admin` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Admin` (
  `idAdmin` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(10) NULL,
  `lastname` VARCHAR(45) NULL,
  `reports_reviewed` INT NULL DEFAULT 0,
  PRIMARY KEY (`idAdmin`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Account` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Account` (
  `idAccount` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(80) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `date` DATE NULL,
  `User_idUser` INT NULL,
  PRIMARY KEY (`idAccount`),
  INDEX `fk_Account_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Account_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `multimediadb`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Thirdpartyorganization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Thirdpartyorganization` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Thirdpartyorganization` (
  `idThirdpartyorganization` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `Account_idAccount` INT NULL,
  PRIMARY KEY (`idThirdpartyorganization`),
  INDEX `fk_Thirdpartyorganization_Account1_idx` (`Account_idAccount` ASC) VISIBLE,
  CONSTRAINT `fk_Thirdpartyorganization_Account1`
    FOREIGN KEY (`Account_idAccount`)
    REFERENCES `multimediadb`.`Account` (`idAccount`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Multimediacontent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Multimediacontent` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Multimediacontent` (
  `idMultimediacontent` INT NOT NULL AUTO_INCREMENT,
  `Thirdpartyorganization_idThirdpartyorganization` INT NULL,
  PRIMARY KEY (`idMultimediacontent`),
  INDEX `fk_Multimediacontent_Thirdpartyorganization1_idx` (`Thirdpartyorganization_idThirdpartyorganization` ASC) VISIBLE,
  CONSTRAINT `fk_Multimediacontent_Thirdpartyorganization1`
    FOREIGN KEY (`Thirdpartyorganization_idThirdpartyorganization`)
    REFERENCES `multimediadb`.`Thirdpartyorganization` (`idThirdpartyorganization`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Contentreport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Contentreport` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Contentreport` (
  `Admin_idAdmin` INT NULL,
  `idContentreport` INT NOT NULL AUTO_INCREMENT,
  `User_idUser` INT NULL,
  `Multimediacontent_idMultimediacontent` INT NOT NULL,
  `report` MEDIUMTEXT NOT NULL,
  `reviewed` INT NULL DEFAULT 0,
  INDEX `fk_Contentreport_Admin1_idx` (`Admin_idAdmin` ASC) VISIBLE,
  PRIMARY KEY (`idContentreport`),
  INDEX `fk_Contentreport_User1_idx` (`User_idUser` ASC) VISIBLE,
  INDEX `fk_Contentreport_Multimediacontent1_idx` (`Multimediacontent_idMultimediacontent` ASC) VISIBLE,
  CONSTRAINT `fk_Contentreport_Admin1`
    FOREIGN KEY (`Admin_idAdmin`)
    REFERENCES `multimediadb`.`Admin` (`idAdmin`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `fk_Contentreport_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `multimediadb`.`User` (`idUser`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `fk_Contentreport_Multimediacontent1`
    FOREIGN KEY (`Multimediacontent_idMultimediacontent`)
    REFERENCES `multimediadb`.`Multimediacontent` (`idMultimediacontent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Facultyaccount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Facultyaccount` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Facultyaccount` (
  `idFacultyaccount` VARCHAR(10) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFacultyaccount`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Video` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Video` (
  `idVideo` INT NOT NULL AUTO_INCREMENT,
  `Multimediacontent_idMultimediacontent` INT NOT NULL,
  `Video` VARCHAR(2083) NOT NULL,
  `length` DECIMAL(20,2) NOT NULL,
  `genre` VARCHAR(100) NULL,
  PRIMARY KEY (`idVideo`, `Multimediacontent_idMultimediacontent`),
  INDEX `fk_Video_Multimediacontent1_idx` (`Multimediacontent_idMultimediacontent` ASC) VISIBLE,
  CONSTRAINT `fk_Video_Multimediacontent1`
    FOREIGN KEY (`Multimediacontent_idMultimediacontent`)
    REFERENCES `multimediadb`.`Multimediacontent` (`idMultimediacontent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Mp3`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Mp3` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Mp3` (
  `idMp3` INT NOT NULL AUTO_INCREMENT,
  `Multimediacontent_idMultimediacontent` INT NOT NULL,
  `Mp3` VARCHAR(2083) NULL,
  `length` DECIMAL(20,2) NULL,
  `genre` VARCHAR(100) NULL,
  PRIMARY KEY (`idMp3`, `Multimediacontent_idMultimediacontent`),
  INDEX `fk_Mp3_Multimediacontent1_idx` (`Multimediacontent_idMultimediacontent` ASC) VISIBLE,
  CONSTRAINT `fk_Mp3_Multimediacontent1`
    FOREIGN KEY (`Multimediacontent_idMultimediacontent`)
    REFERENCES `multimediadb`.`Multimediacontent` (`idMultimediacontent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Ebook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Ebook` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Ebook` (
  `idEbook` INT NOT NULL AUTO_INCREMENT,
  `Multimediacontent_idMultimediacontent` INT NOT NULL,
  `Ebook` VARCHAR(2083) NULL,
  PRIMARY KEY (`idEbook`, `Multimediacontent_idMultimediacontent`),
  INDEX `fk_Ebook_Multimediacontent1_idx` (`Multimediacontent_idMultimediacontent` ASC) VISIBLE,
  CONSTRAINT `fk_Ebook_Multimediacontent1`
    FOREIGN KEY (`Multimediacontent_idMultimediacontent`)
    REFERENCES `multimediadb`.`Multimediacontent` (`idMultimediacontent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Picture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Picture` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Picture` (
  `idPicture` INT NOT NULL AUTO_INCREMENT,
  `Multimediacontent_idMultimediacontent` INT NOT NULL,
  `picture` VARCHAR(2083) NOT NULL,
  PRIMARY KEY (`idPicture`, `Multimediacontent_idMultimediacontent`),
  INDEX `fk_Picture_Multimediacontent1_idx` (`Multimediacontent_idMultimediacontent` ASC) VISIBLE,
  CONSTRAINT `fk_Picture_Multimediacontent1`
    FOREIGN KEY (`Multimediacontent_idMultimediacontent`)
    REFERENCES `multimediadb`.`Multimediacontent` (`idMultimediacontent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Author` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Author` (
  `idAuthor` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  PRIMARY KEY (`idAuthor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Multimediacontentauthor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Multimediacontentauthor` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Multimediacontentauthor` (
  `idMultimediacontentauthor` INT NOT NULL AUTO_INCREMENT,
  `Multimediacontent_idMultimediacontent` INT NOT NULL,
  `Author_idAuthor` INT NOT NULL,
  PRIMARY KEY (`idMultimediacontentauthor`),
  INDEX `fk_Multimediacontentauthor_Multimediacontent1_idx` (`Multimediacontent_idMultimediacontent` ASC) VISIBLE,
  INDEX `fk_Multimediacontentauthor_Author1_idx` (`Author_idAuthor` ASC) VISIBLE,
  CONSTRAINT `fk_Multimediacontentauthor_Multimediacontent1`
    FOREIGN KEY (`Multimediacontent_idMultimediacontent`)
    REFERENCES `multimediadb`.`Multimediacontent` (`idMultimediacontent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Multimediacontentauthor_Author1`
    FOREIGN KEY (`Author_idAuthor`)
    REFERENCES `multimediadb`.`Author` (`idAuthor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Class`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Class` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Class` (
  `idClass` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `subject` VARCHAR(45) NULL,
  PRIMARY KEY (`idClass`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Club` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Club` (
  `idClub` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`idClub`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Forum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Forum` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Forum` (
  `idForum` INT NOT NULL AUTO_INCREMENT,
  `Class_idClass` INT NULL,
  `Club_idClub` INT NULL,
  PRIMARY KEY (`idForum`),
  INDEX `fk_Forum_Class1_idx` (`Class_idClass` ASC) VISIBLE,
  INDEX `fk_Forum_Club1_idx` (`Club_idClub` ASC) VISIBLE,
  CONSTRAINT `fk_Forum_Class1`
    FOREIGN KEY (`Class_idClass`)
    REFERENCES `multimediadb`.`Class` (`idClass`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `fk_Forum_Club1`
    FOREIGN KEY (`Club_idClub`)
    REFERENCES `multimediadb`.`Club` (`idClub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Post` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Post` (
  `idPosts` INT NOT NULL AUTO_INCREMENT,
  `Multimediacontent_idMultimediacontent` INT NULL,
  `User_idUser` INT NULL,
  `Forum_idForum` INT NULL,
  `content` MEDIUMTEXT NULL,
  `time` DATETIME NULL,
  PRIMARY KEY (`idPosts`),
  INDEX `fk_Posts_Multimediacontent1_idx` (`Multimediacontent_idMultimediacontent` ASC) VISIBLE,
  INDEX `fk_Posts_User1_idx` (`User_idUser` ASC) VISIBLE,
  INDEX `fk_Posts_Forum1_idx` (`Forum_idForum` ASC) VISIBLE,
  CONSTRAINT `fk_Posts_Multimediacontent1`
    FOREIGN KEY (`Multimediacontent_idMultimediacontent`)
    REFERENCES `multimediadb`.`Multimediacontent` (`idMultimediacontent`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `fk_Posts_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `multimediadb`.`User` (`idUser`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `fk_Posts_Forum1`
    FOREIGN KEY (`Forum_idForum`)
    REFERENCES `multimediadb`.`Forum` (`idForum`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Comments` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Comments` (
  `idComments` INT NOT NULL AUTO_INCREMENT,
  `Posts_idPosts` INT NOT NULL,
  `User_idUser` INT NULL,
  `comment` VARCHAR(400) NOT NULL,
  PRIMARY KEY (`idComments`),
  INDEX `fk_Comments_Posts1_idx` (`Posts_idPosts` ASC) VISIBLE,
  INDEX `fk_Comments_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Comments_Posts1`
    FOREIGN KEY (`Posts_idPosts`)
    REFERENCES `multimediadb`.`Post` (`idPosts`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Comments_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `multimediadb`.`User` (`idUser`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Bulletin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Bulletin` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Bulletin` (
  `Forum_idForum` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Forum_idForum`),
  CONSTRAINT `fk_Bulletin_Forum1`
    FOREIGN KEY (`Forum_idForum`)
    REFERENCES `multimediadb`.`Forum` (`idForum`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Faculty` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Faculty` (
  `idFaculty` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NULL,
  PRIMARY KEY (`idFaculty`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Facultyclub`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Facultyclub` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Facultyclub` (
  `idFacultyclub` INT NOT NULL AUTO_INCREMENT,
  `Faculty_idFaculty` INT NOT NULL,
  `Club_idClub` INT NOT NULL,
  PRIMARY KEY (`idFacultyclub`),
  INDEX `fk_Facultyclub_Faculty1_idx` (`Faculty_idFaculty` ASC) VISIBLE,
  INDEX `fk_Facultyclub_Club1_idx` (`Club_idClub` ASC) VISIBLE,
  CONSTRAINT `fk_Facultyclub_Faculty1`
    FOREIGN KEY (`Faculty_idFaculty`)
    REFERENCES `multimediadb`.`Faculty` (`idFaculty`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Facultyclub_Club1`
    FOREIGN KEY (`Club_idClub`)
    REFERENCES `multimediadb`.`Club` (`idClub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Professor` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Professor` (
  `idProfessor` INT NOT NULL AUTO_INCREMENT,
  `User_idUser` INT NOT NULL,
  `Professornum` VARCHAR(45) NULL,
  PRIMARY KEY (`idProfessor`, `User_idUser`),
  INDEX `fk_Professor_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Professor_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `multimediadb`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Professorclass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Professorclass` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Professorclass` (
  `idProfessorclass` INT NOT NULL AUTO_INCREMENT,
  `Class_idClass` INT NOT NULL,
  `Professor_idProfessor` INT NOT NULL,
  PRIMARY KEY (`idProfessorclass`),
  INDEX `fk_Professorclass_Class1_idx` (`Class_idClass` ASC) VISIBLE,
  INDEX `fk_Professorclass_Professor1_idx` (`Professor_idProfessor` ASC) VISIBLE,
  CONSTRAINT `fk_Professorclass_Class1`
    FOREIGN KEY (`Class_idClass`)
    REFERENCES `multimediadb`.`Class` (`idClass`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Professorclass_Professor1`
    FOREIGN KEY (`Professor_idProfessor`)
    REFERENCES `multimediadb`.`Professor` (`idProfessor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Student` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Student` (
  `idStudent` INT NOT NULL AUTO_INCREMENT,
  `User_idUser` INT NOT NULL,
  `Studentnum` VARCHAR(45) NULL,
  PRIMARY KEY (`idStudent`, `User_idUser`),
  INDEX `fk_Student_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Student_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `multimediadb`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Studentclass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Studentclass` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Studentclass` (
  `idStudentclass` INT NOT NULL AUTO_INCREMENT,
  `Class_idClass` INT NOT NULL,
  `Student_idStudent` INT NOT NULL,
  PRIMARY KEY (`idStudentclass`),
  INDEX `fk_Studentclass_Class1_idx` (`Class_idClass` ASC) VISIBLE,
  INDEX `fk_Studentclass_Student1_idx` (`Student_idStudent` ASC) VISIBLE,
  CONSTRAINT `fk_Studentclass_Class1`
    FOREIGN KEY (`Class_idClass`)
    REFERENCES `multimediadb`.`Class` (`idClass`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Studentclass_Student1`
    FOREIGN KEY (`Student_idStudent`)
    REFERENCES `multimediadb`.`Student` (`idStudent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Facultymanager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Facultymanager` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Facultymanager` (
  `idFacultymanager` INT NOT NULL AUTO_INCREMENT,
  `Faculty_idFaculty` INT NOT NULL,
  `Faculty_idFaculty1` INT NOT NULL,
  PRIMARY KEY (`idFacultymanager`),
  INDEX `fk_Facultymanager_Faculty1_idx` (`Faculty_idFaculty` ASC) VISIBLE,
  INDEX `fk_Facultymanager_Faculty2_idx` (`Faculty_idFaculty1` ASC) VISIBLE,
  CONSTRAINT `fk_Facultymanager_Faculty1`
    FOREIGN KEY (`Faculty_idFaculty`)
    REFERENCES `multimediadb`.`Faculty` (`idFaculty`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Facultymanager_Faculty2`
    FOREIGN KEY (`Faculty_idFaculty1`)
    REFERENCES `multimediadb`.`Faculty` (`idFaculty`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Paymentmethoduser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Paymentmethoduser` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Paymentmethoduser` (
  `idPaymentmethoduser` INT NOT NULL AUTO_INCREMENT,
  `Paymentmethod_idPaymentmethod` INT NOT NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idPaymentmethoduser`),
  INDEX `fk_Paymentmethoduser_Paymentmethod1_idx` (`Paymentmethod_idPaymentmethod` ASC) VISIBLE,
  INDEX `fk_Paymentmethoduser_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Paymentmethoduser_Paymentmethod1`
    FOREIGN KEY (`Paymentmethod_idPaymentmethod`)
    REFERENCES `multimediadb`.`Paymentmethod` (`idPaymentmethod`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Paymentmethoduser_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `multimediadb`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Event` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Event` (
  `idEvent` INT NOT NULL AUTO_INCREMENT,
  `Thirdpartyorganization_idThirdpartyorganization` INT NULL,
  `date` DATETIME NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idEvent`),
  INDEX `fk_Event_Thirdpartyorganization1_idx` (`Thirdpartyorganization_idThirdpartyorganization` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Thirdpartyorganization1`
    FOREIGN KEY (`Thirdpartyorganization_idThirdpartyorganization`)
    REFERENCES `multimediadb`.`Thirdpartyorganization` (`idThirdpartyorganization`)
    ON DELETE CASCADE
    ON UPDATE SET NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Permissions` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Permissions` (
  `idPermissions` INT NOT NULL AUTO_INCREMENT,
  `description` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`idPermissions`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimediadb`.`Userpermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multimediadb`.`Userpermissions` ;

CREATE TABLE IF NOT EXISTS `multimediadb`.`Userpermissions` (
  `idUserpermissions` INT NOT NULL AUTO_INCREMENT,
  `Permissions_idPermissions` INT NOT NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idUserpermissions`),
  INDEX `fk_Userpermissions_Permissions1_idx` (`Permissions_idPermissions` ASC) VISIBLE,
  INDEX `fk_Userpermissions_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Userpermissions_Permissions1`
    FOREIGN KEY (`Permissions_idPermissions`)
    REFERENCES `multimediadb`.`Permissions` (`idPermissions`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Userpermissions_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `multimediadb`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- Script name: inserts.sql
-- Author:      Ethan Lunderville
-- Purpose:     insert sample data to test the integrity of this database system
   
-- the database used to insert the data into.

USE multimediadb;

INSERT INTO `Warehouse` VALUES (NULL,'11166 Advent Lane');
INSERT INTO `Warehouse` VALUES (NULL,'21 Jackson Dr');
INSERT INTO `Warehouse` VALUES (NULL,'17888 Grey Ct');

INSERT INTO `Product` VALUES (NULL,'Nike',120.00,'Airforce 1s',44);
INSERT INTO `Product` VALUES (NULL,'Vans',50.99,'Half Cabs',66);
INSERT INTO `Product` VALUES (NULL,'Supra','300.99','Vader',100);
INSERT INTO `Product` VALUES (NULL,'Nike','200.99','Airforce 2s',44);
INSERT INTO `Product` VALUES (NULL,'Vans','60.99','Classic',67);
INSERT INTO `Product` VALUES (NULL,'Supra','350.00','Muska',177);
INSERT INTO `Product` VALUES (NULL,'Steve Madden','350.00','Shoe',1);

INSERT INTO `User` VALUES (NULL,'ethan','lunderville',0,NOW(),0);
INSERT INTO `User` VALUES (NULL,'joni','boi',0,NOW(),0);
INSERT INTO `User` VALUES (NULL,'james','lunderville',0,NOW(),0);
INSERT INTO `User` VALUES (NULL,'jordan','lunderville',0,NOW(),0);
INSERT INTO `User` VALUES (NULL,'Demetrius','Johnson',0,NOW(),0);
INSERT INTO `User` VALUES (NULL,'Bartholomew','Dinglenut',0,NOW(),0);
INSERT INTO `User` VALUES (NULL,'Cornelius','lunderville',0,NOW(),0);
INSERT INTO `User` VALUES (NULL,'joni','boi',0,NOW(),1);
INSERT INTO `User` VALUES (NULL,'james','lunderville',0,NOW(),0);

INSERT INTO `Account` VALUES (NULL,'ethan@gmail.com','123456789',CAST('2022-11-06' AS DATE),1);
INSERT INTO `Account` VALUES (NULL,'jon@yahoo.com','Password',NOW(),2);
INSERT INTO `Account` VALUES (NULL,'james@gmail.com','Otherpassword',NOW(),3);
INSERT INTO `Account` VALUES (NULL,'bart@yahoo.com','ddddddddd',NOW(),4);
INSERT INTO `Account` VALUES (NULL,'corndog@gmail.com','Otherpassword5555!',NOW(),5);

-- THIRD PARTIES \/\/\/

INSERT INTO `Account` VALUES (NULL,'girlswhocode@gmail.com','jefjwed',NOW(), 6);
INSERT INTO `Account` VALUES (NULL,'sfhacks@gmail.com','ddddddddd',NOW(),7);
INSERT INTO `Account` VALUES (NULL,'endangeredspeciesinternational@gmail.com','Otherpassword5555!',NOW(),8);

INSERT INTO `Shipmentmethod` VALUES (NULL);
INSERT INTO `Shipmentmethod` VALUES (NULL);
INSERT INTO `Shipmentmethod` VALUES (NULL);

INSERT INTO `Car` VALUES (NULL,1,'4mma999');
INSERT INTO `Car` VALUES (NULL,2,'4444llk');
INSERT INTO `Car` VALUES (NULL,1,'70yglmm');



INSERT INTO `Shoppingcart` VALUES (NULL,1);
INSERT INTO `Shoppingcart` VALUES (NULL,2);
INSERT INTO `Shoppingcart` VALUES (NULL,3);


INSERT INTO `ShoppingcartProduct` VALUES (NULL,1,2);
INSERT INTO `ShoppingcartProduct` VALUES (NULL,2,2);
INSERT INTO `ShoppingcartProduct` VALUES (NULL,2,3);
INSERT INTO `ShoppingcartProduct` VALUES (NULL,1,3);
INSERT INTO `ShoppingcartProduct` VALUES (NULL,3,3);
INSERT INTO `ShoppingcartProduct` VALUES (NULL,2,2);


INSERT INTO `Orders` VALUES (NULL,1,1,CAST('2007-06-09 12:35:23.123' AS datetime), 500.11);
INSERT INTO `Orders` VALUES (NULL,1,2,CAST('2007-06-09 12:35:23.123' AS datetime), 30.33);
INSERT INTO `Orders` VALUES (NULL,2,3,CAST('2007-06-09 12:35:23.123' AS datetime), 55.55);

INSERT INTO `Orders` VALUES (NULL,1,1,CAST('2007-07-09 12:35:23.123' AS datetime), 500.11);
INSERT INTO `Orders` VALUES (NULL,1,2,CAST('2007-07-09 12:35:23.123' AS datetime), 300.33);
INSERT INTO `Orders` VALUES (NULL,2,3,CAST('2007-07-09 12:35:23.123' AS datetime), 556.55);

INSERT INTO `Orders` VALUES (NULL,1,1,CAST('2007-08-09 12:35:23.123' AS datetime), 500.11);
INSERT INTO `Orders` VALUES (NULL,1,2,CAST('2007-08-09 12:35:23.123' AS datetime), 366.33);
INSERT INTO `Orders` VALUES (NULL,2,3,CAST('2007-08-09 12:35:23.123' AS datetime), 552.55);


INSERT INTO `WarehouseProduct` VALUES (NULL,1,2);
INSERT INTO `WarehouseProduct` VALUES (NULL,2,3);
INSERT INTO `WarehouseProduct` VALUES (NULL,3,3);


INSERT INTO `OrdersProduct` VALUES (NULL,1,2);
INSERT INTO `OrdersProduct` VALUES (NULL,2,2);
INSERT INTO `OrdersProduct` VALUES (NULL,2,3);
INSERT INTO `OrdersProduct` VALUES (NULL,2,1);
INSERT INTO `OrdersProduct` VALUES (NULL,3,3);
INSERT INTO `OrdersProduct` VALUES (NULL,1,1);


INSERT INTO `Plane` VALUES (NULL,1,'Spirit');
INSERT INTO `Plane` VALUES (NULL,2,'Southwestern');
INSERT INTO `Plane` VALUES (NULL,3,'Alaska');


INSERT INTO `Paymentmethod` VALUES (NULL);
INSERT INTO `Paymentmethod` VALUES (NULL);
INSERT INTO `Paymentmethod` VALUES (NULL);
INSERT INTO `Paymentmethod` VALUES (NULL);
INSERT INTO `Paymentmethod` VALUES (NULL);
INSERT INTO `Paymentmethod` VALUES (NULL);


INSERT INTO `Crypto` VALUES (NULL,4,'kkDrc30mzb1EAEHthkWbOPQY5orihmXastOnHN4MpGqPSFnsSdGWvkbY9rUrTXR06rh3R6TCPkKXHv40egLKyEnRco5feu88yPWB');
INSERT INTO `Crypto` VALUES (NULL,5,'m8xbpRaNEwloxQXtpfasDHThWBwWQ2vGjlGgs8OpulOVRd7ZXmmHjbkkPQHSRGuGelIWQJZm0v3dOcSJrxJ1jrh9QK0MDoILTfri');
INSERT INTO `Crypto` VALUES (NULL,6,'KRhJP0kQCAyRqjFN3zPclJbpa8VeTUQlM8ExBMVGA3OzVWJS6TDyLnL643UYbqfnmifHRgl07QnioXNtgmoodhnZpsfzrGUMEehi');


INSERT INTO `Bank` VALUES (NULL,1,'XRfm08IdMMdyjWDd','889');
INSERT INTO `Bank` VALUES (NULL,2,'W9KhRZAAc1PiFwOa','443');
INSERT INTO `Bank` VALUES (NULL,3,'gFxebCZqqcCO7zzn','444');


INSERT INTO `Role` VALUES (NULL,'Student');
INSERT INTO `Role` VALUES (NULL,'Professor');
INSERT INTO `Role` VALUES (NULL,'Faculty');
INSERT INTO `Role` VALUES (NULL,'Admin');
INSERT INTO `Role` VALUES (NULL,'SuperUser');


INSERT INTO `Roleuser` VALUES (NULL,1,1);
INSERT INTO `Roleuser` VALUES (NULL,2,1);
INSERT INTO `Roleuser` VALUES (NULL,2,2);
INSERT INTO `Roleuser` VALUES (NULL,1,3);
INSERT INTO `Roleuser` VALUES (NULL,3,1);
INSERT INTO `Roleuser` VALUES (NULL,3,2);


INSERT INTO `Banneduser` VALUES (NULL,1,NOW());
INSERT INTO `Banneduser` VALUES (NULL,2,NOW());
INSERT INTO `Banneduser` VALUES (NULL,3,NOW());


INSERT INTO `Admin` VALUES (NULL,'janice','jane',2);
INSERT INTO `Admin` VALUES (NULL,'lauren','lunderville',5);
INSERT INTO `Admin` VALUES (NULL,'cameron','cambridge',9);


INSERT INTO `Thirdpartyorganization` VALUES (NULL,'GirlsWhoCode',6);
INSERT INTO `Thirdpartyorganization` VALUES (NULL,'SFHacks',7);
INSERT INTO `Thirdpartyorganization` VALUES (NULL,'EndageredSpeciesInternational',8); 


INSERT INTO `Multimediacontent` VALUES (NULL,NULL);
INSERT INTO `Multimediacontent` VALUES (NULL,1);
INSERT INTO `Multimediacontent` VALUES (NULL,2);
INSERT INTO `Multimediacontent` VALUES (NULL,NULL);
INSERT INTO `Multimediacontent` VALUES (NULL,1);
INSERT INTO `Multimediacontent` VALUES (NULL,3);
INSERT INTO `Multimediacontent` VALUES (NULL,NULL);
INSERT INTO `Multimediacontent` VALUES (NULL,2);
INSERT INTO `Multimediacontent` VALUES (NULL,2);
INSERT INTO `Multimediacontent` VALUES (NULL,NULL);
INSERT INTO `Multimediacontent` VALUES (NULL,NULL);
INSERT INTO `Multimediacontent` VALUES (NULL,NULL);
INSERT INTO `Multimediacontent` VALUES (NULL,NULL);
INSERT INTO `Multimediacontent` VALUES (NULL,NULL);
INSERT INTO `Multimediacontent` VALUES (NULL,NULL);
INSERT INTO `Multimediacontent` VALUES (NULL,NULL);



INSERT INTO `Contentreport` VALUES (NULL,NULL,1,1,'Inapproriate image',0);
INSERT INTO `Contentreport` VALUES (NULL,NULL,2,1,'Inapproriate image',0);
INSERT INTO `Contentreport` VALUES (NULL,NULL,3,1,'Inapproriate image',0);
INSERT INTO `Contentreport` VALUES (NULL,NULL,1,2,'Violates Guidelines',0);
INSERT INTO `Contentreport` VALUES (NULL,NULL,2,2,'Hate speech',0);
INSERT INTO `Contentreport` VALUES (NULL,NULL,3,2,'):',0);
INSERT INTO `Contentreport` VALUES (1,NULL,3,3,'Inapproriate image',0);



INSERT INTO `Video` VALUES (NULL,1,'/Users/ethanlunderville/Desktop/Videos/video1',20.44,'cooking');
INSERT INTO `Video` VALUES (NULL,2,'/Users/ethanlunderville/Desktop/Videos/video2',44.99,'cooking');
INSERT INTO `Video` VALUES (NULL,3,'/Users/ethanlunderville/Desktop/Videos/video3',55.77,'cooking');
INSERT INTO `Video` VALUES (NULL,1,'/Users/ethanlunderville/Desktop/Videos/video4',20.66,'gardening');
INSERT INTO `Video` VALUES (NULL,2,'/Users/ethanlunderville/Desktop/Videos/video5',4.8,'gardening');
INSERT INTO `Video` VALUES (NULL,3,'/Users/ethanlunderville/Desktop/Videos/video6',8.77,'gardening');
INSERT INTO `Video` VALUES (NULL,2,'/Users/ethanlunderville/Desktop/Videos/video5',0.10,'memes');
INSERT INTO `Video` VALUES (NULL,3,'/Users/ethanlunderville/Desktop/Videos/video6',0.07,'memes');


INSERT INTO `Mp3` VALUES (NULL,4,'/Users/ethanlunderville/Desktop/Music/mp31',20.55,'techno');
INSERT INTO `Mp3` VALUES (NULL,5,'/Users/ethanlunderville/Desktop/Music/mp32',30.31,'techno');
INSERT INTO `Mp3` VALUES (NULL,6,'/Users/ethanlunderville/Desktop/Music/mp33',20.44,'country');


INSERT INTO `Ebook` VALUES (NULL,7,'/Users/ethanlunderville/Desktop/Music/ebook1');
INSERT INTO `Ebook` VALUES (NULL,8,'/Users/ethanlunderville/Desktop/Music/ebook2');
INSERT INTO `Ebook` VALUES (NULL,9,'/Users/ethanlunderville/Desktop/Music/ebook3');


INSERT INTO `Picture` VALUES (NULL,10,'/Users/ethanlunderville/Desktop/Music/picture1');
INSERT INTO `Picture` VALUES (NULL,11,'/Users/ethanlunderville/Desktop/Music/picture2');
INSERT INTO `Picture` VALUES (NULL,12,'/Users/ethanlunderville/Desktop/Music/picture3');


INSERT INTO `Author` VALUES (NULL,'Jon','Smith');
INSERT INTO `Author` VALUES (NULL,'Jane','Smith');
INSERT INTO `Author` VALUES (NULL,'Joke','Smith');


INSERT INTO `Multimediacontentauthor` VALUES (NULL,1,2);
INSERT INTO `Multimediacontentauthor` VALUES (NULL,2,3);
INSERT INTO `Multimediacontentauthor` VALUES (NULL,3,3);

INSERT INTO `Class` VALUES (NULL,'CSC645','Computer Science');
INSERT INTO `Class` VALUES (NULL,'CSC675','Computer Science');
INSERT INTO `Class` VALUES (NULL,'CSC648','Computer Science');

INSERT INTO `Club` VALUES (NULL,'Computer Science Club');
INSERT INTO `Club` VALUES (NULL,'Electrical engineering club');
INSERT INTO `Club` VALUES (NULL,'Philosophy club');


INSERT INTO `Forum` VALUES (NULL,1,NULL);
INSERT INTO `Forum` VALUES (NULL,2,NULL);
INSERT INTO `Forum` VALUES (NULL,3,NULL);
INSERT INTO `Forum` VALUES (NULL,NULL,2);
INSERT INTO `Forum` VALUES (NULL,NULL,1);
INSERT INTO `Forum` VALUES (NULL,NULL,3);



INSERT INTO `Post` VALUES (NULL,1,1,1,'Something cool', CAST('2023-05-08 12:45:20.123' AS datetime));
INSERT INTO `Post` VALUES (NULL,1,1,1,'I am user one', CAST('2023-05-01 12:45:20.123' AS datetime));
INSERT INTO `Post` VALUES (NULL,2,2,2,'Something else cool', CAST('2028-05-09 12:35:23.123' AS datetime));
INSERT INTO `Post` VALUES (NULL,3,5,3,'Another cool thing', CAST('2037-05-10 12:55:29.123' AS datetime));


INSERT INTO `Comments` VALUES (NULL,1,2,'Woe this is cool');
INSERT INTO `Comments` VALUES (NULL,1,3,'Wow, very cool');
INSERT INTO `Comments` VALUES (NULL,2,2,'This is not cool');


INSERT INTO `Bulletin` VALUES (1);

INSERT INTO `Faculty` VALUES (NULL,'janice','jane','dean');
INSERT INTO `Faculty` VALUES (NULL,'jose','ortiz', 'professor');
INSERT INTO `Faculty` VALUES (NULL,'jon','jakobs','lecturer');


INSERT INTO `Facultyclub` VALUES (NULL,1,2);
INSERT INTO `Facultyclub` VALUES (NULL,2,2);
INSERT INTO `Facultyclub` VALUES (NULL,3,1);
INSERT INTO `Facultyclub` VALUES (NULL,3,3);
INSERT INTO `Facultyclub` VALUES (NULL,3,2);
INSERT INTO `Facultyclub` VALUES (NULL,1,1);

INSERT INTO `Professor` VALUES (1,3,'dddff44444');
INSERT INTO `Professor` VALUES (2,4,'fjthe22222');
INSERT INTO `Professor` VALUES (3,1,'33334k3k32');


INSERT INTO `Professorclass` VALUES (NULL,2,3);
INSERT INTO `Professorclass` VALUES (NULL,3,2);
INSERT INTO `Professorclass` VALUES (NULL,1,1);
INSERT INTO `Professorclass` VALUES (NULL,2,1);
INSERT INTO `Professorclass` VALUES (NULL,3,3);
INSERT INTO `Professorclass` VALUES (NULL,1,2);

INSERT INTO `Student` VALUES (1,2,'123456789');
INSERT INTO `Student` VALUES (2,5,'999999119');
INSERT INTO `Student` VALUES (3,6,'l333fllfo');


INSERT INTO `Studentclass` VALUES (NULL,2,3);
INSERT INTO `Studentclass` VALUES (NULL,3,2);
INSERT INTO `Studentclass` VALUES (NULL,1,1);
INSERT INTO `Studentclass` VALUES (NULL,2,1);
INSERT INTO `Studentclass` VALUES (NULL,3,3);
INSERT INTO `Studentclass` VALUES (NULL,1,2);


INSERT INTO `Facultymanager` VALUES (NULL,2,3);
INSERT INTO `Facultymanager` VALUES (NULL,3,2);
INSERT INTO `Facultymanager` VALUES (NULL,1,1);
INSERT INTO `Facultymanager` VALUES (NULL,2,1);
INSERT INTO `Facultymanager` VALUES (NULL,3,3);
INSERT INTO `Facultymanager` VALUES (NULL,1,2);

INSERT INTO `Paymentmethoduser` VALUES (NULL,2,3);
INSERT INTO `Paymentmethoduser` VALUES (NULL,3,2);
INSERT INTO `Paymentmethoduser` VALUES (NULL,1,1);
INSERT INTO `Paymentmethoduser` VALUES (NULL,2,1);
INSERT INTO `Paymentmethoduser` VALUES (NULL,3,3);
INSERT INTO `Paymentmethoduser` VALUES (NULL,1,2);


INSERT INTO `Event` VALUES (NULL,1,NOW(),'EVENT 1');
INSERT INTO `Event` VALUES (NULL,1,NOW(),'EVENT 2');
INSERT INTO `Event` VALUES (NULL,2,NOW(),'EVENT 3');


INSERT INTO `Permissions` VALUES (NULL,'Allows user to create forums');
INSERT INTO `Permissions` VALUES (NULL,'Gives user access to all Multimediacontent');
INSERT INTO `Permissions` VALUES (NULL,'Grants user complete access to all parts of the db');


INSERT INTO `Userpermissions` VALUES (NULL,2,3);
INSERT INTO `Userpermissions` VALUES (NULL,3,2);
INSERT INTO `Userpermissions` VALUES (NULL,1,1);
INSERT INTO `Userpermissions` VALUES (NULL,2,1);
INSERT INTO `Userpermissions` VALUES (NULL,3,3);
INSERT INTO `Userpermissions` VALUES (NULL,1,2);

DROP TRIGGER IF EXISTS trigger1;

DELIMITER $$
CREATE TRIGGER trigger1
after update on Contentreport
for each row 
BEGIN
  IF (NEW.Admin_idAdmin IS NOT NULL) THEN
     UPDATE `Admin` set reports_reviewed = reports_reviewed + 1 where NEW.Admin_idAdmin = `Admin`.idAdmin;
  END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger2;

DELIMITER $$
CREATE TRIGGER trigger2
after insert on Orders
for each row 
BEGIN
  UPDATE `User` set itemsbought = itemsbought + 1 where NEW.User_idUser = `User`.idUser;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS showposts;

DELIMITER $$
CREATE PROCEDURE showposts ()
BEGIN 
    
     SELECT * FROM Post JOIN Comments ON Post.idPosts = Comments.Posts_idPosts;

END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS deleteclasses;

DELIMITER $$
CREATE PROCEDURE deleteclasses ()
BEGIN 
    DECLARE threshold INT;
    DECLARE x INT;
    SET threshold = (SELECT COUNT(*) FROM Class);
    SET x = 0;
    while_loop: 
       WHILE x < threshold DO 
           DELETE FROM Class WHERE idClass = (x + 1);
           SET x = x + 1;
       END WHILE
    while_loop;
END$$ 

DELIMITER ;

DROP FUNCTION IF EXISTS priceDeterminer;

DELIMITER $$
CREATE FUNCTION priceDeterminer (pricein DECIMAL(20,2))
RETURNS VARCHAR(20) DETERMINISTIC 
    BEGIN 
         DECLARE average DECIMAL(20,2);
         DECLARE leveler VARCHAR(20);
         DECLARE aveg DECIMAL(20,2);

         SET average = (SELECT AVG(price) FROM Product); 
         SET leveler = 'EXPENSIVE';

         IF pricein < average THEN
          SET leveler = 'CHEAP';
         END IF; 

         RETURN leveler;
    END$$
DELIMITER ;

DROP FUNCTION IF EXISTS timePassed;

DELIMITER $$
CREATE FUNCTION timePassed (id INT)
RETURNS TIME DETERMINISTIC 
    BEGIN 

        DECLARE accountDate DATE;
        DECLARE nowdate DATE;
        DECLARE ret TIME;

        SET nowdate = CAST(NOW() AS DATE);
        SET accountDate = (SELECT `date` FROM Account WHERE idAccount = id);
        SET ret = CAST(TIMEDIFF(nowdate, accountDate) AS TIME);
  
        RETURN ret;

    END$$
DELIMITER ;
