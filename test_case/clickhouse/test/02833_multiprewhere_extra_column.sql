system drop mark cache;
select sum(b) from t_multi_prewhere prewhere a < 5000;
system flush logs;
drop table if exists t_multi_prewhere;
drop row policy if exists policy_02834 on t_multi_prewhere;
