select sum(number) over w as x, max(number) over w as y from t_01568 window w as (partition by p) order by x, y;
select sum(number) over w, max(number) over w from t_01568 window w as (partition by p) order by p;
drop table t_01568;