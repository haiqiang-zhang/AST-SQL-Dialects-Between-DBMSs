select array_concat_agg(a) from t;
select ArrAy_cOncAt_aGg(a) from t;
select n, array_concat_agg(a) from t group by n order by n;
drop table t;
