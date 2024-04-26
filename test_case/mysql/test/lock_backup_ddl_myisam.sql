
CREATE TABLE t1 (a INT);

CREATE USER 'testuser1'@'localhost';
SET lock_wait_timeout= 1;
SET autocommit= 0;
CREATE TABLE testtable_2 (c1 int, c2 varchar(10)) ENGINE=MyISAM;
CREATE TABLE testtable_2 (c1 int, c2 varchar(10)) ENGINE=MyISAM;
INSERT INTO testtable_2 VALUES(4,'ddd'),(5,'eeeee'),(3,'fffffff');
ALTER TABLE testtable_2 ADD INDEX i2(c2);
DROP TABLE testtable_2;

CREATE TABLE t2 (c1 int);

DROP USER 'testuser1'@'localhost';
DROP TABLE t1, t2;
