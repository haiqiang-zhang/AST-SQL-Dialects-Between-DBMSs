create table t1 (a varchar(2) character set cp1250)
partition by list columns (a)
( partition p0 values in (0x81));
drop table t1;
create table t1 (a varchar(2) character set cp1250)
partition by list columns (a)
( partition p0 values in (0x80));
drop table t1;
create table t1 (a varchar(1023) character set utf8mb3 COLLATE utf8mb3_spanish2_ci)
partition by range columns(a)
( partition p0 values less than ('CZ'),
  partition p1 values less than ('CH'),
  partition p2 values less than ('D'));
insert into t1 values ('czz'),('chi'),('ci'),('cg');
select * from t1 where a between 'cg' AND 'ci';
drop table t1;
create table t1 (a varchar(2) character set ucs2)
partition by list columns (a)
(partition p0 values in (0x2020),
 partition p1 values in (''));
insert into t1 values ('');
insert into t1 values (_ucs2 0x2020);
drop table t1;
