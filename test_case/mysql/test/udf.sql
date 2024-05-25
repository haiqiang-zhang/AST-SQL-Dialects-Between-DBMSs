delete from t1;
insert into t1 values(100, 54.33), (200, 199.99);
drop table t1;
CREATE TABLE bug19904(n INT, v varchar(10));
INSERT INTO bug19904 VALUES (1,'one'),(2,'two'),(NULL,NULL),(3,'three'),(4,'four');
DROP TABLE bug19904;
create table t1(f1 int);
insert into t1 values(1),(2);
drop table t1;
CREATE TABLE t1(a INT, b INT);
DROP TABLE t1;
drop function if exists pi;
DROP FUNCTION IF EXISTS metaphon;
DROP FUNCTION IF EXISTS metaphon;
create table t1(sum int, price float(24));
drop table t1;
create table bug18761 (n int);
insert into bug18761 values (null),(2);
drop table bug18761;
drop function if exists is_const;
DROP DATABASE IF EXISTS mysqltest;
CREATE DATABASE mysqltest;
DROP DATABASE mysqltest;
CREATE TABLE const_len_bug (
  str_const varchar(4000),
  result1 varchar(4000),
  result2 varchar(4000)
);
SELECT * from const_len_bug;
DROP TABLE const_len_bug;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT PRIMARY KEY);
INSERT INTO t1 VALUES (4),(3),(2),(1);
INSERT INTO t2 SELECT * FROM t1;
DROP TABLE t1,t2;
drop function if exists metaphon;
create database db_31767;
drop database db_31767;
drop function if exists no_such_func;
drop procedure if exists no_such_proc;
CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES (1), (2), (3);
SELECT IF( a = 1, a, a ) AS `b` FROM t1 ORDER BY field( `b` + 1, 1 );
SELECT IF( a = 1, a, a ) AS `b` FROM t1 ORDER BY field( `b`, 1 );
DROP TABLE t1;
CREATE TABLE t1 (f1 INT);
INSERT INTO t1 VALUES(1),(50);
DROP TABLE t1;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for global read lock" AND
        info = "DROP FUNCTION metaphon";
UNLOCK TABLES;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for global read lock";
UNLOCK TABLES;
CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 values
(1, 1), (1, 2), (1, 200),
(2, 1), (2, 200), (2, 200), (2, 1000),
(3, 1), (3, 1), (3, 100), (3, 100), (3, 42);
DROP TABLE t1;
CREATE TABLE users(id INTEGER, name VARCHAR(255));
INSERT INTO users(id, name) VALUES (1, 'Jason'), (2, 'Brian');
CREATE TABLE user_values(id INTEGER, user_id INTEGER, value INTEGER);
INSERT INTO user_values(id, user_id, value) VALUES (1,1,1), (2,2,10);
DROP TABLE users, user_values;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1),(2),(3);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(fld1 INT);
DROP TABLE t1;
CREATE TABLE t1(f1 INTEGER, f2 INTEGER);
INSERT INTO t1 VALUES (1,100),(1,2),(2,100),(2,3);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4);
DROP TABLE t1;
