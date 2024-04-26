
-- Skipping the test when binlog format is mix/statement due to Bug#22173401
--source include/have_binlog_format_row.inc

--
-- BUG#11733: COMMITs should not happen if read-only is set
--

--disable_warnings
DROP TABLE IF EXISTS table_11733 ;

-- READ_ONLY does nothing to SUPER users
-- so we use a non-SUPER one:

set @orig_sql_mode= @@sql_mode;
create user test@localhost;
set global read_only=0;

-- Any transactional engine will do
create table table_11733 (a int) engine=InnoDb;
insert into table_11733 values(11733);
set global read_only=1;
select @@global.read_only;
select * from table_11733 ;
set global read_only=0;
drop table table_11733 ;
drop user test@localhost;

--
-- Bug #35732: read-only blocks SELECT statements in InnoDB
--
-- Test 1: read only mode
CREATE USER test@localhost;
CREATE TABLE t1(a INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (0), (1);
SET GLOBAL read_only=1;
SELECT * FROM t1;
SELECT * FROM t1;
SET GLOBAL read_only=0;

--
-- Test 2: global read lock
--
FLUSH TABLES WITH READ LOCK;
SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
DROP USER test@localhost;
DROP DATABASE IF EXISTS db1;
CREATE USER bug33669@localhost;
CREATE DATABASE db1;
CREATE TABLE db1.t1 (a INT) ENGINE=INNODB;
CREATE TABLE db1.t2 (a INT) ENGINE=INNODB;
INSERT INTO db1.t1 VALUES (1);
INSERT INTO db1.t2 VALUES (2);
      SELECT, LOCK TABLES ON db1.* TO bug33669@localhost;
SET GLOBAL READ_ONLY = ON;
CREATE TEMPORARY TABLE temp (a INT) ENGINE=INNODB;
INSERT INTO temp VALUES (1);
DROP TABLE temp;
CREATE TEMPORARY TABLE temp (a INT) ENGINE=INNODB;
SELECT * FROM t1;
INSERT INTO temp values (1);
SELECT * FROM t2;
DROP TABLE temp;
SELECT * FROM t1;
CREATE TEMPORARY TABLE temp (a INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (1);
INSERT INTO temp VALUES (1);
SELECT * FROM t2;
SELECT * FROM temp;
DROP TABLE temp;
CREATE TEMPORARY TABLE temp (a INT) ENGINE=INNODB;
SELECT * FROM t1;
SELECT * FROM temp;
INSERT INTO t1 VALUES (1);
INSERT INTO temp VALUES (1);
DROP TABLE temp;
CREATE TEMPORARY TABLE t1 (a INT) ENGINE=INNODB;
DROP TABLE t1;
SELECT * FROM t1;

CREATE TEMPORARY TABLE temp1 (a INT) ENGINE=INNODB;
CREATE TEMPORARY TABLE temp2 LIKE temp1;
INSERT INTO temp1 VALUES (10);
INSERT INTO temp2 VALUES (10);
INSERT INTO temp1 SELECT * FROM t1;
INSERT INTO temp2 SELECT * FROM t2;
SELECT * FROM temp1 ORDER BY a;
SELECT * FROM temp2 ORDER BY a;
SELECT * FROM temp1,temp2;
INSERT INTO temp1 VALUES (10);
INSERT INTO temp2 VALUES (10);
INSERT INTO temp1 SELECT * FROM t1;
INSERT INTO temp2 SELECT * FROM t2;
SELECT * FROM temp1 ORDER BY a;
SELECT * FROM temp2 ORDER BY a;
DELETE temp1, temp2 FROM temp1, temp2;
INSERT INTO temp1 VALUES (10);
INSERT INTO temp2 VALUES (10);
INSERT INTO temp1 SELECT * FROM t1;
INSERT INTO temp2 SELECT * FROM t2;
SELECT * FROM temp1 ORDER BY a;
SELECT * FROM temp2 ORDER BY a;
DROP TABLE temp1, temp2;
CREATE TEMPORARY TABLE temp1 (a INT) ENGINE=INNODB;
CREATE TEMPORARY TABLE temp2 LIKE temp1;
INSERT INTO temp1 (a) VALUES ((SELECT MAX(a) FROM t1));
INSERT INTO temp2 (a) VALUES ((SELECT MAX(a) FROM t2));
INSERT INTO temp1 SELECT * FROM t1 WHERE a < (SELECT MAX(a) FROM t2);
INSERT INTO temp2 SELECT * FROM t2 WHERE a > (SELECT MAX(a) FROM t1);
INSERT INTO temp1 SELECT * FROM t1 WHERE a < (SELECT MAX(a) FROM t2);
INSERT INTO temp2 SELECT * FROM t2 WHERE a > (SELECT MAX(a) FROM t1);
SELECT * FROM temp1 ORDER BY a;
SELECT * FROM temp2 ORDER BY a;
DROP TABLE temp1, temp2;

CREATE TEMPORARY TABLE temp1 (a INT) ENGINE=INNODB;
CREATE TEMPORARY TABLE temp2 LIKE temp1;
INSERT INTO temp1 VALUES (1),(2);
INSERT INTO temp2 VALUES (3),(4);
UPDATE temp1,temp2 SET temp1.a = 5, temp2.a = 10;
SELECT * FROM temp1, temp2;
DROP TABLE temp1, temp2;
SET GLOBAL READ_ONLY = OFF;
DROP USER bug33669@localhost;
DROP DATABASE db1;
