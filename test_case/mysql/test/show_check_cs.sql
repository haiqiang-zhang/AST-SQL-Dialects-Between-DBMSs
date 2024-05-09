drop table if exists t1,t2;
drop table if exists t1aa,t2aa;
drop database if exists mysqltest;
drop database if exists mysqltest1;
create table t1 (a int not null primary key, b int not null,c int not null, key(b,c));
insert into t1 values (1,2,2),(2,2,3),(3,2,4),(4,2,4);
insert into t1 values (5,5,5);
drop table t1;
create temporary table t1 (a int not null);
alter table t1 rename t2;
drop table t2;
create table t1 (
  test_set set( 'val1', 'val2', 'val3' ) not null default '',
  name char(20) default 'O''Brien' comment 'O''Brien as default',
  c int not null comment 'int column',
  `c-b` int comment 'name with a minus',
  `space 2` int comment 'name with a space'
  ) comment = 'it\'s a table';
drop table t1;
create table t1 (a int not null, unique aa (a));
drop table t1;
create table t1 (a int not null, primary key (a));
drop table t1;
create table t1(n int);
insert into t1 values (1);
drop table t1;
create table t1 (a decimal(9,2), b decimal (9,0), e double(9,2), f double(5,0), h float(3,2), i float(3,0));
drop table t1;
create table t1 (a int not null);
create table t2 select max(a) from t1;
drop table t1,t2;
create table t1 (c decimal, d double, f float, r real);
drop table t1;
create table t1 (c decimal(3,3), d double(3,3), f float(3,3));
drop table t1;
CREATE TABLE ```ab``cd``` (i INT);
DROP TABLE ```ab``cd```;
CREATE TABLE ```ab````cd``` (i INT);
DROP TABLE ```ab````cd```;
CREATE TABLE ```a` (i INT);
DROP TABLE ```a`;
CREATE TABLE `a.1` (i INT);
DROP TABLE `a.1`;
CREATE TABLE t1 (i INT);
DROP TABLE t1;
CREATE TABLE `table` (i INT);
DROP TABLE `table`;
select @@max_heap_table_size;
CREATE TABLE t1 (
 a int(11) default NULL,
 KEY a USING BTREE (a)
) ENGINE=HEAP;
CREATE TABLE t2 (
 b int(11) default NULL,
 index(b)
) ENGINE=HEAP;
CREATE TABLE t3 (
 a int(11) default NULL,
 b int(11) default NULL,
 KEY a USING BTREE (a),
 index(b)
) ENGINE=HEAP;
insert into t1 values (1),(2);
insert into t2 values (1),(2);
insert into t3 values (1,1),(2,2);
insert into t1 values (3),(4);
insert into t2 values (3),(4);
insert into t3 values (3,3),(4,4);
insert into t1 values (5);
insert into t2 values (5);
insert into t3 values (5,5);
delete from t1 where a=3;
delete from t2 where b=3;
delete from t3 where a=3;
insert into t1 values (5);
insert into t2 values (5);
insert into t3 values (5,5);
delete from t1 where a=5;
delete from t2 where b=5;
delete from t3 where a=5;
drop table t1, t2, t3;
create database mysqltest;
create table mysqltest.t1(a int);
drop database mysqltest;
CREATE TABLE t1(
  field1 text NOT NULL,
  PRIMARY KEY(field1(750))
);
drop table t1;
create table t1 (
  c1 int NOT NULL,
  c2 int NOT NULL,
  PRIMARY KEY USING HASH (c1),
  INDEX USING BTREE(c2)
);
DROP TABLE t1;
DROP DATABASE IF EXISTS mysqltest1;
CREATE DATABASE mysqltest1;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT);
SELECT 1 FROM t1;
SELECT 1 FROM t2;
DROP DATABASE mysqltest1;
select 1 from t1 limit 1;
DROP TABLE t1;
create table t1 (a int);
create view v1 as select a from t1;
create procedure p1()
begin
end;
create event e1 on schedule every 1 year starts now()
  ends date_add(now(), interval 5 hour) do
