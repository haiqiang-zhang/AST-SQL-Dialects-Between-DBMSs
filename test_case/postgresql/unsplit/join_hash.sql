begin;
set local min_parallel_table_scan_size = 0;
set local parallel_setup_cost = 0;
set local enable_hashjoin = on;
end;
end;
create table simple as
  select generate_series(1, 20000) AS id, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
alter table simple set (parallel_workers = 2);
analyze simple;
create table bigger_than_it_looks as
  select generate_series(1, 20000) as id, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
alter table bigger_than_it_looks set (autovacuum_enabled = 'false');
alter table bigger_than_it_looks set (parallel_workers = 2);
analyze bigger_than_it_looks;
create table extremely_skewed (id int, t text);
alter table extremely_skewed set (autovacuum_enabled = 'false');
alter table extremely_skewed set (parallel_workers = 2);
analyze extremely_skewed;
insert into extremely_skewed
  select 42 as id, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
  from generate_series(1, 20000);
create table wide as select generate_series(1, 2) as id, rpad('', 320000, 'x') as t;
alter table wide set (parallel_workers = 2);
set local max_parallel_workers_per_gather = 0;
set local work_mem = '4MB';
set local hash_mem_multiplier = 1.0;
explain (costs off)
  select count(*) from simple r join simple s using (id);
select count(*) from simple r join simple s using (id);
set local max_parallel_workers_per_gather = 2;
set local work_mem = '4MB';
set local hash_mem_multiplier = 1.0;
set local enable_parallel_hash = off;
explain (costs off)
  select count(*) from simple r join simple s using (id);
select count(*) from simple r join simple s using (id);
set local max_parallel_workers_per_gather = 2;
set local work_mem = '4MB';
set local hash_mem_multiplier = 1.0;
set local enable_parallel_hash = on;
explain (costs off)
  select count(*) from simple r join simple s using (id);
select count(*) from simple r join simple s using (id);
set local max_parallel_workers_per_gather = 0;
set local work_mem = '128kB';
set local hash_mem_multiplier = 1.0;
explain (costs off)
  select count(*) from simple r join simple s using (id);
select count(*) from simple r join simple s using (id);
set local max_parallel_workers_per_gather = 2;
set local work_mem = '128kB';
set local hash_mem_multiplier = 1.0;
set local enable_parallel_hash = off;
explain (costs off)
  select count(*) from simple r join simple s using (id);
select count(*) from simple r join simple s using (id);
set local max_parallel_workers_per_gather = 2;
set local work_mem = '192kB';
set local hash_mem_multiplier = 1.0;
set local enable_parallel_hash = on;
explain (costs off)
  select count(*) from simple r join simple s using (id);
select count(*) from simple r join simple s using (id);
select count(*) from simple r full outer join simple s using (id);
set local max_parallel_workers_per_gather = 0;
set local work_mem = '128kB';
set local hash_mem_multiplier = 1.0;
explain (costs off)
  select count(*) FROM simple r JOIN bigger_than_it_looks s USING (id);
select count(*) FROM simple r JOIN bigger_than_it_looks s USING (id);
set local max_parallel_workers_per_gather = 2;
set local work_mem = '128kB';
set local hash_mem_multiplier = 1.0;
set local enable_parallel_hash = off;
explain (costs off)
  select count(*) from simple r join bigger_than_it_looks s using (id);
select count(*) from simple r join bigger_than_it_looks s using (id);
set local max_parallel_workers_per_gather = 1;
set local work_mem = '192kB';
set local hash_mem_multiplier = 1.0;
set local enable_parallel_hash = on;
explain (costs off)
  select count(*) from simple r join bigger_than_it_looks s using (id);
select count(*) from simple r join bigger_than_it_looks s using (id);
set local max_parallel_workers_per_gather = 0;
set local work_mem = '128kB';
set local hash_mem_multiplier = 1.0;
explain (costs off)
  select count(*) from simple r join extremely_skewed s using (id);
select count(*) from simple r join extremely_skewed s using (id);
set local max_parallel_workers_per_gather = 2;
set local work_mem = '128kB';
set local hash_mem_multiplier = 1.0;
set local enable_parallel_hash = off;
explain (costs off)
  select count(*) from simple r join extremely_skewed s using (id);
select count(*) from simple r join extremely_skewed s using (id);
set local max_parallel_workers_per_gather = 1;
set local work_mem = '128kB';
set local hash_mem_multiplier = 1.0;
set local enable_parallel_hash = on;
explain (costs off)
  select count(*) from simple r join extremely_skewed s using (id);
