--  This file unfortunately contains characters in various different encodings. 
--  Be careful when editing this file to ensure that you (or your editor) do
--  not change things (such as encodings) on lines that you did not mean to 
--  modify.
--
--###############################################################################

-- Result differences depending on FS case sensitivity.
if (!$require_case_insensitive_file_system)
{
  --source include/have_case_sensitive_file_system.inc
}

--
-- Test of some show commands
--

SET @old_log_output= @@global.log_output;
SET GLOBAL log_output="FILE,TABLE";
drop table if exists t1,t2;
drop table if exists t1aa,t2aa;
drop database if exists mysqltest;
drop database if exists mysqltest1;

delete from mysql.user where user='mysqltest_1' || user='mysqltest_2' || user='mysqltest_3';
delete from mysql.db where user='mysqltest_1' || user='mysqltest_2' || user='mysqltest_3';

create table t1 (a int not null primary key, b int not null,c int not null, key(b,c));
insert into t1 values (1,2,2),(2,2,3),(3,2,4),(4,2,4);
insert into t1 values (5,5,5);
insert into t1 values (5,5,5);
drop table t1;

-- show variables;

--
-- Test of SHOW CREATE
--

create temporary table t1 (a int not null);
alter table t1 rename t2;
drop table t2;

create table t1 (
  test_set set( 'val1', 'val2', 'val3' ) not null default '',
  name char(20) default 'O''Brien' comment 'O''Brien as default',
  c int not null comment 'int column',
  `c-b` int comment 'name with a minus',
  `space 2` int comment 'name with a space'
  ) comment = 'it\'s a table' ;
set sql_quote_show_create=0;
set sql_quote_show_create=1;
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

--
-- Check metadata
--
create table t1 (a int not null);
create table t2 select max(a) from t1;
drop table t1,t2;

-- Check auto conversions of types

create table t1 (c decimal, d double, f float, r real);
drop table t1;

create table t1 (c decimal(3,3), d double(3,3), f float(3,3));
drop table t1;

--
-- Test for Bug#2593 SHOW CREATE TABLE doesn't properly double quotes
--

SET @old_sql_mode= @@sql_mode, sql_mode= '';
SET @old_sql_quote_show_create= @@sql_quote_show_create, sql_quote_show_create= OFF;

CREATE TABLE ```ab``cd``` (i INT);
DROP TABLE ```ab``cd```;

CREATE TABLE ```ab````cd``` (i INT);
DROP TABLE ```ab````cd```;

CREATE TABLE ```a` (i INT);
DROP TABLE ```a`;

CREATE TABLE `a.1` (i INT);
DROP TABLE `a.1`;

SET sql_mode= 'ANSI_QUOTES';

CREATE TABLE """a" (i INT);
DROP TABLE """a";

-- to test quotes around keywords.. :

SET sql_mode= '';
SET sql_quote_show_create= OFF;

CREATE TABLE t1 (i INT);
DROP TABLE t1;

CREATE TABLE `table` (i INT);
DROP TABLE `table`;

SET sql_quote_show_create= @old_sql_quote_show_create;
SET sql_mode= @old_sql_mode;

--
-- Test for Bug#2719 Heap tables status shows wrong or missing data.
--

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

--
-- Test for Bug#3342 SHOW CREATE DATABASE seems to require DROP privilege
--

create database mysqltest;
create table mysqltest.t1(a int);
insert into mysqltest.t1 values(1);
create user mysqltest_1@localhost, mysqltest_2@localhost, mysqltest_3@localhost;
select * from t1;
drop table t1;
drop database mysqltest;
select * from mysqltest.t1;
drop table mysqltest.t1;
drop database mysqltest;
select * from mysqltest.t1;
drop table mysqltest.t1;
drop database mysqltest;
set names binary;
delete from mysql.user
where user='mysqltest_1' || user='mysqltest_2' || user='mysqltest_3';
delete from mysql.db
where user='mysqltest_1' || user='mysqltest_2' || user='mysqltest_3';

-- Test for Bug#9439 Reporting wrong datatype for sub_part on show index
CREATE TABLE t1(
  field1 text NOT NULL,
  PRIMARY KEY(field1(750))
);
drop table t1;

-- Test for Bug#11635 mysqldump exports TYPE instead of USING for HASH
create table t1 (
  c1 int NOT NULL,
  c2 int NOT NULL,
  PRIMARY KEY USING HASH (c1),
  INDEX USING BTREE(c2)
);
DROP TABLE t1;

--
-- Bug#12183 SHOW OPEN TABLES behavior doesn't match grammar
-- First we close all open tables with FLUSH tables and then we open some.
--

