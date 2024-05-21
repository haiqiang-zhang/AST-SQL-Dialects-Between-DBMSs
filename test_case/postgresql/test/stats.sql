SHOW track_counts;
SET enable_seqscan TO on;
SET enable_indexscan TO on;
SET enable_indexonlyscan TO off;
SET LOCAL stats_fetch_consistency = snapshot;
CREATE TABLE prevstats AS
SELECT t.seq_scan, t.seq_tup_read, t.idx_scan, t.idx_tup_fetch,
       (b.heap_blks_read + b.heap_blks_hit) AS heap_blks,
       (b.idx_blks_read + b.idx_blks_hit) AS idx_blks,
       pg_stat_get_snapshot_timestamp() as snap_ts
  FROM pg_catalog.pg_stat_user_tables AS t,
       pg_catalog.pg_statio_user_tables AS b
 WHERE t.relname='tenk2' AND b.relname='tenk2';
COMMIT;
CREATE TABLE trunc_stats_test(id serial);
CREATE TABLE trunc_stats_test1(id serial, stuff text);
CREATE TABLE trunc_stats_test2(id serial);
CREATE TABLE trunc_stats_test3(id serial, stuff text);
CREATE TABLE trunc_stats_test4(id serial);
INSERT INTO trunc_stats_test DEFAULT VALUES;
INSERT INTO trunc_stats_test DEFAULT VALUES;
INSERT INTO trunc_stats_test DEFAULT VALUES;
TRUNCATE trunc_stats_test;
INSERT INTO trunc_stats_test1 DEFAULT VALUES;
INSERT INTO trunc_stats_test1 DEFAULT VALUES;
INSERT INTO trunc_stats_test1 DEFAULT VALUES;
UPDATE trunc_stats_test1 SET id = id + 10 WHERE id IN (1, 2);
DELETE FROM trunc_stats_test1 WHERE id = 3;
BEGIN;
UPDATE trunc_stats_test1 SET id = id + 100;
TRUNCATE trunc_stats_test1;
INSERT INTO trunc_stats_test1 DEFAULT VALUES;
COMMIT;
BEGIN;
INSERT INTO trunc_stats_test2 DEFAULT VALUES;
INSERT INTO trunc_stats_test2 DEFAULT VALUES;
SAVEPOINT p1;
INSERT INTO trunc_stats_test2 DEFAULT VALUES;
TRUNCATE trunc_stats_test2;
INSERT INTO trunc_stats_test2 DEFAULT VALUES;
RELEASE SAVEPOINT p1;
COMMIT;
BEGIN;
INSERT INTO trunc_stats_test3 DEFAULT VALUES;
INSERT INTO trunc_stats_test3 DEFAULT VALUES;
SAVEPOINT p1;
INSERT INTO trunc_stats_test3 DEFAULT VALUES;
INSERT INTO trunc_stats_test3 DEFAULT VALUES;
TRUNCATE trunc_stats_test3;
INSERT INTO trunc_stats_test3 DEFAULT VALUES;
ROLLBACK TO SAVEPOINT p1;
COMMIT;
BEGIN;
INSERT INTO trunc_stats_test4 DEFAULT VALUES;
INSERT INTO trunc_stats_test4 DEFAULT VALUES;
TRUNCATE trunc_stats_test4;
INSERT INTO trunc_stats_test4 DEFAULT VALUES;
ROLLBACK;
SET enable_bitmapscan TO off;
RESET enable_bitmapscan;
SELECT pg_stat_force_next_flush();
BEGIN;
SET LOCAL stats_fetch_consistency = snapshot;
SELECT relname, n_tup_ins, n_tup_upd, n_tup_del, n_live_tup, n_dead_tup
  FROM pg_stat_user_tables
 WHERE relname like 'trunc_stats_test%' order by relname;
SELECT st.seq_scan >= pr.seq_scan + 1,
       st.seq_tup_read >= pr.seq_tup_read + cl.reltuples,
       st.idx_scan >= pr.idx_scan + 1,
       st.idx_tup_fetch >= pr.idx_tup_fetch + 1
  FROM pg_stat_user_tables AS st, pg_class AS cl, prevstats AS pr
 WHERE st.relname='tenk2' AND cl.relname='tenk2';
SELECT st.heap_blks_read + st.heap_blks_hit >= pr.heap_blks + cl.relpages,
       st.idx_blks_read + st.idx_blks_hit >= pr.idx_blks + 1
  FROM pg_statio_user_tables AS st, pg_class AS cl, prevstats AS pr
 WHERE st.relname='tenk2' AND cl.relname='tenk2';
