select * from t1 where a between 'cg' AND 'ci';
drop table t1;
create table t1 (a varchar(2) character set ucs2)
partition by list columns (a)
(partition p0 values in (0x2020),
 partition p1 values in (''));
insert into t1 values ('');
insert into t1 values (_ucs2 0x2020);
drop table t1;
