drop table if exists t1, t2, t3, t4;
create table t1 (a int)
partition by list (a)
(partition p1 values in (0));
alter table t1 truncate partition p1,p1;
drop table t1;
create table t1 (a int)
partition by list (a)
subpartition by hash (a)
subpartitions 1
(partition p1 values in (1)
 (subpartition sp1));
alter table t1 truncate partition sp1;
drop table t1;
create table t1 (a int);
insert into t1 values (1), (3), (8);
