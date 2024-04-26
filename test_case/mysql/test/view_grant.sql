
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

set @orig_sql_mode_session= @@SESSION.sql_mode;
set @orig_sql_mode_global= @@GLOBAL.sql_mode;
drop database if exists mysqltest;
drop view if exists v1,v2,v3;

-- simple test of grants
create user test@localhost;
drop user test@localhost;

-- grant create view test
--
connect (root,localhost,root,,test);
create database mysqltest;

create table mysqltest.t1 (a int, b int);
create table mysqltest.t2 (a int, b int);
create user mysqltest_1@localhost;
create definer=root@localhost view v1 as select * from mysqltest.t1;
create view v1 as select * from mysqltest.t1;
alter view v1 as select * from mysqltest.t1;
create or replace view v1 as select * from mysqltest.t1;
create view mysqltest.v2  as select * from mysqltest.t1;
create view v2 as select * from mysqltest.t2;
use test;
alter view v1 as select * from mysqltest.t1;
create or replace view v1 as select * from mysqltest.t1;

drop database mysqltest;
drop view test.v1;

--
-- grants per columns
--
-- MERGE algorithm
create database mysqltest;

create table mysqltest.t1 (a int, b int);
create view mysqltest.v1 (c,d) as select a+1,b+1 from mysqltest.t1;
select c from mysqltest.v1;
select d from mysqltest.v1;
delete from mysql.user where user='mysqltest_1';
drop database mysqltest;

-- TEMPORARY TABLE algorithm
create database mysqltest;

create table mysqltest.t1 (a int, b int);
create algorithm=temptable view mysqltest.v1 (c,d) as select a+1,b+1 from mysqltest.t1;
select c from mysqltest.v1;
select d from mysqltest.v1;
delete from mysql.user where user='mysqltest_1';
drop database mysqltest;
create user mysqltest_1@localhost;

--
-- EXPLAIN rights
--
connection root;
create database mysqltest;
create table mysqltest.t1 (a int, b int);
create table mysqltest.t2 (a int, b int);
create view mysqltest.v1 (c,d) as select a+1,b+1 from mysqltest.t1;
create algorithm=temptable view mysqltest.v2 (c,d) as select a+1,b+1 from mysqltest.t1;
create view mysqltest.v3 (c,d) as select a+1,b+1 from mysqltest.t2;
create algorithm=temptable view mysqltest.v4 (c,d) as select a+1,b+1 from mysqltest.t2;
create view mysqltest.v5 (c,d) as select a+1,b+1 from mysqltest.t1;
select c from mysqltest.v1;
select c from mysqltest.v2;
select c from mysqltest.v3;
select c from mysqltest.v4;
select c from mysqltest.v5;

-- missing SELECT on underlying t1, no SHOW VIEW on v1 either.
--error ER_VIEW_NO_EXPLAIN
explain select c from mysqltest.v1;

-- allow to see any view in mysqltest database
connection root;
delete from mysql.user where user='mysqltest_1';
drop database mysqltest;
create user mysqltest_1@localhost;

--
-- UPDATE privileges on VIEW columns and whole VIEW
--
connection root;
create database mysqltest;

create table mysqltest.t1 (a int, b int, primary key(a));
insert into mysqltest.t1 values (10,2), (20,3), (30,4), (40,5), (50,10);
create table mysqltest.t2 (x int);
insert into mysqltest.t2 values (3), (4), (5), (6);
create view mysqltest.v1 (a,c) as select a, b+1 from mysqltest.t1;
create view mysqltest.v2 (a,c) as select a, b from mysqltest.t1;
create view mysqltest.v3 (a,c) as select a, b+1 from mysqltest.t1;
use mysqltest;
update t2,v1 set v1.a=v1.a+v1.c where t2.x=v1.c;
select * from t1;
update v1 set a=a+c;
select * from t1;
update t2,v2 set v2.a=v2.a+v2.c where t2.x=v2.c;
select * from t1;
update v2 set a=a+c;
select * from t1;
update t2,v2 set v2.c=v2.a+v2.c where t2.x=v2.c;
update v2 set c=a+c;
update t2,v3 set v3.a=v3.a+v3.c where t2.x=v3.c;
update v3 set a=a+c;

use test;
drop database mysqltest;

--
-- DELETE privileges on VIEW
--
connection root;
create database mysqltest;

create table mysqltest.t1 (a int, b int, primary key(a));
insert into mysqltest.t1 values (1,2), (2,3), (3,4), (4,5), (5,10);
create table mysqltest.t2 (x int);
insert into mysqltest.t2 values (3), (4), (5), (6);
create view mysqltest.v1 (a,c) as select a, b+1 from mysqltest.t1;
create view mysqltest.v2 (a,c) as select a, b+1 from mysqltest.t1;
use mysqltest;
delete from v1 where c < 4;
select * from t1;
delete v1 from t2,v1 where t2.x=v1.c;
select * from t1;
delete v2 from t2,v2 where t2.x=v2.c;
delete from v2 where c < 4;

use test;
drop database mysqltest;

--
-- insert privileges on VIEW
--
connection root;
create database mysqltest;

create table mysqltest.t1 (a int, b int, primary key(a));
insert into mysqltest.t1 values (1,2), (2,3);
create table mysqltest.t2 (x int, y int);
insert into mysqltest.t2 values (3,4);
create view mysqltest.v1 (a,c) as select a, b from mysqltest.t1;
create view mysqltest.v2 (a,c) as select a, b from mysqltest.t1;
use mysqltest;
insert into v1 values (5,6);
select * from t1;
insert into v1 select x,y from t2;
select * from t1;
insert into v2 values (5,6);
insert into v2 select x,y from t2;

use test;
drop database mysqltest;

--
-- test of CREATE VIEW privileges if we have limited privileges
--
connection root;
create database mysqltest;

create table mysqltest.t1 (a int, b int);
create table mysqltest.t2 (a int, b int);

create view v1 as select * from mysqltest.t1;
create view v2 as select b from mysqltest.t2;
create view mysqltest.v1 as select * from mysqltest.t1;
create view v3 as select a from mysqltest.t2;

-- give CREATE VIEW privileges (without any privileges for result column)
connection root;
create table mysqltest.v3 (b int);
drop table mysqltest.v3;
create view mysqltest.v3 as select b from mysqltest.t2;

-- give UPDATE privileges
connection root;
drop view mysqltest.v3;
create view mysqltest.v3 as select b from mysqltest.t2;


-- Expression need select privileges
--error ER_COLUMNACCESS_DENIED_ERROR
create view v4 as select b+1 from mysqltest.t2;
create view v4 as select b+1 from mysqltest.t2;
create view v4 as select b+1 from mysqltest.t2;
drop database mysqltest;
drop view v1,v2,v4;

--
-- user with global DB privileges
--
connection root;
create database mysqltest;
create table mysqltest.t1 (a int);
use mysqltest;
create view v1 as select * from t1;
use test;
drop database mysqltest;

--
-- view definer grants revoking
--
connection root;
create database mysqltest;

create table mysqltest.t1 (a int, b int);

create view v1 as select * from mysqltest.t1;
select * from v1;
select * from v1;
drop view v1;
drop database mysqltest;

