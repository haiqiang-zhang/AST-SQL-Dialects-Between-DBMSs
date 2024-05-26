drop table if exists t1,t2,t3,t4;
drop database if exists client_test_db;
create table t1
(
  a int primary key,
  b char(10)
);
insert into t1 values (1,'one');
insert into t1 values (2,'two');
insert into t1 values (3,'three');
insert into t1 values (4,'four');
