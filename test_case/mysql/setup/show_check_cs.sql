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