select count(*) from simple r join extremely_skewed s using (id);
set local max_parallel_workers_per_gather = 2;
set local work_mem = '4MB';
set local hash_mem_multiplier = 1.0;
set local parallel_leader_participation = off;
create table join_foo as select generate_series(1, 3) as id, 'xxxxx'::text as t;
alter table join_foo set (parallel_workers = 0);
create table join_bar as select generate_series(1, 10000) as id, 'xxxxx'::text as t;
alter table join_bar set (parallel_workers = 2);
set enable_parallel_hash = off;
set parallel_leader_participation = off;
set min_parallel_table_scan_size = 0;
set parallel_setup_cost = 0;
set parallel_tuple_cost = 0;
set max_parallel_workers_per_gather = 2;
set enable_material = off;
set enable_mergejoin = off;
set work_mem = '64kB';
set hash_mem_multiplier = 1.0;
explain (costs off)
  select count(*) from join_foo
    left join (select b1.id, b1.t from join_bar b1 join join_bar b2 using (id)) ss
    on join_foo.id < ss.id + 1 and join_foo.id > ss.id - 1;
select count(*) from join_foo
  left join (select b1.id, b1.t from join_bar b1 join join_bar b2 using (id)) ss
  on join_foo.id < ss.id + 1 and join_foo.id > ss.id - 1;
set enable_parallel_hash = off;
set parallel_leader_participation = off;
set min_parallel_table_scan_size = 0;
set parallel_setup_cost = 0;
set parallel_tuple_cost = 0;
set max_parallel_workers_per_gather = 2;
set enable_material = off;
set enable_mergejoin = off;
set work_mem = '4MB';
set hash_mem_multiplier = 1.0;
explain (costs off)
  select count(*) from join_foo
    left join (select b1.id, b1.t from join_bar b1 join join_bar b2 using (id)) ss
    on join_foo.id < ss.id + 1 and join_foo.id > ss.id - 1;
select count(*) from join_foo
  left join (select b1.id, b1.t from join_bar b1 join join_bar b2 using (id)) ss
  on join_foo.id < ss.id + 1 and join_foo.id > ss.id - 1;
set enable_parallel_hash = on;
set parallel_leader_participation = off;
set min_parallel_table_scan_size = 0;
set parallel_setup_cost = 0;
set parallel_tuple_cost = 0;
set max_parallel_workers_per_gather = 2;
set enable_material = off;
set enable_mergejoin = off;
set work_mem = '64kB';
set hash_mem_multiplier = 1.0;
explain (costs off)
  select count(*) from join_foo
    left join (select b1.id, b1.t from join_bar b1 join join_bar b2 using (id)) ss
    on join_foo.id < ss.id + 1 and join_foo.id > ss.id - 1;
select count(*) from join_foo
  left join (select b1.id, b1.t from join_bar b1 join join_bar b2 using (id)) ss
  on join_foo.id < ss.id + 1 and join_foo.id > ss.id - 1;
set enable_parallel_hash = on;
set parallel_leader_participation = off;
set min_parallel_table_scan_size = 0;
set parallel_setup_cost = 0;
set parallel_tuple_cost = 0;
set max_parallel_workers_per_gather = 2;
set enable_material = off;
set enable_mergejoin = off;
set work_mem = '4MB';
set hash_mem_multiplier = 1.0;
explain (costs off)
  select count(*) from join_foo
    left join (select b1.id, b1.t from join_bar b1 join join_bar b2 using (id)) ss
    on join_foo.id < ss.id + 1 and join_foo.id > ss.id - 1;
select count(*) from join_foo
  left join (select b1.id, b1.t from join_bar b1 join join_bar b2 using (id)) ss
  on join_foo.id < ss.id + 1 and join_foo.id > ss.id - 1;
set local max_parallel_workers_per_gather = 0;
explain (costs off)
     select  count(*) from simple r full outer join simple s using (id);
select  count(*) from simple r full outer join simple s using (id);
set enable_parallel_hash = off;
set local max_parallel_workers_per_gather = 2;
explain (costs off)
     select  count(*) from simple r full outer join simple s using (id);
select  count(*) from simple r full outer join simple s using (id);
set local max_parallel_workers_per_gather = 2;
explain (costs off)
     select  count(*) from simple r full outer join simple s using (id);
select  count(*) from simple r full outer join simple s using (id);
set local max_parallel_workers_per_gather = 0;
explain (costs off)
     select  count(*) from simple r full outer join simple s on (r.id = 0 - s.id);
select  count(*) from simple r full outer join simple s on (r.id = 0 - s.id);
set enable_parallel_hash = off;
set local max_parallel_workers_per_gather = 2;
explain (costs off)
     select  count(*) from simple r full outer join simple s on (r.id = 0 - s.id);
select  count(*) from simple r full outer join simple s on (r.id = 0 - s.id);
set local max_parallel_workers_per_gather = 2;
explain (costs off)
     select  count(*) from simple r full outer join simple s on (r.id = 0 - s.id);
