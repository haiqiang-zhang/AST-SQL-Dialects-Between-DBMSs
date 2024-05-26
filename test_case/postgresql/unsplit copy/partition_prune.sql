set plan_cache_mode = force_generic_plan;
create table lp (a char) partition by list (a);
create table lp_default partition of lp default;
create table lp_ef partition of lp for values in ('e', 'f');
create table lp_ad partition of lp for values in ('a', 'd');
create table lp_bc partition of lp for values in ('b', 'c');
create table lp_g partition of lp for values in ('g');
create table lp_null partition of lp for values in (null);
explain (costs off) select * from lp;
explain (costs off) select * from lp where a > 'a' and a < 'd';
explain (costs off) select * from lp where a > 'a' and a <= 'd';
explain (costs off) select * from lp where a = 'a';
explain (costs off) select * from lp where 'a' = a;
explain (costs off) select * from lp where a is not null;
explain (costs off) select * from lp where a is null;
explain (costs off) select * from lp where a = 'a' or a = 'c';
explain (costs off) select * from lp where a is not null and (a = 'a' or a = 'c');
explain (costs off) select * from lp where a <> 'g';
explain (costs off) select * from lp where a <> 'a' and a <> 'd';
explain (costs off) select * from lp where a not in ('a', 'd');
create table coll_pruning (a text collate "C") partition by list (a);
create table coll_pruning_a partition of coll_pruning for values in ('a');
create table coll_pruning_b partition of coll_pruning for values in ('b');
create table coll_pruning_def partition of coll_pruning default;
explain (costs off) select * from coll_pruning where a collate "C" = 'a' collate "C";
explain (costs off) select * from coll_pruning where a collate "POSIX" = 'a' collate "POSIX";
create table rlp (a int, b varchar) partition by range (a);
create table rlp_default partition of rlp default partition by list (a);
create table rlp_default_default partition of rlp_default default;
create table rlp_default_10 partition of rlp_default for values in (10);
create table rlp_default_30 partition of rlp_default for values in (30);
create table rlp_default_null partition of rlp_default for values in (null);
create table rlp1 partition of rlp for values from (minvalue) to (1);
create table rlp2 partition of rlp for values from (1) to (10);
create table rlp3 (b varchar, a int) partition by list (b varchar_ops);
create table rlp3_default partition of rlp3 default;
create table rlp3abcd partition of rlp3 for values in ('ab', 'cd');
create table rlp3efgh partition of rlp3 for values in ('ef', 'gh');
create table rlp3nullxy partition of rlp3 for values in (null, 'xy');
alter table rlp attach partition rlp3 for values from (15) to (20);
create table rlp4 partition of rlp for values from (20) to (30) partition by range (a);
create table rlp4_default partition of rlp4 default;
create table rlp4_1 partition of rlp4 for values from (20) to (25);
create table rlp4_2 partition of rlp4 for values from (25) to (29);
create table rlp5 partition of rlp for values from (31) to (maxvalue) partition by range (a);
create table rlp5_default partition of rlp5 default;
create table rlp5_1 partition of rlp5 for values from (31) to (40);
explain (costs off) select * from rlp where a < 1;
explain (costs off) select * from rlp where 1 > a;
explain (costs off) select * from rlp where a <= 1;
explain (costs off) select * from rlp where a = 1;
explain (costs off) select * from rlp where a = 1::bigint;
explain (costs off) select * from rlp where a = 1::numeric;
explain (costs off) select * from rlp where a <= 10;
explain (costs off) select * from rlp where a > 10;
explain (costs off) select * from rlp where a < 15;
explain (costs off) select * from rlp where a <= 15;
explain (costs off) select * from rlp where a > 15 and b = 'ab';
explain (costs off) select * from rlp where a = 16;
explain (costs off) select * from rlp where a = 16 and b in ('not', 'in', 'here');
explain (costs off) select * from rlp where a = 16 and b < 'ab';
explain (costs off) select * from rlp where a = 16 and b <= 'ab';
explain (costs off) select * from rlp where a = 16 and b is null;
explain (costs off) select * from rlp where a = 16 and b is not null;
explain (costs off) select * from rlp where a is null;
explain (costs off) select * from rlp where a is not null;
explain (costs off) select * from rlp where a > 30;
explain (costs off) select * from rlp where a = 30;
explain (costs off) select * from rlp where a <= 31;
explain (costs off) select * from rlp where a = 1 or a = 7;
explain (costs off) select * from rlp where a = 1 or b = 'ab';
explain (costs off) select * from rlp where a > 20 and a < 27;
explain (costs off) select * from rlp where a = 29;
explain (costs off) select * from rlp where a >= 29;
explain (costs off) select * from rlp where a < 1 or (a > 20 and a < 25);
explain (costs off) select * from rlp where a = 20 or a = 40;
explain (costs off) select * from rlp3 where a = 20;
explain (costs off) select * from rlp where a > 1 and a = 10;
explain (costs off) select * from rlp where a > 1 and a >=15;
explain (costs off) select * from rlp where a = 1 and a = 3;
explain (costs off) select * from rlp where (a = 1 and a = 3) or (a > 1 and a = 15);
create table mc3p (a int, b int, c int) partition by range (a, abs(b), c);
create table mc3p_default partition of mc3p default;
create table mc3p0 partition of mc3p for values from (minvalue, minvalue, minvalue) to (1, 1, 1);
create table mc3p1 partition of mc3p for values from (1, 1, 1) to (10, 5, 10);
create table mc3p2 partition of mc3p for values from (10, 5, 10) to (10, 10, 10);
create table mc3p3 partition of mc3p for values from (10, 10, 10) to (10, 10, 20);
create table mc3p4 partition of mc3p for values from (10, 10, 20) to (10, maxvalue, maxvalue);
create table mc3p5 partition of mc3p for values from (11, 1, 1) to (20, 10, 10);
create table mc3p6 partition of mc3p for values from (20, 10, 10) to (20, 20, 20);
create table mc3p7 partition of mc3p for values from (20, 20, 20) to (maxvalue, maxvalue, maxvalue);
explain (costs off) select * from mc3p where a = 1;
explain (costs off) select * from mc3p where a = 1 and abs(b) < 1;
explain (costs off) select * from mc3p where a = 1 and abs(b) = 1;
explain (costs off) select * from mc3p where a = 1 and abs(b) = 1 and c < 8;
explain (costs off) select * from mc3p where a = 10 and abs(b) between 5 and 35;
explain (costs off) select * from mc3p where a > 10;
explain (costs off) select * from mc3p where a >= 10;
explain (costs off) select * from mc3p where a < 10;
explain (costs off) select * from mc3p where a <= 10 and abs(b) < 10;
explain (costs off) select * from mc3p where a = 11 and abs(b) = 0;
explain (costs off) select * from mc3p where a = 20 and abs(b) = 10 and c = 100;
explain (costs off) select * from mc3p where a > 20;
explain (costs off) select * from mc3p where a >= 20;
explain (costs off) select * from mc3p where (a = 1 and abs(b) = 1 and c = 1) or (a = 10 and abs(b) = 5 and c = 10) or (a > 11 and a < 20);
explain (costs off) select * from mc3p where (a = 1 and abs(b) = 1 and c = 1) or (a = 10 and abs(b) = 5 and c = 10) or (a > 11 and a < 20) or a < 1;
explain (costs off) select * from mc3p where (a = 1 and abs(b) = 1 and c = 1) or (a = 10 and abs(b) = 5 and c = 10) or (a > 11 and a < 20) or a < 1 or a = 1;
explain (costs off) select * from mc3p where a = 1 or abs(b) = 1 or c = 1;
explain (costs off) select * from mc3p where (a = 1 and abs(b) = 1) or (a = 10 and abs(b) = 10);
explain (costs off) select * from mc3p where (a = 1 and abs(b) = 1) or (a = 10 and abs(b) = 9);
create table mc2p (a int, b int) partition by range (a, b);
create table mc2p_default partition of mc2p default;
create table mc2p0 partition of mc2p for values from (minvalue, minvalue) to (1, minvalue);
create table mc2p1 partition of mc2p for values from (1, minvalue) to (1, 1);
create table mc2p2 partition of mc2p for values from (1, 1) to (2, minvalue);
create table mc2p3 partition of mc2p for values from (2, minvalue) to (2, 1);
create table mc2p4 partition of mc2p for values from (2, 1) to (2, maxvalue);
create table mc2p5 partition of mc2p for values from (2, maxvalue) to (maxvalue, maxvalue);
explain (costs off) select * from mc2p where a < 2;
explain (costs off) select * from mc2p where a = 2 and b < 1;
explain (costs off) select * from mc2p where a > 1;
explain (costs off) select * from mc2p where a = 1 and b > 1;
explain (costs off) select * from mc2p where a = 1 and b is null;
explain (costs off) select * from mc2p where a is null and b is null;
explain (costs off) select * from mc2p where a is null and b = 1;
explain (costs off) select * from mc2p where a is null;
explain (costs off) select * from mc2p where b is null;
create table boolpart (a bool) partition by list (a);
create table boolpart_default partition of boolpart default;
create table boolpart_t partition of boolpart for values in ('true');
create table boolpart_f partition of boolpart for values in ('false');
insert into boolpart values (true), (false), (null);
explain (costs off) select * from boolpart where a in (true, false);
explain (costs off) select * from boolpart where a = false;
explain (costs off) select * from boolpart where not a = false;
explain (costs off) select * from boolpart where a is true or a is not true;
explain (costs off) select * from boolpart where a is not true;
explain (costs off) select * from boolpart where a is not true and a is not false;
explain (costs off) select * from boolpart where a is unknown;
explain (costs off) select * from boolpart where a is not unknown;
select * from boolpart where a in (true, false);
select * from boolpart where a = false;
select * from boolpart where not a = false;
select * from boolpart where a is true or a is not true;
select * from boolpart where a is not true;
select * from boolpart where a is not true and a is not false;
select * from boolpart where a is unknown;
select * from boolpart where a is not unknown;
delete from boolpart where a is null;
create table boolpart_null partition of boolpart for values in (null);
insert into boolpart values(null);
explain (costs off) select * from boolpart where a is not true;
explain (costs off) select * from boolpart where a is not true and a is not false;
explain (costs off) select * from boolpart where a is not false;
explain (costs off) select * from boolpart where a is not unknown;
select * from boolpart where a is not true;
select * from boolpart where a is not true and a is not false;
select * from boolpart where a is not false;
select * from boolpart where a is not unknown;
explain (costs off) select * from boolpart where a is not unknown and a is unknown;
explain (costs off) select * from boolpart where a is false and a is unknown;
explain (costs off) select * from boolpart where a is true and a is unknown;
create table iboolpart (a bool) partition by list ((not a));
create table iboolpart_default partition of iboolpart default;
create table iboolpart_f partition of iboolpart for values in ('true');
create table iboolpart_t partition of iboolpart for values in ('false');
insert into iboolpart values (true), (false), (null);
explain (costs off) select * from iboolpart where a in (true, false);
explain (costs off) select * from iboolpart where a = false;
explain (costs off) select * from iboolpart where not a = false;
explain (costs off) select * from iboolpart where a is true or a is not true;
explain (costs off) select * from iboolpart where a is not true;
explain (costs off) select * from iboolpart where a is not true and a is not false;
explain (costs off) select * from iboolpart where a is unknown;
explain (costs off) select * from iboolpart where a is not unknown;
select * from iboolpart where a in (true, false);
select * from iboolpart where a = false;
select * from iboolpart where not a = false;
select * from iboolpart where a is true or a is not true;
select * from iboolpart where a is not true;
select * from iboolpart where a is not true and a is not false;
select * from iboolpart where a is unknown;
select * from iboolpart where a is not unknown;
delete from iboolpart where a is null;
create table iboolpart_null partition of iboolpart for values in (null);
insert into iboolpart values(null);
select * from iboolpart where a is not true;
select * from iboolpart where a is not true and a is not false;
select * from iboolpart where a is not false;
create table boolrangep (a bool, b bool, c int) partition by range (a,b,c);
create table boolrangep_tf partition of boolrangep for values from ('true', 'false', 0) to ('true', 'false', 100);
create table boolrangep_ft partition of boolrangep for values from ('false', 'true', 0) to ('false', 'true', 100);
create table boolrangep_ff1 partition of boolrangep for values from ('false', 'false', 0) to ('false', 'false', 50);
create table boolrangep_ff2 partition of boolrangep for values from ('false', 'false', 50) to ('false', 'false', 100);
create table boolrangep_null partition of boolrangep default;
explain (costs off)  select * from boolrangep where not a and not b and c = 25;
explain (costs off)  select * from boolrangep where a is not true and not b and c = 25;
explain (costs off)  select * from boolrangep where a is not false and not b and c = 25;
create table coercepart (a varchar) partition by list (a);
create table coercepart_ab partition of coercepart for values in ('ab');
create table coercepart_bc partition of coercepart for values in ('bc');
create table coercepart_cd partition of coercepart for values in ('cd');
explain (costs off) select * from coercepart where a in ('ab', to_char(125, '999'));
explain (costs off) select * from coercepart where a ~ any ('{ab}');
explain (costs off) select * from coercepart where a !~ all ('{ab}');
explain (costs off) select * from coercepart where a ~ any ('{ab,bc}');
explain (costs off) select * from coercepart where a !~ all ('{ab,bc}');
explain (costs off) select * from coercepart where a = any ('{ab,bc}');
explain (costs off) select * from coercepart where a = any ('{ab,null}');
explain (costs off) select * from coercepart where a = any (null::text[]);
explain (costs off) select * from coercepart where a = all ('{ab}');
explain (costs off) select * from coercepart where a = all ('{ab,bc}');
explain (costs off) select * from coercepart where a = all ('{ab,null}');
explain (costs off) select * from coercepart where a = all (null::text[]);
drop table coercepart;
CREATE TABLE part (a INT, b INT) PARTITION BY LIST (a);
CREATE TABLE part_p1 PARTITION OF part FOR VALUES IN (-2,-1,0,1,2);
CREATE TABLE part_p2 PARTITION OF part DEFAULT PARTITION BY RANGE(a);
CREATE TABLE part_p2_p1 PARTITION OF part_p2 DEFAULT;
CREATE TABLE part_rev (b INT, c INT, a INT);
ALTER TABLE part_rev DROP COLUMN c;
ALTER TABLE part ATTACH PARTITION part_rev FOR VALUES IN (3);
INSERT INTO part VALUES (-1,-1), (1,1), (2,NULL), (NULL,-2),(NULL,NULL);
EXPLAIN (COSTS OFF) SELECT tableoid::regclass as part, a, b FROM part WHERE a IS NULL ORDER BY 1, 2, 3;
EXPLAIN (VERBOSE, COSTS OFF) SELECT * FROM part p(x) ORDER BY x;
explain (costs off) select * from mc2p t1, lateral (select count(*) from mc3p t2 where t2.a = t1.b and abs(t2.b) = 1 and t2.c = 1) s where t1.a = 1;
explain (costs off) select * from mc2p t1, lateral (select count(*) from mc3p t2 where t2.c = t1.b and abs(t2.b) = 1 and t2.a = 1) s where t1.a = 1;
explain (costs off) select * from mc2p t1, lateral (select count(*) from mc3p t2 where t2.a = 1 and abs(t2.b) = 1 and t2.c = 1) s where t1.a = 1;
create table rp (a int) partition by range (a);
create table rp0 partition of rp for values from (minvalue) to (1);
create table rp1 partition of rp for values from (1) to (2);
create table rp2 partition of rp for values from (2) to (maxvalue);
explain (costs off) select * from rp where a <> 1;
explain (costs off) select * from rp where a <> 1 and a <> 2;
explain (costs off) select * from lp where a <> 'a';
explain (costs off) select * from lp where a <> 'a' and a is null;
explain (costs off) select * from lp where (a <> 'a' and a <> 'd') or a is null;
explain (costs off) select * from rlp where a = 15 and b <> 'ab' and b <> 'cd' and b <> 'xy' and b is not null;
create table coll_pruning_multi (a text) partition by range (substr(a, 1) collate "POSIX", substr(a, 1) collate "C");
create table coll_pruning_multi1 partition of coll_pruning_multi for values from ('a', 'a') to ('a', 'e');
create table coll_pruning_multi2 partition of coll_pruning_multi for values from ('a', 'e') to ('a', 'z');
create table coll_pruning_multi3 partition of coll_pruning_multi for values from ('b', 'a') to ('b', 'e');
explain (costs off) select * from coll_pruning_multi where substr(a, 1) = 'e' collate "C";
explain (costs off) select * from coll_pruning_multi where substr(a, 1) = 'a' collate "POSIX";
explain (costs off) select * from coll_pruning_multi where substr(a, 1) = 'e' collate "C" and substr(a, 1) = 'a' collate "POSIX";
create table like_op_noprune (a text) partition by list (a);
create table like_op_noprune1 partition of like_op_noprune for values in ('ABC');
create table like_op_noprune2 partition of like_op_noprune for values in ('BCD');
explain (costs off) select * from like_op_noprune where a like '%BC';
create table lparted_by_int2 (a smallint) partition by list (a);
create table lparted_by_int2_1 partition of lparted_by_int2 for values in (1);
create table lparted_by_int2_16384 partition of lparted_by_int2 for values in (16384);
explain (costs off) select * from lparted_by_int2 where a = 100_000_000_000_000;
create table rparted_by_int2 (a smallint) partition by range (a);
create table rparted_by_int2_1 partition of rparted_by_int2 for values from (1) to (10);
create table rparted_by_int2_16384 partition of rparted_by_int2 for values from (10) to (16384);
explain (costs off) select * from rparted_by_int2 where a > 100_000_000_000_000;
create table rparted_by_int2_maxvalue partition of rparted_by_int2 for values from (16384) to (maxvalue);
explain (costs off) select * from rparted_by_int2 where a > 100_000_000_000_000;
drop table lp, coll_pruning, rlp, mc3p, mc2p, boolpart, iboolpart, boolrangep, rp, coll_pruning_multi, like_op_noprune, lparted_by_int2, rparted_by_int2;
create table ab (a int not null, b int not null) partition by list (a);
create table ab_a2 partition of ab for values in(2) partition by list (b);
create table ab_a2_b1 partition of ab_a2 for values in (1);
create table ab_a2_b2 partition of ab_a2 for values in (2);
create table ab_a2_b3 partition of ab_a2 for values in (3);
create table ab_a1 partition of ab for values in(1) partition by list (b);
create table ab_a1_b1 partition of ab_a1 for values in (1);
create table ab_a1_b2 partition of ab_a1 for values in (2);
create table ab_a1_b3 partition of ab_a1 for values in (3);
create table ab_a3 partition of ab for values in(3) partition by list (b);
create table ab_a3_b1 partition of ab_a3 for values in (1);
create table ab_a3_b2 partition of ab_a3 for values in (2);
create table ab_a3_b3 partition of ab_a3 for values in (3);
set enable_indexonlyscan = off;
prepare ab_q1 (int, int, int) as
select * from ab where a between $1 and $2 and b <= $3;
explain (analyze, costs off, summary off, timing off) execute ab_q1 (2, 2, 3);
explain (analyze, costs off, summary off, timing off) execute ab_q1 (1, 2, 3);
deallocate ab_q1;
prepare ab_q1 (int, int) as
select a from ab where a between $1 and $2 and b < 3;
explain (analyze, costs off, summary off, timing off) execute ab_q1 (2, 2);
explain (analyze, costs off, summary off, timing off) execute ab_q1 (2, 4);
prepare ab_q2 (int, int) as
select a from ab where a between $1 and $2 and b < (select 3);
explain (analyze, costs off, summary off, timing off) execute ab_q2 (2, 2);
prepare ab_q3 (int, int) as
select a from ab where b between $1 and $2 and a < (select 3);
explain (analyze, costs off, summary off, timing off) execute ab_q3 (2, 2);
create table list_part (a int) partition by list (a);
create table list_part1 partition of list_part for values in (1);
create table list_part2 partition of list_part for values in (2);
create table list_part3 partition of list_part for values in (3);
create table list_part4 partition of list_part for values in (4);
insert into list_part select generate_series(1,4);
begin;
declare cur SCROLL CURSOR for select 1 from list_part where a > (select 1) and a < (select 4);
move 3 from cur;
fetch backward all from cur;
commit;
begin;
end;
rollback;
drop table list_part;
prepare ab_q4 (int, int) as
select avg(a) from ab where a between $1 and $2 and b < 4;
set parallel_setup_cost = 0;
set parallel_tuple_cost = 0;
set min_parallel_table_scan_size = 0;
set max_parallel_workers_per_gather = 2;
prepare ab_q5 (int, int, int) as
select avg(a) from ab where a in($1,$2,$3) and b < 4;
create table lprt_a (a int not null);
insert into lprt_a select 0 from generate_series(1,100);
insert into lprt_a values(1),(1);
analyze lprt_a;
create index ab_a2_b1_a_idx on ab_a2_b1 (a);
create index ab_a2_b2_a_idx on ab_a2_b2 (a);
create index ab_a2_b3_a_idx on ab_a2_b3 (a);
create index ab_a1_b1_a_idx on ab_a1_b1 (a);
create index ab_a1_b2_a_idx on ab_a1_b2 (a);
create index ab_a1_b3_a_idx on ab_a1_b3 (a);
create index ab_a3_b1_a_idx on ab_a3_b1 (a);
create index ab_a3_b2_a_idx on ab_a3_b2 (a);
create index ab_a3_b3_a_idx on ab_a3_b3 (a);
set enable_hashjoin = 0;
set enable_mergejoin = 0;
set enable_memoize = 0;
select c.relname,c.relpages,c.reltuples,i.indisvalid,s.autovacuum_count,s.autoanalyze_count
from pg_class c
left join pg_stat_all_tables s on c.oid = s.relid
left join pg_index i on c.oid = i.indexrelid
where c.relname like 'ab\_%' order by c.relname;
insert into lprt_a values(3),(3);
delete from lprt_a where a = 1;
reset enable_hashjoin;
reset enable_mergejoin;
reset enable_memoize;
reset parallel_setup_cost;
reset parallel_tuple_cost;
reset min_parallel_table_scan_size;
reset max_parallel_workers_per_gather;
explain (analyze, costs off, summary off, timing off)
select * from ab where a = (select max(a) from lprt_a) and b = (select max(a)-1 from lprt_a);
explain (analyze, costs off, summary off, timing off)
select * from (select * from ab where a = 1 union all select * from ab) ab where b = (select 1);
explain (analyze, costs off, summary off, timing off)
select * from (select * from ab where a = 1 union all (values(10,5)) union all select * from ab) ab where b = (select 1);
create table xy_1 (x int, y int);
insert into xy_1 values(100,-10);
set enable_bitmapscan = 0;
set enable_indexscan = 0;
prepare ab_q6 as
select * from (
	select tableoid::regclass,a,b from ab
union all
	select tableoid::regclass,x,y from xy_1
union all
	select tableoid::regclass,a,b from ab
) ab where a = $1 and b = (select -10);
explain (analyze, costs off, summary off, timing off) execute ab_q6(1);
execute ab_q6(100);
reset enable_bitmapscan;
reset enable_indexscan;
deallocate ab_q1;
deallocate ab_q2;
deallocate ab_q3;
deallocate ab_q4;
deallocate ab_q5;
deallocate ab_q6;
select c.relname,c.relpages,c.reltuples,i.indisvalid,s.autovacuum_count,s.autoanalyze_count
from pg_class c
left join pg_stat_all_tables s on c.oid = s.relid
left join pg_index i on c.oid = i.indexrelid
where c.relname like 'ab\_%' order by c.relname;
insert into ab values (1,2);
explain (analyze, costs off, summary off, timing off)
update ab_a1 set b = 3 from ab where ab.a = 1 and ab.a = ab_a1.a;
table ab;
truncate ab;
insert into ab values (1, 1), (1, 2), (1, 3), (2, 1);
explain (analyze, costs off, summary off, timing off)
update ab_a1 set b = 3 from ab_a2 where ab_a2.b = (select 1);
select tableoid::regclass, * from ab;
drop table ab, lprt_a;
create table tbl1(col1 int);
insert into tbl1 values (501), (505);
create table tprt (col1 int) partition by range (col1);
create table tprt_1 partition of tprt for values from (1) to (501);
create table tprt_2 partition of tprt for values from (501) to (1001);
create table tprt_3 partition of tprt for values from (1001) to (2001);
create table tprt_4 partition of tprt for values from (2001) to (3001);
create table tprt_5 partition of tprt for values from (3001) to (4001);
create table tprt_6 partition of tprt for values from (4001) to (5001);
create index tprt1_idx on tprt_1 (col1);
create index tprt2_idx on tprt_2 (col1);
create index tprt3_idx on tprt_3 (col1);
create index tprt4_idx on tprt_4 (col1);
create index tprt5_idx on tprt_5 (col1);
create index tprt6_idx on tprt_6 (col1);
insert into tprt values (10), (20), (501), (502), (505), (1001), (4500);
set enable_hashjoin = off;
set enable_mergejoin = off;
explain (analyze, costs off, summary off, timing off)
select * from tbl1 join tprt on tbl1.col1 > tprt.col1;
explain (analyze, costs off, summary off, timing off)
select * from tbl1 join tprt on tbl1.col1 = tprt.col1;
select tbl1.col1, tprt.col1 from tbl1
inner join tprt on tbl1.col1 > tprt.col1
order by tbl1.col1, tprt.col1;
select tbl1.col1, tprt.col1 from tbl1
inner join tprt on tbl1.col1 = tprt.col1
order by tbl1.col1, tprt.col1;
insert into tbl1 values (1001), (1010), (1011);
explain (analyze, costs off, summary off, timing off)
select * from tbl1 inner join tprt on tbl1.col1 > tprt.col1;
explain (analyze, costs off, summary off, timing off)
select * from tbl1 inner join tprt on tbl1.col1 = tprt.col1;
select tbl1.col1, tprt.col1 from tbl1
inner join tprt on tbl1.col1 > tprt.col1
order by tbl1.col1, tprt.col1;
select tbl1.col1, tprt.col1 from tbl1
inner join tprt on tbl1.col1 = tprt.col1
order by tbl1.col1, tprt.col1;
delete from tbl1;
insert into tbl1 values (4400);
explain (analyze, costs off, summary off, timing off)
select * from tbl1 join tprt on tbl1.col1 < tprt.col1;
select tbl1.col1, tprt.col1 from tbl1
inner join tprt on tbl1.col1 < tprt.col1
order by tbl1.col1, tprt.col1;
delete from tbl1;
insert into tbl1 values (10000);
explain (analyze, costs off, summary off, timing off)
select * from tbl1 join tprt on tbl1.col1 = tprt.col1;
select tbl1.col1, tprt.col1 from tbl1
inner join tprt on tbl1.col1 = tprt.col1
order by tbl1.col1, tprt.col1;
drop table tbl1, tprt;
create table part_abc (a int not null, b int not null, c int not null) partition by list (a);
create table part_bac (b int not null, a int not null, c int not null) partition by list (b);
create table part_cab (c int not null, a int not null, b int not null) partition by list (c);
create table part_abc_p1 (a int not null, b int not null, c int not null);
alter table part_abc attach partition part_bac for values in(1);
alter table part_bac attach partition part_cab for values in(2);
alter table part_cab attach partition part_abc_p1 for values in(3);
prepare part_abc_q1 (int, int, int) as
select * from part_abc where a = $1 and b = $2 and c = $3;
explain (analyze, costs off, summary off, timing off) execute part_abc_q1 (1, 2, 3);
deallocate part_abc_q1;
drop table part_abc;
create table listp (a int, b int) partition by list (a);
create table listp_1 partition of listp for values in(1) partition by list (b);
create table listp_1_1 partition of listp_1 for values in(1);
create table listp_2 partition of listp for values in(2) partition by list (b);
create table listp_2_1 partition of listp_2 for values in(2);
select * from listp where b = 1;
prepare q1 (int,int) as select * from listp where b in ($1,$2);
explain (analyze, costs off, summary off, timing off)  execute q1 (1,1);
explain (analyze, costs off, summary off, timing off)  execute q1 (2,2);
explain (analyze, costs off, summary off, timing off)  execute q1 (0,0);
deallocate q1;
prepare q1 (int,int,int,int) as select * from listp where b in($1,$2) and $3 <> b and $4 <> b;
explain (analyze, costs off, summary off, timing off)  execute q1 (1,2,2,0);
explain (analyze, costs off, summary off, timing off)  execute q1 (1,2,2,1);
explain (analyze, costs off, summary off, timing off)
select * from listp where a = (select null::int);
drop table listp;
create table stable_qual_pruning (a timestamp) partition by range (a);
create table stable_qual_pruning1 partition of stable_qual_pruning
  for values from ('2000-01-01') to ('2000-02-01');
