{
  --source include/have_case_sensitive_file_system.inc
}

--

--echo --########################################################
--echo -- WL#6599: New data dictionary and I_S.
--echo -- 
--echo -- The re-implemntation of I_S as views on top of DD tables,
--echo -- together with the modified way of retrieving statistics
--echo -- information, introduces some differences when comparing
--echo -- with the previous I_S implementation. The purpose of this
--echo -- test is to focus on these behavioral differences, both
--echo -- for the purpose of regression testing, and to document
--echo -- the changes. The issues below refer to the items listed
--echo -- in the WL#6599 text (HLS section 6).

USE test;

SET information_schema_stats_expiry=default;

CREATE TABLE t1 (i INTEGER, KEY cached_key(i)) ENGINE=INNODB STATS_PERSISTENT=0;
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19);
DROP TABLE t1;

SET information_schema_stats_expiry=0;
CREATE TABLE t1 (i INTEGER, KEY latest_key(i));
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
let $wait_condition = SELECT stat_value = 10
      FROM mysql.innodb_index_stats
      WHERE table_name = 't1'
        AND index_name = 'latest_key'
        AND stat_name = 'n_diff_pfx01';
DROP TABLE t1;

SET information_schema_stats_expiry=default;
SELECT table_name FROM information_schema.tables
  WHERE TABLE_NAME LIKE 'tables' AND TABLE_SCHEMA LIKE 'mysql'
  ORDER BY table_name COLLATE utf8mb3_general_ci;
SELECT table_name FROM information_schema.tables
  WHERE TABLE_NAME LIKE '%tables%' AND TABLE_SCHEMA LIKE 'mysql'
  ORDER BY table_name COLLATE utf8mb3_general_ci;
SELECT table_name FROM information_schema.tables
  WHERE table_schema = 'no such schema';
SELECT table_name as 'table_name' FROM information_schema.tables
  WHERE table_schema = 'no such schema';

CREATE TABLE t1 (f1 int);
INSERT INTO t1 VALUES (20);
SELECT TABLE_NAME,
       IF(CREATE_TIME IS NULL, 'no create time', 'have create time')
  FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_NAME='t1';

DROP TABLE t1;
USE test;
CREATE TABLE t1 LIKE information_schema.CHARACTER_SETS;
CREATE TABLE t1 AS SELECT * FROM information_schema.CHARACTER_SETS;
DROP TABLE t1;
CREATE TABLE t1 LIKE information_schema.processlist;
DROP TABLE t1;
SELECT table_name FROM information_schema.tables
  WHERE table_name LIKE 'no_such_table';
SELECT table_name AS 'table_name'
  FROM information_schema.tables
  WHERE table_name LIKE 'no_such_table';

CREATE VIEW v1 AS SELECT table_name
  FROM information_schema.tables
  WHERE table_schema LIKE 'information_schema'
        AND table_name NOT LIKE 'INNODB%'
        AND table_name NOT LIKE 'ndb%'
  ORDER BY table_name COLLATE utf8mb3_GENERAL_CI;
SELECT * FROM v1;
DROP VIEW v1;

SELECT table_name FROM information_schema.tables
  WHERE table_name LIKE 'no_such_table';
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_NAME LIKE 'no_such_table';

SELECT count(*) = IF(@@lower_case_table_names = 0, 7, 12)
  FROM information_schema.tables
  WHERE table_name LIKE 'TAB%';
SELECT count(*) = IF(@@lower_case_table_names = 0, 5, 12)
  FROM information_schema.tables
  WHERE table_name LIKE 'tab%';
SELECT COUNT(*)+IF(@@lower_case_table_names=0, 1, 0) FROM
INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='INFORMATION_SCHEMA' AND
TABLE_NAME='TABLES';

SET @old_join_size= @@session.max_join_size;
SET @@session.max_join_size= 1;
SET @@session.max_join_size= @old_join_size;

use test;
CREATE TABLE t1(a INT PRIMARY KEY) ENGINE=InnoDB;
INSERT INTO t1 VALUES(1);
let $restart_parameters = restart;
DROP TABLE t1;

CREATE DATABASE test1;

DROP DATABASE test1;

CREATE TABLE t1 (f1 INT);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "CREATE TABLE t2 AS SELECT * FROM t1";
SELECT table_name, table_type, auto_increment, table_comment
       FROM information_schema.tables
       WHERE table_schema='test' and table_name='t2';
DROP TABLE t1, t2;

-- cleanup
connection default;

CREATE TABLE t1 (c1 INT(11) DEFAULT NULL, c2 INT(11) DEFAULT NULL);
INSERT INTO t1 VALUES(5, 5);

CREATE VIEW v1 AS SELECT A.c1 AS c1 FROM t1 A
                  WHERE EXISTS(SELECT B.c2 FROM t1 B WHERE (B.c2 = A.c1));
SELECT table_name, is_updatable FROM INFORMATION_SCHEMA.VIEWS
                                WHERE table_name = 'v1';

INSERT INTO v1 VALUES (10);
UPDATE v1 SET c1=25;
DELETE FROM v1;
DROP TABLE t1;
DROP VIEW v1;

CREATE TABLE t1(f1 int);
CREATE VIEW v1 AS SELECT f1+1 AS a FROM t1;
SELECT table_name, is_updatable FROM INFORMATION_SCHEMA.VIEWS
    WHERE table_schema != 'sys' ORDER BY table_name;
DROP TABLE t1;
DROP VIEW v1;
