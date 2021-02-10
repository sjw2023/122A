-- Create somewhere for our tables to exist!
CREATE DATABASE IF NOT EXISTS cs122a;
USE cs122a;

-- Create the Boats table.
DROP TABLE IF EXISTS Boats;
CREATE TABLE Boats (
  bid INTEGER,
  bname VARCHAR(45),
  color VARCHAR(15),
  PRIMARY KEY (bid)
);

-- Insert data into Boats.
INSERT INTO Boats VALUES (101,'Interlake','blue'),(102,'Interlake','red'),(103,'Clipper','green'),(104,'Marine','red');

-- Create the Boats2 table.
DROP TABLE IF EXISTS Boats2;
CREATE TABLE Boats2 (
  bid INTEGER,
  bname VARCHAR(45),
  color VARCHAR(15),
  PRIMARY KEY (bid)
);

-- Insert data into Boats2.
INSERT INTO Boats2 VALUES (103,'Clipper','green'),(104,'Marine','red'),(105,'InterClipper','blue'),(106,'InterMarine','red');

-- Create the Reserves table.
DROP TABLE IF EXISTS Reserves;
CREATE TABLE Reserves (
  sid INTEGER,
  bid INTEGER,
  `date` date
); 

-- Insert data into Reserves.
INSERT INTO Reserves VALUES (22,101,'1998-10-10'),(22,102,'1998-10-10'),(22,103,'1998-10-08'),(22,104,'1998-10-07'),(31,102,'1998-11-10'),(31,103,'1998-11-06'),(31,104,'1998-11-12'),(64,101,'1998-09-05'),(64,102,'1998-09-08'),(74,103,'1998-09-08'),(NULL,103,'1998-09-09'),(1,NULL,'2001-01-11'),(1,NULL,'2002-02-02');

-- Create the Reserves2 table.
DROP TABLE IF EXISTS Reserves2;
CREATE TABLE Reserves2 (
  sid INTEGER,
  bid INTEGER,
  `date` DATE 
);

-- Insert data into Reserves2.
INSERT INTO Reserves2 VALUES (22,103,'1998-10-10'),(22,104,'1998-10-10'),(22,105,'1998-10-08'),(22,106,'1998-10-07'),(31,103,'1998-11-10'),(31,104,'1998-11-06'),(31,105,'1998-11-12'),(64,104,'1998-09-05'),(64,105,'1998-09-08'),(74,105,'1998-09-08'),(NULL,104,'1998-09-09'),(108,NULL,'2001-01-11'),(108,NULL,'2002-02-02');

-- Create table Sailors.
DROP TABLE IF EXISTS `Sailors`;
CREATE TABLE `Sailors` (
  sid INTEGER,
  sname VARCHAR(45) NOT NULL,
  rating INTEGER,
  age DECIMAL(5,1),
  PRIMARY KEY (sid)
);

-- Insert data into Sailors2.
INSERT INTO Sailors VALUES (22,'Dustin',7,45.0),(29,'Brutus',1,33.0),(31,'Lubber',8,55.5),(32,'Andy',8,25.5),(58,'Rusty',10,35.0),(64,'Horatio',7,35.0),(71,'Zorba',10,16.0),(74,'Horatio',9,35.0),(85,'Art',4,25.5),(95,'Bob',3,63.5),(101,'Joan',3,NULL),(107,'Johannes',NULL,35.0);

-- Create table Sailors2.
DROP TABLE IF EXISTS Sailors2;
CREATE TABLE Sailors2 (
  sid INTEGER,
  sname VARCHAR(45) NOT NULL,
  rating INTEGER,
  age DECIMAL(5,1),
  PRIMARY KEY (sid)
);

-- Insert data into Sailors2.
INSERT INTO Sailors2 VALUES (22,'Dustin',7,45.0),(31,'Lubber',8,55.5),(64,'Horatio',7,35.0),(71,'Zorba',10,16.0),(74,'Horatio',9,35.0),(85,'Art',4,25.5),(95,'Bob',3,63.5),(101,'Joan',3,NULL),(107,'Johannes',NULL,35.0),(108,'Sandy',NULL,36.0),(109,'James',5,38.0);