--
-- rights on execution of view underlying functiond (Bug#9505)
--
connection root;
create database mysqltest;

use mysqltest;
create table t1 (a int);
insert into t1 values (1);
create table t2 (s1 int);
create function f2 () returns int begin declare v int;
create algorithm=TEMPTABLE view v1 as select f2() from t1;
create algorithm=MERGE view v2 as select f2() from t1;
create algorithm=TEMPTABLE SQL SECURITY INVOKER view v3 as select f2() from t1;
create algorithm=MERGE SQL SECURITY INVOKER view v4 as select f2() from t1;
create SQL SECURITY INVOKER view v5 as select * from v4;
use mysqltest;
select * from v1;
select * from v2;
select * from v3;
select * from v4;
select * from v5;
use test;
drop view v1, v2, v3, v4, v5;
drop function f2;
drop table t1, t2;
use test;
drop database mysqltest;

--
-- revertion of previous test, definer of view lost his/her rights to execute
-- function
--

connection root;
create database mysqltest;

use mysqltest;
create table t1 (a int);
insert into t1 values (1);
create table t2 (s1 int);
create function f2 () returns int begin declare v int;
use mysqltest;
create algorithm=TEMPTABLE view v1 as select f2() from t1;
create algorithm=MERGE view v2 as select f2() from t1;
create algorithm=TEMPTABLE SQL SECURITY INVOKER view v3 as select f2() from t1;
create algorithm=MERGE SQL SECURITY INVOKER view v4 as select f2() from t1;
use test;
create view v5 as select * from v1;
select * from v1;
select * from v2;
select * from v3;
select * from v4;
select * from v5;

drop view v1, v2, v3, v4, v5;
drop function f2;
drop table t1, t2;
use test;
drop database mysqltest;

--
-- definer/invoker rights for columns
--
connection root;
create database mysqltest;

use mysqltest;
create table t1 (a int);
create table v1 (a int);
insert into t1 values (1);
drop table v1;
use mysqltest;
create algorithm=TEMPTABLE view v1 as select *, a as b from t1;
create algorithm=MERGE view v2 as select *, a as b from t1;
create algorithm=TEMPTABLE SQL SECURITY INVOKER view v3 as select *, a as b from t1;
create algorithm=MERGE SQL SECURITY INVOKER view v4 as select *, a as b from t1;
create view v5 as select * from v1;
use test;
select * from v1;
select * from v2;
select * from v3;
select * from v4;
select * from v5;
drop table t1;
use test;
drop database mysqltest;
create database mysqltest;

use mysqltest;
create table t1 (a int);
insert into t1 values (1);
create algorithm=TEMPTABLE view v1 as select *, a as b from t1;
create algorithm=MERGE view v2 as select *, a as b from t1;
create algorithm=TEMPTABLE SQL SECURITY INVOKER view v3 as select *, a as b from t1;
create algorithm=MERGE SQL SECURITY INVOKER view v4 as select *, a as b from t1;
create SQL SECURITY INVOKER view v5 as select * from v4;
use mysqltest;
select * from v1;
select * from v2;
select * from v3;
select * from v4;
select * from v5;
use test;
drop view v1, v2, v3, v4, v5;
drop table t1;
use test;
drop database mysqltest;

--
-- Bug#14256 definer in view definition is not fully qualified
--
--disable_warnings
drop view if exists v1;
drop table if exists t1;

-- Backup anonymous users and remove them. (They get in the way of
-- the one we test with here otherwise.)
create table t1 as select * from mysql.user where user='';
delete from mysql.user where user='';

-- Create the test user
create user 'test14256'@'%';
use test;

create view v1 as select 42;

select definer into @v1def1 from information_schema.views
  where table_schema = 'test' and table_name='v1';
drop view v1;

create definer=`test14256`@`%` view v1 as select 42;

select definer into @v1def2 from information_schema.views
  where table_schema = 'test' and table_name='v1';
drop view v1;

select @v1def1, @v1def2, @v1def1=@v1def2;
drop user test14256;

-- Restore the anonymous users.
insert into mysql.user select * from t1;

drop table t1;

--
-- Bug#14726 freeing stack variable in case of an error of opening a view when
--           we have locked tables with LOCK TABLES statement.
--
connection root;
create database mysqltest;

use mysqltest;
CREATE TABLE t1 (i INT);
CREATE VIEW  v1 AS SELECT * FROM t1;

use mysqltest;
use test;
use test;
drop user mysqltest_1@localhost;
drop database mysqltest;

--
-- switch to default connection
--
disconnect user1;

--
-- DEFINER information check
--
create definer=some_user@`` sql security invoker view v1 as select 1;
create definer=some_user@localhost sql security invoker view v2 as select 1;
drop view v1;
drop view v2;

--
-- Bug#18681 View privileges are broken
--
CREATE DATABASE mysqltest1;
CREATE USER readonly@localhost;
CREATE TABLE mysqltest1.t1 (x INT);
INSERT INTO mysqltest1.t1 VALUES (1), (2);
CREATE SQL SECURITY INVOKER VIEW mysqltest1.v_t1 AS SELECT * FROM mysqltest1.t1;
CREATE SQL SECURITY DEFINER VIEW mysqltest1.v_ts AS SELECT * FROM mysqltest1.t1;
CREATE SQL SECURITY DEFINER VIEW mysqltest1.v_ti AS SELECT * FROM mysqltest1.t1;
CREATE SQL SECURITY DEFINER VIEW mysqltest1.v_tu AS SELECT * FROM mysqltest1.t1;
CREATE SQL SECURITY DEFINER VIEW mysqltest1.v_tus AS SELECT * FROM mysqltest1.t1;
CREATE SQL SECURITY DEFINER VIEW mysqltest1.v_td AS SELECT * FROM mysqltest1.t1;
CREATE SQL SECURITY DEFINER VIEW mysqltest1.v_tds AS SELECT * FROM mysqltest1.t1;
SELECT * FROM mysqltest1.v_t1;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
INSERT INTO mysqltest1.v_t1 VALUES(4);
DELETE FROM mysqltest1.v_t1 WHERE x = 1;
UPDATE mysqltest1.v_t1 SET x = 3 WHERE x = 2;
UPDATE mysqltest1.v_t1 SET x = 3;
DELETE FROM mysqltest1.v_t1;
SET sql_mode = default;
SELECT 1 FROM mysqltest1.v_t1;
SELECT * FROM mysqltest1.t1;

SELECT * FROM mysqltest1.v_ts;
SELECT * FROM mysqltest1.v_ts, mysqltest1.t1 WHERE mysqltest1.t1.x = mysqltest1.v_ts.x;
SELECT * FROM mysqltest1.v_ti;
INSERT INTO mysqltest1.v_ts VALUES (100);
INSERT INTO mysqltest1.v_ti VALUES (100);
UPDATE mysqltest1.v_ts SET x= 200 WHERE x = 100;
UPDATE mysqltest1.v_ts SET x= 200;
UPDATE mysqltest1.v_tu SET x= 200 WHERE x = 100;
UPDATE mysqltest1.v_tus SET x= 200 WHERE x = 100;
UPDATE mysqltest1.v_tu SET x= 200;
DELETE FROM mysqltest1.v_ts WHERE x= 200;
DELETE FROM mysqltest1.v_ts;
DELETE FROM mysqltest1.v_td WHERE x= 200;
DELETE FROM mysqltest1.v_tds WHERE x= 200;
DELETE FROM mysqltest1.v_td;
DROP VIEW mysqltest1.v_tds;
DROP VIEW mysqltest1.v_td;
DROP VIEW mysqltest1.v_tus;
DROP VIEW mysqltest1.v_tu;
DROP VIEW mysqltest1.v_ti;
DROP VIEW mysqltest1.v_ts;
DROP VIEW mysqltest1.v_t1;
DROP TABLE mysqltest1.t1;
DROP USER readonly@localhost;
DROP DATABASE mysqltest1;

--
-- Bug#14875 Bad view DEFINER makes SHOW CREATE VIEW fail
--
CREATE TABLE t1 (a INT PRIMARY KEY);
INSERT INTO t1 VALUES (1), (2), (3);
CREATE DEFINER = 'no-such-user'@localhost VIEW v AS SELECT a from t1;
SELECT * FROM v;
DROP VIEW v;
DROP TABLE t1;
USE test;

--
-- Bug#20363 Create view on just created view is now denied
--
eval CREATE USER mysqltest_db1@localhost identified by 'PWD';

-- The session with the non root user is needed.
--replace_result $MASTER_MYPORT MYSQL_PORT $MASTER_MYSOCK MYSQL_SOCK
connect (session1,localhost,mysqltest_db1,PWD,test);

CREATE SCHEMA mysqltest_db1 ;
USE mysqltest_db1 ;

CREATE TABLE t1 (f1 INTEGER);

CREATE VIEW view1 AS
SELECT * FROM t1;

CREATE VIEW view2 AS
SELECT * FROM view1;
SELECT * FROM view2;

CREATE VIEW view3 AS
SELECT * FROM view2;

SELECT * from view3;
DROP VIEW mysqltest_db1.view3;
DROP VIEW mysqltest_db1.view2;
DROP VIEW mysqltest_db1.view1;
DROP TABLE mysqltest_db1.t1;
DROP SCHEMA mysqltest_db1;
DROP USER mysqltest_db1@localhost;
--           in different schemas
--
--disable_warnings
CREATE DATABASE test1;
CREATE DATABASE test2;

CREATE TABLE test1.t0 (a VARCHAR(20));
CREATE TABLE test2.t1 (a VARCHAR(20));
CREATE VIEW  test2.t3 AS SELECT * FROM test1.t0;
CREATE OR REPLACE VIEW test.v1 AS
  SELECT ta.a AS col1, tb.a AS col2 FROM test2.t3 ta, test2.t1 tb;

DROP VIEW test.v1;
DROP VIEW test2.t3;
DROP TABLE test2.t1, test1.t0;
DROP DATABASE test2;
DROP DATABASE test1;


--
-- Bug#20570 CURRENT_USER() in a VIEW with SQL SECURITY DEFINER returns
--           invoker name
--
--disable_warnings
DROP VIEW IF EXISTS v1;
DROP VIEW IF EXISTS v2;
DROP VIEW IF EXISTS v3;
DROP FUNCTION IF EXISTS f1;
DROP FUNCTION IF EXISTS f2;
DROP PROCEDURE IF EXISTS p1;

CREATE SQL SECURITY DEFINER VIEW v1 AS SELECT CURRENT_USER() AS cu;

CREATE FUNCTION f1() RETURNS VARCHAR(77) SQL SECURITY INVOKER
  RETURN CURRENT_USER();
CREATE SQL SECURITY DEFINER VIEW v2 AS SELECT f1() AS cu;

CREATE PROCEDURE p1(OUT cu VARCHAR(77)) SQL SECURITY INVOKER
  SET cu= CURRENT_USER();
CREATE FUNCTION f2() RETURNS VARCHAR(77) SQL SECURITY INVOKER
BEGIN
  DECLARE cu VARCHAR(77);
CREATE SQL SECURITY DEFINER VIEW v3 AS SELECT f2() AS cu;

CREATE USER mysqltest_u1@localhost;
SELECT CURRENT_USER() = 'mysqltest_u1@localhost';
SELECT f1() = 'mysqltest_u1@localhost';
SELECT @cu = 'mysqltest_u1@localhost';
SELECT f2() = 'mysqltest_u1@localhost';
SELECT cu = 'root@localhost' FROM v1;
SELECT cu = 'root@localhost' FROM v2;
SELECT cu = 'root@localhost' FROM v3;

DROP VIEW v3;
DROP FUNCTION f2;
DROP PROCEDURE p1;
DROP FUNCTION f1;
DROP VIEW v2;
DROP VIEW v1;
DROP USER mysqltest_u1@localhost;


--
-- Bug#17254 Error for DEFINER security on VIEW provides too much info
--
connect (root,localhost,root,,);
CREATE DATABASE db17254;
USE db17254;
CREATE TABLE t1 (f1 INT);
INSERT INTO t1 VALUES (10),(20);
CREATE USER def_17254@localhost;
CREATE USER inv_17254@localhost;
CREATE VIEW v1 AS SELECT * FROM t1;
DROP USER def_17254@localhost;
SELECT * FROM v1;
SELECT * FROM v1;
DROP USER inv_17254@localhost;
DROP DATABASE db17254;


--
-- Bug#24404 strange bug with view+permission+prepared statement
--
--disable_warnings
DROP DATABASE IF EXISTS mysqltest_db1;
DROP DATABASE IF EXISTS mysqltest_db2;
DROP USER mysqltest_u1;
DROP USER mysqltest_u2;

CREATE USER mysqltest_u1@localhost;
CREATE USER mysqltest_u2@localhost;

CREATE DATABASE mysqltest_db1;
CREATE DATABASE mysqltest_db2;

CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (1);

-- Use view with subquery for better coverage.
CREATE VIEW v1 AS SELECT i FROM t1 WHERE 1 IN (SELECT * FROM t1);

CREATE TABLE t2 (s CHAR(7));
INSERT INTO t2 VALUES ('public');

SELECT * FROM mysqltest_db1.v1, mysqltest_db1.t2;
UPDATE t2 SET s = 'private' WHERE s = 'public';
SELECT * FROM mysqltest_db1.v1, mysqltest_db1.t2;

-- Cleanup.
disconnect conn2;
DROP DATABASE mysqltest_db1;
DROP DATABASE mysqltest_db2;
DROP USER mysqltest_u1@localhost;
DROP USER mysqltest_u2@localhost;

--
-- Bug#26813 The SUPER privilege is wrongly required to alter a view created
--           by another user.
--
connection root;
CREATE DATABASE db26813;
USE db26813;
CREATE TABLE t1(f1 INT, f2 INT);
CREATE VIEW v1 AS SELECT f1 FROM t1;
CREATE VIEW v2 AS SELECT f1 FROM t1;
CREATE VIEW v3 AS SELECT f1 FROM t1;
CREATE USER u26813@localhost;
ALTER VIEW v1 AS SELECT f2 FROM t1;
ALTER VIEW v2 AS SELECT f2 FROM t1;
ALTER VIEW v3 AS SELECT f2 FROM t1;

DROP USER u26813@localhost;
DROP DATABASE db26813;
CREATE DATABASE mysqltest_29908;
USE mysqltest_29908;
CREATE TABLE t1(f1 INT, f2 INT);
CREATE USER u29908_1@localhost;
CREATE DEFINER = u29908_1@localhost VIEW v1 AS SELECT f1 FROM t1;
CREATE DEFINER = u29908_1@localhost SQL SECURITY INVOKER VIEW v2 AS
  SELECT f1 FROM t1;
CREATE USER u29908_2@localhost;
ALTER VIEW v1 AS SELECT f2 FROM t1;
ALTER VIEW v2 AS SELECT f2 FROM t1;
ALTER VIEW v1 AS SELECT f2 FROM t1;
ALTER VIEW v2 AS SELECT f2 FROM t1;
ALTER VIEW v1 AS SELECT f1 FROM t1;
ALTER VIEW v2 AS SELECT f1 FROM t1;

DROP USER u29908_1@localhost;
DROP USER u29908_2@localhost;
DROP DATABASE mysqltest_29908;

--
-- Bug#24040 Create View don't succed with "all privileges" on a database.
--

-- Prepare.

--disable_warnings
DROP DATABASE IF EXISTS mysqltest1;
DROP DATABASE IF EXISTS mysqltest2;

CREATE DATABASE mysqltest1;
CREATE DATABASE mysqltest2;

-- Test.

CREATE TABLE mysqltest1.t1(c1 INT);
CREATE TABLE mysqltest1.t2(c2 INT);
CREATE TABLE mysqltest1.t3(c3 INT);
CREATE TABLE mysqltest1.t4(c4 INT);

INSERT INTO mysqltest1.t1 VALUES (11), (12), (13), (14);
INSERT INTO mysqltest1.t2 VALUES (21), (22), (23), (24);
INSERT INTO mysqltest1.t3 VALUES (31), (32), (33), (34);
INSERT INTO mysqltest1.t4 VALUES (41), (42), (43), (44);

CREATE USER mysqltest_u1@localhost;

SELECT * FROM mysqltest1.t1;
INSERT INTO mysqltest1.t2 VALUES(25);
UPDATE mysqltest1.t3 SET c3 = 331 WHERE c3 = 31;
DELETE FROM mysqltest1.t4 WHERE c4 = 44;

CREATE VIEW v1 AS SELECT * FROM mysqltest1.t1;
CREATE VIEW v2 AS SELECT * FROM mysqltest1.t2;
CREATE VIEW v3 AS SELECT * FROM mysqltest1.t3;
CREATE VIEW v4 AS SELECT * FROM mysqltest1.t4;

SELECT * FROM v1;
INSERT INTO v2 VALUES(26);
UPDATE v3 SET c3 = 332 WHERE c3 = 32;
DELETE FROM v4 WHERE c4 = 43;
CREATE VIEW v12 AS SELECT c1, c2 FROM mysqltest1.t1, mysqltest1.t2;
CREATE VIEW v13 AS SELECT c1, c3 FROM mysqltest1.t1, mysqltest1.t3;
CREATE VIEW v14 AS SELECT c1, c4 FROM mysqltest1.t1, mysqltest1.t4;
CREATE VIEW v21 AS SELECT c2, c1 FROM mysqltest1.t2, mysqltest1.t1;
CREATE VIEW v23 AS SELECT c2, c3 FROM mysqltest1.t2, mysqltest1.t3;
CREATE VIEW v24 AS SELECT c2, c4 FROM mysqltest1.t2, mysqltest1.t4;

CREATE VIEW v31 AS SELECT c3, c1 FROM mysqltest1.t3, mysqltest1.t1;
CREATE VIEW v32 AS SELECT c3, c2 FROM mysqltest1.t3, mysqltest1.t2;
CREATE VIEW v34 AS SELECT c3, c4 FROM mysqltest1.t3, mysqltest1.t4;

CREATE VIEW v41 AS SELECT c4, c1 FROM mysqltest1.t4, mysqltest1.t1;
CREATE VIEW v42 AS SELECT c4, c2 FROM mysqltest1.t4, mysqltest1.t2;
CREATE VIEW v43 AS SELECT c4, c3 FROM mysqltest1.t4, mysqltest1.t3;

SELECT * FROM mysqltest1.t1;
SELECT * FROM mysqltest1.t2;
SELECT * FROM mysqltest1.t3;
SELECT * FROM mysqltest1.t4;

-- Cleanup.

disconnect bug24040_con;

DROP DATABASE mysqltest1;
DROP DATABASE mysqltest2;
DROP USER mysqltest_u1@localhost;


--
-- Bug#41354 Access control is bypassed when all columns of a view are
--           selected by * wildcard

CREATE DATABASE db1;
USE db1;
CREATE TABLE t1(f1 INT, f2 INT);
CREATE VIEW v1 AS SELECT f1, f2 FROM t1;
CREATE USER foo;
USE db1;

SELECT f1 FROM t1;
SELECT f2 FROM t1;
SELECT * FROM t1;

SELECT f1 FROM v1;
SELECT f2 FROM v1;
SELECT * FROM v1;
USE test;
DROP USER foo;
DROP VIEW db1.v1;
DROP TABLE db1.t1;
DROP DATABASE db1;

-- As a root-like user
connect (root,localhost,root,,test);

create database mysqltest1;
create table mysqltest1.t1 (i int);
create table mysqltest1.t2 (j int);
create table mysqltest1.t3 (k int, secret int);

create user alice@localhost;
create user bob@localhost;
create user cecil@localhost;
create user dan@localhost;
create user eugene@localhost;
create user fiona@localhost;
create user greg@localhost;
create user han@localhost;
create user inga@localhost;
create user jamie@localhost;
create user karl@localhost;
create user lena@localhost;
create user mhairi@localhost;
create user noam@localhost;
create user olga@localhost;
create user pjotr@localhost;
create user quintessa@localhost;

--
--echo ... as alice
connect (test11765687,localhost,alice,,mysqltest1);

create view v1 as select * from t1;
create view v2 as select * from v1, t2;
create view v3 as select k from t3;

--
--echo ... as bob
connect (test11765687,localhost,bob,,mysqltest1);

select * from v1;

--
--echo ... as cecil
connect (test11765687,localhost,cecil,,mysqltest1);
select * from v1;

--
--echo ... as dan
connect (test11765687,localhost,dan,,mysqltest1);

select * from v1;

--
--echo ... as eugene
connect (test11765687,localhost,eugene,,mysqltest1);

select * from v1;

--
--echo ... as fiona
connect (test11765687,localhost,fiona,,mysqltest1);

select * from v2;

--
--echo ... as greg
connect (test11765687,localhost,greg,,mysqltest1);

select * from v2;

--
--echo ... as han
connect (test11765687,localhost,han,,mysqltest1);
select * from t3;
select k from t3;
select * from v3;

--
--echo ... as inga
connect (test11765687,localhost,inga,,mysqltest1);

select * from v2;

--
--echo ... as jamie
connect (test11765687,localhost,jamie,,mysqltest1);

select * from v2;

--
--echo ... as karl
connect (test11765687,localhost,karl,,mysqltest1);

select * from v2;

--
--echo ... as lena

connect (test11765687,localhost,lena,,mysqltest1);
select * from v2;

--
--echo ... as mhairi
connect (test11765687,localhost,mhairi,,mysqltest1);

select * from v2;

--
--echo ... as noam
connect (test11765687,localhost,noam,,mysqltest1);

select * from v2;

--
--echo ... as olga
connect (test11765687,localhost,olga,,mysqltest1);

select * from v2;

--
--echo ... as pjotr
connect (test11765687,localhost,pjotr,,mysqltest1);

select * from v2;

--
--echo ... as quintessa
connect (test11765687,localhost,quintessa,,mysqltest1);

select * from v1;

-- cleanup

--
--echo ... as root again at last: clean-up time!
connection root;

drop user alice@localhost;
drop user bob@localhost;
drop user cecil@localhost;
drop user dan@localhost;
drop user eugene@localhost;
drop user fiona@localhost;
drop user greg@localhost;
drop user han@localhost;
drop user inga@localhost;
drop user jamie@localhost;
drop user karl@localhost;
drop user lena@localhost;
drop user mhairi@localhost;
drop user noam@localhost;
drop user olga@localhost;
drop user pjotr@localhost;
drop user quintessa@localhost;

drop database mysqltest1;


--
-- Test that ALTER VIEW accepts DEFINER and ALGORITHM, see bug#16425.
--
connection default;
DROP VIEW IF EXISTS v1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (i INT);
CREATE VIEW v1 AS SELECT * FROM t1;

ALTER VIEW v1 AS SELECT * FROM t1;
ALTER DEFINER=no_such@user_1 VIEW v1 AS SELECT * FROM t1;
ALTER ALGORITHM=MERGE VIEW v1 AS SELECT * FROM t1;
ALTER ALGORITHM=TEMPTABLE DEFINER=no_such@user_2 VIEW v1 AS SELECT * FROM t1;

DROP VIEW v1;
DROP TABLE t1;

--
-- Bug#37191: Failed assertion in CREATE VIEW
--
CREATE USER mysqluser1@localhost;
CREATE DATABASE mysqltest1;

USE mysqltest1;

CREATE TABLE t1 ( a INT );
CREATE TABLE t2 ( b INT );

INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1), (2);
CREATE VIEW v1 AS SELECT a, b FROM t1, t2;
SELECT * FROM v1;
SELECT b FROM v1;

