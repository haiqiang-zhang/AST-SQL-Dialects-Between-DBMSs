select 1;
create database mysqltest1;
drop database mysqltest1;
create table t1 (a int);
drop table t1;
CREATE TABLE t1 (a int );
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 LIKE t1;
CREATE TABLE t4 LIKE t1;
CREATE TABLE t5 LIKE t1;
CREATE TABLE t6 LIKE t1;
CREATE TABLE t7 LIKE t1;
CREATE TABLE t8 LIKE t1;
CREATE TABLE t9 LIKE t1;
CREATE TABLE t10 LIKE t1;
CREATE DATABASE testdb1;
CREATE DATABASE testdb2;
CREATE DATABASE testdb3;
CREATE DATABASE testdb4;
CREATE DATABASE testdb5;
CREATE DATABASE testdb6;
CREATE DATABASE testdb7;
CREATE DATABASE testdb8;
CREATE DATABASE testdb9;
CREATE DATABASE testdb10;
DROP TABLE t1,t2,t3,t4,t5,t6,t7,t8,t9,t10;
DROP DATABASE testdb1;
DROP DATABASE testdb2;
DROP DATABASE testdb3;
DROP DATABASE testdb4;
DROP DATABASE testdb5;
DROP DATABASE testdb6;
DROP DATABASE testdb7;
DROP DATABASE testdb8;
DROP DATABASE testdb9;
DROP DATABASE testdb10;
create table t1(a int, b int, c int, d int);
drop table t1;
create database mysqltest_1;
create database mysqltest_2;
SELECT * FROM INFORMATION_SCHEMA.COLUMN_PRIVILEGES
 WHERE GRANTEE = '''mysqltest_3''@''localhost'''
 ORDER BY TABLE_NAME,COLUMN_NAME,PRIVILEGE_TYPE;
SELECT * FROM INFORMATION_SCHEMA.TABLE_PRIVILEGES
 WHERE GRANTEE = '''mysqltest_3''@''localhost'''
 ORDER BY TABLE_NAME,PRIVILEGE_TYPE;
SELECT * from INFORMATION_SCHEMA.SCHEMA_PRIVILEGES
 WHERE GRANTEE = '''mysqltest_3''@''localhost'''
 ORDER BY TABLE_SCHEMA,PRIVILEGE_TYPE;
SELECT * from INFORMATION_SCHEMA.USER_PRIVILEGES
 WHERE GRANTEE = '''mysqltest_3''@''localhost'''
 ORDER BY TABLE_CATALOG,PRIVILEGE_TYPE;
