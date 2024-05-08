/*Project: Trade lifecycle management system in a bank
The trade lifecycle relational database will help to manage the lifecycle of trades from execution to settlement. 
It will capture the trade details and track the status of trades in a bank’s trading system */

-- CORE REQUIREMENTS--------------------------
CREATE DATABASE TradeLifecycle;
USE TradeLifecycle;

-- Table 1:Trades table with trade details
-- Where Price is not applicable there is a Notional amount in the Notional column
CREATE TABLE trades(
TradeID INT,
Portfolio VARCHAR(50),
TradeDate DATE,
InstrumentID INT,
Quantity INT,
Price DECIMAL(10,2),
Typology VARCHAR(20),
CounterpartyID INT,
TraderID INT,
Notional DECIMAL(20,2),
FixedRate DECIMAL(10,2),
FloatRateIndex VARCHAR(50),
Spread DECIMAL(10,2),
PRIMARY KEY(TradeID));

INSERT INTO trades(TradeID,Portfolio,TradeDate,InstrumentID,Quantity,Price,Typology,CounterpartyID,TraderID,Notional,FixedRate,FloatRateIndex,Spread)
VALUES
(1,'SGBEQ_EQTP6','2018-07-25',92,1000,180.50,'Equity', 182, 11, NULL, NULL, NULL, NULL),
(2,'SGBMM_IRP21','2018-08-14',13,1,NULL,'Interest Rate Swap', 109, 6, 1000000, 1.75, 'USD LIBOR 6M', 0.25),
(3,'HKTCM_COMP2','2023-09-12', 15,100,1800,'Commodity Spot', 2, 8,NULL, NULL, NULL, NULL),
(4,'SGBCM_COMP7','2023-05-17', 105, 10, 1500,'Commodity Spot',5, 35, NULL, NULL, NULL, NULL),
(5,'MYBEQ_EQTP4','2023-12-12',10,10000,26.22,'Equity',7,10,NULL, NULL, NULL, NULL),
(6,'SGBMM_IRP14', '2023-06-20', 106,1, NULL, 'Interest Rate Swap', 206, 36, 10000000, 2.75, 'LIBOR', 0.05),
(7,'HKTEQ_EQTP12','2023-10-25',8,3000,0.45,'Equity',8,15,NULL, NULL, NULL, NULL),
(8,'SGTCM_COMP2', '2024-01-17',9,1400,2.75, 'Commodity Spot', 16, 26, NULL, NULL, NULL, NULL),
(9,'SGTMM_IRP11', '2023-08-23', 2, 1, NULL, 'Interest Rate Swap', 109, 29, 1000000, 1.75, 'USD LIBOR 3M', 0.25),
(10,'SGBEQ_EQTP4','2024-02-07',4,6000,188.85,'Equity',12,14,NULL, NULL, NULL, NULL);

SELECT * FROM trades;

-- Table 2:Instrument table with the underlying financial instrument details
CREATE TABLE instrument(
InstrumentID INT,
InstrumentLabel VARCHAR(100),
TradeID INT,
MaturityDate DATE,
SettlementType VARCHAR(50),
Currency VARCHAR(3),
PRIMARY KEY (InstrumentID),
FOREIGN KEY (TradeID) REFERENCES Trades (TradeID));

INSERT INTO instrument(InstrumentID,InstrumentLabel,TradeID,MaturityDate,SettlementType,Currency)
VALUES 
(92,'DBS SP',1,NULL,'Cash','SGD'),
(13,'SWAADY 10.RT',2,'2028-08-14','Cash','SGD'),
(15,'Gold',3,'2023-09-14','Physical Delivery','HKD'),
(105,'Silver',4,'2023-05-19','Physical Delivery','SGD'),
(10,'3867 KL',5,NULL,'Cash','MYR'),
(106,'SWAADY 2.RT',6,'2025-06-20','Cash','SGD'),
(8,'2439 HK',7,NULL,'Cash','HKD'),
(9,'Copper',8,'2024-01-19','Physical Delivery','SGD'),
(2,'SWAADY 1.RT',9,'2024-08-23','Cash','SGD'),
(4,'AAPL UN',10,NULL,'Cash','USD');

SELECT * FROM instrument;

-- Table 3:Trade status table displaying whether the trade is pending, already confirmed or settled.
CREATE TABLE tradestatus(
TradeID INT,
StatusID INT,
StatusName VARCHAR(50) NOT NULL,
PRIMARY KEY(TradeID,StatusID),
FOREIGN KEY(TradeID) REFERENCES Trades(TradeID));

