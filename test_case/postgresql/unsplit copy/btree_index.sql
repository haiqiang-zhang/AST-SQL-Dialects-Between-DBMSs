CREATE TABLE bt_i4_heap (
	seqno 		int4,
	random 		int4
);
CREATE TABLE bt_name_heap (
	seqno 		name,
	random 		int4
);
CREATE TABLE bt_txt_heap (
	seqno 		text,
	random 		int4
);
CREATE TABLE bt_f8_heap (
	seqno 		float8,
	random 		int4
);
ANALYZE bt_i4_heap;
ANALYZE bt_name_heap;
ANALYZE bt_txt_heap;
ANALYZE bt_f8_heap;
CREATE INDEX bt_i4_index ON bt_i4_heap USING btree (seqno int4_ops);
CREATE INDEX bt_name_index ON bt_name_heap USING btree (seqno name_ops);
CREATE INDEX bt_txt_index ON bt_txt_heap USING btree (seqno text_ops);
CREATE INDEX bt_f8_index ON bt_f8_heap USING btree (seqno float8_ops);
SELECT b.*
   FROM bt_i4_heap b
   WHERE b.seqno < 1;
SELECT b.*
   FROM bt_i4_heap b
   WHERE b.seqno >= 9999;
SELECT b.*
   FROM bt_i4_heap b
   WHERE b.seqno = 4500;
SELECT b.*
   FROM bt_name_heap b
   WHERE b.seqno < '1'::name;
SELECT b.*
   FROM bt_name_heap b
   WHERE b.seqno >= '9999'::name;
SELECT b.*
   FROM bt_name_heap b
   WHERE b.seqno = '4500'::name;
SELECT b.*
   FROM bt_txt_heap b
   WHERE b.seqno < '1'::text;
SELECT b.*
   FROM bt_txt_heap b
   WHERE b.seqno >= '9999'::text;
SELECT b.*
   FROM bt_txt_heap b
   WHERE b.seqno = '4500'::text;
SELECT b.*
   FROM bt_f8_heap b
   WHERE b.seqno < '1'::float8;
SELECT b.*
   FROM bt_f8_heap b
   WHERE b.seqno >= '9999'::float8;
SELECT b.*
   FROM bt_f8_heap b
   WHERE b.seqno = '4500'::float8;
set enable_seqscan to false;
set enable_indexscan to true;
set enable_bitmapscan to false;
set enable_seqscan to false;
set enable_indexscan to true;
set enable_bitmapscan to false;
explain (costs off)
select proname from pg_proc where proname like E'RI\\_FKey%del' order by 1;
select proname from pg_proc where proname like E'RI\\_FKey%del' order by 1;
explain (costs off)
select proname from pg_proc where proname ilike '00%foo' order by 1;
select proname from pg_proc where proname ilike '00%foo' order by 1;
explain (costs off)
select proname from pg_proc where proname ilike 'ri%foo' order by 1;
set enable_indexscan to false;
set enable_bitmapscan to true;
explain (costs off)
select proname from pg_proc where proname like E'RI\\_FKey%del' order by 1;
select proname from pg_proc where proname like E'RI\\_FKey%del' order by 1;
explain (costs off)
select proname from pg_proc where proname ilike '00%foo' order by 1;
select proname from pg_proc where proname ilike '00%foo' order by 1;
explain (costs off)
select proname from pg_proc where proname ilike 'ri%foo' order by 1;
reset enable_seqscan;
reset enable_indexscan;
reset enable_bitmapscan;
create temp table btree_bpchar (f1 text collate "C");
create index on btree_bpchar(f1 bpchar_ops) WITH (deduplicate_items=on);
insert into btree_bpchar values ('foo'), ('fool'), ('bar'), ('quux');
explain (costs off)
select * from btree_bpchar where f1 like 'foo';
select * from btree_bpchar where f1 like 'foo';
explain (costs off)
select * from btree_bpchar where f1 like 'foo%';
select * from btree_bpchar where f1 like 'foo%';
explain (costs off)
select * from btree_bpchar where f1::bpchar like 'foo';
select * from btree_bpchar where f1::bpchar like 'foo';
explain (costs off)
select * from btree_bpchar where f1::bpchar like 'foo%';
select * from btree_bpchar where f1::bpchar like 'foo%';
insert into btree_bpchar select 'foo' from generate_series(1,1500);
CREATE TABLE dedup_unique_test_table (a int) WITH (autovacuum_enabled=false);
CREATE UNIQUE INDEX dedup_unique ON dedup_unique_test_table (a) WITH (deduplicate_items=on);
CREATE UNIQUE INDEX plain_unique ON dedup_unique_test_table (a) WITH (deduplicate_items=off);
DO $$
BEGIN
    FOR r IN 1..1350 LOOP
        DELETE FROM dedup_unique_test_table;
        INSERT INTO dedup_unique_test_table SELECT 1;
    END LOOP;
END$$;
DROP INDEX plain_unique;
DELETE FROM dedup_unique_test_table WHERE a = 1;
INSERT INTO dedup_unique_test_table SELECT i FROM generate_series(0,450) i;
create table btree_tall_tbl(id int4, t text);
alter table btree_tall_tbl alter COLUMN t set storage plain;
create index btree_tall_idx on btree_tall_tbl (t, id) with (fillfactor = 10);
insert into btree_tall_tbl select g, repeat('x', 250)
from generate_series(1, 130) g;
CREATE TABLE delete_test_table (a bigint, b bigint, c bigint, d bigint);
INSERT INTO delete_test_table SELECT i, 1, 2, 3 FROM generate_series(1,80000) i;
ALTER TABLE delete_test_table ADD PRIMARY KEY (a,b,c,d);
DELETE FROM delete_test_table WHERE a < 79990;
VACUUM delete_test_table;
INSERT INTO delete_test_table SELECT i, 1, 2, 3 FROM generate_series(1,1000) i;
CREATE INDEX btree_tall_idx2 ON btree_tall_tbl (id);
DROP INDEX btree_tall_idx2;
CREATE TABLE btree_part (id int4) PARTITION BY RANGE (id);
CREATE INDEX btree_part_idx ON btree_part(id);
DROP TABLE btree_part;
