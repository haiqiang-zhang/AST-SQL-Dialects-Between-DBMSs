drop table if exists t1,t2,t7,t8,t9;
drop database if exists mysqltest;
create table t1 (a int not null auto_increment, b char(16) not null, primary key (a)) engine=myisam;
create table t2 (a int not null auto_increment, b char(16) not null, primary key (a)) engine=myisam;
insert into t1 (b) values ("test"),("test1"),("test2"),("test3");
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
drop table t2;
drop table t1;
create database mysqltest;
create table mysqltest.t9 (a int not null auto_increment, b char(16) not null, primary key (a)) 
engine=myisam index directory="/this-dir-does-not-exist";
drop database mysqltest;
create table t1 (a int not null) engine=myisam;
alter table t1 add b int;
drop table t1;
create table t1 (a int) engine=myisam select 42 a;
select * from t1;
select * from t1;
select * from t1;
drop table t1;
CREATE TABLE t1 (a INT) ENGINE MYISAM;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP SCHEMA schema1;
drop table if exists t1, t2;
CREATE DATABASE x;
DROP DATABASE x;
