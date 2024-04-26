
-- Initialise
--disable_warnings
drop table if exists t1;
drop database if exists mysqltest;
drop database if exists client_test_db;
drop table t1;
create table t1(n int);
insert into t1 values(1);
create temporary table t1( n int);
insert into t1 values(2);
create table t1(n int);
drop table t1;
select * from t1;

-- now test for a bug in drop database - it is important that the name
-- of the table is the same as the name of the database - in the original
-- code this triggered a bug
create database mysqltest;
drop database if exists mysqltest;
create database mysqltest;
create table mysqltest.mysqltest (n int);
insert into mysqltest.mysqltest values (4);
select * from mysqltest.mysqltest;
drop database if exists mysqltest;
create database mysqltest;

--
-- drop many tables - bug#3891
-- we'll do it in mysqltest db, to be able to use longer table names
-- (tableN instead on tN)
--
use mysqltest;
drop table table1, table2, table3, table4, table5, table6,
table7, table8, table9, table10, table11, table12, table13,
table14, table15, table16, table17, table18, table19, table20,
table21, table22, table23, table24, table25, table26, table27,
table28;
drop table table1, table2, table3, table4, table5, table6,
table7, table8, table9, table10, table11, table12, table13,
table14, table15, table16, table17, table18, table19, table20,
table21, table22, table23, table24, table25, table26, table27,
table28, table29, table30;

use test;
drop database mysqltest;

-- test drop/create database and FLUSH TABLES WITH READ LOCK
flush tables with read lock;
create database mysqltest;
create database mysqltest;
select schema_name from information_schema.schemata order by schema_name;
drop database mysqltest;
drop database mysqltest;
select schema_name from information_schema.schemata order by schema_name;
drop database mysqltest;

-- test create table and FLUSH TABLES WITH READ LOCK
drop table t1;
create table t1(n int);
create table t1(n int);
drop table t1;

-- End of 4.1 tests


--
-- Test for bug#21216 "Simultaneous DROP TABLE and SHOW OPEN TABLES causes
-- server to crash". Crash (caused by failed assertion in 5.0 or by null
-- pointer dereference in 5.1) happened when one ran SHOW OPEN TABLES
-- while concurrently doing DROP TABLE (or RENAME TABLE, CREATE TABLE LIKE
-- or any other command that takes name-lock) in other connection.
-- 
-- Also includes test for similar bug#12212 "Crash that happens during
-- removing of database name from cache" reappeared in 5.1 as bug#19403
-- In its case crash happened when one concurrently executed DROP DATABASE
-- and one of name-locking command.
-- 
--disable_warnings
drop database if exists mysqltest;
drop table if exists t1;
create table t1 (i int);
create database mysqltest;
select 1;

--
-- Bug#25858 Some DROP TABLE under LOCK TABLES can cause deadlocks
--

--disable_warnings
drop table if exists t1,t2;
create table t1 (a int);
create table t2 (a int);
drop table t2;
drop table t1;
drop table t1,t2;
create table t1 (i int);
create table t2 (i int);
drop table t1;
drop table t1,t2;
drop table t1,t2;
create database mysqltestbug26703;
use mysqltestbug26703;
create table `--mysql50#abc``def` ( id int );
create table `aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa` (a int);
create table `aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa` (a int);
create table `--mysql50#aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa` (a int);
create table `--mysql50#aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa` (a int);
use test;
drop database mysqltestbug26703;
DROP TABLE IF EXISTS t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a INT);
DROP TABLE t1, t1;
DROP TABLE t1;
DROP TABLE table1;
DROP TABLE table1,table2;
DROP VIEW view1,view2,view3,view4;
DROP TABLE IF EXISTS table1;
DROP TABLE IF EXISTS table1,table2;
DROP VIEW IF EXISTS view1,view2,view3,view4;

CREATE TABLE table1(a int);
CREATE TABLE table2(b int);

-- Database name is only available (for printing) if specified in 
-- the trigger definition
CREATE TRIGGER trg1 AFTER INSERT ON table1
FOR EACH ROW
  INSERT INTO table2 SELECT t.notable.*;
INSERT INTO table1 VALUES (1);

DROP TABLE table1,table2;
CREATE DATABASE bug19573998;
USE bug19573998;
CREATE TABLE t1(i int);
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for schema metadata lock" AND
        info = "DROP DATABASE bug19573998";
CREATE DATABASE bug19573998;
let $MYSQLD_DATADIR= `select @@datadir`;
EOF

--echo -- Verify that it is possible to drop the database
DROP DATABASE bug19573998;
USE test;
