CREATE TABLE t1 (i INTEGER, KEY cached_key(i)) ENGINE=INNODB STATS_PERSISTENT=0;
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19);
DROP TABLE t1;
CREATE TABLE t1 (i INTEGER, KEY latest_key(i));
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
DROP TABLE t1;
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
PREPARE ps1 FROM 'SHOW TABLES FROM no_such_schema';
PREPARE ps2 FROM 'SHOW TABLES FROM mysql LIKE \'%tables%\'';
DEALLOCATE PREPARE ps1;
DEALLOCATE PREPARE ps2;
CREATE TABLE t1(a INT PRIMARY KEY) ENGINE=InnoDB;
INSERT INTO t1 VALUES(1);
DROP TABLE t1;
CREATE DATABASE test1;
DROP DATABASE test1;
CREATE TABLE t1 (f1 INT);
LOCK TABLE t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "CREATE TABLE t2 AS SELECT * FROM t1";
SELECT table_name, table_type, auto_increment, table_comment
       FROM information_schema.tables
       WHERE table_schema='test' and table_name='t2';
UNLOCK TABLES;
SELECT table_name, is_updatable FROM INFORMATION_SCHEMA.VIEWS
                                WHERE table_name = 'v1';
DROP TABLE t1;
CREATE TABLE t1(f1 int);
CREATE VIEW v1 AS SELECT f1+1 AS a FROM t1;
SELECT table_name, is_updatable FROM INFORMATION_SCHEMA.VIEWS
    WHERE table_schema != 'sys' ORDER BY table_name;
DROP TABLE t1;
DROP VIEW v1;
