
CREATE DATABASE XY;
USE XY;

--
-- Logs are disabled, since the number of creates tables
-- and subsequent select statements may vary between
-- versions
--
--disable_query_log
--disable_result_log

let $tcs = `SELECT @@table_open_cache + 1`;

let $i = $tcs;
{
  eval CREATE TABLE XY.T_$i (a INT NOT NULL, b INT NOT NULL, c INT NOT NULL, d INT,
                             primary key(a, b), unique(b)) ENGINE=InnoDB;
  dec $i;
                           ADD CONSTRAINT C1 FOREIGN KEY (c, b) REFERENCES XY.T_1 (a, b);
                           ADD CONSTRAINT C2 FOREIGN KEY (b) REFERENCES XY.T_1(a);

let $i = $tcs;
{
  eval SELECT * FROM XY.T_$i LIMIT 1;
  dec $i;

DROP DATABASE XY;
CREATE DATABASE XY;
USE XY;
                             PRIMARY KEY(a, b), UNIQUE(b)) ENGINE=InnoDB;
DROP DATABASE XY;
USE TEST;
DROP TABLE IF EXISTS `Table2`;
DROP TABLE IF EXISTS `Table1`;

CREATE TABLE `Table1`(c1 INT PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE `Table2`(c1 INT PRIMARY KEY, c2 INT) ENGINE=InnoDB;
ALTER TABLE `Table2` ADD CONSTRAINT fk1 FOREIGN KEY(c2) REFERENCES `Table1`(c1);
DROP TABLE `Table2`;
DROP TABLE `Table1`;
DROP TABLE IF EXISTS Product_Order;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;

CREATE TABLE Product (Category INT NOT NULL, Id INT NOT NULL,
	Price DECIMAL, PRIMARY KEY(Category, Id)) ENGINE=InnoDB;
CREATE TABLE Customer (Id INT NOT NULL, PRIMARY KEY (Id)) ENGINE=InnoDB;
CREATE TABLE Product_Order (No INT NOT NULL AUTO_INCREMENT,
	Product_Category INT NOT NULL,
	Product_Id INT NOT NULL,
	Customer_Id INT NOT NULL,
	PRIMARY KEY(No),
	INDEX (Product_Category, Product_Id),
	FOREIGN KEY (Product_Category, Product_Id)
		REFERENCES Product(Category, Id) ON UPDATE CASCADE ON DELETE RESTRICT,
	INDEX (Customer_Id),
	FOREIGN KEY (Customer_Id)
		REFERENCES Customer(Id)
	) ENGINE=INNODB;
DROP TABLE Product_Order;
DROP TABLE Product;
DROP TABLE Customer;

CREATE DATABASE my_db;
USE my_db;
CREATE TABLE UPPERCASE_MYISAM (a INT) ENGINE=MYISAM;
CREATE TABLE lowercase_myisam (a INT) ENGINE=MYISAM;
CREATE TABLE UPPERCASE_INNODB (a INT) ENGINE=InnoDB;
CREATE TABLE lowercase_innodb (a INT) ENGINE=InnoDB;

-- Create a new user and assign SELECT privileges on the above tables.
CREATE USER 'test_user'@'localhost';

-- Connect using the new user
--connect(con1, localhost, test_user,,)

USE my_db;
DROP USER 'test_user'@'localhost';
DROP DATABASE my_db;
USE test;
