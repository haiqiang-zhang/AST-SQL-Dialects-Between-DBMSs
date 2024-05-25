CREATE TABLE brintest_bloom (byteacol bytea,
	charcol "char",
	namecol name,
	int8col bigint,
	int2col smallint,
	int4col integer,
	textcol text,
	oidcol oid,
	float4col real,
	float8col double precision,
	macaddrcol macaddr,
	inetcol inet,
	cidrcol cidr,
	bpcharcol character,
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
CREATE INDEX brinidx_bloom ON brintest_bloom USING brin (
	byteacol bytea_bloom_ops,
	charcol char_bloom_ops,
	namecol name_bloom_ops,
	int8col int8_bloom_ops,
	int2col int2_bloom_ops,
	int4col int4_bloom_ops,
	textcol text_bloom_ops,
	oidcol oid_bloom_ops,
	float4col float4_bloom_ops,
	float8col float8_bloom_ops,
	macaddrcol macaddr_bloom_ops,
	inetcol inet_bloom_ops,
	cidrcol inet_bloom_ops,
	bpcharcol bpchar_bloom_ops,
	datecol date_bloom_ops,
	timecol time_bloom_ops,
	timestampcol timestamp_bloom_ops,
	timestamptzcol timestamptz_bloom_ops,
	intervalcol interval_bloom_ops,
	timetzcol timetz_bloom_ops,
	numericcol numeric_bloom_ops,
	uuidcol uuid_bloom_ops,
	lsncol pg_lsn_bloom_ops
) with (pages_per_range = 1);
CREATE TABLE brinopers_bloom (colname name, typ text,
	op text[], value text[], matches int[],
	check (cardinality(op) = cardinality(value)),
	check (cardinality(op) = cardinality(matches)));
INSERT INTO brinopers_bloom VALUES
	('byteacol', 'bytea',
	 '{=}',
	 '{BNAAAABNAAAABNAAAABNAAAABNAAAABNAAAABNAAAABNAAAA}',
	 '{1}'),
	('charcol', '"char"',
	 '{=}',
	 '{M}',
	 '{6}'),
	('namecol', 'name',
	 '{=}',
	 '{MAAAAA}',
	 '{2}'),
	('int2col', 'int2',
	 '{=}',
	 '{800}',
	 '{1}'),
	('int4col', 'int4',
	 '{=}',
	 '{800}',
	 '{1}'),
	('int8col', 'int8',
	 '{=}',
	 '{1257141600}',
	 '{1}'),
	('textcol', 'text',
	 '{=}',
	 '{BNAAAABNAAAABNAAAABNAAAABNAAAABNAAAABNAAAABNAAAA}',
	 '{1}'),
	('oidcol', 'oid',
	 '{=}',
	 '{8800}',
	 '{1}'),
	('float4col', 'float4',
	 '{=}',
	 '{1}',
	 '{4}'),
	('float8col', 'float8',
	 '{=}',
	 '{0}',
	 '{1}'),
	('macaddrcol', 'macaddr',
	 '{=}',
	 '{2c:00:2d:00:16:00}',
	 '{2}'),
	('inetcol', 'inet',
	 '{=}',
	 '{10.2.14.231/24}',
	 '{1}'),
	('inetcol', 'cidr',
	 '{=}',
	 '{fe80::6e40:8ff:fea9:8c46}',
	 '{1}'),
	('cidrcol', 'inet',
	 '{=}',
	 '{10.2.14/24}',
	 '{2}'),
	('cidrcol', 'inet',
	 '{=}',
	 '{fe80::6e40:8ff:fea9:8c46}',
	 '{1}'),
	('cidrcol', 'cidr',
	 '{=}',
	 '{10.2.14/24}',
	 '{2}'),
	('cidrcol', 'cidr',
	 '{=}',
	 '{fe80::6e40:8ff:fea9:8c46}',
	 '{1}'),
	('bpcharcol', 'bpchar',
	 '{=}',
	 '{W}',
	 '{6}'),
	('datecol', 'date',
	 '{=}',
	 '{2009-12-01}',
	 '{1}'),
	('timecol', 'time',
	 '{=}',
	 '{02:28:57}',
	 '{1}'),
	('timestampcol', 'timestamp',
	 '{=}',
	 '{1964-03-24 19:26:45}',
	 '{1}'),
	('timestamptzcol', 'timestamptz',
	 '{=}',
	 '{1972-10-19 09:00:00-07}',
	 '{1}'),
	('intervalcol', 'interval',
	 '{=}',
	 '{1 mons 13 days 12:24}',
	 '{1}'),
	('timetzcol', 'timetz',
	 '{=}',
	 '{01:35:50+02}',
	 '{2}'),
	('numericcol', 'numeric',
	 '{=}',
	 '{2268164.347826086956521739130434782609}',
	 '{1}'),
	('uuidcol', 'uuid',
	 '{=}',
	 '{52225222-5222-5222-5222-522252225222}',
	 '{1}'),
	('lsncol', 'pg_lsn',
	 '{=, IS, IS NOT}',
	 '{44/455222, NULL, NULL}',
	 '{1, 25, 100}');
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
SELECT brin_desummarize_range('brinidx_bloom', 0);
VACUUM brintest_bloom;
UPDATE brintest_bloom SET int8col = int8col * int4col;
UPDATE brintest_bloom SET textcol = '' WHERE textcol IS NOT NULL;
SELECT brin_summarize_new_values('brinidx_bloom');
SELECT brin_desummarize_range('brinidx_bloom', 0);
SELECT brin_desummarize_range('brinidx_bloom', 0);
SELECT brin_desummarize_range('brinidx_bloom', 100000000);
CREATE TABLE brin_summarize_bloom (
    value int
) WITH (fillfactor=10, autovacuum_enabled=false);
CREATE INDEX brin_summarize_bloom_idx ON brin_summarize_bloom USING brin (value) WITH (pages_per_range=2);
SELECT brin_summarize_range('brin_summarize_bloom_idx', 0);
SELECT brin_summarize_range('brin_summarize_bloom_idx', 1);
SELECT brin_summarize_range('brin_summarize_bloom_idx', 2);
SELECT brin_summarize_range('brin_summarize_bloom_idx', 4294967295);
CREATE TABLE brin_test_bloom (a INT, b INT);
INSERT INTO brin_test_bloom SELECT x/100,x%100 FROM generate_series(1,10000) x(x);
CREATE INDEX brin_test_bloom_a_idx ON brin_test_bloom USING brin (a) WITH (pages_per_range = 2);
CREATE INDEX brin_test_bloom_b_idx ON brin_test_bloom USING brin (b) WITH (pages_per_range = 2);
VACUUM ANALYZE brin_test_bloom;
EXPLAIN (COSTS OFF) SELECT * FROM brin_test_bloom WHERE a = 1;
EXPLAIN (COSTS OFF) SELECT * FROM brin_test_bloom WHERE b = 1;
