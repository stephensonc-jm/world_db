Skip to content
Search or jump to…
Pull requests
Issues
Marketplace
Explore
 
@stephensonc-jm 
datacharmer
/
test_db
Public
Code
Issues
1
Pull requests
Actions
Projects
Wiki
Security
Insights
test_db/employees.sql
@datacharmer
datacharmer Added missing semicolon
Latest commit fca5b77 on Sep 22, 2015
 History
 1 contributor
127 lines (112 sloc)  4.09 KB
   
--  Sample employee database 
--  See changelog table for details
--  Copyright (C) 2007,2008, MySQL AB
--  
--  Original data created by Fusheng Wang and Carlo Zaniolo
--  http://www.cs.aau.dk/TimeCenter/software.htm
--  http://www.cs.aau.dk/TimeCenter/Data/employeeTemporalDataSet.zip
-- 
--  Current schema by Giuseppe Maxia 
--  Data conversion from XML to relational by Patrick Crews
-- 
-- This work is licensed under the 
-- Creative Commons Attribution-Share Alike 3.0 Unported License. 
-- To view a copy of this license, visit 
-- http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to 
-- Creative Commons, 171 Second Street, Suite 300, San Francisco, 
-- California, 94105, USA.
-- 
--  DISCLAIMER
--  To the best of our knowledge, this data is fabricated, and
--  it does not correspond to real people. 
--  Any similarity to existing people is purely coincidental.
-- 

DROP DATABASE IF EXISTS world;
CREATE DATABASE IF NOT EXISTS world;
USE world;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS city,
                     country,
                     countrylanguage;

/*!50503 set default_storage_engine = InnoDB */;
/*!50503 select CONCAT('storage engine: ', @@default_storage_engine) as INFO */;

CREATE TABLE city (
  ID int NOT NULL AUTO_INCREMENT,
  Name char(35) NOT NULL DEFAULT '',
  CountryCode char(3) NOT NULL DEFAULT '',
  District char(20) NOT NULL DEFAULT '',
  Population int NOT NULL DEFAULT '0',
  PRIMARY KEY (ID),
  KEY CountryCode (CountryCode),
  CONSTRAINT city_ibfk_1 FOREIGN KEY (CountryCode) REFERENCES country (Code));

CREATE TABLE country (
  Code char(3) NOT NULL DEFAULT '',
  Name char(52) NOT NULL DEFAULT '',
  Continent enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL DEFAULT 'Asia',
  Region char(26) NOT NULL DEFAULT '',
  SurfaceArea decimal(10,2) NOT NULL DEFAULT '0.00',
  IndepYear smallint DEFAULT NULL,
  Population int NOT NULL DEFAULT '0',
  LifeExpectancy decimal(3,1) DEFAULT NULL,
  GNP decimal(10,2) DEFAULT NULL,
  GNPOld decimal(10,2) DEFAULT NULL,
  LocalName char(45) NOT NULL DEFAULT '',
  GovernmentForm char(45) NOT NULL DEFAULT '',
  HeadOfState char(60) DEFAULT NULL,
  Capital int DEFAULT NULL,
  Code2 char(2) NOT NULL DEFAULT '',
  PRIMARY KEY (Code)
);

CREATE TABLE countrylanguage (
  CountryCode char(3) NOT NULL DEFAULT '',
  Language char(30) NOT NULL DEFAULT '',
  IsOfficial enum('T','F') NOT NULL DEFAULT 'F',
  Percentage decimal(4,1) NOT NULL DEFAULT '0.0',
  PRIMARY KEY (CountryCode,Language),
  KEY CountryCode (CountryCode),
  CONSTRAINT countryLanguage_ibfk_1 FOREIGN KEY (CountryCode) REFERENCES country (Code)
) 

flush /*!50503 binary */ logs;

SELECT 'LOADING city' as 'INFO';
source load_city.dump ;
SELECT 'LOADING country' as 'INFO';
source load_country.dump ;
SELECT 'LOADING countrylanguage' as 'INFO';
source load_countrylanguage.dump ;


source show_elapsed.sql ;
© 2022 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
Loading complete