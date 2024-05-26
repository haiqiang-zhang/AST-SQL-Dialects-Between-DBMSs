select count(*) from t1;
drop table t1;
create table t1 (id int)
partition by range (id)
(partition p0 values less than (1000),
 partition p1 values less than (maxvalue));
alter table t1 discard partition p0 tablespace;
drop table t1;