--echo
--echo -- Bug#12183 SHOW OPEN TABLES behavior doesn't match grammar.
--echo

-- NOTE: SHOW OPEN TABLES does not sort result list by database or table names.
-- Tables are listed in the order they were opened. We can not use the system
-- database (mysql) for the test here, because we have no control over the order
-- of opening tables in it. Consequently, we can not use 'SHOW OPEN TABLES'.

--disable_warnings
DROP DATABASE IF EXISTS mysqltest1;

CREATE DATABASE mysqltest1;
use mysqltest1;

CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT);

SELECT 1 FROM t1;
SELECT 1 FROM t2;

DROP DATABASE mysqltest1;
use test;

--
-- Bug#12591 SHOW TABLES FROM dbname produces wrong error message
--
--error ER_BAD_DB_ERROR
SHOW TABLES FROM non_existing_database;

--
-- Check that SHOW TABLES and SHOW COLUMNS give a error if there is no
-- referenced database and table respectively.
--
--error ER_BAD_DB_ERROR
SHOW TABLES FROM no_such_database;


--
-- Bug#19764 SHOW commands end up in the slow log as table scans
--
SET GLOBAL EVENT_SCHEDULER = OFF;
CREATE TABLE t1 (f1 INT, f2 INT);
INSERT INTO t1 VALUES(10, 20);
select 1 from t1 limit 1;
DROP TABLE t1;

create table t1 (a int);
create trigger tr1 before insert on t1 for each row
begin
end;
create view v1 as select a from t1;
create procedure p1()
begin
end;
create function f1()
returns int
return 0;
create event e1 on schedule every 1 year starts now()
  ends date_add(now(), interval 5 hour) do
begin
end;

drop view v1;
drop table t1;
drop procedure p1;
drop function f1;
drop event e1;
SET GLOBAL EVENT_SCHEDULER = ON;

--
-- Bug#10491 Server returns data as charset binary SHOW CREATE TABLE or SELECT
--           FROM I_S.
--

--
-- Part 1: check that meta-data specifies not-binary character set.
--

-- Ensure that all needed objects are dropped.

--disable_warnings
DROP DATABASE IF EXISTS mysqltest1;
DROP TABLE IF EXISTS t1;
DROP VIEW IF EXISTS v1;
DROP PROCEDURE IF EXISTS p1;
DROP FUNCTION IF EXISTS f1;

-- Create objects.

CREATE DATABASE mysqltest1;

CREATE TABLE t1(c INT NOT NULL PRIMARY KEY);

CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW SET @a = 1;

CREATE VIEW v1 AS SELECT 1;

CREATE PROCEDURE p1() SELECT 1;

CREATE FUNCTION f1() RETURNS INT RETURN 1;


-- Test.

set names utf8mb3;
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

-- Cleanup.

DROP DATABASE mysqltest1;
DROP TABLE t1;
DROP VIEW v1;
DROP PROCEDURE p1;
DROP FUNCTION f1;

--
-- Part 2: check that table with non-latin1 characters are dumped/restored
-- correctly.
--

-- Ensure that all needed objects are dropped.

set names koi8r;
DROP DATABASE IF EXISTS mysqltest1;

-- Create objects.

CREATE DATABASE mysqltest1;

use mysqltest1;

CREATE TABLE t1(колонка1 INT);

-- Check:
--   - Dump mysqltest1;

--   - Clean mysqltest1;

DROP DATABASE mysqltest1;

--   - Restore mysqltest1;

--   - Check definition of the table.

SHOW CREATE TABLE mysqltest1.t1;

-- Cleanup.

DROP DATABASE mysqltest1;
use test;

--
-- Bug#9785 SELECT privilege for the whole database is needed to do
--          SHOW CREATE DATABASE
--
create database mysqltest;
create table mysqltest.t1(a int);
insert into mysqltest.t1 values(1);
create user mysqltest_4@localhost;
delete from mysql.user where user='mysqltest_4';
delete from mysql.db where user='mysqltest_4';
delete from mysql.tables_priv where user='mysqltest_4';
drop database mysqltest;

--
-- Ensure that show plugin code is tested
--

--disable_result_log
show plugins;

--
-- Bug#19874 SHOW COLUMNS and SHOW KEYS handle identifiers containing
--           \ incorrectly
--
create database `mysqlttest\1`;
create table `mysqlttest\1`.`a\b` (a int);
drop table `mysqlttest\1`.`a\b`;
drop database `mysqlttest\1`;

--
-- Bug#24392 SHOW ENGINE MUTEX STATUS is a synonym for SHOW INNODB STATUS
--