DROP TABLE t1, t2;
DROP VIEW v1;
DROP DATABASE mysqltest1;
DROP USER mysqluser1@localhost;
USE test;

--
-- Bug#36086: SELECT * from views don't check column grants
--
CREATE USER mysqluser1@localhost;
CREATE DATABASE mysqltest1;

USE mysqltest1;

CREATE TABLE t1 ( a INT, b INT );
CREATE TABLE t2 ( a INT, b INT );

CREATE VIEW v1 AS SELECT a, b FROM t1;
SELECT * FROM mysqltest1.v1;
CREATE VIEW v1 AS SELECT * FROM mysqltest1.t2;

DROP TABLE t1, t2;
DROP VIEW v1;
DROP DATABASE mysqltest1;
DROP USER mysqluser1@localhost;

--
-- Bug#35600 Security breach via view, I_S table and prepared
--           statement/stored procedure
--
CREATE USER mysqluser1@localhost;
CREATE DATABASE mysqltest1;

USE mysqltest1;

CREATE VIEW v1 AS SELECT * FROM information_schema.tables LIMIT 1;
CREATE ALGORITHM = TEMPTABLE VIEW v2 AS SELECT 1 AS A;

CREATE VIEW test.v3 AS SELECT 1 AS a;
DROP VIEW v1, v2;
DROP DATABASE mysqltest1;
DROP VIEW test.v3;
DROP USER mysqluser1@localhost;
USE test;
CREATE USER mysqluser1@localhost;
CREATE DATABASE mysqltest1;
CREATE DATABASE mysqltest2;

