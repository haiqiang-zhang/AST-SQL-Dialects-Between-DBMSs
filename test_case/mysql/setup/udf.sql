drop table if exists t1;
create table t1(sum int, price float(24));
insert into t1 values(100, 50.00), (100, 100.00);
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
