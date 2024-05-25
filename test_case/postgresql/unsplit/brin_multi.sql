CREATE TABLE brintest_multi (
	int8col bigint,
	int2col smallint,
	int4col integer,
	oidcol oid,
	tidcol tid,
	float4col real,
	float8col double precision,
	macaddrcol macaddr,
	macaddr8col macaddr8,
	inetcol inet,
	cidrcol cidr,
	datecol date,
	timecol time without time zone,
	timestampcol timestamp without time zone,
	timestamptzcol timestamp with time zone,
	intervalcol interval,
	timetzcol time with time zone,
	numericcol numeric,
	uuidcol uuid,
	lsncol pg_lsn
) WITH (fillfactor=10);
CREATE INDEX brinidx_multi ON brintest_multi USING brin (
	int8col int8_minmax_multi_ops,
	int2col int2_minmax_multi_ops,
	int4col int4_minmax_multi_ops,
	oidcol oid_minmax_multi_ops,
	tidcol tid_minmax_multi_ops,
	float4col float4_minmax_multi_ops,
	float8col float8_minmax_multi_ops,
	macaddrcol macaddr_minmax_multi_ops,
	macaddr8col macaddr8_minmax_multi_ops,
	inetcol inet_minmax_multi_ops,
	cidrcol inet_minmax_multi_ops,
	datecol date_minmax_multi_ops,
	timecol time_minmax_multi_ops,
	timestampcol timestamp_minmax_multi_ops,
	timestamptzcol timestamptz_minmax_multi_ops,
	intervalcol interval_minmax_multi_ops,
	timetzcol timetz_minmax_multi_ops,
	numericcol numeric_minmax_multi_ops,
	uuidcol uuid_minmax_multi_ops,
	lsncol pg_lsn_minmax_multi_ops
);
DROP INDEX brinidx_multi;
CREATE INDEX brinidx_multi ON brintest_multi USING brin (
	int8col int8_minmax_multi_ops,
	int2col int2_minmax_multi_ops,
	int4col int4_minmax_multi_ops,
	oidcol oid_minmax_multi_ops,
	tidcol tid_minmax_multi_ops,
	float4col float4_minmax_multi_ops,
	float8col float8_minmax_multi_ops,
	macaddrcol macaddr_minmax_multi_ops,
	macaddr8col macaddr8_minmax_multi_ops,
	inetcol inet_minmax_multi_ops,
	cidrcol inet_minmax_multi_ops,
	datecol date_minmax_multi_ops,
	timecol time_minmax_multi_ops,
	timestampcol timestamp_minmax_multi_ops,
	timestamptzcol timestamptz_minmax_multi_ops,
	intervalcol interval_minmax_multi_ops,
	timetzcol timetz_minmax_multi_ops,
	numericcol numeric_minmax_multi_ops,
	uuidcol uuid_minmax_multi_ops,
	lsncol pg_lsn_minmax_multi_ops
) with (pages_per_range = 1);
CREATE TABLE brinopers_multi (colname name, typ text,
	op text[], value text[], matches int[],
	check (cardinality(op) = cardinality(value)),
	check (cardinality(op) = cardinality(matches)));
