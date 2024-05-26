drop database if exists mysqltest_db1;
create database mysqltest_db1;
create table t_column_priv_only (a int, b int);
create table t_select_priv like t_column_priv_only;
create table t_no_priv like t_column_priv_only;
