drop table if exists t1,t2;
create table t1 (a char(16), b date, c datetime);
insert into t1 SET a='test 2000-01-01', b='2000-01-01', c='2000-01-01';
