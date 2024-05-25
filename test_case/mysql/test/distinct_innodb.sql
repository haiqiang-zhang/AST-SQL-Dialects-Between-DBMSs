create view v1 as select t1.* from t1 left join t2 on 1;
drop view v1;
create view v1 as select t1.a*2 as a, t1.b*2 as b, t1.c*2 as c from t1;
drop view v1;
select
 (select distinct 1 from t1 t1_inner
  group by t1_inner.a order by max(t1_outer.b))
 from t1 t1_outer;
drop table t1, t2;
