SELECT brin_desummarize_range('brinidx_multi', 0);
VACUUM brintest_multi;
insert into public.brintest_multi (float4col) values (real 'nan');
insert into public.brintest_multi (float8col) values (real 'nan');
UPDATE brintest_multi SET int8col = int8col * int4col;
CREATE TABLE brin_test_inet (a inet);
CREATE INDEX ON brin_test_inet USING brin (a inet_minmax_multi_ops);
INSERT INTO brin_test_inet VALUES ('127.0.0.1/0');
INSERT INTO brin_test_inet VALUES ('0.0.0.0/12');
DROP TABLE brin_test_inet;
SELECT brin_summarize_new_values('brinidx_multi');
CREATE TABLE brin_large_range (a int4);
INSERT INTO brin_large_range SELECT i FROM generate_series(1,10000) s(i);
CREATE INDEX brin_large_range_idx ON brin_large_range USING brin (a int4_minmax_multi_ops);
DROP TABLE brin_large_range;
CREATE TABLE brin_summarize_multi (
    value int
) WITH (fillfactor=10, autovacuum_enabled=false);
CREATE INDEX brin_summarize_multi_idx ON brin_summarize_multi USING brin (value) WITH (pages_per_range=2);
SELECT brin_summarize_range('brin_summarize_multi_idx', 0);
CREATE TABLE brin_test_multi (a INT, b INT);
INSERT INTO brin_test_multi SELECT x/100,x%100 FROM generate_series(1,10000) x(x);
CREATE INDEX brin_test_multi_a_idx ON brin_test_multi USING brin (a) WITH (pages_per_range = 2);
CREATE INDEX brin_test_multi_b_idx ON brin_test_multi USING brin (b) WITH (pages_per_range = 2);
VACUUM ANALYZE brin_test_multi;
EXPLAIN (COSTS OFF) SELECT * FROM brin_test_multi WHERE a = 1;
EXPLAIN (COSTS OFF) SELECT * FROM brin_test_multi WHERE b = 1;
CREATE TABLE brin_test_multi_1 (a INT, b BIGINT) WITH (fillfactor=10);
INSERT INTO brin_test_multi_1
SELECT i/5 + mod(911 * i + 483, 25),
       i/10 + mod(751 * i + 221, 41)
  FROM generate_series(1,1000) s(i);
CREATE INDEX brin_test_multi_1_idx_1 ON brin_test_multi_1 USING brin (a int4_minmax_multi_ops) WITH (pages_per_range=5);
CREATE INDEX brin_test_multi_1_idx_2 ON brin_test_multi_1 USING brin (b int8_minmax_multi_ops) WITH (pages_per_range=5);
SET enable_seqscan=off;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a < 37;
TRUNCATE brin_test_multi_1;
INSERT INTO brin_test_multi_1
SELECT i/5 + mod(911 * i + 483, 25),
       i/10 + mod(751 * i + 221, 41)
  FROM generate_series(1,1000) s(i);
DROP TABLE brin_test_multi_1;
RESET enable_seqscan;
CREATE TABLE brin_test_multi_2 (a UUID) WITH (fillfactor=10);
CREATE INDEX brin_test_multi_2_idx ON brin_test_multi_2 USING brin (a uuid_minmax_multi_ops) WITH (pages_per_range=5);
SET enable_seqscan=off;
TRUNCATE brin_test_multi_2;
DROP TABLE brin_test_multi_2;
RESET enable_seqscan;
CREATE TABLE brin_timestamp_test(a TIMESTAMPTZ);
SET datestyle TO iso;
INSERT INTO brin_timestamp_test
SELECT '4713-01-01 00:00:01 BC'::timestamptz + (i || ' seconds')::interval
  FROM generate_series(1,30) s(i);
INSERT INTO brin_timestamp_test
SELECT '294276-12-01 00:00:01'::timestamptz + (i || ' seconds')::interval
  FROM generate_series(1,30) s(i);
