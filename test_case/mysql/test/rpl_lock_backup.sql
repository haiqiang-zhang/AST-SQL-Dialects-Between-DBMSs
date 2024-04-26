
CREATE TABLE t1 (a INT);

CREATE USER 'testuser1'@'localhost';
SET lock_wait_timeout= 1;
SET autocommit= 0;
CREATE DATABASE testdb;
CREATE TABLESPACE testtablespace ADD DATAFILE 'ts.ibd' ENGINE=InnoDB;
CREATE TABLE testtable_1 (c1 int, c2 varchar(10));
CREATE TEMPORARY TABLE temptable_1 (tt1 int);
INSERT INTO temptable_1 SELECT * FROM t1;
SELECT * FROM temptable_1;
CREATE DATABASE testdb;
CREATE TABLESPACE testtablespace ADD DATAFILE 'ts.ibd' ENGINE=InnoDB;
CREATE TABLE testtable_1 (c1 int, c2 varchar(10)) TABLESPACE testtablespace;
INSERT INTO testtable_1 VALUES(1,'aaa'),(2,'bbbbbb'),(3,'cccccccc');
INSERT INTO testtable_1 VALUES(4,'ddd'),(5,'eeeee'),(3,'fffffff');
UPDATE testtable_1 SET c1=11, c2='yyy' WHERE c1=1;
DELETE FROM testtable_1 WHERE c2 LIKE "aa";
ALTER DATABASE testdb CHARACTER SET 'latin1';
ALTER TABLE testtable_1 ADD INDEX i2(c2);
DROP DATABASE testdb;
DROP TABLE testtable_1;
DROP TABLESPACE testtablespace;

DROP USER 'testuser1'@'localhost';
DROP TABLE t1;
