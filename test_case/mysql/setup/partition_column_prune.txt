drop table if exists t1,t2,t3,t4,t5,t6,t7,t8,t9;
create table t1 (a char, b char, c char)
partition by range columns(a,b,c)
( partition p0 values less than ('a','b','c'));
insert into t1 values ('a', NULL, 'd');
