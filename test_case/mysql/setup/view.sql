drop table if exists t1,t2,t3,t4,t9,`t1a``b`,v1,v2,v3,v4,v5,v6;
drop view if exists t1,t2,`t1a``b`,v1,v2,v3,v4,v5,v6;
drop database if exists mysqltest;
create temporary table t1 (a int, b int);
drop table t1;
create table t1 (a int, b int);
insert into t1 values (1,2), (1,3), (2,4), (2,5), (3,10);
create view v1 (c) as select b+1 from t1;
