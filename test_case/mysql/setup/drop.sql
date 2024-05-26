drop table if exists t1;
drop database if exists mysqltest;
drop database if exists client_test_db;
create table t1(n int);
insert into t1 values(1);
create temporary table t1( n int);
insert into t1 values(2);
drop table t1;