drop database mysqltest_1;
drop database mysqltest_2;
create database mysqltest;
create table mysqltest.t1 (a int,b int,c int);
drop database mysqltest;
CREATE DATABASE mysqltest;
CREATE TABLE mysqltest.dummytable (dummyfield INT);
DROP DATABASE mysqltest;
CREATE DATABASE mysqltest;
CREATE TABLE mysqltest.dummytable (dummyfield INT);
DROP DATABASE mysqltest;
CREATE DATABASE mysqltest;
CREATE TABLE mysqltest.dummytable (dummyfield INT);
DROP DATABASE mysqltest;
create database mysqltest;
create table t1(f1 int);
drop database mysqltest;
create database db27515;
drop database db27515;
select * from  information_schema.schema_privileges
where grantee like "'mysqltest_8'%";
select * from t1;
select * from  information_schema.schema_privileges
where grantee like "'mysqltest_8'%";
select * from  information_schema.column_privileges;
select * from t1;
select * from  information_schema.column_privileges;
select * from  information_schema.table_privileges where table_schema NOT IN ('sys','mysql');
select * from t1;
select * from  information_schema.table_privileges where table_schema NOT IN ('sys','mysql');
select * from  information_schema.user_privileges
where grantee like "'mysqltest_8'%";
select * from t1;
select * from  information_schema.user_privileges
where grantee like "'mysqltest_8'%";
drop table t1;
CREATE DATABASE mysqltest3;
CREATE TABLE t_nn (c1 INT);
CREATE VIEW  v_nn AS SELECT * FROM t_nn;
CREATE DATABASE mysqltest2;
CREATE VIEW  v_yn AS SELECT * FROM t_nn;
CREATE VIEW  v_gy AS SELECT * FROM t_nn;
CREATE VIEW  v_ny AS SELECT * FROM t_nn;
CREATE VIEW  v_yy AS SELECT * FROM t_nn WHERE c1=55;
DROP DATABASE mysqltest2;
DROP DATABASE mysqltest3;
CREATE DATABASE mysqltest1;
CREATE TABLE mysqltest1.t1 (
  int_field INTEGER UNSIGNED NOT NULL,
  char_field CHAR(10),
  INDEX(`int_field`)
);
CREATE TABLE mysqltest1.t2 (int_field INT);
SELECT USER();
DROP TABLE mysqltest1.t2;
DROP DATABASE mysqltest1;
CREATE DATABASE bug23556;
CREATE TABLE t1 (a INT PRIMARY KEY);
DROP TABLE t1;
DROP DATABASE bug23556;
CREATE DATABASE mysqltest1;
CREATE DATABASE mysqltest2;
CREATE DATABASE mysqltest3;
CREATE DATABASE mysqltest4;
DROP DATABASE mysqltest1;
DROP DATABASE mysqltest2;
DROP DATABASE mysqltest3;
DROP DATABASE mysqltest4;
CREATE DATABASE mysqltest1;
CREATE DATABASE mysqltest2;
CREATE TABLE t1(c INT);
DROP DATABASE mysqltest1;
DROP DATABASE mysqltest2;
CREATE DATABASE mysqltest1;
CREATE DATABASE mysqltest2;
CREATE TABLE mysqltest1.t1(c INT);
CREATE TABLE mysqltest2.t2(c INT);
PREPARE stmt1 FROM 'SHOW TABLES FROM mysqltest1';
DROP DATABASE mysqltest1;
DROP DATABASE mysqltest2;
CREATE DATABASE db27878;
DROP DATABASE db27878;
DROP TABLE t1;
drop table if exists test;
drop function if exists test_function;
drop view if exists v1;
create table test (col1 varchar(30));
drop table test;
SELECT CURRENT_USER();
CREATE DATABASE mysqltest1;
CREATE DATABASE mysqltest2;
CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 VALUES (1, 1);
CREATE TABLE t2(a INT);
INSERT INTO t2 VALUES (2);
CREATE TABLE mysqltest2.t3(a INT);
PREPARE s1 FROM 'SELECT b FROM t1';
PREPARE s2 FROM 'SELECT a FROM t2';
PREPARE s3 FROM 'SHOW TABLES FROM mysqltest2';
CREATE PROCEDURE p1() SELECT b FROM t1;
CREATE PROCEDURE p2() SELECT a FROM t2;
CREATE PROCEDURE p3() SHOW TABLES FROM mysqltest2;
SELECT b FROM t1;
SELECT SUM(b) OVER () FROM t1;
SELECT a FROM t2;
DROP DATABASE mysqltest1;
DROP DATABASE mysqltest2;
create database mysqltest1;
create table mysqltest1.t11 (i int);
create table mysqltest1.t22 (i int);
drop database mysqltest1;
create database mysqltest;
create table t4 (i INT);
insert into t2 values (1);
create table if not exists t1 select * from t2;
create table if not exists t3 select * from t2;
create table if not exists t4 select * from t2;
create table if not exists t5 select * from t2;
create table t6 select * from t2;
create table t7 select * from t2;
drop table t1,t2,t4,t5,t6;
drop database mysqltest;
CREATE DATABASE mysqltest1;
DROP DATABASE mysqltest1;
CREATE DATABASE dbbug33464;
DROP DATABASE dbbug33464;
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;
CREATE DATABASE db1;
DROP DATABASE db1;
CREATE DATABASE db1;
CREATE DATABASE db2;
CREATE TABLE t1 (a INT);
DROP DATABASE db1;
DROP DATABASE db2;
CREATE DATABASE mysqltest_db1;
CREATE TABLE mysqltest_db1.t1(a INT);
DROP DATABASE mysqltest_db1;
create database mysqltest_db1;
drop database mysqltest_db1;
CREATE DATABASE secret;
DROP DATABASE secret;
SELECT user(), current_user();
SELECT 1;
SELECT 1;
SELECT 1;
CREATE DATABASE db_1;
CREATE TABLE db_1.test_table (name varchar(15) not null, surname varchar(20) not null, 
email varchar(50) null, street varchar(50) null, city varchar(50) null, 
is_active int default 1 );
DROP TABLE db_1.test_table;
DROP DATABASE db_1;
DROP TABLE t1;
DROP PROCEDURE p1;
CREATE DATABASE db8657;
CREATE TABLE db8657.t1 (i INT);
PREPARE stmt FROM 'CREATE TABLE db8657.t2 (i INT)';
DROP DATABASE db8657;
CREATE DATABASE db8063;
CREATE TABLE db8063.t1(a VARCHAR(20));
DROP DATABASE db8063;
CREATE DATABASE mysqltest_1;
SELECT view_definition
  FROM information_schema.views
  WHERE table_schema='mysqltest_1' AND table_name='v1';
SELECT view_definition FROM information_schema.views
  WHERE table_schema='mysqltest_1' AND table_name='v1';
DROP DATABASE mysqltest_1;
CREATE DATABASE mysqltest;
CREATE TABLE mysqltest.visible(s INTEGER, u INTEGER, d INTEGER);
CREATE TABLE mysqltest.cols(
 s1 INTEGER, s2 INTEGER,
 u1 INTEGER, u2 INTEGER,
 i1 INTEGER, i2 INTEGER);
CREATE TABLE mysqltest.ins(i1 INTEGER, i2 INTEGER, i3 INTEGER);
CREATE TABLE mysqltest.source(b1 INTEGER, b2 INTEGER);
DROP TABLE mysqltest.visible, mysqltest.cols, mysqltest.source, mysqltest.ins;
DROP DATABASE mysqltest;
CREATE DATABASE test01;
CREATE TABLE test01.c (id int primary key, a varchar(100));
CREATE DATABASE test02;
CREATE TABLE test02.tbl01 (id int primary key, a varchar(100));
CREATE TABLE test02.tbl02 (id int primary key, a varchar(100));
DROP DATABASE test01;
DROP DATABASE test02;