select  count(*) from simple r full outer join simple s on (r.id = 0 - s.id);
set max_parallel_workers_per_gather = 2;
set enable_parallel_hash = on;
set work_mem = '128kB';
set hash_mem_multiplier = 1.0;
explain (costs off)
  select length(max(s.t))
  from wide left join (select id, coalesce(t, '') || '' as t from wide) s using (id);
select length(max(s.t))
from wide left join (select id, coalesce(t, '') || '' as t from wide) s using (id);
SET enable_parallel_hash = on;
SET min_parallel_table_scan_size = 0;
SET parallel_setup_cost = 0;
SET parallel_tuple_cost = 0;
CREATE TABLE hjtest_matchbits_t1(id int);
CREATE TABLE hjtest_matchbits_t2(id int);
INSERT INTO hjtest_matchbits_t1 VALUES (1);
INSERT INTO hjtest_matchbits_t2 VALUES (2);
UPDATE hjtest_matchbits_t2 set id = 2;
SELECT * FROM hjtest_matchbits_t1 t1 FULL JOIN hjtest_matchbits_t2 t2 ON t1.id = t2.id
  ORDER BY t1.id;
RESET parallel_setup_cost;
SET enable_parallel_hash = off;
SELECT * FROM hjtest_matchbits_t1 t1 FULL JOIN hjtest_matchbits_t2 t2 ON t1.id = t2.id;
rollback;
BEGIN;
SET LOCAL enable_sort = OFF;
SET LOCAL from_collapse_limit = 1;
CREATE TABLE hjtest_1 (a text, b int, id int, c bool);
CREATE TABLE hjtest_2 (a bool, id int, b text, c int);
INSERT INTO hjtest_1(a, b, id, c) VALUES ('text', 2, 1, false);
INSERT INTO hjtest_1(a, b, id, c) VALUES ('text', 1, 2, false);
INSERT INTO hjtest_1(a, b, id, c) VALUES ('text', 20, 1, false);
INSERT INTO hjtest_1(a, b, id, c) VALUES ('text', 1, 1, false);
INSERT INTO hjtest_2(a, id, b, c) VALUES (true, 1, 'another', 2);
INSERT INTO hjtest_2(a, id, b, c) VALUES (true, 3, 'another', 7);
INSERT INTO hjtest_2(a, id, b, c) VALUES (true, 1, 'another', 90);
INSERT INTO hjtest_2(a, id, b, c) VALUES (true, 1, 'another', 3);
INSERT INTO hjtest_2(a, id, b, c) VALUES (true, 1, 'text', 1);
EXPLAIN (COSTS OFF, VERBOSE)
SELECT hjtest_1.a a1, hjtest_2.a a2,hjtest_1.tableoid::regclass t1, hjtest_2.tableoid::regclass t2
FROM hjtest_1, hjtest_2
WHERE
    hjtest_1.id = (SELECT 1 WHERE hjtest_2.id = 1)
    AND (SELECT hjtest_1.b * 5) = (SELECT hjtest_2.c*5)
    AND (SELECT hjtest_1.b * 5) < 50
    AND (SELECT hjtest_2.c * 5) < 55
    AND hjtest_1.a <> hjtest_2.b;
SELECT hjtest_1.a a1, hjtest_2.a a2,hjtest_1.tableoid::regclass t1, hjtest_2.tableoid::regclass t2
FROM hjtest_1, hjtest_2
WHERE
    hjtest_1.id = (SELECT 1 WHERE hjtest_2.id = 1)
    AND (SELECT hjtest_1.b * 5) = (SELECT hjtest_2.c*5)
    AND (SELECT hjtest_1.b * 5) < 50
    AND (SELECT hjtest_2.c * 5) < 55
    AND hjtest_1.a <> hjtest_2.b;
EXPLAIN (COSTS OFF, VERBOSE)
SELECT hjtest_1.a a1, hjtest_2.a a2,hjtest_1.tableoid::regclass t1, hjtest_2.tableoid::regclass t2
FROM hjtest_2, hjtest_1
WHERE
    hjtest_1.id = (SELECT 1 WHERE hjtest_2.id = 1)
    AND (SELECT hjtest_1.b * 5) = (SELECT hjtest_2.c*5)
    AND (SELECT hjtest_1.b * 5) < 50
    AND (SELECT hjtest_2.c * 5) < 55
    AND hjtest_1.a <> hjtest_2.b;
SELECT hjtest_1.a a1, hjtest_2.a a2,hjtest_1.tableoid::regclass t1, hjtest_2.tableoid::regclass t2
FROM hjtest_2, hjtest_1
WHERE
    hjtest_1.id = (SELECT 1 WHERE hjtest_2.id = 1)
    AND (SELECT hjtest_1.b * 5) = (SELECT hjtest_2.c*5)
    AND (SELECT hjtest_1.b * 5) < 50
    AND (SELECT hjtest_2.c * 5) < 55
    AND hjtest_1.a <> hjtest_2.b;
ROLLBACK;
begin;
set local enable_hashjoin = on;
rollback;
