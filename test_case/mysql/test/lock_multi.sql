
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--disable_warnings
drop table if exists t1,t2;

-- Test to see if select will get the lock ahead of low priority update

connect (locker,localhost,root,,);
create table t1(n int);
insert into t1 values (1);
select get_lock("mysqltest_lock", 100);
update t1 set n = 2 and get_lock('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and info = "update t1 set n = 2 and get_lock('mysqltest_lock', 100)";
update low_priority t1 set n = 4;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update low_priority t1 set n = 4";
select n from t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "select n from t1";
select release_lock("mysqltest_lock");
select release_lock("mysqltest_lock");
drop table t1;
create table t1(n int);
insert into t1 values (1);
select get_lock("mysqltest_lock", 100);
select n from t1 where get_lock('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and info = "select n from t1 where get_lock('mysqltest_lock', 100)";
update low_priority t1 set n = 4;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update low_priority t1 set n = 4";
select n from t1;
select release_lock("mysqltest_lock");
select release_lock("mysqltest_lock");
drop table t1;
create table t1 (a int, b int);
create table t2 (c int, d int);
insert into t1 values(1,1);
insert into t1 values(2,2);
insert into t2 values(1,2);
select get_lock("mysqltest_lock", 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and info = "select a from t1 where get_lock('mysqltest_lock', 100)";
update t1,t2 set c=a where b=d;
select c from t2;
select release_lock("mysqltest_lock");
select release_lock("mysqltest_lock");
select get_lock("mysqltest_lock", 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and info = "select c from t2 where get_lock('mysqltest_lock', 100)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update t1,t2 set c=a where b=d";
select release_lock("mysqltest_lock");
select release_lock("mysqltest_lock");
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "update t1,t2 set c=a where b=d";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "update t1,t2 set c=a where b=d";
update t1,t2 set c=a where b=d;
drop table t1;
drop table t2;


--
-- Test problem when using locks on many tables and dropping a table that
-- is to-be-locked by another thread
--
--
connection locker;
create table t1 (a int);
create table t2 (a int);
insert t1 select * from t2;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert t1 select * from t2";
drop table t2;
drop table t1;

--
-- Same test as above, but with the dropped table locked twice
--

connection locker;
create table t1 (a int);
create table t2 (a int);
insert t1 select * from t2;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert t1 select * from t2";
drop table t2;
drop table t1;

--
-- Bug#9998 MySQL client hangs on USE "database"
--
create table t1(a int);
drop table t1;

--
-- Bug#16986 Deadlock condition with MyISAM tables
--

-- Need a matching user in mysql.user for multi-table select
--source include/add_anonymous_users.inc

connection locker;
USE mysql;
USE mysql;
SELECT user.Select_priv FROM user, db WHERE user.user = db.user LIMIT 1;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND info =
  "SELECT user.Select_priv FROM user, db WHERE user.user = db.user LIMIT 1";
USE test;
use test;
CREATE TABLE t1 (c1 int);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "FLUSH TABLES WITH READ LOCK";
CREATE TABLE t2 (c1 int);
DROP TABLE t1;
CREATE TABLE t1 (c1 int);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "FLUSH TABLES WITH READ LOCK";
CREATE TABLE t2 AS SELECT * FROM t1;
DROP TABLE t1;

--
-- Bug#19815 CREATE/RENAME/DROP DATABASE can deadlock on a global read lock
--
connect (con1,localhost,root,,);
CREATE DATABASE mysqltest_1;
DROP DATABASE mysqltest_1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock"
  and info = "DROP DATABASE mysqltest_1";
DROP DATABASE mysqltest_1;
DROP DATABASE mysqltest_1;

--
-- Bug#17264 MySQL Server freeze
--
connection locker;
create table t1 (f1 int(12) unsigned not null auto_increment, primary key(f1)) engine=innodb;
alter table t1 auto_increment=0;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 auto_increment=0";
alter table t1 auto_increment=0;
let $wait_condition=
  select count(*) = 2 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 auto_increment=0";
drop table t1;

--
-- Bug#43230: SELECT ... FOR UPDATE can hang with FLUSH TABLES WITH READ LOCK indefinitely
--

connect (con1,localhost,root,,);

create table t1 (a int);
create table t2 like t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "flush tables with read lock";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "select * from t2 for update";

drop table t1,t2;

create table t1 (a int);
create table t2 like t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "update t2 set a = 1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "lock tables t2 write";

drop table t1,t2;


--
-- Bug#21281 Pending write lock is incorrectly removed when its
--           statement being KILLed
--
create table t1 (i int);
insert into t1 values (1);
select get_lock('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "select * from t1 where get_lock('mysqltest_lock', 100)";
update t1 set i= 10;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update t1 set i= 10";
select * from t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "select * from t1";
let $ID= `select id from information_schema.processlist
          where state = "Waiting for table level lock" and
                info = "update t1 set i= 10"`;
select release_lock('mysqltest_lock');
select release_lock('mysqltest_lock');
drop table t1;

--
-- Bug#25856 HANDLER table OPEN in one connection lock DROP TABLE in another one
--
--disable_warnings
drop table if exists t1;
create table t1 (a int) ENGINE=MEMORY;
drop table t1;


-- Disconnect sessions used in many subtests above
disconnect locker;


--
-- Bug#32395 Alter table under a impending global read lock causes a server crash
--

--
-- Test ALTER TABLE under LOCK TABLES and FLUSH TABLES WITH READ LOCK
--

--disable_warnings
drop table if exists t1;
create table t1 (i int);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "flush tables with read lock";
alter table t1 add column j int;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "flush tables with read lock";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "insert into t1 values (1,2)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "insert into t1 values (1,2)";
select * from t1;
let $wait_condition=
  select count(*) = 1 from t1;
select * from t1;
drop table t1;

--
-- Test that FLUSH TABLES under LOCK TABLES protects write locked tables
-- from a impending FLUSH TABLES WITH READ LOCK
--

--disable_warnings
drop table if exists t1;
create table t1 (i int);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock";
drop table t1;

--
-- Bug#30331 Table_locks_waited shows inaccurate values
--

--disable_warnings
drop table if exists t1,t2;
create table t1 (a int);
insert into t1 values (1);
select get_lock('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "select * from t1 where get_lock('mysqltest_lock', 100)";

let $tlwa= `show status like 'Table_locks_waited'`;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update t1 set a= 2";
let $tlwb= `show status like 'Table_locks_waited'`;
select release_lock('mysqltest_lock');
select release_lock('mysqltest_lock');
drop table t1;
select @tlwa < @tlwb;

--
-- Test that DROP TABLES does not wait for a impending FLUSH TABLES
-- WITH READ LOCK
--

--disable_warnings
drop table if exists t1;
create table t1 (i int);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock";
drop table t1;
drop table if exists t1;
create table t1 (c1 int primary key, c2 int, c3 int);
insert into t1 values (1,1,0),(2,2,0),(3,3,0),(4,4,0),(5,5,0);
update t1 set c3=c3+1 where c2=3;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c4 int";
update t1 set c3=c3+1 where c2=4;
drop table t1;
DROP TABLE IF EXISTS t1;
DROP VIEW  IF EXISTS v1;

CREATE TABLE t1 ( f1 integer );
CREATE VIEW v1 AS SELECT f1 FROM t1 ;

-- Cleanup
DROP TABLE t1;
DROP VIEW v1;

CREATE TABLE t1 ( f1 integer );
CREATE VIEW v1 AS SELECT f1 FROM t1 ;

-- Cleanup
DROP TABLE t1;
DROP VIEW v1;
drop table if exists t1;
drop view if exists v1;
create table t1 (i int);
create view v1 as select i from t1;
select * from t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column j int";
delete a from t1 as a where i = 1;
select * from v1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 drop column j";
insert into v1 values (1);
drop view v1;
drop table t1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (id int);
SET SESSION lock_wait_timeout= 1;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
SELECT * FROM t1;
ALTER TABLE t1 RENAME TO t2;
INSERT INTO t1(id) VALUES (2);
INSERT INTO t1(id) VALUES(4);
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table flush" AND info = "FLUSH TABLES";
SELECT * FROM t1;
CREATE TABLE t2 (id INT);
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "DROP TABLE t1, t2";
SET SESSION information_schema_stats_expiry=0;
SELECT table_name, table_rows, table_comment FROM information_schema.tables
  WHERE table_schema= 'test' AND table_name= 't1';
SET SESSION information_schema_stats_expiry=default;
drop tables if exists t1, t2, t3;
create table t3 (i int);
let $ID= `select connection_id()`;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename tables t1 to t2, t2 to t3";
drop table t3;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (id INT);
CREATE TEMPORARY TABLE t1 (id INT);
ALTER TABLE t1 ADD COLUMN j INT;
DROP TABLE t1;
CREATE TABLE t1 (i INT) ENGINE=MyISAM;
CREATE TABLE t2 (i INT) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1);
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM t2;
CREATE TABLE t3 (j INT);
CREATE TABLE t4 (j INT);
CREATE VIEW v3 AS SELECT * FROM t3 WHERE (SELECT COUNT(*) FROM t1);
CREATE VIEW v4 AS SELECT * FROM t4 WHERE (SELECT COUNT(*) FROM t2);
CREATE TABLE t5 (k INT);
CREATE TABLE t6 (k INT);
CREATE TRIGGER bi_t5 BEFORE INSERT ON t5 FOR EACH ROW SET @a:= (SELECT COUNT(*) FROM t1);
CREATE TRIGGER bi_t6 BEFORE INSERT ON t6 FOR EACH ROW SET @a:= (SELECT COUNT(*) FROM t2);
CREATE TABLE t7 (z INT);
CREATE TABLE t8 (z INT);
CREATE TRIGGER bi_t7 BEFORE INSERT ON t7 FOR EACH ROW INSERT INTO t1 VALUES (1);
CREATE TRIGGER bi_t8 BEFORE INSERT ON t8 FOR EACH ROW INSERT INTO t2 VALUES (1);
SELECT * FROM t1;
SELECT * FROM t2;
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1, t2";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 READ";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');

SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 READ";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t1 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 READ";
INSERT INTO t2 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 READ";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 READ";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 READ";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t2";
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');

SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
SELECT * FROM t2;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
INSERT INTO t1 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
INSERT INTO t2 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
SELECT * FROM t1;
SELECT * FROM t2;
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1, t2";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 READ";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');

SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 READ";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t1 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 READ";
INSERT INTO t2 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 READ";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 READ";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 READ";
SELECT * FROM t1;
SELECT * FROM t2;
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1, t2";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v3 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');

SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v4 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t1 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v3 WRITE";
INSERT INTO t2 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v4 WRITE";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v3 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v4 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t2";
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');

SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 WRITE";
SELECT * FROM t2;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 WRITE";
INSERT INTO t1 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 WRITE";
INSERT INTO t2 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 WRITE";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
SELECT * FROM t1;
SELECT * FROM t2;
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1, t2";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t5 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');

SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t6 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t1 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t5 WRITE";
INSERT INTO t2 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t6 WRITE";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t5 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t6 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t2";
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t7 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t8 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t7 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');

SELECT GET_LOCK('mysqltest_lock', 100);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t8 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t7 WRITE";
SELECT * FROM t2;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t8 WRITE";
INSERT INTO t1 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t7 WRITE";
INSERT INTO t2 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t8 WRITE";
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";

DROP VIEW v1, v2, v3, v4;
DROP TABLES t1, t2, t3, t4, t5, t6, t7, t8;
SET @old_concurrent_insert= @@global.concurrent_insert;
SET @@global.concurrent_insert= 1;
CREATE TABLE t1 (i INT) ENGINE=MyISAM;
CREATE TABLE t2 (i INT) ENGINE=InnoDB;
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS (SELECT * FROM t1) UNION (SELECT * FROM t1);
CREATE VIEW v3 AS SELECT * FROM t2;
INSERT INTO t1 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "UPDATE t1 SET i= 2";
INSERT INTO v1 VALUES (1);
INSERT INTO t1 VALUES (3);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "UPDATE t1 SET i= 2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE t1 SET i= 2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE t2 SET i= 2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE t2 SET i= 2";
DROP VIEW v1, v2, v3;
DROP TABLES t1, t2;
SET @@global.concurrent_insert= @old_concurrent_insert;
CREATE TABLE t1 (i INT) ENGINE=MyISAM;
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE TABLE t2 (j INT);
CREATE TRIGGER t2_ai AFTER INSERT ON t2 FOR EACH ROW
  INSERT LOW_PRIORITY INTO t1 VALUES (2);
CREATE TABLE t3 (k INT);
CREATE TRIGGER t3_ai AFTER INSERT ON t3 FOR EACH ROW
  INSERT INTO t1 VALUES (2);
CREATE TABLE tm (i INT) ENGINE=MERGE UNION=(t1);
INSERT INTO t1 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLE t1 READ";
INSERT HIGH_PRIORITY INTO t1 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT LOW_PRIORITY INTO t1 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "REPLACE LOW_PRIORITY INTO t1 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE LOW_PRIORITY t1 SET i= 1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE LOW_PRIORITY t1 AS a, t1 AS b SET a.i= 1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE LOW_PRIORITY FROM t1 LIMIT 1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE LOW_PRIORITY FROM a USING t1 AS a, t1 AS b";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOAD DATA LOW_PRIORITY INFILE '../../std_data/rpl_loaddata.dat' INTO TABLE t1 (@dummy,i)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE LOW_PRIORITY FROM v1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE LOW_PRIORITY FROM tm LIMIT 1";
INSERT INTO t1 VALUES (0);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLE t1 READ";
SET @@session.low_priority_updates= 1;
INSERT HIGH_PRIORITY INTO t1 VALUES (1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
SET @@session.low_priority_updates= 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "REPLACE INTO t1 VALUES (1)";
SET @@session.low_priority_updates= 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE t1 SET i= 1";
SET @@session.low_priority_updates= 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE t1 AS a, t1 AS b SET a.i= 1";
SET @@session.low_priority_updates= 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE FROM t1 LIMIT 1";
SET @@session.low_priority_updates= 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE FROM a USING t1 AS a, t1 AS b";
SET @@session.low_priority_updates= 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOAD DATA INFILE '../../std_data/rpl_loaddata.dat' INTO TABLE t1 (@dummy,i)";
SET @@session.low_priority_updates= 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE FROM v1";
SET @@session.low_priority_updates= 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t3 VALUES (1)";
SET @@session.low_priority_updates= 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE FROM tm LIMIT 1";

DROP VIEW v1;
DROP TABLES tm, t2, t3, t1;

create table t1(i int);
create table t2(i int);
create table t3(i int);
create table t4(i int);
select count(*) from t4;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert into t3 values (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t2 to t0, t4 to t2, t0 to t4";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "PREPARE stmt1 FROM ...";
alter table t1 add column j int;
drop tables t1, t2, t3, t4;
