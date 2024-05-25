drop database if exists mysqltest_db1;
create database mysqltest_db1;
create table mysqltest_db1.t1 (a int, key(a)) engine=myisam;
create table mysqltest_db1.t2 (b int);
drop database mysqltest_db1;
