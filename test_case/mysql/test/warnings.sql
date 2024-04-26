set @@session.sql_mode='';

drop table if exists t1, t2;
SET SQL_WARNINGS=1;

create table t1 (a int);
create table t1 (a int);
create table t2(a int) default charset qwerty;
create table t (i);
insert into t1 values (1);
insert ignore into t1 values ("hej");
insert ignore into t1 values ("hej"),("då");
set SQL_WARNINGS=1;
insert ignore into t1 values ("hej");
insert ignore into t1 values ("hej"),("då");
drop table t1;
set SQL_WARNINGS=0;

--
-- Test other warnings
--

drop temporary table if exists not_exists;
drop table if exists not_exists_table;
drop database if exists not_exists_db;
create table t1(id int);
create table if not exists t1(id int);
select @@warning_count;
drop table t1;

--
-- Test warnings for LOAD DATA INFILE
--
create table t1(a tinyint, b int not null, c date, d char(5));
select @@warning_count;
drop table t1;

--
-- Warnings from basic INSERT, UPDATE and ALTER commands
--

create table t1(a tinyint NOT NULL, b tinyint unsigned, c char(5));
insert ignore into t1 values(NULL,100,'mysql'),(10,-1,'mysql ab'),(500,256,'open source'),(20,NULL,'test');
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
alter table t1 modify c char(4);
SET sql_mode = default;
alter table t1 add d char(2);
update ignore t1 set a=NULL where a=10;
update ignore t1 set c='mysql ab' where c='test';
update ignore t1 set d=c;
create table t2(a tinyint NOT NULL, b char(3));
insert ignore into t2 select b,c from t1;
insert ignore into t2(b) values('mysqlab');
set sql_warnings=1;
insert ignore into t2(b) values('mysqlab');
set sql_warnings=0;
drop table t1, t2;

--
-- Test for max_error_count
--

create table t1(a char(10));
let $1=50;
{
  eval insert into t1 values('mysql ab');
  dec $1;
alter table t1 add b char;
set max_error_count=10;
update ignore t1 set b=a;
select @@warning_count;

-- Bug#9072
set max_error_count=0;
update ignore t1 set b='hi';
select @@warning_count;
set max_error_count=65535;
set max_error_count=10;

drop table t1;

--
-- Tests for show warnings limit a, b
--
create table t1 (a int);
insert into t1 (a) values (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
update ignore t1 set a='abc';
select * from t1 limit 0;
select * from t1 limit 1, 0;
select * from t1 limit 0, 0;
drop table t1;

--
-- Bug#20778: strange characters in warning message 1366 when called in SP
--

CREATE TABLE t1( f1 CHAR(20) );
CREATE TABLE t2( f1 CHAR(20), f2 CHAR(25) );
CREATE TABLE t3( f1 CHAR(20), f2 CHAR(25), f3 DATE );

INSERT INTO t1 VALUES ( 'a`' );
INSERT INTO t2 VALUES ( 'a`', 'a`' );
INSERT INTO t3 VALUES ( 'a`', 'a`', '1000-01-1' );

DROP PROCEDURE IF EXISTS sp1;
DROP PROCEDURE IF EXISTS sp2;
DROP PROCEDURE IF EXISTS sp3;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE PROCEDURE sp1()
BEGIN
   DECLARE x NUMERIC ZEROFILL;
   SELECT f1 INTO x FROM t1 LIMIT 1;
CREATE PROCEDURE sp2()
BEGIN
   DECLARE x NUMERIC ZEROFILL;
   SELECT f1 INTO x FROM t2 LIMIT 1;
CREATE PROCEDURE sp3()
BEGIN
   DECLARE x NUMERIC ZEROFILL;
   SELECT f1 INTO x FROM t3 LIMIT 1;

DROP PROCEDURE IF EXISTS sp1;
CREATE PROCEDURE sp1()
BEGIN
declare x numeric unsigned zerofill;
SELECT f1 into x from t2 limit 1;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP PROCEDURE sp1;
DROP PROCEDURE sp2;
DROP PROCEDURE sp3;
SET sql_mode = default;

--
-- Bug#30059: End-space truncation warnings are inconsistent or incorrect
--

create table t1 (c_char char(255), c_varchar varchar(255), c_tinytext tinytext);
create table t2 (c_tinyblob tinyblob);
set @c = repeat(' ', 256);
set @q = repeat('q', 256);

set sql_mode = '';

insert into t1 values(@c, @c, @c);
insert into t2 values(@c);
insert into t1 values(@q, @q, @q);
insert into t2 values(@q);

set sql_mode = 'traditional';

insert into t1 values(@c, @c, @c);
insert into t2 values(@c);
insert into t1 values(@q, NULL, NULL);
insert into t1 values(NULL, @q, NULL);
insert into t1 values(NULL, NULL, @q);
insert into t2 values(@q);

drop table t1, t2;

--
-- Bug#42364 SHOW ERRORS returns empty resultset after dropping non existent table
--
--error ER_BAD_TABLE_ERROR
DROP TABLE t1;

--
-- Bug#55847: SHOW WARNINGS returns empty result set when SQLEXCEPTION is active
--

--echo
--echo -- Bug--55847
--echo

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP FUNCTION IF EXISTS f1;

CREATE TABLE t1(a INT UNIQUE);

CREATE FUNCTION f1(x INT) RETURNS INT
BEGIN
  INSERT INTO t1 VALUES(x);
  INSERT INTO t1 VALUES(x);

DROP TABLE t1;
DROP FUNCTION f1;