USE mysqltest1;

CREATE TABLE t1( a INT );
CREATE TABLE t2( a INT, b INT );
CREATE FUNCTION f1() RETURNS INT RETURN 1;
CREATE VIEW v1 AS SELECT 1 AS a;
CREATE VIEW v2 AS SELECT 1 AS a, 2 AS b;

CREATE VIEW v_t1 AS SELECT * FROM t1;
CREATE VIEW v_t2 AS SELECT * FROM t2;
CREATE VIEW v_f1 AS SELECT f1() AS a;
CREATE VIEW v_v1 AS SELECT * FROM v1;
CREATE VIEW v_v2 AS SELECT * FROM v2;
CREATE VIEW v_mysqluser1_t1 AS SELECT * FROM mysqltest1.t1;
CREATE VIEW v_mysqluser1_t2 AS SELECT * FROM mysqltest1.t2;
CREATE VIEW v_mysqluser1_f1 AS SELECT mysqltest1.f1() AS a;
CREATE VIEW v_mysqluser1_v1 AS SELECT * FROM mysqltest1.v1;
CREATE VIEW v_mysqluser1_v2 AS SELECT * FROM mysqltest1.v2;
DROP TABLE t1;
DROP FUNCTION f1;
DROP VIEW v1;
DROP USER mysqluser1@localhost;
DROP DATABASE mysqltest1;
DROP DATABASE mysqltest2;
USE test;

