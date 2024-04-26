
-- Skipping the test when binlog format is mix/statement due to Bug#22173401
--source include/have_binlog_format_row.inc

-- Test of the READ_ONLY global variable:
-- check that it blocks updates unless they are only on temporary tables.

set @start_read_only= @@global.read_only;

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--disable_warnings
DROP TABLE IF EXISTS t1,t2,t3;

-- READ_ONLY does nothing to SUPER users
-- so we use a non-SUPER one:

set @orig_sql_mode= @@sql_mode;
create user test@localhost;

set global read_only=0;

create table t1 (a int);

insert into t1 values(1);

create table t2 select * from t1;

set global read_only=1;

-- We check that SUPER can:

create table t3 (a int);
drop table t3;

select @@global.read_only;
create table t3 (a int);
insert into t1 values(1);

-- if a statement, after parse stage, looks like it will update a
-- non-temp table, it will be rejected, even if at execution it would
-- have turned out that 0 rows would be updated
--error ER_OPTION_PREVENTS_STATEMENT
update t1 set a=1 where 1=0;

-- multi-update is special (see sql_parse.cc) so we test it
--error ER_OPTION_PREVENTS_STATEMENT
update t1,t2 set t1.a=t2.a+1 where t1.a=t2.a;

-- check multi-delete to be sure
--error ER_OPTION_PREVENTS_STATEMENT
delete t1,t2 from t1,t2 where t1.a=t2.a;

-- With temp tables updates should be accepted:

create temporary table t3 (a int);

create temporary table t4 (a int) select * from t3;

insert into t3 values(1);

insert into t4 select * from t3;

-- a non-temp table updated:
--error ER_OPTION_PREVENTS_STATEMENT
update t1,t3 set t1.a=t3.a+1 where t1.a=t3.a;

-- no non-temp table updated (just swapped):
update t1,t3 set t3.a=t1.a+1 where t1.a=t3.a;

update t4,t3 set t4.a=t3.a+1 where t4.a=t3.a;
delete t1 from t1,t3 where t1.a=t3.a;

delete t3 from t1,t3 where t1.a=t3.a;

delete t4 from t3,t4 where t4.a=t3.a;

-- and even homonymous ones

create temporary table t1 (a int);

insert into t1 values(1);

update t1,t3 set t1.a=t3.a+1 where t1.a=t3.a;

delete t1 from t1,t3 where t1.a=t3.a;

drop table t1;
insert into t1 values(1);

--
-- Bug#11733 COMMITs should not happen if read-only is set
--

-- LOCK TABLE ... WRITE / READ_ONLY
-- - is an error in the same connection
-- - is ok in a different connection

--echo connection default;
set global read_only=0;
set global read_only=1;
select @@global.read_only;
let $wait_condition= SELECT @@global.read_only= 1;
select @@global.read_only;

-- LOCK TABLE ... READ / READ_ONLY
-- - is an error in the same connection
-- - is ok in a different connection

--echo connection default;
set global read_only=0;
set global read_only=1;

-- after unlock tables in current connection
-- the next command must be executed successfully
set global read_only=1;
select @@global.read_only;
select @@global.read_only;

-- pending transaction / READ_ONLY
-- - is an error in the same connection
-- - is ok in a different connection

--echo connection default;
set global read_only=0;
set global read_only=1;

set global read_only=1;
select @@global.read_only;

-- Verify that FLUSH TABLES WITH READ LOCK do not block READ_ONLY
-- - in the same SUPER connection
-- - in another SUPER connection

--echo connection default;
set global read_only=0;
set global read_only=1;
set global read_only=0;
set global read_only=1;
select @@global.read_only;

-- Bug#22077 DROP TEMPORARY TABLE fails with wrong error if read_only is set
--
-- check if DROP TEMPORARY on a non-existing temporary table returns the right
-- error

--error ER_BAD_TABLE_ERROR
drop temporary table ttt;

-- check if DROP TEMPORARY TABLE IF EXISTS produces a warning with read_only set
drop temporary table if exists ttt;

--
-- Cleanup
--
--echo connection default;
set global read_only=0;
drop table t1,t2;
drop user test@localhost;
set global read_only= 1;
drop database if exists mysqltest_db1;
drop database if exists mysqltest_db2;

delete from mysql.user where User like 'mysqltest_%';
delete from mysql.db where User like 'mysqltest_%';
delete from mysql.tables_priv where User like 'mysqltest_%';
delete from mysql.columns_priv where User like 'mysqltest_%';

create user `mysqltest_u1`@`%`;
create database mysqltest_db1;
create database mysqltest_db2;
drop database mysqltest_db1;
delete from mysql.user where User like 'mysqltest_%';
delete from mysql.db where User like 'mysqltest_%';
delete from mysql.tables_priv where User like 'mysqltest_%';
delete from mysql.columns_priv where User like 'mysqltest_%';
drop database mysqltest_db1;
set global read_only= @start_read_only;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1), (2);