CREATE INDEX ON brin_timestamp_test USING brin (a timestamptz_minmax_multi_ops) WITH (pages_per_range=1);
DROP TABLE brin_timestamp_test;
CREATE TABLE brin_date_test(a DATE);
INSERT INTO brin_date_test SELECT '4713-01-01 BC'::date + i FROM generate_series(1, 30) s(i);
INSERT INTO brin_date_test SELECT '5874897-12-01'::date + i FROM generate_series(1, 30) s(i);
CREATE INDEX ON brin_date_test USING brin (a date_minmax_multi_ops) WITH (pages_per_range=1);
SET enable_seqscan = off;
EXPLAIN (ANALYZE, TIMING OFF, COSTS OFF, SUMMARY OFF)
SELECT * FROM brin_date_test WHERE a = '2023-01-01'::date;
DROP TABLE brin_date_test;
RESET enable_seqscan;
CREATE TABLE brin_timestamp_test(a TIMESTAMP);
INSERT INTO brin_timestamp_test VALUES ('-infinity'), ('infinity');
INSERT INTO brin_timestamp_test
SELECT i FROM generate_series('2000-01-01'::timestamp, '2000-02-09'::timestamp, '1 day'::interval) s(i);
CREATE INDEX ON brin_timestamp_test USING brin (a timestamp_minmax_multi_ops) WITH (pages_per_range=1);
SET enable_seqscan = off;
EXPLAIN (ANALYZE, TIMING OFF, COSTS OFF, SUMMARY OFF)
SELECT * FROM brin_timestamp_test WHERE a = '2023-01-01'::timestamp;
EXPLAIN (ANALYZE, TIMING OFF, COSTS OFF, SUMMARY OFF)
SELECT * FROM brin_timestamp_test WHERE a = '1900-01-01'::timestamp;
DROP TABLE brin_timestamp_test;
RESET enable_seqscan;
CREATE TABLE brin_date_test(a DATE);
INSERT INTO brin_date_test VALUES ('-infinity'), ('infinity');
INSERT INTO brin_date_test SELECT '2000-01-01'::date + i FROM generate_series(1, 40) s(i);
CREATE INDEX ON brin_date_test USING brin (a date_minmax_multi_ops) WITH (pages_per_range=1);
SET enable_seqscan = off;
EXPLAIN (ANALYZE, TIMING OFF, COSTS OFF, SUMMARY OFF)
SELECT * FROM brin_date_test WHERE a = '2023-01-01'::date;
EXPLAIN (ANALYZE, TIMING OFF, COSTS OFF, SUMMARY OFF)
SELECT * FROM brin_date_test WHERE a = '1900-01-01'::date;
DROP TABLE brin_date_test;
RESET enable_seqscan;
RESET datestyle;
CREATE TABLE brin_interval_test(a INTERVAL);
INSERT INTO brin_interval_test SELECT (i || ' years')::interval FROM generate_series(-178000000, -177999980) s(i);
INSERT INTO brin_interval_test SELECT (i || ' years')::interval FROM generate_series( 177999980,  178000000) s(i);
CREATE INDEX ON brin_interval_test USING brin (a interval_minmax_multi_ops) WITH (pages_per_range=1);
SET enable_seqscan = off;
EXPLAIN (ANALYZE, TIMING OFF, COSTS OFF, SUMMARY OFF)
SELECT * FROM brin_interval_test WHERE a = '-30 years'::interval;
EXPLAIN (ANALYZE, TIMING OFF, COSTS OFF, SUMMARY OFF)
SELECT * FROM brin_interval_test WHERE a = '30 years'::interval;
DROP TABLE brin_interval_test;
RESET enable_seqscan;
CREATE TABLE brin_interval_test(a INTERVAL);
INSERT INTO brin_interval_test SELECT (i || ' days')::interval FROM generate_series(100, 140) s(i);
CREATE INDEX ON brin_interval_test USING brin (a interval_minmax_multi_ops) WITH (pages_per_range=1);
SET enable_seqscan = off;
EXPLAIN (ANALYZE, TIMING OFF, COSTS OFF, SUMMARY OFF)
SELECT * FROM brin_interval_test WHERE a = '-30 years'::interval;
EXPLAIN (ANALYZE, TIMING OFF, COSTS OFF, SUMMARY OFF)
SELECT * FROM brin_interval_test WHERE a = '30 years'::interval;
DROP TABLE brin_interval_test;
RESET enable_seqscan;
RESET datestyle;
