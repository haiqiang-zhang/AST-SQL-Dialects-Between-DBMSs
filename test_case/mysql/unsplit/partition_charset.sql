drop table if exists t1;
create table t1 (s1 int)
  partition by list (s1)
    (partition c values in (1),
     partition ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ values in (3));
insert into t1 values (1),(3);
select * from t1;
select * from t1;
drop table t1;
