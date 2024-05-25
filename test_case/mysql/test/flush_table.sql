lock table t1 read;
unlock tables;
lock table t1 write;
unlock tables;
lock table t1 write;
select * from t1;
unlock tables;
unlock tables;
lock table t1 write;
select * from t1;
unlock tables;
unlock tables;
select * from t1;
drop table t1;
create table t1(table_id char(20) primary key);
create table t2(table_id char(20) primary key);
insert into t1 values ('test.t1');
insert into t1 values ('');
insert into t2 values ('test.t2');
insert into t2 values ('');
drop table t1;
drop table t2;
create table t1(table_id char(20) primary key);
insert into t1 values ('Record-01');
insert into t1 values ('Record-02');
insert into t1 values ('Record-03');
insert into t1 values ('Record-04');
insert into t1 values ('Record-05');
drop table t1;
UNLOCK TABLES;
CREATE PROCEDURE p1(export INT) BEGIN END;
DROP PROCEDURE p1;
CREATE PROCEDURE export() BEGIN END;
DROP PROCEDURE export;
CREATE TABLE t1 (i INT) engine=InnoDB;
CREATE TABLE t2 LIKE t1;
UNLOCK TABLES;
UNLOCK TABLES;
UNLOCK TABLES;
UNLOCK TABLES;
DROP TABLES t1, t2;
CREATE TABLE export (i INT) engine=InnoDB;
UNLOCK TABLES;
DROP TABLE export;
CREATE VIEW v1 AS SELECT 1;
CREATE TEMPORARY TABLE t1 (a INT);
DROP TEMPORARY TABLE t1;
DROP VIEW v1;
CREATE TABLE t1 (a INT PRIMARY KEY, b INT) engine= InnoDB;
CREATE TABLE t2 (a INT) engine= InnoDB;
INSERT INTO t1 VALUES (1, 1);
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "FLUSH TABLES t1 FOR EXPORT";
INSERT INTO t2 VALUES (1);
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "INSERT INTO t1 VALUES (2, 2)";
UNLOCK TABLES;
SELECT * FROM t1;
SELECT * FROM t1;
UNLOCK TABLES;
SELECT * FROM t1;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "ALTER TABLE t1 ADD INDEX i1(b)";
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "FLUSH TABLE t1 FOR EXPORT";
UNLOCK TABLES;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "DROP TABLE t1";
UNLOCK TABLES;
DROP TABLE t2;
UNLOCK TABLES;
UNLOCK TABLES;
DROP TABLE t1;
UNLOCK TABLES;
DROP TABLE db1.t1;
DROP DATABASE db1;
CREATE TABLE t1 (a INT) engine= InnoDB;
CREATE TABLE t2 (a INT) engine= InnoDB;
UNLOCK TABLES;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "FLUSH TABLE t1 FOR EXPORT";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLE t1 READ;
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLE t1 READ;
UNLOCK TABLES;
UNLOCK TABLES;
DROP TABLE t1, t2;
CREATE TABLE t1 ( i INT ) ENGINE = Innodb;
UNLOCK TABLES;
DROP TABLE t1;
CREATE TABLE t1 ( i INT ) ENGINE = Innodb;
INSERT INTO t1 VALUES (100),(200);
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "FLUSH LOCAL TABLES t1 FOR EXPORT";
UNLOCK TABLE;
SELECT * FROM t1 ORDER BY i;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "FLUSH NO_WRITE_TO_BINLOG TABLES test.t1 FOR EXPORT";
UNLOCK TABLES;
SELECT * FROM t1 ORDER BY i;
UNLOCK TABLE;
DROP TABLE t1;
CREATE TABLE t1 ( i INT ) ENGINE = Innodb;
INSERT INTO t1 VALUES (100),(200);
INSERT INTO t1 VALUES (300);
SELECT * FROM t1 ORDER BY i;
INSERT INTO t1 VALUES (400);
SELECT * FROM t1 ORDER BY i;
UNLOCK TABLES;
DROP TABLE t1;
CREATE TABLE t1 ( i INT ) ENGINE = Innodb;
UNLOCK TABLES;
DROP TABLE t1;