begin
end;
drop view v1;
drop table t1;
drop procedure p1;
DROP DATABASE IF EXISTS mysqltest1;
DROP TABLE IF EXISTS t1;
DROP VIEW IF EXISTS v1;
DROP PROCEDURE IF EXISTS p1;
DROP FUNCTION IF EXISTS f1;
CREATE DATABASE mysqltest1;
CREATE TABLE t1(c INT NOT NULL PRIMARY KEY);
CREATE VIEW v1 AS SELECT 1;
CREATE PROCEDURE p1() SELECT 1;
SELECT
  TABLE_CATALOG,
  TABLE_SCHEMA,
  TABLE_NAME,
  TABLE_TYPE,
  ENGINE,
  ROW_FORMAT,
  TABLE_COLLATION,
  CREATE_OPTIONS,
  TABLE_COMMENT
FROM INFORMATION_SCHEMA.TABLES
WHERE table_name = 't1';
SELECT
  TABLE_CATALOG,
  TABLE_SCHEMA,
  TABLE_NAME,
  COLUMN_NAME,
  COLUMN_DEFAULT,
  IS_NULLABLE,
  DATA_TYPE,
  CHARACTER_SET_NAME,
  COLLATION_NAME,
  COLUMN_TYPE,
  COLUMN_KEY,
  EXTRA,
  PRIVILEGES,
  COLUMN_COMMENT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 't1';
SELECT
  TRIGGER_CATALOG,
  TRIGGER_SCHEMA,
  TRIGGER_NAME,
  EVENT_MANIPULATION,
  EVENT_OBJECT_CATALOG,
  EVENT_OBJECT_SCHEMA,
  EVENT_OBJECT_TABLE,
  ACTION_CONDITION,
  ACTION_STATEMENT,
  ACTION_ORIENTATION,
  ACTION_TIMING,
  ACTION_REFERENCE_OLD_TABLE,
  ACTION_REFERENCE_NEW_TABLE,
  ACTION_REFERENCE_OLD_ROW,
  ACTION_REFERENCE_NEW_ROW,
  SQL_MODE,
  DEFINER
FROM INFORMATION_SCHEMA.TRIGGERS
WHERE trigger_name = 't1_bi';
SELECT *
FROM INFORMATION_SCHEMA.VIEWS
WHERE table_name = 'v1';
SELECT
  SPECIFIC_NAME,
  ROUTINE_CATALOG,
  ROUTINE_SCHEMA,
  ROUTINE_NAME,
  ROUTINE_TYPE,
  DTD_IDENTIFIER,
  ROUTINE_BODY,
  ROUTINE_DEFINITION,
  EXTERNAL_NAME,
  EXTERNAL_LANGUAGE,
  PARAMETER_STYLE,
  IS_DETERMINISTIC,
  SQL_DATA_ACCESS,
  SQL_PATH,
  SECURITY_TYPE,
  SQL_MODE,
  ROUTINE_COMMENT,
  DEFINER
FROM INFORMATION_SCHEMA.ROUTINES
WHERE routine_name = 'p1';
SELECT
  SPECIFIC_NAME,
  ROUTINE_CATALOG,
  ROUTINE_SCHEMA,
  ROUTINE_NAME,
  ROUTINE_TYPE,
  DTD_IDENTIFIER,
  ROUTINE_BODY,
  ROUTINE_DEFINITION,
  EXTERNAL_NAME,
  EXTERNAL_LANGUAGE,
  PARAMETER_STYLE,
  IS_DETERMINISTIC,
  SQL_DATA_ACCESS,
  SQL_PATH,
  SECURITY_TYPE,
  SQL_MODE,
  ROUTINE_COMMENT,
  DEFINER