INSERT INTO brinopers_multi VALUES
	('int2col', 'int2',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 800, 999, 999}',
	 '{100, 100, 1, 100, 100}'),
	('int2col', 'int4',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 800, 999, 1999}',
	 '{100, 100, 1, 100, 100}'),
	('int2col', 'int8',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 800, 999, 1428427143}',
	 '{100, 100, 1, 100, 100}'),
	('int4col', 'int2',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 800, 1999, 1999}',
	 '{100, 100, 1, 100, 100}'),
	('int4col', 'int4',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 800, 1999, 1999}',
	 '{100, 100, 1, 100, 100}'),
	('int4col', 'int8',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 800, 1999, 1428427143}',
	 '{100, 100, 1, 100, 100}'),
	('int8col', 'int2',
	 '{>, >=}',
	 '{0, 0}',
	 '{100, 100}'),
	('int8col', 'int4',
	 '{>, >=}',
	 '{0, 0}',
	 '{100, 100}'),
	('int8col', 'int8',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 1257141600, 1428427143, 1428427143}',
	 '{100, 100, 1, 100, 100}'),
	('oidcol', 'oid',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 8800, 9999, 9999}',
	 '{100, 100, 1, 100, 100}'),
	('tidcol', 'tid',
	 '{>, >=, =, <=, <}',
	 '{"(0,0)", "(0,0)", "(8800,0)", "(9999,19)", "(9999,19)"}',
	 '{100, 100, 1, 100, 100}'),
	('float4col', 'float4',
	 '{>, >=, =, <=, <}',
	 '{0.0103093, 0.0103093, 1, 1, 1}',
	 '{100, 100, 4, 100, 96}'),
	('float4col', 'float8',
	 '{>, >=, =, <=, <}',
	 '{0.0103093, 0.0103093, 1, 1, 1}',
	 '{100, 100, 4, 100, 96}'),
	('float8col', 'float4',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 0, 1.98, 1.98}',
	 '{99, 100, 1, 100, 100}'),
	('float8col', 'float8',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 0, 1.98, 1.98}',
	 '{99, 100, 1, 100, 100}'),
	('macaddrcol', 'macaddr',
	 '{>, >=, =, <=, <}',
	 '{00:00:01:00:00:00, 00:00:01:00:00:00, 2c:00:2d:00:16:00, ff:fe:00:00:00:00, ff:fe:00:00:00:00}',
	 '{99, 100, 2, 100, 100}'),
	('macaddr8col', 'macaddr8',
	 '{>, >=, =, <=, <}',
	 '{b1:d1:0e:7b:af:a4:42:12, d9:35:91:bd:f7:86:0e:1e, 72:8f:20:6c:2a:01:bf:57, 23:e8:46:63:86:07:ad:cb, 13:16:8e:6a:2e:6c:84:b4}',
	 '{31, 17, 1, 11, 4}'),
	('inetcol', 'inet',
	 '{=, <, <=, >, >=}',
	 '{10.2.14.231/24, 255.255.255.255, 255.255.255.255, 0.0.0.0, 0.0.0.0}',
	 '{1, 100, 100, 125, 125}'),
	('inetcol', 'cidr',
	 '{<, <=, >, >=}',
	 '{255.255.255.255, 255.255.255.255, 0.0.0.0, 0.0.0.0}',
	 '{100, 100, 125, 125}'),
	('cidrcol', 'inet',
	 '{=, <, <=, >, >=}',
	 '{10.2.14/24, 255.255.255.255, 255.255.255.255, 0.0.0.0, 0.0.0.0}',
	 '{2, 100, 100, 125, 125}'),
	('cidrcol', 'cidr',
	 '{=, <, <=, >, >=}',
	 '{10.2.14/24, 255.255.255.255, 255.255.255.255, 0.0.0.0, 0.0.0.0}',
	 '{2, 100, 100, 125, 125}'),
	('datecol', 'date',
	 '{>, >=, =, <=, <}',
	 '{1995-08-15, 1995-08-15, 2009-12-01, 2022-12-30, 2022-12-30}',
	 '{100, 100, 1, 100, 100}'),
	('timecol', 'time',
	 '{>, >=, =, <=, <}',
	 '{01:20:30, 01:20:30, 02:28:57, 06:28:31.5, 06:28:31.5}',
	 '{100, 100, 1, 100, 100}'),
	('timestampcol', 'timestamp',
	 '{>, >=, =, <=, <}',
	 '{1942-07-23 03:05:09, 1942-07-23 03:05:09, 1964-03-24 19:26:45, 1984-01-20 22:42:21, 1984-01-20 22:42:21}',
	 '{100, 100, 1, 100, 100}'),
	('timestampcol', 'timestamptz',
	 '{>, >=, =, <=, <}',
	 '{1942-07-23 03:05:09, 1942-07-23 03:05:09, 1964-03-24 19:26:45, 1984-01-20 22:42:21, 1984-01-20 22:42:21}',
	 '{100, 100, 1, 100, 100}'),
	('timestamptzcol', 'timestamptz',
	 '{>, >=, =, <=, <}',
	 '{1972-10-10 03:00:00-04, 1972-10-10 03:00:00-04, 1972-10-19 09:00:00-07, 1972-11-20 19:00:00-03, 1972-11-20 19:00:00-03}',
	 '{100, 100, 1, 100, 100}'),
	('intervalcol', 'interval',
	 '{>, >=, =, <=, <}',
	 '{00:00:00, 00:00:00, 1 mons 13 days 12:24, 2 mons 23 days 07:48:00, 1 year}',
	 '{100, 100, 1, 100, 100}'),
	('timetzcol', 'timetz',
	 '{>, >=, =, <=, <}',
	 '{01:30:20+02, 01:30:20+02, 01:35:50+02, 23:55:05+02, 23:55:05+02}',
	 '{99, 100, 2, 100, 100}'),
	('numericcol', 'numeric',
	 '{>, >=, =, <=, <}',
	 '{0.00, 0.01, 2268164.347826086956521739130434782609, 99470151.9, 99470151.9}',
	 '{100, 100, 1, 100, 100}'),
	('uuidcol', 'uuid',
	 '{>, >=, =, <=, <}',
	 '{00040004-0004-0004-0004-000400040004, 00040004-0004-0004-0004-000400040004, 52225222-5222-5222-5222-522252225222, 99989998-9998-9998-9998-999899989998, 99989998-9998-9998-9998-999899989998}',
	 '{100, 100, 1, 100, 100}'),
	('lsncol', 'pg_lsn',
	 '{>, >=, =, <=, <, IS, IS NOT}',
	 '{0/1200, 0/1200, 44/455222, 198/1999799, 198/1999799, NULL, NULL}',
	 '{100, 100, 1, 100, 100, 25, 100}');
