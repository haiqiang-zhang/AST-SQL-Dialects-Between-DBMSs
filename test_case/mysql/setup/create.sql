drop table if exists t1,t2,t3,t4,t5;
drop database if exists mysqltest;
drop view if exists v1;
create table t1 (b char(0));
insert into t1 values (""),(null);
