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
select count(*) from t1;
drop table t1;
create table t1 (id int)
partition by range (id)
(partition p0 values less than (1000),
 partition p1 values less than (maxvalue));
alter table t1 discard partition p0 tablespace;
drop table t1;
