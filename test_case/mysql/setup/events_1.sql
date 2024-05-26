drop database if exists events_test;
drop database if exists db_x;
drop database if exists mysqltest_db2;
drop database if exists mysqltest_no_such_database;
create database events_test;
CREATE DATABASE db_x;
CREATE TABLE x_table(a int);
CREATE EVENT e_x1 ON SCHEDULE EVERY 1 SECOND DO DROP DATABASE db_x;
CREATE EVENT e_x2 ON SCHEDULE EVERY 1 SECOND DO DROP TABLE x_table;