FROM INFORMATION_SCHEMA.ROUTINES
WHERE routine_name = 'f1';
DROP DATABASE mysqltest1;
DROP TABLE t1;
DROP VIEW v1;
DROP PROCEDURE p1;
DROP DATABASE IF EXISTS mysqltest1;
CREATE DATABASE mysqltest1;
CREATE TABLE t1(ÃÂÃÂÃÂÃÂÃÂÃÂÃÂ1 INT);
DROP DATABASE mysqltest1;
create database mysqltest;
create table mysqltest.t1(a int);
drop database mysqltest;
create database `mysqlttest\1`;
create table `mysqlttest\1`.`a\b` (a int);
drop table `mysqlttest\1`.`a\b`;
drop database `mysqlttest\1`;
drop table if exists `ÃÂÃÂ©tÃÂÃÂ©`;
create table `ÃÂÃÂ©tÃÂÃÂ©` (field1 int);
drop table `ÃÂÃÂ©tÃÂÃÂ©`;
CREATE DATABASE `ÃÂ¤`;
CREATE TABLE `ÃÂ¤`.`ÃÂ¤` (a int) ENGINE=Memory;
DROP DATABASE `ÃÂ¤`;
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS p1;
CREATE TABLE t1(c1 INT);
CREATE PROCEDURE p1() SHOW CREATE TRIGGER t1_bi;
PREPARE stmt1 FROM 'SHOW CREATE TRIGGER t1_bi';
DROP TABLE t1;
DROP PROCEDURE p1;
DEALLOCATE PREPARE stmt1;
DROP VIEW IF EXISTS v1;
DROP PROCEDURE IF EXISTS p1;
DROP FUNCTION IF EXISTS f1;
DROP TABLE IF EXISTS t1;
DROP EVENT IF EXISTS ev1;
CREATE VIEW v1 AS SELECT 'ÃÂÃÂÃÂÃÂ' AS test;
CREATE PROCEDURE p1() SELECT 'ÃÂÃÂÃÂÃÂ' AS test;
CREATE TABLE t1(c1 CHAR(10));
CREATE EVENT ev1 ON SCHEDULE AT '2030-01-01 00:00:00' DO SELECT 'ÃÂÃÂÃÂÃÂ' AS test;
DROP VIEW v1;
DROP PROCEDURE p1;
DROP TABLE t1;
DROP EVENT ev1;
SELECT COUNT(*)=0 FROM INFORMATION_SCHEMA.PROCESSLIST WHERE
  INFO= "KILL QUERY $ID";
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (i INT PRIMARY KEY);
LOCK TABLE t1 WRITE;
UNLOCK TABLES;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INT);
LOCK TABLE t1 WRITE;
ALTER TABLE t1 CHARACTER SET = utf8mb3;
UNLOCK TABLES;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT);
LOCK TABLE t1 WRITE;
UNLOCK TABLES;
ALTER TABLE t1 CHARACTER SET = utf8mb3;
DROP TABLE t1;
SELECT GET_LOCK('t', 1000);
SELECT RELEASE_LOCK('t');
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT);
CREATE TEMPORARY TABLE t1 (b INT);
DROP TEMPORARY TABLE t1;
DROP TABLE t1;
CREATE TABLE t1 (i CHAR(3),
                 n CHAR(20) CHARACTER SET utf8mb3 GENERATED ALWAYS AS (md5(i)));
DROP TABLE t1;
CREATE TABLE `t1` (
  `i` char(3) DEFAULT NULL,
  `n` char(20) CHARACTER SET utf8mb3 GENERATED ALWAYS AS (md5(i)) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
DROP TABLE t1;
CREATE DATABASE unknown;
DROP DATABASE unknown;
CREATE TABLE t1 (c1 int(11) NOT NULL,
                 c2 int(11) DEFAULT NULL,
                 c3 text,
                 PRIMARY KEY (c1));
CREATE INDEX c2d ON t1(c2);
SELECT table_name, column_name, column_type FROM
       INFORMATION_SCHEMA.COLUMNS WHERE table_name='t1';
SELECT table_schema, table_name, index_name, column_name FROM
       INFORMATION_SCHEMA.STATISTICS WHERE table_name='t1';
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE table_name='t1';
SELECT constraint_schema, constraint_name, table_name, column_name FROM
       INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE table_name='t1';
DROP TABLE t1;
CREATE TEMPORARY TABLE t1 (f1 INT, f2 INT);
DROP TABLE t1;
CREATE TABLE t1 (f1 CHAR(1),
                 f2 CHAR(1) COLLATE utf8mb3_BIN,
                 f3 CHAR(1) CHARSET UTF8MB3,
                 f4 CHAR(1) CHARSET UTF8MB4);
ALTER TABLE t1 ADD COLUMN f5 CHAR(1);
ALTER TABLE t1 ADD COLUMN f6 CHAR(1) CHARSET UTF8MB4;
CREATE TABLE t3 LIKE t1;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