INSERT INTO tradestatus(TradeID,StatusID,StatusName)
VALUES 
(1,3,'Settled'),  
(2,2,'Confirmed'),  
(3,2,'Confirmed'),  	
(4,2,'Confirmed'),  
(5,3,'Settled'),  
(6,2,'Confirmed'),  
(7,2,'Confirmed'),  
(8,2,'Confirmed'),  
(9,2,'Confirmed'),  
(10,1,'Pending');

SELECT * FROM tradestatus;

-- Table 4:Trader table with details of the trader who booked the trade in the system
CREATE TABLE trader(
TraderID INT,
TraderName VARCHAR(50) NOT NULL,
TraderEmail VARCHAR(100),
TradeID INT,
PRIMARY KEY(TraderID),
FOREIGN KEY(TradeID) REFERENCES Trades(TradeID));
    
INSERT INTO trader(TraderID, TraderName, TraderEmail,TradeID)
VALUES 
(11,'Kelvin Lee','lee.kelvin@xyzgroup.com',1),  
(6, 'Robert Walter', 'walter.robert@xyzgroup.com',2), 
(8, 'Charles Van', 'van.charles@xyzgroup.com',3), 
(35, 'Derek Peters', 'peters.derek@xyzgroup.com',4),
(10, 'Dominic Lee', 'lee.dominic@xyzgroup.com',5),  
(36, 'Fiona Lim', 'lim.fiona@xyzgroup.com' ,6), 
(15, 'Noel Tan', 'tan.noel@xyzgroup.com', 7), 
(26, 'Yuan Kim', 'kim.yuan@xyzgroup.com',8),  
(29, 'Anika Gupta','gupta.anika@xyzgroup.com',9), 
(14, 'Omar Khan','khan.omar@xyzgroup.com',10);

SELECT * FROM trader;

-- Table 5:Counterparties table with details of the bank counterparties to the trades
CREATE TABLE counterparties(
TradeID INT,
CounterpartyID INT,
CounterpartyName VARCHAR(100) NOT NULL,
ExposureLimit DECIMAL(50,2),
PRIMARY KEY(TradeID,CounterpartyID),
FOREIGN KEY (TradeID) REFERENCES Trades (TradeID));

INSERT INTO counterparties(TradeID,CounterpartyID,CounterpartyName,ExposureLimit)
VALUES 
(1,182, 'Counterparty A',8000000),  
(2,109, 'Counterparty B',14000000),  
(3,2, 'Counterparty C',5000000),  
(4,5, 'Counterparty D',11000000), 
(5,7, 'Counterparty E',9000000),  
(6,206, 'Counterparty F',22000000),  
(7,8, 'Counterparty G',18000000), 
(8,16, 'Counterparty H',8500000),  
(9,109, 'Counterparty I',14000000), 
(10,12, 'Counterparty J',9800000);

SELECT * FROM counterparties;

-- Table 6:Audit table with details of the activities that were performed for a trade and when they were performed
CREATE TABLE audit(
AuditID INT NOT NULL AUTO_INCREMENT,
TradeID INT,
Activity VARCHAR(100),
ActivityTimestamp TIMESTAMP,
PRIMARY KEY(AuditID),
FOREIGN KEY (TradeID) REFERENCES Trades (TradeID));

INSERT INTO audit(AuditID, TradeID, Activity, ActivityTimestamp)
VALUES 
(1, 1, 'Trade created', '2018-08-01 10:00:00'),
(2, 1, 'Trade confirmed', '2018-08-01 10:00:10'),
(3, 1, 'Trade modified', '2018-08-02 09:00:00'),
(4, 1, 'Trade settled', '2023-09-11 10:00:00'),
(5, 2, 'Trade created', '2018-08-14 10:15:00'),
(6, 2, 'Trade confirmed', '2018-08-14 10:16:00'),
(7, 3, 'Trade created', '2023-09-12 09:30:00'),
(8, 3, 'Trade confirmed', '2023-09-12 09:32:00'),
(9, 4, 'Trade created', '2023-05-17 11:45:00'),
(10, 4, 'Trade confirmed', '2023-05-17 11:47:00'),
(11, 4, 'Trade modified', '2023-05-19 13:00:00'),
(12, 5, 'Trade created', '2023-12-12 13:15:00'),
(13, 5, 'Trade confirmed', '2023-12-12 13:16:30'),
(14, 5, 'Trade modified', '2024-01-26 14:45:00'),
(15, 5, 'Trade settled', '2024-01-30 15:00:00'),
(16, 6, 'Trade created', '2023-06-20 15:15:00'),
(17, 6, 'Trade confirmed', '2023-06-20 15:18:10'),
(18, 7, 'Trade created', '2023-10-23 16:45:00'),
(19, 7, 'Trade confirmed', '2023-10-23 16:46:55'),
(20, 8, 'Trade created', '2024-01-17 18:00:00'),
(21, 8, 'Trade confirmed', '2024-01-17 18:01:05'),
(22, 9, 'Trade created', '2023-08-23 18:00:16'),
(23, 9, 'Trade confirmed', '2023-08-23 18:02:00'),
(24, 10, 'Trade created', '2024-02-07 11:00:00');