create table stable_qual_pruning2 partition of stable_qual_pruning
  for values from ('2000-02-01') to ('2000-03-01');
create table stable_qual_pruning3 partition of stable_qual_pruning
  for values from ('3000-02-01') to ('3000-03-01');
explain (analyze, costs off, summary off, timing off)
select * from stable_qual_pruning where a < localtimestamp;
explain (analyze, costs off, summary off, timing off)
select * from stable_qual_pruning where a < '2000-02-01'::timestamptz;
explain (analyze, costs off, summary off, timing off)
select * from stable_qual_pruning
  where a = any(array['2010-02-01', '2020-01-01']::timestamp[]);
explain (analyze, costs off, summary off, timing off)
select * from stable_qual_pruning
  where a = any(array['2000-02-01', '2010-01-01']::timestamp[]);
explain (analyze, costs off, summary off, timing off)
select * from stable_qual_pruning
  where a = any(array['2000-02-01', localtimestamp]::timestamp[]);
explain (analyze, costs off, summary off, timing off)
select * from stable_qual_pruning
  where a = any(array['2010-02-01', '2020-01-01']::timestamptz[]);
explain (analyze, costs off, summary off, timing off)
select * from stable_qual_pruning
  where a = any(array['2000-02-01', '2010-01-01']::timestamptz[]);