CREATE TABLE t1( a INT );
CREATE DEFINER = no_such_user@no_such_host VIEW v1 AS SELECT * FROM t1;
DROP TABLE t1;
DROP VIEW v1;
CREATE DATABASE mysqltest1;
USE mysqltest1;

CREATE TABLE t1 (a INT);

CREATE SQL SECURITY INVOKER VIEW v1 AS SELECT a FROM t1 GROUP BY a;
CREATE SQL SECURITY INVOKER VIEW v2 AS SELECT a FROM v1;

CREATE USER mysqluser1;
SELECT a FROM v1;
SELECT a FROM v2;
DROP USER mysqluser1;
DROP DATABASE mysqltest1;
USE test;

CREATE DEFINER=`unknown`@`unknown` SQL SECURITY DEFINER VIEW v1 AS SELECT 1;
DROP VIEW v1;
CREATE DATABASE mysqltest1;
USE mysqltest1;
CREATE TABLE t1 (i INT);
CREATE TABLE t2 (j INT);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
CREATE SQL SECURITY INVOKER VIEW v1_uses_t1 AS SELECT * FROM t1;
CREATE SQL SECURITY INVOKER VIEW v1_uses_t2 AS SELECT * FROM t2;
CREATE USER 'mysqluser1'@'%';
CREATE SQL SECURITY DEFINER VIEW v2_uses_t1 AS SELECT * FROM v1_uses_t1;
CREATE SQL SECURITY DEFINER VIEW v2_uses_t2 AS SELECT * FROM v1_uses_t2;
CREATE USER 'mysqluser2'@'%';
SELECT * FROM v2_uses_t1;
SELECT * FROM v2_uses_t2;
DROP VIEW v2_uses_t1, v2_uses_t2;
CREATE SQL SECURITY INVOKER VIEW v2_uses_t1 AS SELECT * FROM v1_uses_t1;
CREATE SQL SECURITY INVOKER VIEW v2_uses_t2 AS SELECT * FROM v1_uses_t2;
SELECT * FROM v2_uses_t1;
SELECT * FROM v2_uses_t2;
SELECT * FROM v2_uses_t1;
SELECT * FROM v2_uses_t2;
DROP VIEW v1_uses_t1, v1_uses_t2;
CREATE SQL SECURITY DEFINER VIEW v1_uses_t1 AS SELECT * FROM t1;
CREATE SQL SECURITY DEFINER VIEW v1_uses_t2 AS SELECT * FROM t2;
SELECT * FROM v2_uses_t1;
SELECT * FROM v2_uses_t2;
DROP VIEW v2_uses_t1, v2_uses_t2;
CREATE SQL SECURITY DEFINER VIEW v2_uses_t1 AS SELECT * FROM v1_uses_t1;
CREATE SQL SECURITY DEFINER VIEW v2_uses_t2 AS SELECT * FROM v1_uses_t2;
SELECT * FROM v2_uses_t1;
SELECT * FROM v2_uses_t2;
USE test;
DROP DATABASE mysqltest1;
DROP USER 'mysqluser1'@'%';
DROP USER 'mysqluser2'@'%';
drop database if exists mysqltest1;
drop database if exists mysqltest2;
create database mysqltest1;
create database mysqltest2;
create user user_11766767;
use mysqltest1;
create table t1 (id int primary key, val varchar(20));
insert into t1 values (1, 'test1');
create table t11 (id int primary key);
insert into t11 values (1);
create algorithm=temptable view v1_temp as select * from t1;
create algorithm=merge view v1_merge as select * from t1;
create algorithm=temptable view v11_temp as
  select t1.id as id, t1.val as val from t1, t11 where t1.id= t11.id;
create algorithm=merge view v11_merge as
  select t1.id as id, t1.val as val from t1, t11 where t1.id= t11.id;
use mysqltest2;
create table t2 (id int primary key, val varchar(20));
insert into t2 values (1, 'test2');
create table t21 (id int primary key);
insert into t21 values (1);
create algorithm=temptable view v2_temp as select * from t2;
create algorithm=merge view v2_merge as select * from t2;
create algorithm=temptable view v21_temp as 
  select t2.id as id, t2.val as val from t2, t21 where t2.id= t21.id;
create algorithm=merge view v21_merge as
  select t2.id as id, t2.val as val from t2, t21 where t2.id= t21.id;
create algorithm=temptable sql security invoker view v3_temp as
  select t1.id as id, t1.val as val from mysqltest1.t1 as t1, mysqltest1.t11 as t11
    where t1.id = t11.id;
create algorithm=merge sql security invoker view v3_merge as
  select t1.id as id, t1.val as val from mysqltest1.t1 as t1, mysqltest1.t11 as t11
    where t1.id = t11.id;
create sql security invoker view v31 as
  select t2.id as id, t2.val as val from mysqltest2.t2 as t2, mysqltest1.t11 as t11
    where t2.id = t11.id;
create sql security invoker view v4 as
  select t2.id as id, t2.val as val from mysqltest2.t2 as t2, mysqltest1.v1_merge as v1
    where t2.id = v1.id;
create sql security invoker view v41 as
  select v1.id as id, v1.val as val from mysqltest2.t2 as t2, mysqltest1.v1_merge as v1
    where t2.id = v1.id;
create sql security invoker view v42 as
  select v2.id as id, v2.val as val from mysqltest2.t2 as t2, mysqltest2.v2_merge as v2
    where t2.id = v2.id;
update mysqltest2.t2 as t2, mysqltest1.v1_merge as v1 set t2.val= 'test3'
  where t2.id= v1.id;
update mysqltest2.t2 as t2, mysqltest1.v1_temp as v1 set t2.val= 'test4'
  where t2.id= v1.id;
update mysqltest2.t2 as t2, mysqltest1.v1_merge as v1 set v1.val= 'test5'
  where t2.id= v1.id;
update mysqltest1.t1 as t1, mysqltest2.v2_merge as v2 set v2.val= 'test6'
  where t1.id= v2.id;
update mysqltest2.t2 as t2, mysqltest1.v1_temp as v1 set v1.val= 'test7'
  where t2.id= v1.id;
update mysqltest1.t1 as t1, mysqltest2.v2_temp as v2 set v2.val= 'test8'
  where t1.id= v2.id;
update mysqltest2.t2 as t2, mysqltest1.v11_merge as v11 set t2.val= 'test9'
  where t2.id= v11.id;
update mysqltest2.t2 as t2, mysqltest1.v11_temp as v11 set t2.val= 'test10'
  where t2.id= v11.id;
update mysqltest2.t2 as t2, mysqltest1.v11_merge as v11 set v11.val= 'test11'
  where t2.id= v11.id;
update mysqltest1.t1 as t1, mysqltest2.v21_merge as v21 set v21.val= 'test12'
  where t1.id= v21.id;
update mysqltest2.t2 as t2, mysqltest1.v11_temp as v11 set v11.val= 'test13'
  where t2.id= v11.id;
update mysqltest1.t1 as t1, mysqltest2.v21_temp as v21 set v21.val= 'test14'
  where t1.id= v21.id;
update mysqltest2.t2 as t2, mysqltest2.v3_merge as v3 set t2.val= 'test15'
  where t2.id= v3.id;
update mysqltest2.t2 as t2, mysqltest2.v3_temp as v3 set t2.val= 'test16'
  where t2.id= v3.id;
update mysqltest2.t2 as t2, mysqltest2.v3_merge as v3 set v3.val= 'test17'
  where t2.id= v3.id;
update mysqltest1.t11 as t11, mysqltest2.v31 as v31 set v31.val= 'test18'
  where t11.id= v31.id;
update mysqltest1.t11 as t11, mysqltest2.v4 as v4 set v4.val= 'test19'
  where t11.id= v4.id;
update mysqltest1.t11 as t11, mysqltest2.v41 as v4 set v4.val= 'test20'
  where t11.id= v4.id;
update mysqltest1.t11 as t11, mysqltest2.v42 as v4 set v4.val= 'test20'
  where t11.id= v4.id;
drop user user_11766767;
drop database mysqltest1;
drop database mysqltest2;

CREATE DATABASE test1;
USE test1;
CREATE USER user1@localhost;

CREATE TABLE test1.t1
 (cn CHAR(1), cs CHAR(1), ci CHAR(1), cu CHAR(1), cus CHAR(1));