--error ER_UNKNOWN_STORAGE_ENGINE
show engine foobar status;
set names utf8mb3;
drop table if exists `ц╘tц╘`;
create table `ц╘tц╘` (field1 int);
drop table `ц╘tц╘`;
set names latin1;
SET NAMES latin1;
CREATE DATABASE `Д`;
CREATE TABLE `Д`.`Д` (a int) ENGINE=Memory;
DROP DATABASE `Д`;

--
-- Bug#26402 Server crashes with old-style named table
--
--error ER_NO_SUCH_TABLE,ER_FILE_NOT_FOUND
show columns from `--mysql50#????????`;

--
-- SHOW CREATE TRIGGER test.
--

-- Prepare.

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS p1;

CREATE TABLE t1(c1 INT);

CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW SET @a = 1;

-- Test.

--replace_column 7 --
SHOW CREATE TRIGGER t1_bi;

CREATE PROCEDURE p1() SHOW CREATE TRIGGER t1_bi;

-- Cleanup.

DROP TABLE t1;
DROP PROCEDURE p1;

--
-- Bug#10491 Server returns data as charset binary SHOW CREATE TABLE or SELECT
--           FROM INFORMATION_SCHEMA.
--
-- Before the change performed to fix the bug, the metadata of the output of
-- SHOW CREATE statements would always describe the result as 'binary'. That
-- would ensure that the result is never converted to character_set_client
-- (which was essential to mysqldump). Now we return to the client the actual
-- character set of the object -- which is character_set_client of the
-- connection that issues the CREATE statement, and this triggers an automatic
-- conversion to character_set_results of the connection that issues SHOW CREATE
-- statement.
--
-- This test demonstrates that this conversion indeed is taking place.
--

-- Prepare: create objects in a one character set.

set names koi8r;
DROP VIEW IF EXISTS v1;
DROP PROCEDURE IF EXISTS p1;
DROP FUNCTION IF EXISTS f1;
DROP TABLE IF EXISTS t1;
DROP EVENT IF EXISTS ev1;

CREATE VIEW v1 AS SELECT 'тест' AS test;

CREATE PROCEDURE p1() SELECT 'тест' AS test;

CREATE FUNCTION f1() RETURNS CHAR(10) RETURN 'тест';

CREATE TABLE t1(c1 CHAR(10));
CREATE TRIGGER t1_bi BEFORE INSERT ON t1
  FOR EACH ROW
    SET NEW.c1 = 'тест';

CREATE EVENT ev1 ON SCHEDULE AT '2030-01-01 00:00:00' DO SELECT 'тест' AS test;

-- Test: switch the character set and show that SHOW CREATE output is
-- automatically converted to the new character_set_client.

set names utf8mb3;

-- Cleanup.

DROP VIEW v1;
DROP PROCEDURE p1;
DROP FUNCTION f1;
DROP TABLE t1;
DROP EVENT ev1;

--
-- Bug#30036 SHOW TABLE TYPES causes the debug client to crash
--
--disable_result_log
SHOW STORAGE ENGINES;


--
-- Bug#32710 SHOW INNODB STATUS requires SUPER
--

CREATE USER test_u@localhost;
DROP USER test_u@localhost;
LET $ID= `SELECT connection_id()`;
let $wait_timeout= 5;
let $wait_condition=
  SELECT COUNT(*)=0 FROM INFORMATION_SCHEMA.PROCESSLIST WHERE
  INFO= "KILL QUERY $ID";
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (i INT PRIMARY KEY);
DROP TABLE t1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(a INT);
ALTER TABLE t1 CHARACTER SET = utf8mb3;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a INT);
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW SET new.a = 1;
ALTER TABLE t1 CHARACTER SET = utf8mb3;
DROP TRIGGER t1_bi;
DROP TABLE t1;

SET NAMES latin1;
SELECT GET_LOCK('t', 1000);
SET NAMES latin1;
let $wait_timeout= 10;
let $wait_condition= SELECT COUNT(*) FROM INFORMATION_SCHEMA.PROCESSLIST WHERE INFO LIKE '%GET_LOCK%' AND ID != CONNECTION_ID();
SET NAMES utf8mb3;
SELECT RELEASE_LOCK('t');
SET NAMES latin1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a INT);
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW BEGIN END;

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
CREATE TABLE t2 AS SELECT * FROM t1;
CREATE TABLE t3 LIKE t1;

DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;

-- Wait till all disconnects are completed
--source include/wait_until_count_sessions.inc

SET @@global.log_output = @old_log_output;