explain (analyze, costs off, summary off, timing off)
select * from stable_qual_pruning
  where a = any(null::timestamptz[]);
drop table stable_qual_pruning;
create table mc3p (a int, b int, c int) partition by range (a, abs(b), c);
create table mc3p0 partition of mc3p
  for values from (0, 0, 0) to (0, maxvalue, maxvalue);
create table mc3p1 partition of mc3p
  for values from (1, 1, 1) to (2, minvalue, minvalue);
create table mc3p2 partition of mc3p
  for values from (2, minvalue, minvalue) to (3, maxvalue, maxvalue);
insert into mc3p values (0, 1, 1), (1, 1, 1), (2, 1, 1);
explain (analyze, costs off, summary off, timing off)
select * from mc3p where a < 3 and abs(b) = 1;
prepare ps1 as
  select * from mc3p where a = $1 and abs(b) < (select 3);
explain (analyze, costs off, summary off, timing off)
execute ps1(1);
deallocate ps1;
prepare ps2 as
  select * from mc3p where a <= $1 and abs(b) < (select 3);
explain (analyze, costs off, summary off, timing off)
execute ps2(1);
deallocate ps2;
drop table mc3p;
create table boolvalues (value bool not null);
insert into boolvalues values('t'),('f');
create table boolp (a bool) partition by list (a);
create table boolp_t partition of boolp for values in('t');
create table boolp_f partition of boolp for values in('f');
explain (analyze, costs off, summary off, timing off)
select * from boolp where a = (select value from boolvalues where value);
explain (analyze, costs off, summary off, timing off)
select * from boolp where a = (select value from boolvalues where not value);
drop table boolp;
set enable_seqscan = off;
set enable_sort = off;
create table ma_test (a int, b int) partition by range (a);
create table ma_test_p1 partition of ma_test for values from (0) to (10);
create table ma_test_p2 partition of ma_test for values from (10) to (20);
create table ma_test_p3 partition of ma_test for values from (20) to (30);
insert into ma_test select x,x from generate_series(0,29) t(x);
create index on ma_test (b);
analyze ma_test;
prepare mt_q1 (int) as select a from ma_test where a >= $1 and a % 10 = 5 order by b;
explain (analyze, costs off, summary off, timing off) execute mt_q1(15);
execute mt_q1(15);
explain (analyze, costs off, summary off, timing off) execute mt_q1(25);
execute mt_q1(25);
explain (analyze, costs off, summary off, timing off) execute mt_q1(35);
execute mt_q1(35);
deallocate mt_q1;
prepare mt_q2 (int) as select * from ma_test where a >= $1 order by b limit 1;
explain (analyze, verbose, costs off, summary off, timing off) execute mt_q2 (35);
deallocate mt_q2;
explain (analyze, costs off, summary off, timing off) select * from ma_test where a >= (select min(b) from ma_test_p2) order by b;
reset enable_seqscan;
reset enable_sort;
drop table ma_test;
reset enable_indexonlyscan;
create table pp_arrpart (a int[]) partition by list (a);
create table pp_arrpart1 partition of pp_arrpart for values in ('{1}');
create table pp_arrpart2 partition of pp_arrpart for values in ('{2, 3}', '{4, 5}');
explain (costs off) select * from pp_arrpart where a = '{1}';
explain (costs off) select * from pp_arrpart where a = '{1, 2}';
explain (costs off) select * from pp_arrpart where a in ('{4, 5}', '{1}');
explain (costs off) update pp_arrpart set a = a where a = '{1}';
explain (costs off) delete from pp_arrpart where a = '{1}';
drop table pp_arrpart;
create table pph_arrpart (a int[]) partition by hash (a);
create table pph_arrpart1 partition of pph_arrpart for values with (modulus 2, remainder 0);
create table pph_arrpart2 partition of pph_arrpart for values with (modulus 2, remainder 1);
insert into pph_arrpart values ('{1}'), ('{1, 2}'), ('{4, 5}');
select tableoid::regclass, * from pph_arrpart order by 1;
explain (costs off) select * from pph_arrpart where a = '{1}';
explain (costs off) select * from pph_arrpart where a = '{1, 2}';
explain (costs off) select * from pph_arrpart where a in ('{4, 5}', '{1}');
drop table pph_arrpart;
create type pp_colors as enum ('green', 'blue', 'black');
create table pp_enumpart (a pp_colors) partition by list (a);
create table pp_enumpart_green partition of pp_enumpart for values in ('green');
create table pp_enumpart_blue partition of pp_enumpart for values in ('blue');
explain (costs off) select * from pp_enumpart where a = 'blue';
explain (costs off) select * from pp_enumpart where a = 'black';
drop table pp_enumpart;
drop type pp_colors;
create type pp_rectype as (a int, b int);
create table pp_recpart (a pp_rectype) partition by list (a);
create table pp_recpart_11 partition of pp_recpart for values in ('(1,1)');
create table pp_recpart_23 partition of pp_recpart for values in ('(2,3)');
explain (costs off) select * from pp_recpart where a = '(1,1)'::pp_rectype;
explain (costs off) select * from pp_recpart where a = '(1,2)'::pp_rectype;
drop table pp_recpart;
drop type pp_rectype;
create table pp_intrangepart (a int4range) partition by list (a);
create table pp_intrangepart12 partition of pp_intrangepart for values in ('[1,2]');
create table pp_intrangepart2inf partition of pp_intrangepart for values in ('[2,)');
explain (costs off) select * from pp_intrangepart where a = '[1,2]'::int4range;
explain (costs off) select * from pp_intrangepart where a = '(1,2)'::int4range;
drop table pp_intrangepart;
create table pp_lp (a int, value int) partition by list (a);
create table pp_lp1 partition of pp_lp for values in(1);
create table pp_lp2 partition of pp_lp for values in(2);
explain (costs off) select * from pp_lp where a = 1;
explain (costs off) update pp_lp set value = 10 where a = 1;
explain (costs off) delete from pp_lp where a = 1;
set enable_partition_pruning = off;
set constraint_exclusion = 'partition';
explain (costs off) select * from pp_lp where a = 1;
explain (costs off) update pp_lp set value = 10 where a = 1;
explain (costs off) delete from pp_lp where a = 1;
set constraint_exclusion = 'off';
explain (costs off) select * from pp_lp where a = 1;
explain (costs off) update pp_lp set value = 10 where a = 1;
explain (costs off) delete from pp_lp where a = 1;
drop table pp_lp;
create table inh_lp (a int, value int);
create table inh_lp1 (a int, value int, check(a = 1)) inherits (inh_lp);
create table inh_lp2 (a int, value int, check(a = 2)) inherits (inh_lp);
set constraint_exclusion = 'partition';
explain (costs off) select * from inh_lp where a = 1;
explain (costs off) update inh_lp set value = 10 where a = 1;
explain (costs off) delete from inh_lp where a = 1;
explain (costs off) update inh_lp1 set value = 10 where a = 2;
drop table inh_lp cascade;
reset enable_partition_pruning;
reset constraint_exclusion;
create temp table pp_temp_parent (a int) partition by list (a);
create temp table pp_temp_part_1 partition of pp_temp_parent for values in (1);
create temp table pp_temp_part_def partition of pp_temp_parent default;
explain (costs off) select * from pp_temp_parent where true;
explain (costs off) select * from pp_temp_parent where a = 2;
drop table pp_temp_parent;
create temp table p (a int, b int, c int) partition by list (a);
create temp table p1 partition of p for values in (1);
create temp table p2 partition of p for values in (2);
create temp table q (a int, b int, c int) partition by list (a);
create temp table q1 partition of q for values in (1) partition by list (b);
create temp table q11 partition of q1 for values in (1) partition by list (c);
create temp table q111 partition of q11 for values in (1);
create temp table q2 partition of q for values in (2) partition by list (b);
create temp table q21 partition of q2 for values in (1);
create temp table q22 partition of q2 for values in (2);
insert into q22 values (2, 2, 3);
explain (costs off)
select *
from (
      select * from p
      union all
      select * from q1
      union all
      select 1, 1, 1
     ) s(a, b, c)