SET enable_seqscan = 0;
SET enable_bitmapscan = 1;
SET enable_seqscan = 1;
SET enable_bitmapscan = 0;
SET enable_seqscan = 1;
SET enable_bitmapscan = 0;
SET enable_seqscan = 0;
SET enable_bitmapscan = 1;
END;
RESET enable_seqscan;
RESET enable_bitmapscan;
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
SELECT brin_desummarize_range('brinidx_multi', 0);
SELECT brin_desummarize_range('brinidx_multi', 0);
SELECT brin_desummarize_range('brinidx_multi', 100000000);
CREATE TABLE brin_large_range (a int4);
INSERT INTO brin_large_range SELECT i FROM generate_series(1,10000) s(i);
CREATE INDEX brin_large_range_idx ON brin_large_range USING brin (a int4_minmax_multi_ops);
DROP TABLE brin_large_range;
CREATE TABLE brin_summarize_multi (
    value int
) WITH (fillfactor=10, autovacuum_enabled=false);
CREATE INDEX brin_summarize_multi_idx ON brin_summarize_multi USING brin (value) WITH (pages_per_range=2);
SELECT brin_summarize_range('brin_summarize_multi_idx', 0);
SELECT brin_summarize_range('brin_summarize_multi_idx', 1);
SELECT brin_summarize_range('brin_summarize_multi_idx', 2);
SELECT brin_summarize_range('brin_summarize_multi_idx', 4294967295);
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
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a < 113;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a <= 177;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a <= 25;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a > 120;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a >= 180;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a > 71;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a >= 63;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a = 207;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a = 177;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b < 73;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b <= 47;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b < 199;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b <= 150;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b > 93;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b > 37;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b >= 215;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b > 201;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b = 88;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b = 103;
TRUNCATE brin_test_multi_1;
INSERT INTO brin_test_multi_1
SELECT i/5 + mod(911 * i + 483, 25),
       i/10 + mod(751 * i + 221, 41)
  FROM generate_series(1,1000) s(i);
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a < 37;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a < 113;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a <= 177;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a <= 25;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a > 120;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a >= 180;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a > 71;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a >= 63;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a = 207;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE a = 177;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b < 73;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b <= 47;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b < 199;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b <= 150;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b > 93;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b > 37;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b >= 215;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b > 201;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b = 88;
SELECT COUNT(*) FROM brin_test_multi_1 WHERE b = 103;
DROP TABLE brin_test_multi_1;
RESET enable_seqscan;
CREATE TABLE brin_test_multi_2 (a UUID) WITH (fillfactor=10);
CREATE INDEX brin_test_multi_2_idx ON brin_test_multi_2 USING brin (a uuid_minmax_multi_ops) WITH (pages_per_range=5);
SET enable_seqscan=off;
SELECT COUNT(*) FROM brin_test_multi_2 WHERE a < '3d914f93-48c9-cc0f-f8a7-9716700b9fcd';
SELECT COUNT(*) FROM brin_test_multi_2 WHERE a > '3d914f93-48c9-cc0f-f8a7-9716700b9fcd';
SELECT COUNT(*) FROM brin_test_multi_2 WHERE a <= 'f369cb89-fc62-7e66-8987-007d121ed1ea';
SELECT COUNT(*) FROM brin_test_multi_2 WHERE a >= 'aea92132-c4cb-eb26-3e6a-c2bf6c183b5d';
SELECT COUNT(*) FROM brin_test_multi_2 WHERE a = '5feceb66-ffc8-6f38-d952-786c6d696c79';
SELECT COUNT(*) FROM brin_test_multi_2 WHERE a = '86e50149-6586-6131-2a9e-0b35558d84f6';
TRUNCATE brin_test_multi_2;
SELECT COUNT(*) FROM brin_test_multi_2 WHERE a < '3d914f93-48c9-cc0f-f8a7-9716700b9fcd';
SELECT COUNT(*) FROM brin_test_multi_2 WHERE a > '3d914f93-48c9-cc0f-f8a7-9716700b9fcd';
SELECT COUNT(*) FROM brin_test_multi_2 WHERE a <= 'f369cb89-fc62-7e66-8987-007d121ed1ea';
SELECT COUNT(*) FROM brin_test_multi_2 WHERE a >= 'aea92132-c4cb-eb26-3e6a-c2bf6c183b5d';
SELECT COUNT(*) FROM brin_test_multi_2 WHERE a = '5feceb66-ffc8-6f38-d952-786c6d696c79';
SELECT COUNT(*) FROM brin_test_multi_2 WHERE a = '86e50149-6586-6131-2a9e-0b35558d84f6';
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