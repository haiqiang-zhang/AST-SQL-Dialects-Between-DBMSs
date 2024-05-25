DROP TABLE IF EXISTS t1;
create table t1 (a int);
drop table t1;
create table t1 (a char(1) character set latin1);
insert into t1 values ('a'),('b'),('c');
