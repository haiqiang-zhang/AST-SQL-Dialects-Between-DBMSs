create table nu (a int);
drop table nu;
CREATE TABLE t1 (a int, b int);
DROP TABLE t1;
CREATE DATABASE `TESTDB`;
DROP DATABASE `TESTDB`;
drop procedure if exists proc_1;
create procedure proc_1() install plugin my_plug soname '\\root\\some_plugin.dll';
drop procedure proc_1;
prepare abc from "install plugin my_plug soname '\\\\root\\\\some_plugin.dll'";
deallocate prepare abc;
SELECT VARIABLE_NAME FROM performance_schema.global_variables
  WHERE VARIABLE_NAME = 'socket';