INSERT INTO test1.t1 VALUES('0', '0', '0', '0', '0');

CREATE TABLE test1.single (a INTEGER);

INSERT INTO test1.single VALUES(1);

CREATE SQL SECURITY INVOKER VIEW test1.v1_none AS
SELECT * FROM test1.t1;

CREATE SQL SECURITY INVOKER VIEW test1.v1_all AS
SELECT * FROM test1.t1;

CREATE SQL SECURITY INVOKER VIEW test1.v1_same AS
SELECT * FROM test1.t1;

CREATE SQL SECURITY INVOKER VIEW test1.v1_cross AS
SELECT * FROM test1.t1;

CREATE SQL SECURITY INVOKER VIEW test1.v1_middle AS
SELECT * FROM test1.t1;

CREATE SQL SECURITY INVOKER VIEW test1.v1_multi AS
SELECT * FROM test1.v1_middle;

CREATE SQL SECURITY INVOKER VIEW test1.v1_renamed AS
SELECT cn AS cs, cn AS cx, cs AS cus, cs AS cy FROM test1.t1;

SELECT cs, cus FROM test1.t1;
SELECT * FROM test1.t1;
SELECT cn FROM test1.t1;
SELECT ci FROM test1.t1;
SELECT cu FROM test1.t1;

SELECT cs FROM test1.t1 WHERE cs = '0';
SELECT cs FROM test1.t1 WHERE cus = '0';
SELECT cs FROM test1.t1 WHERE cn = '0';
SELECT cs FROM test1.t1 WHERE ci = '0';
SELECT cs FROM test1.t1 WHERE cu = '0';

SELECT COUNT(*) AS c FROM test1.t1 GROUP BY cs;
SELECT COUNT(*) AS c FROM test1.t1 GROUP BY cus;
SELECT COUNT(*) AS c FROM test1.t1 GROUP BY cn;
SELECT COUNT(*) AS c FROM test1.t1 GROUP BY ci;
SELECT COUNT(*) AS c FROM test1.t1 GROUP BY cu;

SELECT COUNT(*) AS c FROM test1.t1 HAVING MIN(cs) = '0';
SELECT COUNT(*) AS c FROM test1.t1 HAVING MIN(cus) = '0';
SELECT COUNT(*) AS c FROM test1.t1 HAVING MIN(cn) = '0';
SELECT COUNT(*) AS c FROM test1.t1 HAVING MIN(ci) = '0';
SELECT COUNT(*) AS c FROM test1.t1 HAVING MIN(cu) = '0';

SELECT COUNT(*) AS c FROM test1.t1 ORDER BY MIN(cs);
SELECT COUNT(*) AS c FROM test1.t1 ORDER BY MIN(cus);
SELECT COUNT(*) AS c FROM test1.t1 ORDER BY MIN(cn);
SELECT COUNT(*) AS c FROM test1.t1 ORDER BY MIN(ci);
SELECT COUNT(*) AS c FROM test1.t1 ORDER BY MIN(cu);

UPDATE test1.t1 SET cu='u';
UPDATE test1.t1 SET cus='s' WHERE cus='0';

UPDATE test1.t1, test1.single SET cu='u';
UPDATE test1.t1, test1.single SET cus='s' WHERE cus='0';
UPDATE test1.t1 SET cn='x';
UPDATE test1.t1, test1.single SET cn='x';
UPDATE test1.t1 SET cs='x';
UPDATE test1.t1, test1.single SET cs='x';
UPDATE test1.t1 SET ci='x';
UPDATE test1.t1, test1.single SET ci='x';
UPDATE test1.t1 SET cu='x' WHERE cn='0';
UPDATE test1.t1, test1.single SET cu='x' WHERE cn='0';

INSERT INTO test1.t1(ci) VALUES('i');
INSERT INTO test1.t1(ci) SELECT 'i' FROM test1.single;
INSERT INTO test1.t1(ci) VALUES('i')
ON DUPLICATE KEY UPDATE cu='u';
INSERT INTO test1.t1(ci) SELECT 'i' FROM test1.single
ON DUPLICATE KEY UPDATE cu='u';
INSERT INTO test1.t1(cn) VALUES('x');
INSERT INTO test1.t1(cn) SELECT 'x' FROM test1.single;
INSERT INTO test1.t1(cs) VALUES('x');
INSERT INTO test1.t1(cs) SELECT 'x' FROM test1.single;
INSERT INTO test1.t1(cu) VALUES('x');
INSERT INTO test1.t1(cu) SELECT 'x' FROM test1.single;
INSERT INTO test1.t1(cus) VALUES('x');
INSERT INTO test1.t1(cus) SELECT 'x' FROM test1.single;
INSERT INTO test1.t1(ci) VALUES('i')
ON DUPLICATE KEY UPDATE cn='u';
INSERT INTO test1.t1(ci) SELECT 'i' FROM test1.single
ON DUPLICATE KEY UPDATE cn='u';
DELETE FROM test1.t1;
DELETE FROM test1.t1 WHERE cs='0';
DELETE test1.t1 FROM test1.t1, test1.single WHERE cs='0';

SELECT * FROM (SELECT cs FROM test1.t1) AS dt;
SELECT * FROM (SELECT cus FROM test1.t1) AS dt;
SELECT * FROM (SELECT cn FROM test1.t1) AS dt;
SELECT * FROM (SELECT cu FROM test1.t1) AS dt;
SELECT * FROM (SELECT ci FROM test1.t1) AS dt;

SELECT * FROM (SELECT MIN(cs) AS c FROM test1.t1) AS dt;
SELECT * FROM (SELECT MIN(cus) AS c FROM test1.t1) AS dt;
SELECT * FROM (SELECT MIN(cn) AS c FROM test1.t1) AS dt;
SELECT * FROM (SELECT MIN(cu) AS c FROM test1.t1) AS dt;
SELECT * FROM (SELECT MIN(ci) AS c FROM test1.t1) AS dt;

SELECT * FROM (SELECT cs FROM test1.t1 WHERE cs = '0') AS dt;
SELECT * FROM (SELECT cs FROM test1.t1 WHERE cus = '0') AS dt;
SELECT * FROM (SELECT cs FROM test1.t1 WHERE cn = '0') AS dt;
SELECT * FROM (SELECT cs FROM test1.t1 WHERE ci = '0') AS dt;
SELECT * FROM (SELECT cs FROM test1.t1 WHERE cu = '0') AS dt;

SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 GROUP BY cs) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 GROUP BY cus) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 GROUP BY cn) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 GROUP BY ci) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 GROUP BY cu) AS dt;

SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 HAVING MIN(cs) = '0') AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 HAVING MIN(cus) = '0') AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 HAVING MIN(cn) = '0') AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 HAVING MIN(ci) = '0') AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 HAVING MIN(cu) = '0') AS dt;

SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 ORDER BY MIN(cs)) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 ORDER BY MIN(cus)) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 ORDER BY MIN(cn)) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 ORDER BY MIN(ci)) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.t1 ORDER BY MIN(cu)) AS dt;
SELECT cs, cus FROM test1.v1_none;
UPDATE test1.v1_none SET cu='x';
UPDATE test1.v1_none, test1.single SET cu='x';
UPDATE test1.v1_none SET cus='x' WHERE cus='0';
UPDATE test1.v1_none, test1.single SET cus='x' WHERE cus='0';
INSERT INTO test1.v1_none(ci) VALUES('x');
INSERT INTO test1.v1_none(ci) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_none(ci) VALUES('x')
ON DUPLICATE KEY UPDATE cu='u';
INSERT INTO test1.v1_none(ci) SELECT 'x' FROM test1.single
ON DUPLICATE KEY UPDATE cu='u';
DELETE FROM test1.v1_none;
DELETE FROM test1.v1_none WHERE cs='0';
DELETE test1.v1_none FROM test1.v1_none, test1.single WHERE cs='0';

SELECT cs, cus FROM test1.v1_all;
SELECT * FROM test1.v1_all;
SELECT cn FROM test1.v1_all;
SELECT ci FROM test1.v1_all;
SELECT cu FROM test1.v1_all;

UPDATE test1.v1_all SET cu='v';
UPDATE test1.v1_all, test1.single SET cu='v';

UPDATE test1.v1_all SET cus='t' WHERE cus='0';
UPDATE test1.v1_all, test1.single SET cus='t' WHERE cus='0';
UPDATE test1.v1_all SET cn='x';
UPDATE test1.v1_all, test1.single SET cn='x';
UPDATE test1.v1_all SET cs='x';
UPDATE test1.v1_all, test1.single SET cs='x';
UPDATE test1.v1_all SET ci='x';
UPDATE test1.v1_all, test1.single SET ci='x';
UPDATE test1.v1_all SET cu='x' WHERE cn='0';
UPDATE test1.v1_all, test1.single SET cu='x' WHERE cn='0';

