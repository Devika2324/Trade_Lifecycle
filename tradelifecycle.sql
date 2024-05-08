-- MySQL dump 10.13  Distrib 5.7.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tradelifecycle
-- ------------------------------------------------------
-- Server version	5.7.44-log

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
-- Table structure for table `audit`
--

DROP TABLE IF EXISTS `audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit` (
  `AuditID` int(11) NOT NULL AUTO_INCREMENT,
  `TradeID` int(11) DEFAULT NULL,
  `Activity` varchar(100) DEFAULT NULL,
  `ActivityTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`AuditID`),
  KEY `TradeID` (`TradeID`),
  CONSTRAINT `audit_ibfk_1` FOREIGN KEY (`TradeID`) REFERENCES `trades` (`TradeID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit`
--

LOCK TABLES `audit` WRITE;
/*!40000 ALTER TABLE `audit` DISABLE KEYS */;
INSERT INTO `audit` VALUES (1,1,'Trade created','2018-08-01 08:00:00'),(2,1,'Trade confirmed','2018-08-01 08:00:10'),(3,1,'Trade modified','2018-08-02 07:00:00'),(4,1,'Trade settled','2023-09-11 08:00:00'),(5,2,'Trade created','2018-08-14 08:15:00'),(6,2,'Trade confirmed','2018-08-14 08:16:00'),(7,3,'Trade created','2023-09-12 07:30:00'),(8,3,'Trade confirmed','2023-09-12 07:32:00'),(9,4,'Trade created','2023-05-17 09:45:00'),(10,4,'Trade confirmed','2023-05-17 09:47:00'),(11,4,'Trade modified','2023-05-19 11:00:00'),(12,5,'Trade created','2023-12-12 12:15:00'),(13,5,'Trade confirmed','2023-12-12 12:16:30'),(14,5,'Trade modified','2024-01-26 13:45:00'),(15,5,'Trade settled','2024-01-30 14:00:00'),(16,6,'Trade created','2023-06-20 13:15:00'),(17,6,'Trade confirmed','2023-06-20 13:18:10'),(18,7,'Trade created','2023-10-23 14:45:00'),(19,7,'Trade confirmed','2023-10-23 14:46:55'),(20,8,'Trade created','2024-01-17 17:00:00'),(21,8,'Trade confirmed','2024-01-17 17:01:05'),(22,9,'Trade created','2023-08-23 16:00:16'),(23,9,'Trade confirmed','2023-08-23 16:02:00'),(24,10,'Trade created','2024-02-07 10:00:00');
/*!40000 ALTER TABLE `audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counterparties`
--

DROP TABLE IF EXISTS `counterparties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counterparties` (
  `TradeID` int(11) NOT NULL,
  `CounterpartyID` int(11) NOT NULL,
  `CounterpartyName` varchar(100) NOT NULL,
  `ExposureLimit` decimal(50,2) DEFAULT NULL,
  PRIMARY KEY (`TradeID`,`CounterpartyID`),
  CONSTRAINT `counterparties_ibfk_1` FOREIGN KEY (`TradeID`) REFERENCES `trades` (`TradeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counterparties`
--

LOCK TABLES `counterparties` WRITE;
/*!40000 ALTER TABLE `counterparties` DISABLE KEYS */;
INSERT INTO `counterparties` VALUES (1,182,'Counterparty A',8000000.00),(2,109,'Counterparty B',14000000.00),(3,2,'Counterparty C',5000000.00),(4,5,'Counterparty D',11000000.00),(5,7,'Counterparty E',9000000.00),(6,206,'Counterparty F',22000000.00),(7,8,'Counterparty G',18000000.00),(8,16,'Counterparty H',8500000.00),(9,109,'Counterparty I',14000000.00),(10,12,'Counterparty J',9800000.00);
/*!40000 ALTER TABLE `counterparties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instrument`
--

DROP TABLE IF EXISTS `instrument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instrument` (
  `InstrumentID` int(11) NOT NULL,
  `InstrumentLabel` varchar(100) DEFAULT NULL,
  `TradeID` int(11) DEFAULT NULL,
  `MaturityDate` date DEFAULT NULL,
  `SettlementType` varchar(50) DEFAULT NULL,
  `Currency` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`InstrumentID`),
  KEY `TradeID` (`TradeID`),
  CONSTRAINT `instrument_ibfk_1` FOREIGN KEY (`TradeID`) REFERENCES `trades` (`TradeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instrument`
--

LOCK TABLES `instrument` WRITE;
/*!40000 ALTER TABLE `instrument` DISABLE KEYS */;
INSERT INTO `instrument` VALUES (2,'SWAADY 1.RT',9,'2024-08-23','Cash','SGD'),(4,'AAPL UN',10,NULL,'Cash','USD'),(8,'2439 HK',7,NULL,'Cash','HKD'),(9,'Copper',8,'2024-01-19','Physical Delivery','SGD'),(10,'3867 KL',5,NULL,'Cash','MYR'),(13,'SWAADY 10.RT',2,'2028-08-14','Cash','SGD'),(15,'Gold',3,'2023-09-14','Physical Delivery','HKD'),(92,'DBS SP',1,NULL,'Cash','SGD'),(105,'Silver',4,'2023-05-19','Physical Delivery','SGD'),(106,'SWAADY 2.RT',6,'2025-06-20','Cash','SGD');
/*!40000 ALTER TABLE `instrument` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `tradedetails`
--

DROP TABLE IF EXISTS `tradedetails`;
/*!50001 DROP VIEW IF EXISTS `tradedetails`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `tradedetails` AS SELECT 
 1 AS `TradeID`,
 1 AS `Portfolio`,
 1 AS `TradeDate`,
 1 AS `Quantity`,
 1 AS `Price`,
 1 AS `Typology`,
 1 AS `Notional`,
 1 AS `InstrumentLabel`,
 1 AS `MaturityDate`,
 1 AS `Currency`,
 1 AS `CounterpartyName`,
 1 AS `TraderName`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `trader`
--

DROP TABLE IF EXISTS `trader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trader` (
  `TraderID` int(11) NOT NULL,
  `TraderName` varchar(50) NOT NULL,
  `TraderEmail` varchar(100) DEFAULT NULL,
  `TradeID` int(11) DEFAULT NULL,
  PRIMARY KEY (`TraderID`),
  KEY `TradeID` (`TradeID`),
  CONSTRAINT `trader_ibfk_1` FOREIGN KEY (`TradeID`) REFERENCES `trades` (`TradeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trader`
--

LOCK TABLES `trader` WRITE;
/*!40000 ALTER TABLE `trader` DISABLE KEYS */;
INSERT INTO `trader` VALUES (6,'Robert Walter','walter.robert@xyzgroup.com',2),(8,'Charles Van','van.charles@xyzgroup.com',3),(10,'Dominic Lee','lee.dominic@xyzgroup.com',5),(11,'Kelvin Lee','lee.kelvin@xyzgroup.com',1),(14,'Omar Khan','khan.omar@xyzgroup.com',10),(15,'Noel Tan','tan.noel@xyzgroup.com',7),(26,'Yuan Kim','kim.yuan@xyzgroup.com',8),(29,'Anika Gupta','gupta.anika@xyzgroup.com',9),(35,'Derek Peters','peters.derek@xyzgroup.com',4),(36,'Fiona Lim','lim.fiona@xyzgroup.com',6);
/*!40000 ALTER TABLE `trader` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trades`
--

DROP TABLE IF EXISTS `trades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trades` (
  `TradeID` int(11) NOT NULL,
  `Portfolio` varchar(50) DEFAULT NULL,
  `TradeDate` date DEFAULT NULL,
  `InstrumentID` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Typology` varchar(20) DEFAULT NULL,
  `CounterpartyID` int(11) DEFAULT NULL,
  `TraderID` int(11) DEFAULT NULL,
  `Notional` decimal(20,2) DEFAULT NULL,
  `FixedRate` decimal(10,2) DEFAULT NULL,
  `FloatRateIndex` varchar(50) DEFAULT NULL,
  `Spread` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`TradeID`),
  KEY `fk_instrument` (`InstrumentID`),
  KEY `fk_trader` (`TraderID`),
  CONSTRAINT `fk_instrument` FOREIGN KEY (`InstrumentID`) REFERENCES `instrument` (`InstrumentID`),
  CONSTRAINT `fk_trader` FOREIGN KEY (`TraderID`) REFERENCES `trader` (`TraderID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trades`
--

LOCK TABLES `trades` WRITE;
/*!40000 ALTER TABLE `trades` DISABLE KEYS */;
INSERT INTO `trades` VALUES (1,'SGBEQ_EQTP6','2018-07-25',92,1000,180.50,'Equity',182,11,NULL,NULL,NULL,NULL),(2,'SGBMM_IRP21','2018-08-14',13,1,NULL,'Interest Rate Swap',109,6,1000000.00,1.75,'USD LIBOR 6M',0.25),(3,'HKTCM_COMP2','2023-09-12',15,100,1800.00,'Commodity Spot',2,8,NULL,NULL,NULL,NULL),(4,'SGBCM_COMP7','2023-05-17',105,10,1500.00,'Commodity Spot',5,35,NULL,NULL,NULL,NULL),(5,'MYBEQ_EQTP4','2023-12-12',10,10000,26.22,'Equity',7,10,NULL,NULL,NULL,NULL),(6,'SGBMM_IRP14','2023-06-20',106,1,NULL,'Interest Rate Swap',206,36,10000000.00,2.75,'LIBOR',0.05),(7,'HKTEQ_EQTP12','2023-10-25',8,3000,0.45,'Equity',8,15,NULL,NULL,NULL,NULL),(8,'SGTCM_COMP2','2024-01-17',9,1400,2.75,'Commodity Spot',16,26,NULL,NULL,NULL,NULL),(9,'SGTMM_IRP11','2023-08-23',2,1,NULL,'Interest Rate Swap',109,29,1000000.00,1.75,'USD LIBOR 3M',0.25),(10,'SGBEQ_EQTP4','2024-02-07',4,6000,188.85,'Equity',12,14,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `trades` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER CheckExposureLimit
BEFORE INSERT ON trades
FOR EACH ROW
BEGIN
  DECLARE new_exposure DECIMAL(50,2);
  DECLARE limit_exposure DECIMAL(50,2);
  SET new_exposure = TotalCounterpartyExposure(NEW.CounterpartyID);
  SELECT ExposureLimit INTO limit_exposure
  FROM counterparties
  WHERE CounterpartyID = NEW.CounterpartyID;
IF new_exposure > limit_exposure THEN SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Counterparty exposure exceeds the limit';
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tradestatus`
--

DROP TABLE IF EXISTS `tradestatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tradestatus` (
  `TradeID` int(11) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `StatusName` varchar(50) NOT NULL,
  PRIMARY KEY (`TradeID`,`StatusID`),
  CONSTRAINT `tradestatus_ibfk_1` FOREIGN KEY (`TradeID`) REFERENCES `trades` (`TradeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tradestatus`
--

LOCK TABLES `tradestatus` WRITE;
/*!40000 ALTER TABLE `tradestatus` DISABLE KEYS */;
INSERT INTO `tradestatus` VALUES (1,3,'Settled'),(2,2,'Confirmed'),(3,2,'Confirmed'),(4,2,'Confirmed'),(5,3,'Settled'),(6,2,'Confirmed'),(7,2,'Confirmed'),(8,2,'Confirmed'),(9,2,'Confirmed'),(10,1,'Pending');
/*!40000 ALTER TABLE `tradestatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `tradedetails`
--

/*!50001 DROP VIEW IF EXISTS `tradedetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tradedetails` AS select `t`.`TradeID` AS `TradeID`,`t`.`Portfolio` AS `Portfolio`,`t`.`TradeDate` AS `TradeDate`,`t`.`Quantity` AS `Quantity`,`t`.`Price` AS `Price`,`t`.`Typology` AS `Typology`,`t`.`Notional` AS `Notional`,`i`.`InstrumentLabel` AS `InstrumentLabel`,`i`.`MaturityDate` AS `MaturityDate`,`i`.`Currency` AS `Currency`,`c`.`CounterpartyName` AS `CounterpartyName`,`tr`.`TraderName` AS `TraderName` from (((`trades` `t` join `counterparties` `c` on((`t`.`CounterpartyID` = `c`.`CounterpartyID`))) join `instrument` `i` on((`t`.`InstrumentID` = `i`.`InstrumentID`))) join `trader` `tr` on((`t`.`TraderID` = `tr`.`TraderID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-14  0:32:00
