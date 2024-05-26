set work_mem to '2MB';
reset work_mem;
create table t(a integer, b integer);
end;
end;
end;
insert into t(a, b) select i/100 + 1, i + 1 from generate_series(0, 999) n(i);
analyze t;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 31;
select * from (select * from t order by a) s order by a, b limit 31;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 32;
select * from (select * from t order by a) s order by a, b limit 32;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 33;
select * from (select * from t order by a) s order by a, b limit 33;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 65;
select * from (select * from t order by a) s order by a, b limit 65;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 66;
select * from (select * from t order by a) s order by a, b limit 66;
delete from t;
insert into t(a, b) select i/50 + 1, i + 1 from generate_series(0, 999) n(i);
analyze t;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 55;
select * from (select * from t order by a) s order by a, b limit 55;
delete from t;
insert into t(a, b) select (case when i < 5 then i else 9 end), i from generate_series(1, 1000) n(i);
analyze t;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 70;
select * from (select * from t order by a) s order by a, b limit 70;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 5;
select * from (select * from t order by a) s order by a, b limit 5;
begin;
set local enable_hashjoin = off;
set local enable_mergejoin = off;
set local enable_material = off;
set local enable_sort = off;
explain (costs off) select * from t left join (select * from (select * from t order by a) v order by a, b) s on s.a = t.a where t.a in (1, 2);
select * from t left join (select * from (select * from t order by a) v order by a, b) s on s.a = t.a where t.a in (1, 2);
rollback;
delete from t;
insert into t(a, b) select i / 10, i from generate_series(1, 1000) n(i);
analyze t;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 31;
select * from (select * from t order by a) s order by a, b limit 31;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 32;
select * from (select * from t order by a) s order by a, b limit 32;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 33;
select * from (select * from t order by a) s order by a, b limit 33;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 65;
select * from (select * from t order by a) s order by a, b limit 65;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 66;
select * from (select * from t order by a) s order by a, b limit 66;
delete from t;
insert into t(a, b) select i, i from generate_series(1, 1000) n(i);
analyze t;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 31;
select * from (select * from t order by a) s order by a, b limit 31;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 32;
select * from (select * from t order by a) s order by a, b limit 32;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 33;
select * from (select * from t order by a) s order by a, b limit 33;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 65;
select * from (select * from t order by a) s order by a, b limit 65;
explain (costs off) select * from (select * from t order by a) s order by a, b limit 66;
select * from (select * from t order by a) s order by a, b limit 66;
delete from t;
drop table t;
set min_parallel_table_scan_size = '1kB';
set min_parallel_index_scan_size = '1kB';
set parallel_setup_cost = 0;
set parallel_tuple_cost = 0;
set max_parallel_workers_per_gather = 2;
create table t (a int, b int, c int);
insert into t select mod(i,10),mod(i,10),i from generate_series(1,10000) s(i);
create index on t (a);
analyze t;
set enable_incremental_sort = off;
explain (costs off) select a,b,sum(c) from t group by 1,2 order by 1,2,3 limit 1;
set enable_incremental_sort = on;
explain (costs off) select a,b,sum(c) from t group by 1,2 order by 1,2,3 limit 1;
set enable_hashagg to off;
explain (costs off) select * from t union select * from t order by 1,3;
explain (costs off) select distinct a,b from t;
drop table t;
set enable_hashagg=off;
set enable_seqscan=off;
set enable_incremental_sort = off;
set parallel_tuple_cost=0;
set parallel_setup_cost=0;
set min_parallel_table_scan_size = 0;
set min_parallel_index_scan_size = 0;
reset enable_hashagg;
reset enable_seqscan;
reset enable_incremental_sort;
reset parallel_tuple_cost;
reset parallel_setup_cost;
reset min_parallel_table_scan_size;
reset min_parallel_index_scan_size;
create table point_table (a point, b int);
create index point_table_a_idx on point_table using gist(a);
explain (costs off) select a, b, a <-> point(5, 5) dist from point_table order by dist, b limit 1;
explain (costs off) select a, b, a <-> point(5, 5) dist from point_table order by dist, b desc limit 1;