where s.a = 1 and s.b = 1 and s.c = (select 1);
select *
from (
      select * from p
      union all
      select * from q1
      union all
      select 1, 1, 1
     ) s(a, b, c)
where s.a = 1 and s.b = 1 and s.c = (select 1);
prepare q (int, int) as
select *
from (
      select * from p
      union all
      select * from q1
      union all
      select 1, 1, 1
     ) s(a, b, c)
where s.a = $1 and s.b = $2 and s.c = (select 1);
explain (costs off) execute q (1, 1);
execute q (1, 1);
drop table p, q;
create table listp (a int, b int) partition by list (a);
create table listp1 partition of listp for values in(1);
create table listp2 partition of listp for values in(2) partition by list(b);
create table listp2_10 partition of listp2 for values in (10);
explain (analyze, costs off, summary off, timing off)
select * from listp where a = (select 2) and b <> 10;
set enable_partition_pruning to off;
set constraint_exclusion to 'partition';
explain (costs off) select * from listp1 where a = 2;
explain (costs off) update listp1 set a = 1 where a = 2;
set constraint_exclusion to 'on';
explain (costs off) select * from listp1 where a = 2;
explain (costs off) update listp1 set a = 1 where a = 2;
reset constraint_exclusion;
reset enable_partition_pruning;
drop table listp;
set parallel_setup_cost to 0;
set parallel_tuple_cost to 0;
create table listp (a int) partition by list(a);
create table listp_12 partition of listp for values in(1,2) partition by list(a);
create table listp_12_1 partition of listp_12 for values in(1);
create table listp_12_2 partition of listp_12 for values in(2);
alter table listp_12_1 set (parallel_workers = 0);
drop table listp;
reset parallel_tuple_cost;
reset parallel_setup_cost;
set enable_sort to 0;
create table rangep (a int, b int) partition by range (a);
create table rangep_0_to_100 partition of rangep for values from (0) to (100) partition by list (b);
create table rangep_0_to_100_1 partition of rangep_0_to_100 for values in(1);
create table rangep_0_to_100_2 partition of rangep_0_to_100 for values in(2);
create table rangep_0_to_100_3 partition of rangep_0_to_100 for values in(3);
create table rangep_100_to_200 partition of rangep for values from (100) to (200);
create index on rangep (a);
explain (analyze on, costs off, timing off, summary off)
select * from rangep where b IN((select 1),(select 2)) order by a;
reset enable_sort;
drop table rangep;
create table rp_prefix_test1 (a int, b varchar) partition by range(a, b);
create table rp_prefix_test1_p1 partition of rp_prefix_test1 for values from (1, 'a') to (1, 'b');
create table rp_prefix_test1_p2 partition of rp_prefix_test1 for values from (2, 'a') to (2, 'b');
explain (costs off) select * from rp_prefix_test1 where a <= 1 and b = 'a';
create table rp_prefix_test2 (a int, b int, c int) partition by range(a, b, c);
create table rp_prefix_test2_p1 partition of rp_prefix_test2 for values from (1, 1, 0) to (1, 1, 10);
create table rp_prefix_test2_p2 partition of rp_prefix_test2 for values from (2, 2, 0) to (2, 2, 10);
explain (costs off) select * from rp_prefix_test2 where a <= 1 and b = 1 and c >= 0;
create table rp_prefix_test3 (a int, b int, c int, d int) partition by range(a, b, c, d);
create table rp_prefix_test3_p1 partition of rp_prefix_test3 for values from (1, 1, 1, 0) to (1, 1, 1, 10);
create table rp_prefix_test3_p2 partition of rp_prefix_test3 for values from (2, 2, 2, 0) to (2, 2, 2, 10);
explain (costs off) select * from rp_prefix_test3 where a >= 1 and b >= 1 and b >= 2 and c >= 2 and d >= 0;
explain (costs off) select * from rp_prefix_test3 where a >= 1 and b >= 1 and b = 2 and c = 2 and d >= 0;
drop table rp_prefix_test1;
drop table rp_prefix_test2;
drop table rp_prefix_test3;
select
  'explain (costs off) select tableoid::regclass,* from hp_prefix_test where ' ||
  string_agg(c.colname || case when g.s & (1 << c.colpos) = 0 then ' is null' else ' = ' || (colpos+1)::text end, ' and ' order by c.colpos)
from (values('a',0),('b',1),('c',2),('d',3)) c(colname, colpos), generate_Series(0,15) g(s)
group by g.s
order by g.s;
select
  'select tableoid::regclass,* from hp_prefix_test where ' ||
  string_agg(c.colname || case when g.s & (1 << c.colpos) = 0 then ' is null' else ' = ' || (colpos+1)::text end, ' and ' order by c.colpos)
from (values('a',0),('b',1),('c',2),('d',3)) c(colname, colpos), generate_Series(0,15) g(s)
group by g.s
order by g.s;
create operator === (
   leftarg = int4,
   rightarg = int4,
   procedure = int4eq,
   commutator = ===,
   hashes
);
drop operator ===(int4, int4);
