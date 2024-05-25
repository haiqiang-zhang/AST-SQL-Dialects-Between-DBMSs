drop row policy if exists policy_02834 on t_multi_prewhere;
create table t_multi_prewhere (a UInt64, b UInt64, c UInt8)
engine = MergeTree order by tuple()
settings min_bytes_for_wide_part = 0;
insert into t_multi_prewhere select number, number, number from numbers(10000);
system drop mark cache;
select sum(b) from t_multi_prewhere prewhere a < 5000;
system flush logs;
drop table if exists t_multi_prewhere;
drop row policy if exists policy_02834 on t_multi_prewhere;