SELECT pr.snap_ts < pg_stat_get_snapshot_timestamp() as snapshot_newer
FROM prevstats AS pr;
COMMIT;
SET LOCAL stats_fetch_consistency = none;
COMMIT;
BEGIN;
COMMIT;
BEGIN;
ROLLBACK;
SELECT pg_stat_force_next_flush();
BEGIN;
ROLLBACK;
BEGIN;
COMMIT;
BEGIN;
COMMIT;
CREATE TABLE drop_stats_test();
INSERT INTO drop_stats_test DEFAULT VALUES;
DROP TABLE drop_stats_test;
BEGIN;
ROLLBACK;
SELECT pg_stat_force_next_flush();
BEGIN;
COMMIT;
SELECT pg_stat_force_next_flush();
BEGIN;
COMMIT;
SELECT pg_stat_force_next_flush();
BEGIN;
SAVEPOINT sp1;
ROLLBACK TO SAVEPOINT sp1;
COMMIT;
BEGIN;
SAVEPOINT sp1;
COMMIT;
DROP TABLE trunc_stats_test, trunc_stats_test1, trunc_stats_test2, trunc_stats_test3, trunc_stats_test4;
DROP TABLE prevstats;
BEGIN;
CREATE TEMPORARY TABLE test_last_scan(idx_col int primary key, noidx_col int);
INSERT INTO test_last_scan(idx_col, noidx_col) VALUES(1, 1);
SELECT pg_stat_force_next_flush();
SELECT last_seq_scan, last_idx_scan FROM pg_stat_all_tables WHERE relid = 'test_last_scan'::regclass;
COMMIT;
SELECT seq_scan, idx_scan FROM pg_stat_all_tables WHERE relid = 'test_last_scan'::regclass;
BEGIN;
SET LOCAL enable_seqscan TO on;
SET LOCAL enable_indexscan TO on;
SET LOCAL enable_bitmapscan TO off;
EXPLAIN (COSTS off) SELECT count(*) FROM test_last_scan WHERE noidx_col = 1;
SELECT count(*) FROM test_last_scan WHERE noidx_col = 1;
SET LOCAL enable_seqscan TO off;
EXPLAIN (COSTS off) SELECT count(*) FROM test_last_scan WHERE idx_col = 1;
SELECT count(*) FROM test_last_scan WHERE idx_col = 1;
SELECT pg_stat_force_next_flush();
COMMIT;
BEGIN;
SET LOCAL enable_seqscan TO on;
SET LOCAL enable_indexscan TO off;
SET LOCAL enable_bitmapscan TO off;
EXPLAIN (COSTS off) SELECT count(*) FROM test_last_scan WHERE noidx_col = 1;
SELECT count(*) FROM test_last_scan WHERE noidx_col = 1;
SELECT pg_stat_force_next_flush();
COMMIT;
BEGIN;
SET LOCAL enable_seqscan TO off;
SET LOCAL enable_indexscan TO on;
SET LOCAL enable_bitmapscan TO off;
EXPLAIN (COSTS off) SELECT count(*) FROM test_last_scan WHERE idx_col = 1;
SELECT count(*) FROM test_last_scan WHERE idx_col = 1;
SELECT pg_stat_force_next_flush();
COMMIT;
BEGIN;
SET LOCAL enable_seqscan TO off;
SET LOCAL enable_indexscan TO off;
SET LOCAL enable_bitmapscan TO on;
EXPLAIN (COSTS off) SELECT count(*) FROM test_last_scan WHERE idx_col = 1;
SELECT count(*) FROM test_last_scan WHERE idx_col = 1;
SELECT pg_stat_force_next_flush();
COMMIT;
SELECT pg_stat_force_next_flush();
COMMIT;
SELECT (n_tup_ins + n_tup_upd) > 0 AS has_data FROM pg_stat_all_tables
  WHERE relid = 'pg_shdescription'::regclass;
SELECT (n_tup_ins + n_tup_upd) > 0 AS has_data FROM pg_stat_all_tables
  WHERE relid = 'pg_shdescription'::regclass;
