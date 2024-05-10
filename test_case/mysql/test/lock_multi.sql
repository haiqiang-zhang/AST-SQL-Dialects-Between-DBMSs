drop table if exists t1,t2;
create table t1(n int);
insert into t1 values (1);
select get_lock("mysqltest_lock", 100);
update t1 set n = 2 and get_lock('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and info = "update t1 set n = 2 and get_lock('mysqltest_lock', 100)";
update low_priority t1 set n = 4;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update low_priority t1 set n = 4";
select n from t1;
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
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and info = "select n from t1 where get_lock('mysqltest_lock', 100)";
update low_priority t1 set n = 4;
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
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and info = "select a from t1 where get_lock('mysqltest_lock', 100)";
update t1,t2 set c=a where b=d;
select c from t2;
select release_lock("mysqltest_lock");
select release_lock("mysqltest_lock");
select get_lock("mysqltest_lock", 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and info = "select c from t2 where get_lock('mysqltest_lock', 100)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update t1,t2 set c=a where b=d";
select release_lock("mysqltest_lock");
select release_lock("mysqltest_lock");
lock table t1 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "update t1,t2 set c=a where b=d";
unlock tables;
lock table t2 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "update t1,t2 set c=a where b=d";
unlock tables;
lock table t1 read;
lock tables t1 read, t2 write;
update t1,t2 set c=a where b=d;
unlock tables;
unlock tables;
drop table t1;
drop table t2;
create table t1 (a int);
create table t2 (a int);
lock table t1 write, t2 write;
insert t1 select * from t2;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert t1 select * from t2";
drop table t2;
unlock tables;
drop table t1;
create table t1 (a int);
create table t2 (a int);
lock table t1 write, t2 write, t1 as t1_2 write, t2 as t2_2 write;
insert t1 select * from t2;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert t1 select * from t2";
drop table t2;
unlock tables;
drop table t1;
create table t1(a int);
lock tables t1 write;
unlock tables;
drop table t1;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND info =
  "SELECT user.Select_priv FROM user, db WHERE user.user = db.user LIMIT 1";
UNLOCK TABLES;
CREATE TABLE t1 (c1 int);
LOCK TABLE t1 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "FLUSH TABLES WITH READ LOCK";
UNLOCK TABLES;
UNLOCK TABLES;
DROP TABLE t1;
CREATE TABLE t1 (c1 int);
LOCK TABLE t1 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "FLUSH TABLES WITH READ LOCK";
UNLOCK TABLES;
UNLOCK TABLES;
DROP TABLE t1;
CREATE DATABASE mysqltest_1;
DROP DATABASE mysqltest_1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock"
  and info = "DROP DATABASE mysqltest_1";
UNLOCK TABLES;
create table t1 (f1 int(12) unsigned not null auto_increment, primary key(f1)) engine=innodb;
lock tables t1 write;
alter table t1 auto_increment=0;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 auto_increment=0";
alter table t1 auto_increment=0;
select count(*) = 2 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 auto_increment=0";
unlock tables;
drop table t1;
create table t1 (a int);
create table t2 like t1;
lock tables t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "flush tables with read lock";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "select * from t2 for update";
unlock tables;
unlock tables;
drop table t1,t2;
create table t1 (a int);
create table t2 like t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "update t2 set a = 1";
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "lock tables t2 write";
unlock tables;
unlock tables;
drop table t1,t2;
create table t1 (i int);
insert into t1 values (1);
select get_lock('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "select * from t1 where get_lock('mysqltest_lock', 100)";
update t1 set i= 10;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update t1 set i= 10";
select * from t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "select * from t1";
select release_lock('mysqltest_lock');
select release_lock('mysqltest_lock');
drop table t1;
drop table if exists t1;
create table t1 (a int) ENGINE=MEMORY;
drop table t1;
drop table if exists t1;
create table t1 (i int);
lock tables t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "flush tables with read lock";
alter table t1 add column j int;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "flush tables with read lock";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "insert into t1 values (1,2)";
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "insert into t1 values (1,2)";
select * from t1;
unlock tables;
select count(*) = 1 from t1;
select * from t1;
drop table t1;
drop table if exists t1;
create table t1 (i int);
lock tables t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock";
unlock tables;
drop table t1;
drop table if exists t1,t2;
create table t1 (a int);
insert into t1 values (1);
select get_lock('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "select * from t1 where get_lock('mysqltest_lock', 100)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "update t1 set a= 2";
select release_lock('mysqltest_lock');
select release_lock('mysqltest_lock');
drop table t1;
select @tlwa < @tlwb;
drop table if exists t1;
create table t1 (i int);
lock tables t1 write;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock";
drop table t1;
drop table if exists t1;
create table t1 (c1 int primary key, c2 int, c3 int);
insert into t1 values (1,1,0),(2,2,0),(3,3,0),(4,4,0),(5,5,0);
update t1 set c3=c3+1 where c2=3;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c4 int";
update t1 set c3=c3+1 where c2=4;
drop table t1;
DROP TABLE IF EXISTS t1;
DROP VIEW  IF EXISTS v1;
CREATE TABLE t1 ( f1 integer );
CREATE VIEW v1 AS SELECT f1 FROM t1;
LOCK TABLES v1 WRITE, t1 READ;
LOCK TABLES t1 WRITE;
UNLOCK TABLES;
DROP TABLE t1;
DROP VIEW v1;
CREATE TABLE t1 ( f1 integer );
CREATE VIEW v1 AS SELECT f1 FROM t1;
LOCK TABLES t1 WRITE, v1 READ;
LOCK TABLES t1 WRITE;
DROP TABLE t1;
DROP VIEW v1;
drop table if exists t1;
drop view if exists v1;
create table t1 (i int);
create view v1 as select i from t1;
select * from t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column j int";
delete a from t1 as a where i = 1;
select * from v1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 drop column j";
insert into v1 values (1);
drop view v1;
drop table t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id int);
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
UNLOCK TABLES;
UNLOCK TABLES;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table flush" AND info = "FLUSH TABLES";
UNLOCK TABLES;
CREATE TABLE t2 (id INT);
LOCK TABLE t2 WRITE;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "DROP TABLE t1, t2";
SELECT table_name, table_rows, table_comment FROM information_schema.tables
  WHERE table_schema= 'test' AND table_name= 't1';
UNLOCK TABLES;
drop tables if exists t1, t2, t3;
create table t3 (i int);
lock table t3 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename tables t1 to t2, t2 to t3";
unlock tables;
drop table t3;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT);
LOCK TABLE t1 WRITE;
CREATE TEMPORARY TABLE t1 (id INT);
ALTER TABLE t1 ADD COLUMN j INT;
UNLOCK TABLES;
DROP TABLE t1;
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
CREATE TABLE t7 (z INT);
CREATE TABLE t8 (z INT);
LOCK TABLE t1 READ, t2 READ;
SELECT * FROM t1;
SELECT * FROM t2;
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1, t2";
LOCK TABLES t1 READ, t2 READ;
UNLOCK TABLES;
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
LOCK TABLE t1 READ, t2 READ;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 READ";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 READ";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
LOCK TABLES t1 READ;
UNLOCK TABLES;
SELECT * FROM t2;
LOCK TABLES t2 READ;
UNLOCK TABLES;
INSERT INTO t1 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 READ";
UNLOCK TABLES;
INSERT INTO t2 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 READ";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
LOCK TABLES t1 READ, t2 READ;
LOCK TABLES t1 READ, t2 READ;
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t1 READ;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t2 READ;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t1 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 READ";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t2 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 READ";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLE t1 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t1";
UNLOCK TABLES;
LOCK TABLE t2 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t2";
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
UNLOCK TABLES;
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t2";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
UNLOCK TABLES;
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
LOCK TABLE t1 WRITE, t2 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
UNLOCK TABLES;
SELECT * FROM t2;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
UNLOCK TABLES;
INSERT INTO t1 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
UNLOCK TABLES;
INSERT INTO t2 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
LOCK TABLES t1 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t2 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLE v1 READ, v2 READ;
SELECT * FROM t1;
SELECT * FROM t2;
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1, t2";
LOCK TABLES v1 READ, v2 READ;
UNLOCK TABLES;
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
LOCK TABLE v1 READ, v2 READ;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 READ";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 READ";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
LOCK TABLES v1 READ;
UNLOCK TABLES;
SELECT * FROM t2;
LOCK TABLES v2 READ;
UNLOCK TABLES;
INSERT INTO t1 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 READ";
UNLOCK TABLES;
INSERT INTO t2 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 READ";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
LOCK TABLES t1 READ, t2 READ;
LOCK TABLES v1 READ, v2 READ;
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES v1 READ;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES v2 READ;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t1 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 READ";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t2 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 READ";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES v3 WRITE, v4 WRITE;
SELECT * FROM t1;
SELECT * FROM t2;
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1, t2";
LOCK TABLES v3 WRITE, v4 WRITE;
UNLOCK TABLES;
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
LOCK TABLES v3 WRITE, v4 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v3 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v4 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
LOCK TABLES v3 WRITE;
UNLOCK TABLES;
SELECT * FROM t2;
LOCK TABLES v4 WRITE;
UNLOCK TABLES;
INSERT INTO t1 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v3 WRITE";
UNLOCK TABLES;
INSERT INTO t2 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v4 WRITE";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
LOCK TABLES t1 READ, t2 READ;
LOCK TABLES v3 WRITE, v4 WRITE;
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES v3 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES v4 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t1 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v3 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t2 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v4 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLE v1 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t1";
UNLOCK TABLES;
LOCK TABLE v2 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t2";
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 WRITE";
UNLOCK TABLES;
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t2";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 WRITE";
UNLOCK TABLES;
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
LOCK TABLE v1 WRITE, v2 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 WRITE";
UNLOCK TABLES;
SELECT * FROM t2;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 WRITE";
UNLOCK TABLES;
INSERT INTO t1 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v1 WRITE";
UNLOCK TABLES;
INSERT INTO t2 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES v2 WRITE";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
LOCK TABLES v1 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES v2 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t5 WRITE, t6 WRITE;
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1, t2";
LOCK TABLES v3 WRITE, t6 WRITE;
UNLOCK TABLES;
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
LOCK TABLES t5 WRITE, t6 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t5 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t6 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
LOCK TABLES t5 WRITE;
UNLOCK TABLES;
SELECT * FROM t2;
LOCK TABLES t6 WRITE;
UNLOCK TABLES;
INSERT INTO t1 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t5 WRITE";
UNLOCK TABLES;
INSERT INTO t2 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t6 WRITE";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
LOCK TABLES t1 READ, t2 READ;
LOCK TABLES t5 WRITE, t6 WRITE;
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t5 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t6 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t1 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t5 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t2 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t6 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLE t7 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t1";
UNLOCK TABLES;
LOCK TABLE t8 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t2";
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t7 WRITE";
UNLOCK TABLES;
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "SELECT GET_LOCK('mysqltest_lock', 100) FROM t2";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t8 WRITE";
UNLOCK TABLES;
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
LOCK TABLE t7 WRITE, t8 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t1 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t7 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "INSERT INTO t2 VALUES (GET_LOCK('mysqltest_lock', 100))";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t8 WRITE";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
SELECT * FROM t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t7 WRITE";
UNLOCK TABLES;
SELECT * FROM t2;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t8 WRITE";
UNLOCK TABLES;
INSERT INTO t1 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t7 WRITE";
UNLOCK TABLES;
INSERT INTO t2 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t8 WRITE";
UNLOCK TABLES;
DELETE FROM t1 LIMIT 1;
DELETE FROM t2 LIMIT 1;
LOCK TABLES t7 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t1 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
LOCK TABLES t8 WRITE;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLES t2 WRITE";
UNLOCK TABLES;
UNLOCK TABLES;
DROP VIEW v1, v2, v3, v4;
DROP TABLES t1, t2, t3, t4, t5, t6, t7, t8;
CREATE TABLE t1 (i INT) ENGINE=MyISAM;
CREATE TABLE t2 (i INT) ENGINE=InnoDB;
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS (SELECT * FROM t1) UNION (SELECT * FROM t1);
CREATE VIEW v3 AS SELECT * FROM t2;
LOCK TABLE t1 READ LOCAL;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "UPDATE t1 SET i= 2";
UNLOCK TABLES;
LOCK TABLE v1 READ LOCAL;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
        info = "UPDATE t1 SET i= 2";
UNLOCK TABLES;
LOCK TABLE v2 READ LOCAL;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
UNLOCK TABLES;
LOCK TABLE v2 READ LOCAL;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE t1 SET i= 2";
UNLOCK TABLES;
LOCK TABLE t2 READ LOCAL;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
UNLOCK TABLES;
LOCK TABLE t2 READ LOCAL;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE t2 SET i= 2";
UNLOCK TABLES;
LOCK TABLE v3 READ LOCAL;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
UNLOCK TABLES;
LOCK TABLE v3 READ LOCAL;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE t2 SET i= 2";
UNLOCK TABLES;
DROP VIEW v1, v2, v3;
DROP TABLES t1, t2;
CREATE TABLE t1 (i INT) ENGINE=MyISAM;
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE TABLE t2 (j INT);
CREATE TABLE t3 (k INT);
CREATE TABLE tm (i INT) ENGINE=MERGE UNION=(t1);
INSERT INTO t1 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLE t1 READ";
INSERT HIGH_PRIORITY INTO t1 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT LOW_PRIORITY INTO t1 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "REPLACE LOW_PRIORITY INTO t1 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE LOW_PRIORITY t1 SET i= 1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE LOW_PRIORITY t1 AS a, t1 AS b SET a.i= 1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE LOW_PRIORITY FROM t1 LIMIT 1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE LOW_PRIORITY FROM a USING t1 AS a, t1 AS b";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOAD DATA LOW_PRIORITY INFILE '../../std_data/rpl_loaddata.dat' INTO TABLE t1 (@dummy,i)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE LOW_PRIORITY FROM v1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t2 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE LOW_PRIORITY FROM tm LIMIT 1";
UNLOCK TABLES;
INSERT INTO t1 VALUES (0);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOCK TABLE t1 READ";
INSERT HIGH_PRIORITY INTO t1 VALUES (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t1 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "REPLACE INTO t1 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE t1 SET i= 1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "UPDATE t1 AS a, t1 AS b SET a.i= 1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE FROM t1 LIMIT 1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE FROM a USING t1 AS a, t1 AS b";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "LOAD DATA INFILE '../../std_data/rpl_loaddata.dat' INTO TABLE t1 (@dummy,i)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE FROM v1";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "INSERT INTO t3 VALUES (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "DELETE FROM tm LIMIT 1";
UNLOCK TABLES;
DROP VIEW v1;
DROP TABLES tm, t2, t3, t1;
create table t1(i int);
create table t2(i int);
create table t3(i int);
create table t4(i int);
lock tables t1 write, t3 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert into t3 values (1)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t2 to t0, t4 to t2, t0 to t4";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "PREPARE stmt1 FROM ...";
alter table t1 add column j int;
unlock tables;
drop tables t1, t2, t3, t4;
