drop database if exists db1_secret;
create database db1_secret;
create table t1 ( u varchar(64), i int );
insert into t1 values('test', 0);
create procedure stamp(i int)
  insert into db1_secret.t1 values (user(), i);
select * from t1;
select * from t1;
alter procedure stamp sql security invoker;
select * from t1;
drop database if exists db2;
create database db2;
create table t2 (s1 int);
insert into t2 values (0);
create procedure p () insert into t2 values (1);
select * from t2;
create procedure q () insert into t2 values (2);
select * from t2;
select * from t2;
alter procedure p modifies sql data;
drop procedure p;
alter procedure q modifies sql data;
drop procedure q;
select routine_type, routine_schema, routine_name
from information_schema.routines where routine_schema like 'db%'
order by routine_type, routine_name;
drop database db1_secret;
drop database db2;
select routine_type, routine_schema, routine_name
from information_schema.routines where routine_schema like 'db%';
create database sptest;
select * from t1;
drop database sptest;
drop table t1;
drop function if exists bug_9503;
select current_user();
select user();
create procedure bug7291_0 () sql security invoker select current_user(), user();
create procedure bug7291_1 () sql security definer call bug7291_0();
create procedure bug7291_2 () sql security invoker call bug7291_0();
drop procedure bug7291_1;
drop procedure bug7291_2;
drop procedure bug7291_0;
drop database if exists mysqltest_1;
create database mysqltest_1;
drop database mysqltest_1;
create database db_bug14834;
create procedure p_bug14834() select user(), current_user();
drop database db_bug14834;
create database db_bug14533;
create table t1 (id int);
create procedure bug14533_1()
    sql security definer
  desc db_bug14533.t1;
create procedure bug14533_2()
    sql security definer
   select * from db_bug14533.t1;
drop database db_bug14533;
DROP DATABASE IF EXISTS mysqltest;
CREATE DATABASE mysqltest;
CREATE PROCEDURE wl2897_p1() SELECT 1;
DROP DATABASE mysqltest;
DROP DATABASE IF EXISTS mysqltest;
CREATE DATABASE mysqltest;
CREATE PROCEDURE bug13198_p1()
  SELECT 1;
DROP DATABASE mysqltest;
DROP TABLE IF EXISTS t1;
DROP VIEW IF EXISTS v1;
DROP FUNCTION IF EXISTS f_suid;
DROP PROCEDURE IF EXISTS p_suid;
DROP FUNCTION IF EXISTS f_evil;
CREATE TABLE t1 (i INT);
CREATE PROCEDURE p_suid(IN i INT) SQL SECURITY DEFINER SET @c:= 0;
SELECT COUNT(*) FROM t1;
SELECT @a, @b;
SELECT @a, @b;
SELECT @a, @b;
SELECT @a, @b;
DROP PROCEDURE p_suid;
DROP TABLE t1;
CREATE DATABASE B48872;
CREATE TABLE `TestTab` (id INT);
INSERT INTO `TestTab` VALUES (1),(2);
SELECT * FROM TestTab;
SELECT * FROM TestTab;
SELECT * FROM TestTab;
DROP TABLE `TestTab`;
DROP DATABASE B48872;
drop database if exists mysqltest_db;
create database mysqltest_db;
drop database mysqltest_db;
drop database if exists mysqltest_db;
create database mysqltest_db;
drop database mysqltest_db;
CREATE DATABASE mysqltest_db;
SELECT routine_schema, routine_name, routine_type, routine_definition
FROM INFORMATION_SCHEMA.ROUTINES WHERE routine_schema = 'mysqltest_db';
SELECT specific_schema, specific_name, parameter_name
FROM INFORMATION_SCHEMA.PARAMETERS WHERE specific_schema = 'mysqltest_db';
SELECT CURRENT_USER();
DROP DATABASE mysqltest_db;
CREATE SCHEMA testdb;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA="testdb" ORDER BY ROUTINE_DEFINITION;
DROP SCHEMA testdb;