SELECT (current_schemas(true))[1] = ('pg_temp_' || beid::text) AS match
FROM pg_stat_get_backend_idset() beid
WHERE pg_stat_get_backend_pid(beid) = pg_backend_pid();
BEGIN;
SET LOCAL stats_fetch_consistency = snapshot;
SELECT pg_stat_get_snapshot_timestamp();
SELECT pg_stat_get_function_calls(0);
SELECT pg_stat_get_snapshot_timestamp() >= NOW();
SELECT pg_stat_clear_snapshot();
SELECT pg_stat_get_snapshot_timestamp();
COMMIT;
BEGIN;
SET LOCAL stats_fetch_consistency = cache;
SELECT pg_stat_get_function_calls(0);
SELECT pg_stat_get_snapshot_timestamp() IS NOT NULL AS snapshot_ok;
SET LOCAL stats_fetch_consistency = snapshot;
SELECT pg_stat_get_snapshot_timestamp() IS NOT NULL AS snapshot_ok;
SELECT pg_stat_get_function_calls(0);
SELECT pg_stat_get_snapshot_timestamp() IS NOT NULL AS snapshot_ok;
SET LOCAL stats_fetch_consistency = none;
SELECT pg_stat_get_snapshot_timestamp() IS NOT NULL AS snapshot_ok;
SELECT pg_stat_get_function_calls(0);
SELECT pg_stat_get_snapshot_timestamp() IS NOT NULL AS snapshot_ok;
ROLLBACK;
CREATE table stats_test_tab1 as select generate_series(1,10) a;
CREATE index stats_test_idx1 on stats_test_tab1(a);
select a from stats_test_tab1 where a = 3;
DROP index stats_test_idx1;
BEGIN;
CREATE index stats_test_idx1 on stats_test_tab1(a);
ROLLBACK;
CREATE index stats_test_idx1 on stats_test_tab1(a);
REINDEX index CONCURRENTLY stats_test_idx1;
BEGIN;
ROLLBACK;
SET enable_seqscan TO on;
SELECT pg_stat_get_replication_slot(NULL);
SELECT pg_stat_get_subscription_stats(NULL);
SELECT pg_stat_force_next_flush();
COMMIT;
SELECT pg_stat_force_next_flush();
SET LOCAL enable_nestloop TO on;
SET LOCAL enable_mergejoin TO off;
SET LOCAL enable_hashjoin TO off;
SET LOCAL enable_material TO off;
COMMIT;
SELECT pg_stat_force_next_flush();
CREATE TEMPORARY TABLE test_io_local(a int, b TEXT);
SELECT pg_relation_size('test_io_local') / current_setting('block_size')::int8 > 100;
SELECT pg_stat_force_next_flush();
SELECT pg_stat_force_next_flush();
RESET temp_buffers;
SET wal_skip_threshold = '1 kB';
SELECT pg_stat_force_next_flush();
RESET wal_skip_threshold;
SELECT pg_stat_force_next_flush();
CREATE TABLE brin_hot (
  id  integer PRIMARY KEY,
  val integer NOT NULL
) WITH (autovacuum_enabled = off, fillfactor = 70);
INSERT INTO brin_hot SELECT *, 0 FROM generate_series(1, 235);
CREATE INDEX val_brin ON brin_hot using brin(val);
UPDATE brin_hot SET val = -3 WHERE id = 42;
SELECT pg_stat_get_tuples_hot_updated('brin_hot'::regclass::oid);
DROP TABLE brin_hot;
CREATE TABLE brin_hot_2 (a int, b int);
INSERT INTO brin_hot_2 VALUES (1, 100);
CREATE INDEX ON brin_hot_2 USING brin (b) WHERE a = 2;
UPDATE brin_hot_2 SET a = 2;
EXPLAIN (COSTS OFF) SELECT * FROM brin_hot_2 WHERE a = 2 AND b = 100;
SELECT COUNT(*) FROM brin_hot_2 WHERE a = 2 AND b = 100;
SET enable_seqscan = off;
EXPLAIN (COSTS OFF) SELECT * FROM brin_hot_2 WHERE a = 2 AND b = 100;
SELECT COUNT(*) FROM brin_hot_2 WHERE a = 2 AND b = 100;
DROP TABLE brin_hot_2;
CREATE TABLE brin_hot_3 (a int, filler text) WITH (fillfactor = 10);
INSERT INTO brin_hot_3 SELECT 1, repeat(' ', 500) FROM generate_series(1, 20);
CREATE INDEX ON brin_hot_3 USING brin (a) WITH (pages_per_range = 1);
UPDATE brin_hot_3 SET a = 2;
EXPLAIN (COSTS OFF) SELECT * FROM brin_hot_3 WHERE a = 2;
SELECT COUNT(*) FROM brin_hot_3 WHERE a = 2;
DROP TABLE brin_hot_3;
SET enable_seqscan = on;