SELECT * FROM audit;

ALTER TABLE trades 
ADD CONSTRAINT fk_instrument FOREIGN KEY(InstrumentID) REFERENCES instrument(InstrumentID),
ADD CONSTRAINT fk_trader FOREIGN KEY(TraderID) REFERENCES trader(TraderID);

-- Using any type of the joins create a view that combines multiple tables in a logical way----------
-- Joining tables Trades, Instrument and Counterparties to provide an overview with all important trade details
CREATE VIEW TradeDetails AS
SELECT 
    t.TradeID,
    t.Portfolio,
    t.TradeDate,
    t.Quantity,
    t.Price,
    t.Typology,
    t.Notional,
    i.InstrumentLabel,
    i.MaturityDate,
    i.Currency,
    c.CounterpartyName,
    tr.TraderName
FROM trades t
INNER JOIN counterparties c ON t.CounterpartyID = c.CounterpartyID
INNER JOIN instrument i ON t.InstrumentID = i.InstrumentID
INNER JOIN trader tr ON t.traderID = tr.traderID;

-- Create a stored function that can be applied to a query in your DB-------------
-- Stored function that calculates the total exposure to a counterparty
DELIMITER //
CREATE FUNCTION TotalCounterpartyExposure(CounterpartyID INT)
RETURNS DECIMAL(50,2)
DETERMINISTIC
BEGIN
  DECLARE TotalExposure DECIMAL(50,2);
  SELECT SUM(IF(t.Price IS NULL,t.Notional,(t.Price * t.Quantity))) INTO TotalExposure
  FROM Trades t
  WHERE t.CounterpartyID = CounterpartyID
  GROUP BY t.CounterpartyID;
RETURN TotalExposure;
END //
DELIMITER ;
-- ----------------------------
-- ---- Query that provides the counterparty and corresponding exposure---------------
SELECT t.CounterpartyID, 
       c.CounterpartyName,
       TotalCounterpartyExposure(t.CounterpartyID) AS 'ExposureByCounterparty'
FROM trades t
INNER JOIN counterparties c ON t.CounterpartyID = c.CounterpartyID;

-- Example query with a subquery to demonstrate how to extract data from DB for analysis 
SELECT * FROM trades t
JOIN (
SELECT i.InstrumentID,i.InstrumentLabel,i.TradeID,i.MaturityDate,i.Currency 
FROM instrument i
WHERE i.MaturityDate BETWEEN '2023-01-01' AND '2023-12-31'
AND i.TradeID IN (SELECT t.TradeID FROM trades t WHERE t.Typology = 'Commodity Spot')
) AS COM
ON t.TradeID = COM.TradeID;

-- ADVANCED REQUIREMENTS-------------------------
-- Create a stored procedure------
DELIMITER //
CREATE PROCEDURE GetTradeInfo(TradeID INT)
BEGIN
SELECT * FROM TradeDetails
WHERE TradeDetails.TradeID = TradeID;
END //
DELIMITER ;

CALL GetTradeInfo(10);

-- Create a trigger------------
 -- Calculate the total exposure for the counterparty after the new trade is inserted
 -- Trigger applied when Counterparty exposure limit is breached
DELIMITER //
CREATE TRIGGER CheckExposureLimit
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
END //
DELIMITER ;

-- Query to test the trigger----
INSERT INTO trades(TradeID,Portfolio,TradeDate,InstrumentID,Quantity,Price,Typology,CounterpartyID,TraderID,Notional,FixedRate,FloatRateIndex,Spread)
VALUES
(12,'SGBCM_COMP1','2024-01-31',3,900000000,522.50,'Commodity', 182, 11, NULL, NULL, NULL, NULL);

-- Create an event------------ 
-- Turn ON Event Scheduler 
SET GLOBAL event_scheduler = ON;
-- Purge trades older than the date 5 years ago
DELIMITER //
CREATE EVENT PurgeTrades
ON SCHEDULE EVERY 3 MONTH
DO BEGIN
DELETE t FROM trades t
INNER JOIN instrument i ON t.InstrumentID =i.InstrumentID 
WHERE i.MaturityDate < NOW() - INTERVAL 5 YEAR;
END //
DELIMITER ; 



