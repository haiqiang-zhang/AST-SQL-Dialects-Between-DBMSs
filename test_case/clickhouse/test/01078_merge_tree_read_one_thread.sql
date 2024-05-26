optimize table t final;
select sum(a) from t where a in (0, 3) and b = 0;
drop table t;