INSERT INTO test1.v1_all(ci) VALUES('j');
INSERT INTO test1.v1_all(ci) SELECT 'j' FROM test1.single;
INSERT INTO test1.v1_all(ci) VALUES('j')
ON DUPLICATE KEY UPDATE cu='u';
INSERT INTO test1.v1_all(ci) SELECT 'j' FROM test1.single
ON DUPLICATE KEY UPDATE cu='u';
INSERT INTO test1.v1_all(cn) VALUES('x');
INSERT INTO test1.v1_all(cn) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_all(cs) VALUES('x');
INSERT INTO test1.v1_all(cs) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_all(cu) VALUES('x');
INSERT INTO test1.v1_all(cu) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_all(cus) VALUES('x');
INSERT INTO test1.v1_all(cus) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_all(cn) VALUES('x')
ON DUPLICATE KEY UPDATE cu='u';
INSERT INTO test1.v1_all(cn) SELECT 'x' FROM test1.single
ON DUPLICATE KEY UPDATE cu='u';
INSERT INTO test1.v1_all(ci) VALUES('x')
ON DUPLICATE KEY UPDATE cn='u';
INSERT INTO test1.v1_all(ci) SELECT 'x' FROM test1.single
ON DUPLICATE KEY UPDATE cn='u';
DELETE FROM test1.v1_all;
DELETE FROM test1.v1_all WHERE cs='0';
DELETE test1.v1_all FROM test1.v1_all, test1.single WHERE cs='0';

SELECT * FROM (SELECT cs FROM test1.v1_all) AS dt;
SELECT * FROM (SELECT cus FROM test1.v1_all) AS dt;
SELECT * FROM (SELECT cn FROM test1.v1_all) AS dt;
SELECT * FROM (SELECT cu FROM test1.v1_all) AS dt;
SELECT * FROM (SELECT ci FROM test1.v1_all) AS dt;

SELECT * FROM (SELECT MIN(cs) AS c FROM test1.v1_all) AS dt;
SELECT * FROM (SELECT MIN(cus) AS c FROM test1.v1_all) AS dt;
SELECT * FROM (SELECT MIN(cn) AS c FROM test1.v1_all) AS dt;
SELECT * FROM (SELECT MIN(cu) AS c FROM test1.v1_all) AS dt;
SELECT * FROM (SELECT MIN(ci) AS c FROM test1.v1_all) AS dt;

SELECT * FROM (SELECT cs FROM test1.v1_all WHERE cs = '0') AS dt;
SELECT * FROM (SELECT cs FROM test1.v1_all WHERE cus = '0') AS dt;
SELECT * FROM (SELECT cs FROM test1.v1_all WHERE cn = '0') AS dt;
SELECT * FROM (SELECT cs FROM test1.v1_all WHERE ci = '0') AS dt;
SELECT * FROM (SELECT cs FROM test1.v1_all WHERE cu = '0') AS dt;

SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all GROUP BY cs) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all GROUP BY cus) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all GROUP BY cn) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all GROUP BY ci) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all GROUP BY cu) AS dt;

SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all HAVING MIN(cs) = '0') AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all HAVING MIN(cus) = '0') AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all HAVING MIN(cn) = '0') AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all HAVING MIN(ci) = '0') AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all HAVING MIN(cu) = '0') AS dt;

SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all ORDER BY MIN(cs)) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all ORDER BY MIN(cus)) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all ORDER BY MIN(cn)) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all ORDER BY MIN(ci)) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_all ORDER BY MIN(cu)) AS dt;

SELECT cs, cus FROM test1.v1_same;
SELECT * FROM test1.v1_same;
SELECT cn FROM test1.v1_same;
SELECT ci FROM test1.v1_same;
SELECT cu FROM test1.v1_same;

UPDATE test1.v1_same SET cu='w';
UPDATE test1.v1_same, test1.single SET cu='w';
UPDATE test1.v1_same SET cus='z' WHERE cus='0';
UPDATE test1.v1_same, test1.single SET cus='z' WHERE cus='0';
UPDATE test1.v1_same SET cn='x';
UPDATE test1.v1_same, test1.single SET cn='x';
UPDATE test1.v1_same SET cs='x';
UPDATE test1.v1_same, test1.single SET cs='x';
UPDATE test1.v1_same SET ci='x';
UPDATE test1.v1_same, test1.single SET ci='x';
UPDATE test1.v1_same SET cu='x' WHERE cn='0';
UPDATE test1.v1_same, test1.single SET cu='x' WHERE cn='0';

INSERT INTO test1.v1_same(ci) VALUES('k');
INSERT INTO test1.v1_same(ci) SELECT 'k' FROM test1.single;
INSERT INTO test1.v1_same(ci) VALUES('k')
ON DUPLICATE KEY UPDATE cu='u';
INSERT INTO test1.v1_same(ci) SELECT 'k' FROM test1.single
ON DUPLICATE KEY UPDATE cu='u';
INSERT INTO test1.v1_same(cn) VALUES('x');
INSERT INTO test1.v1_same(cn) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_same(cs) VALUES('x');
INSERT INTO test1.v1_same(cs) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_same(cu) VALUES('x');
INSERT INTO test1.v1_same(cu) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_same(cus) VALUES('x');
INSERT INTO test1.v1_same(cus) SELECT 'x' FROM test1.single;
DELETE FROM test1.v1_same;
DELETE FROM test1.v1_same WHERE cs='0';
DELETE test1.v1_same FROM test1.v1_same, test1.single WHERE cs='0';

SELECT * FROM (SELECT cs FROM test1.v1_same) AS dt;
SELECT * FROM (SELECT cus FROM test1.v1_same) AS dt;
SELECT * FROM (SELECT cn FROM test1.v1_same) AS dt;
SELECT * FROM (SELECT cu FROM test1.v1_same) AS dt;
SELECT * FROM (SELECT ci FROM test1.v1_same) AS dt;

SELECT * FROM (SELECT MIN(cs) AS c FROM test1.v1_same) AS dt;
SELECT * FROM (SELECT MIN(cus) AS c FROM test1.v1_same) AS dt;
SELECT * FROM (SELECT MIN(cn) AS c FROM test1.v1_same) AS dt;
SELECT * FROM (SELECT MIN(cu) AS c FROM test1.v1_same) AS dt;
SELECT * FROM (SELECT MIN(ci) AS c FROM test1.v1_same) AS dt;

SELECT * FROM (SELECT cs FROM test1.v1_same WHERE cs = '0') AS dt;
SELECT * FROM (SELECT cs FROM test1.v1_same WHERE cus = '0') AS dt;
SELECT * FROM (SELECT cs FROM test1.v1_same WHERE cn = '0') AS dt;
SELECT * FROM (SELECT cs FROM test1.v1_same WHERE ci = '0') AS dt;
SELECT * FROM (SELECT cs FROM test1.v1_same WHERE cu = '0') AS dt;

SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same GROUP BY cs) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same GROUP BY cus) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same GROUP BY cn) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same GROUP BY ci) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same GROUP BY cu) AS dt;

SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same HAVING MIN(cs) = '0') AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same HAVING MIN(cus) = '0') AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same HAVING MIN(cn) = '0') AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same HAVING MIN(ci) = '0') AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same HAVING MIN(cu) = '0') AS dt;

SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same ORDER BY MIN(cs)) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same ORDER BY MIN(cus)) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same ORDER BY MIN(cn)) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same ORDER BY MIN(ci)) AS dt;
SELECT * FROM (SELECT COUNT(*) AS c FROM test1.v1_same ORDER BY MIN(cu)) AS dt;
SELECT cs, cus FROM test1.v1_cross;
SELECT * FROM test1.v1_cross;
SELECT cn FROM test1.v1_cross;
SELECT ci FROM test1.v1_cross;
SELECT cu FROM test1.v1_cross;
UPDATE test1.v1_cross SET cu='x';
UPDATE test1.v1_cross, test1.single SET cu='x';
UPDATE test1.v1_cross SET cus='x' WHERE cus='0';
UPDATE test1.v1_cross, test1.single SET cus='x' WHERE cus='0';
UPDATE test1.v1_cross SET cn='x';
UPDATE test1.v1_cross, test1.single SET cn='x';
UPDATE test1.v1_cross SET cs='x';
UPDATE test1.v1_cross, test1.single SET cs='x';
UPDATE test1.v1_cross SET ci='x';
UPDATE test1.v1_cross, test1.single SET ci='x';
UPDATE test1.v1_cross SET cu='x' WHERE cn='0';
UPDATE test1.v1_cross, test1.single SET cu='x' WHERE cn='0';
INSERT INTO test1.v1_cross(ci) VALUES('x');
INSERT INTO test1.v1_cross(ci) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_cross(ci) VALUES('k')
ON DUPLICATE KEY UPDATE cu='u';
INSERT INTO test1.v1_cross(ci) SELECT 'k' FROM test1.single
ON DUPLICATE KEY UPDATE cu='u';
INSERT INTO test1.v1_cross(cn) VALUES('x');
INSERT INTO test1.v1_cross(cn) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_cross(cs) VALUES('x');
INSERT INTO test1.v1_cross(cs) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_cross(cu) VALUES('x');
INSERT INTO test1.v1_cross(cu) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_cross(cus) VALUES('x');
INSERT INTO test1.v1_cross(cus) SELECT 'x' FROM test1.single;
DELETE FROM test1.v1_cross;
DELETE FROM test1.v1_cross WHERE cs='0';
DELETE test1.v1_cross FROM test1.v1_cross, test1.single WHERE cs='0';
SELECT cs FROM test1.v1_multi;

SELECT cus FROM test1.v1_multi;
UPDATE test1.v1_multi SET cu='x';
UPDATE test1.v1_multi, test1.single SET cu='x';
UPDATE test1.v1_multi SET cus='x' WHERE cus='0';
UPDATE test1.v1_multi, test1.single SET cus='x' WHERE cus='0';
INSERT INTO test1.v1_multi(ci) VALUES('x');
INSERT INTO test1.v1_multi(ci) SELECT 'x' FROM test1.single;
INSERT INTO test1.v1_multi(ci) VALUES('x')
ON DUPLICATE KEY UPDATE cu='u';
INSERT INTO test1.v1_multi(ci) SELECT 'x' FROM test1.single
ON DUPLICATE KEY UPDATE cu='u';
DELETE FROM test1.v1_multi;
DELETE FROM test1.v1_multi WHERE cs='0';
DELETE test1.v1_multi FROM test1.v1_multi WHERE cs='0';
SELECT cn FROM test1.v1_renamed;
SELECT cs FROM test1.v1_renamed;
SELECT cus FROM test1.v1_renamed;
SELECT cx FROM test1.v1_renamed;
SELECT cy FROM test1.v1_renamed;
SELECT cs, cus FROM (SELECT * FROM test1.t1) AS dt;
SELECT * FROM (SELECT * FROM test1.t1) AS dt;
SELECT cn FROM (SELECT * FROM test1.t1) AS dt;
SELECT ci FROM (SELECT * FROM test1.t1) AS dt;
SELECT cu FROM (SELECT * FROM test1.t1) AS dt;

SELECT * FROM (SELECT cs, cus FROM test1.t1) AS dt;
SELECT cs, cus FROM (SELECT cs, cus FROM test1.t1) AS dt;
SELECT cx FROM (SELECT CONCAT(cs, cus) AS cx FROM test1.t1) AS dt;
SELECT * FROM (SELECT cn FROM test1.t1) AS dt;
SELECT * FROM (SELECT ci FROM test1.t1) AS dt;
SELECT * FROM (SELECT cu FROM test1.t1) AS dt;
SELECT * FROM (SELECT CONCAT(cs, cu) AS cx FROM test1.t1) AS dt;
SELECT * FROM (SELECT CONCAT(ci, cu) AS cx FROM test1.t1) AS dt;
SELECT cx FROM (SELECT CONCAT(cs, cu) AS cx FROM test1.t1) AS dt;
SELECT cx FROM (SELECT CONCAT(ci, cu) AS cx FROM test1.t1) AS dt;

DROP VIEW test1.v1_none, test1.v1_all, test1.v1_same;
DROP VIEW test1.v1_cross, test1.v1_middle, test1.v1_multi;
DROP VIEW test1.v1_renamed;

DROP USER user1@localhost;

-- SQL SECURITY DEFINER tests

CREATE USER user1@localhost;

-- SELECT privilege is required to create the views:
GRANT SELECT(cs) ON test1.t1 TO user1@localhost;

CREATE DEFINER=user1@localhost SQL SECURITY DEFINER VIEW test1.v1_none AS
SELECT cs FROM test1.t1;

CREATE DEFINER=user1@localhost SQL SECURITY DEFINER VIEW test1.v1_middle AS
SELECT cs FROM test1.t1;

CREATE DEFINER=user1@localhost SQL SECURITY DEFINER VIEW test1.v1_multi AS
SELECT * FROM test1.v1_middle;

-- Note that we're connected as root.
SELECT * FROM test1.t1 LIMIT 1;

-- user1 cannot see t1.cs
--error ER_VIEW_INVALID
SELECT cs FROM test1.v1_none;

-- user1 can see t1.cs
SELECT cs FROM test1.v1_none LIMIT 1;

-- user1 can see t1.cs but not v1_middle.cs
--error ER_VIEW_INVALID
SELECT cs FROM test1.v1_multi;

-- user1 can see t1.cs and v1_middle.cs
SELECT cs FROM test1.v1_multi LIMIT 1;

-- user1 cannot see t1.cs, can see v1_middle.cs
--error ER_VIEW_INVALID
SELECT cs FROM test1.v1_multi;

DROP USER user1@localhost;
DROP DATABASE test1;
CREATE DATABASE test1;
CREATE USER 'user1'@'localhost';
CREATE TABLE test1.t1 (cn CHAR(1), cs CHAR(1), ci CHAR(1), cu CHAR(1), cus CHAR(1));
CREATE SQL SECURITY INVOKER VIEW test1.v1_all AS
SELECT * FROM test1.t1;
SET sql_mode='STRICT_ALL_TABLES';
UPDATE test1.v1_all SET cn='x';
SET sql_mode='';
UPDATE test1.v1_all SET cn='x';
UPDATE IGNORE test1.v1_all SET cn='x';
CREATE VIEW v1 AS SELECT 1 FROM (SELECT 1) AS d1;
DROP PREPARE stmt;
DROP VIEW v1;
DROP USER 'user1'@'localhost';
DROP DATABASE test1;

set GLOBAL sql_mode= @orig_sql_mode_global;
set SESSION sql_mode= @orig_sql_mode_session;

-- Wait till we reached the initial number of concurrent sessions
--source include/wait_until_count_sessions.inc


--echo --
--echo -- WL#2284: Increase the length of a user name
--echo --


CREATE DATABASE test1;
CREATE TABLE test1.t1 (
  int_field INTEGER UNSIGNED NOT NULL,
  char_field CHAR(10),
  INDEX(`int_field`)
);

use test;

CREATE USER user_name_len_22_01234@localhost;
CREATE USER user_name_len_32_012345678901234@localhost;
SELECT * FROM test1.t1;
SELECT * FROM test1.t1;

CREATE DEFINER=user_name_len_32_012345678901234@localhost
  VIEW test1.v1 AS SELECT int_field FROM test1.t1;
SELECT * FROM test1.v1;
CREATE DEFINER=user_name_len_33_0123456789012345@localhost
  VIEW test1.v2 AS SELECT int_field FROM test1.t1;
DROP DATABASE test1;

DROP USER user_name_len_22_01234@localhost;
DROP USER user_name_len_32_012345678901234@localhost;
CREATE USER user_name_robert_golebiowski@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char;

CREATE TABLE silly_one (ID INT);
CREATE DEFINER=user_name_robert_golebiowski@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char VIEW silly_view AS SELECT * FROM silly_one;
SELECT DEFINER FROM information_schema.VIEWS WHERE TABLE_NAME='silly_view';

DROP USER user_name_robert_golebiowski@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char;
DROP VIEW silly_view;
DROP TABLE silly_one;

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1);

CREATE USER `u1`@`localhost`;
CREATE USER `u2`@`localhost`;
CREATE DEFINER=`u2`@`localhost` VIEW v1 AS SELECT a FROM t1;

let $OUTFILE = $MYSQLTEST_VARDIR/tmp/datadict.out;
DROP USER `u1`@`localhost`;
DROP USER `u2`@`localhost`;
DROP VIEW v1;
DROP TABLE t1;