CREATE USER user1;

SET GLOBAL read_only= 1;
INSERT INTO t1 VALUES (3);
UPDATE t1 SET a= 1;
DELETE FROM t1;
DROP USER user1;

SET GLOBAL read_only= 0;
DROP TABLE t1;

set sql_mode= @orig_sql_mode;

CREATE TABLE t1(f1 INT);
CREATE TEMPORARY TABLE t1(a1 INT);
CREATE TEMPORARY TABLE t3(a3 INT);
SET @@global.super_read_only=TRUE;
SET @@global.read_only=default;
DROP TABLE t1;
DROP TABLE t1;
DROP TABLE t3;

SET @save_read_only= @@global.read_only;

CREATE USER test@localhost;
let $query= CREATE DATABASE new;
CREATE DATABASE new;
let $query= DROP DATABASE new;
DROP DATABASE new;
let $query= CREATE TABLE t1(fld1 INT);
CREATE TABLE t1(fld1 INT);
let $query= CREATE TABLE IF NOT EXISTS t1(fld1 INT);
let $query= ALTER TABLE t1 ADD fld2 INT;
ALTER TABLE t1 RENAME COLUMN fld1 TO fld1;
let $query= DROP TABLE t1;
let $query= DROP TABLE IF EXISTS no_such_table;
let $query= CREATE INDEX idx1 ON t1 (fld1) USING BTREE;
CREATE INDEX idx1 ON t1 (fld1) USING BTREE;
let $query= DROP INDEX idx1 ON t1;
DROP INDEX idx1 ON t1;
let $MYSQLD_DATADIR=`SELECT @@datadir`;
EOF
let $EXPORT_DIR= $MYSQL_TMP_DIR/export;
let $MYSQLD_DATADIR=`SELECT @@datadir`;
CREATE TABLE t2(fld1 INT) ENGINE=MYISAM;
DROP TABLE t2;
let $query= IMPORT TABLE FROM 'test/t2*.sdi';
let $query= CREATE TRIGGER trg1 BEFORE INSERT ON t1
FOR EACH ROW BEGIN END;
CREATE TRIGGER trg1 BEFORE INSERT ON t1
FOR EACH ROW BEGIN END;
let $query= DROP TRIGGER trg1;
DROP TRIGGER trg1;
let $query= TRUNCATE TABLE t1;
let $query= CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v1 AS SELECT * FROM t1;
let $query= ALTER VIEW v1 AS SELECT 1;
let $query= DROP VIEW v1;
let $query= DROP VIEW IF EXISTS no_such_view;
DROP VIEW v1;
DROP TABLE t1;
let $query= CREATE TABLESPACE ts1
            ADD DATAFILE 'ts1.ibd' ENGINE=INNODB;
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1.ibd' ENGINE=INNODB;
let $query= DROP TABLESPACE ts1;
DROP TABLESPACE ts1;
let $query= CREATE FUNCTION f1() RETURNS INT RETURN 5;
CREATE FUNCTION f1() RETURNS INT RETURN 5;
let $query= ALTER FUNCTION f1 COMMENT 'test';
let $query= DROP FUNCTION f1;
let $query= DROP FUNCTION IF EXISTS f1;
DROP FUNCTION f1;
let $query= CREATE PROCEDURE p1() select 1;
CREATE PROCEDURE p1() select 1;
let $query= ALTER PROCEDURE p1 comment 'test';
let $query= DROP PROCEDURE p1;
let $query= DROP PROCEDURE IF EXISTS no_such_procedure;
DROP PROCEDURE p1;
SET @saved_event_scheduler= @@global.event_scheduler;
SET GLOBAL event_scheduler= OFF;
let $query= CREATE EVENT event1 ON SCHEDULE
EVERY 10 HOUR DO SELECT 1;
CREATE EVENT event1 ON SCHEDULE EVERY 10 HOUR DO SELECT 1;
let $query= CREATE EVENT IF NOT EXISTS event1 ON SCHEDULE EVERY 10 HOUR DO SELECT 1;
let $query= ALTER EVENT event1 DISABLE;
let $query= DROP EVENT event1;
DROP EVENT event1;
let $query= DROP EVENT IF EXISTS no_such_event;
SET GLOBAL event_scheduler= @saved_event_scheduler;
CREATE TABLE t1(fld1 INT);
DROP TABLE t1;
DROP USER test@localhost;
SET GLOBAL read_only= @save_read_only;

SET @save_read_only= @@global.read_only;
SET @save_super_read_only= @@global.super_read_only;

CREATE USER user1@localhost;
let $query= ALTER INSTANCE ROTATE INNODB MASTER KEY;
SET GLOBAL SUPER_READ_ONLY= ON;
ALTER INSTANCE ROTATE INNODB MASTER KEY;
SET GLOBAL read_only= @save_read_only;
SET GLOBAL super_read_only= @save_super_read_only;
DROP USER user1@localhost;
