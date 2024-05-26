select
 (select distinct 1 from t1 t1_inner
  group by t1_inner.a order by max(t1_outer.b))
 from t1 t1_outer;
drop table t1, t2;
