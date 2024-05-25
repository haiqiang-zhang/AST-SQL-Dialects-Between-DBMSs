DROP TABLE IF EXISTS t1,t2,t3;
create table t1 (a int);
insert into t1 values(1);
create table t2 select * from t1;
create table t3 (a int);
drop table t3;
