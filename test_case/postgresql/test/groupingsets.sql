select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by rollup (a,b);
select a, b, grouping(a,b),
       array_agg(v order by v),
       string_agg(v::text, ':' order by v desc),
       percentile_disc(0.5) within group (order by v),
       rank(1,2,12) within group (order by a,b,v)
  from gstest1 group by rollup (a,b) order by a,b;
select grouping(a), a, array_agg(b),
       rank(a) within group (order by b nulls first),
       rank(a) within group (order by b nulls last)
  from (values (1,1),(1,4),(1,5),(3,1),(3,2)) v(a,b)
 group by rollup (a) order by a;
select a, b, sum(c), sum(sum(c)) over (order by a,b) as rsum
  from gstest2 group by rollup (a,b) order by rsum, a, b;
select sum(c) from gstest2
  group by grouping sets((), grouping sets((), grouping sets(())))
  order by 1 desc;
select a, b, sum(v), count(*) from gstest_empty group by grouping sets ((a,b),a);
select t1.a, t2.b, grouping(t1.a, t2.b), sum(t1.v), max(t2.a)
  from gstest1 t1, gstest2 t2
 group by grouping sets ((t1.a, t2.b), ());
explain (costs off)
select g as alias1, g as alias2
  from generate_series(1,3) g
 group by alias1, rollup(alias2);
select g as alias1, g as alias2
  from generate_series(1,3) g
 group by alias1, rollup(alias2);
select a, b, sum(v.x)
  from (values (1),(2)) v(x), gstest_data(v.x)
 group by rollup (a,b);
CREATE VIEW gstest_view AS select a, b, grouping(a,b), sum(c), count(*), max(c)
  from gstest2 group by rollup ((a,b,c),(c,d));
select pg_get_viewdef('gstest_view'::regclass, true);
select(select (select grouping(a,b) from (values (1)) v2(c)) from (values (1,2)) v1(a,b) group by (a,b)) from (values(6,7)) v3(e,f) GROUP BY ROLLUP(e,f);
select(select (select grouping(e,f) from (values (1)) v2(c)) from (values (1,2)) v1(a,b) group by (a,b)) from (values(6,7)) v3(e,f) GROUP BY ROLLUP(e,f);
select(select (select grouping(c) from (values (1)) v2(c) GROUP BY c) from (values (1,2)) v1(a,b) group by (a,b)) from (values(6,7)) v3(e,f) GROUP BY ROLLUP(e,f);
select a, b, c, d from gstest2 group by rollup(a,b),grouping sets(c,d);
select a, b from (values (1,2),(2,3)) v(a,b) group by a,b, grouping sets(a);
select(select (select grouping(a,b) from (values (1)) v2(c)) from (values (1,2)) v1(a,b) group by (a,b)) from (values(6,7)) v3(e,f) GROUP BY CUBE((e+1),(f+1)) ORDER BY (e+1),(f+1);
select a, b, sum(c) from (values (1,1,10),(1,1,11),(1,2,12),(1,2,13),(1,3,14),(2,3,15),(3,3,16),(3,4,17),(4,1,18),(4,1,19)) v(a,b,c) group by rollup (a,b);
explain (costs off)
select * from gstest1 group by grouping sets((a,b,v),(v)) order by v,b,a;
select a,count(*) from gstest2 group by rollup(a) order by a;
explain (costs off)
  select a,count(*) from gstest2 group by rollup(a) having a is distinct from 1 order by a;
select v.c, (select count(*) from gstest2 group by () having v.c)
  from (values (false),(true)) v(c) order by v.c;
explain (costs off)
  select v.c, (select count(*) from gstest2 group by () having v.c)
    from (values (false),(true)) v(c) order by v.c;
set enable_hashagg = true;
explain (costs off) select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by grouping sets ((a),(b)) order by 3,1,2;
select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by cube(a,b) order by 3,1,2;
explain (costs off) select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by cube(a,b) order by 3,1,2;
explain (costs off)
  select a, b, grouping(a,b), array_agg(v order by v)
    from gstest1 group by cube(a,b);
select unsortable_col, count(*)
  from gstest4 group by grouping sets ((unsortable_col),(unsortable_col))
  order by unsortable_col::text;
select unhashable_col, unsortable_col,
       grouping(unhashable_col, unsortable_col),
       count(*), sum(v)
  from gstest4 group by grouping sets ((unhashable_col),(unsortable_col))
 order by 3, 5;
explain (costs off)
  select unhashable_col, unsortable_col,
         grouping(unhashable_col, unsortable_col),
         count(*), sum(v)
    from gstest4 group by grouping sets ((unhashable_col),(unsortable_col))
   order by 3,5;
explain (costs off)
  select a, b, sum(v), count(*) from gstest_empty group by grouping sets ((a,b),a);
explain (costs off)
  select a, b, sum(v.x)
    from (values (1),(2)) v(x), gstest_data(v.x)
   group by grouping sets (a,b)
   order by 3, 1, 2;
explain (costs off)
  select a, b, sum(c), sum(sum(c)) over (order by a,b) as rsum
    from gstest2 group by cube (a,b) order by rsum, a, b;
BEGIN;
SET LOCAL enable_hashagg = false;
COMMIT;
set enable_indexscan = false;
set hash_mem_multiplier = 1.0;
set work_mem = '64kB';
set work_mem = '384kB';
select v||'a', case grouping(v||'a') when 1 then 1 else 0 end, count(*)
  from unnest(array[1,1], array['a','b']) u(i,v)
 group by rollup(i, v||'a') order by 1,3;
create table bug_16784(i int, j int);
analyze bug_16784;
alter table bug_16784 set (autovacuum_enabled = 'false');
insert into bug_16784 select g/10, g from generate_series(1,40) g;
set work_mem='64kB';
set enable_sort = false;
create table gs_data_1 as
select g%1000 as g1000, g%100 as g100, g%10 as g10, g
   from generate_series(0,1999) g;
analyze gs_data_1;
alter table gs_data_1 set (autovacuum_enabled = 'false');
set work_mem='64kB';
set enable_sort = true;
set enable_hashagg = false;
set jit_above_cost = 0;
explain (costs off)
select g100, g10, sum(g::numeric), count(*), max(g::text)
from gs_data_1 group by cube (g1000, g100,g10);
create table gs_group_1 as
select g100, g10, sum(g::numeric), count(*), max(g::text)
from gs_data_1 group by cube (g1000, g100,g10);
set enable_hashagg = true;
set enable_sort = false;
create table gs_hash_1 as
select g100, g10, sum(g::numeric), count(*), max(g::text)
from gs_data_1 group by cube (g1000, g100,g10);
set enable_sort = true;
set work_mem to default;
set hash_mem_multiplier to default;
(select * from gs_hash_1 except select * from gs_group_1)
  union all
(select * from gs_group_1 except select * from gs_hash_1);
drop table gs_group_1;
drop table gs_hash_1;
explain (costs off)
select (select grouping(v1)) from (values ((select 1))) v(v1) group by cube(v1);
select (select grouping(v1)) from (values ((select 1))) v(v1) group by cube(v1);
