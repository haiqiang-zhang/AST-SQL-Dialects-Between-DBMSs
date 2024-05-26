COMMENT ON STATISTICS ab1_a_b_stats IS 'new comment';
COMMENT ON STATISTICS ab1_a_b_stats IS 'changed comment';
DROP STATISTICS ab1_a_b_stats;
RESET SESSION AUTHORIZATION;
CREATE STATISTICS IF NOT EXISTS ab1_a_b_stats ON a, b FROM ab1;
DROP STATISTICS ab1_a_b_stats;
CREATE SCHEMA regress_schema_2;
CREATE STATISTICS regress_schema_2.ab1_a_b_stats ON a, b FROM ab1;
SELECT pg_get_statisticsobjdef(oid) FROM pg_statistic_ext WHERE stxname = 'ab1_a_b_stats';
DROP STATISTICS regress_schema_2.ab1_a_b_stats;
CREATE STATISTICS ab1_b_c_stats ON b, c FROM ab1;
CREATE STATISTICS ab1_a_b_c_stats ON a, b, c FROM ab1;
CREATE STATISTICS ab1_b_a_stats ON b, a FROM ab1;
ALTER TABLE ab1 DROP COLUMN a;
SELECT stxname FROM pg_statistic_ext WHERE stxname LIKE 'ab1%';
DROP TABLE ab1;
SELECT stxname FROM pg_statistic_ext WHERE stxname LIKE 'ab1%';
CREATE TABLE ab1 (a INTEGER, b INTEGER);
ALTER TABLE ab1 ALTER a SET STATISTICS 0;
INSERT INTO ab1 SELECT a, a%23 FROM generate_series(1, 1000) a;
CREATE STATISTICS ab1_a_b_stats ON a, b FROM ab1;
ANALYZE ab1;
ALTER TABLE ab1 ALTER a SET STATISTICS -1;
ALTER STATISTICS ab1_a_b_stats SET STATISTICS 0;
ANALYZE ab1;
ALTER STATISTICS ab1_a_b_stats SET STATISTICS -1;
ANALYZE ab1 (a);
ANALYZE ab1;
DROP TABLE ab1;
ALTER STATISTICS IF EXISTS ab1_a_b_stats SET STATISTICS 0;
CREATE TABLE ab1 (a INTEGER, b INTEGER);
CREATE TABLE ab1c () INHERITS (ab1);
INSERT INTO ab1 VALUES (1,1);
CREATE STATISTICS ab1_a_b_stats ON a, b FROM ab1;
ANALYZE ab1;
DROP TABLE ab1 CASCADE;
CREATE TABLE stxdinh(a int, b int);
CREATE TABLE stxdinh1() INHERITS(stxdinh);
CREATE TABLE stxdinh2() INHERITS(stxdinh);
INSERT INTO stxdinh SELECT mod(a,50), mod(a,100) FROM generate_series(0, 1999) a;
INSERT INTO stxdinh1 SELECT mod(a,100), mod(a,100) FROM generate_series(0, 999) a;
INSERT INTO stxdinh2 SELECT mod(a,100), mod(a,100) FROM generate_series(0, 999) a;
VACUUM ANALYZE stxdinh, stxdinh1, stxdinh2;
CREATE STATISTICS stxdinh ON a, b FROM stxdinh;
VACUUM ANALYZE stxdinh, stxdinh1, stxdinh2;
DROP TABLE stxdinh, stxdinh1, stxdinh2;
CREATE TABLE stxdinp(i int, a int, b int) PARTITION BY RANGE (i);
CREATE TABLE stxdinp1 PARTITION OF stxdinp FOR VALUES FROM (1) TO (100);
INSERT INTO stxdinp SELECT 1, a/100, a/100 FROM generate_series(1, 999) a;
CREATE STATISTICS stxdinp ON (a + 1), a, b FROM stxdinp;
VACUUM ANALYZE stxdinp;
SELECT 1 FROM pg_statistic_ext WHERE stxrelid = 'stxdinp'::regclass;
DROP TABLE stxdinp;
CREATE TABLE ab1 (a INTEGER, b INTEGER, c TIMESTAMP, d TIMESTAMPTZ);
CREATE STATISTICS ab1_exprstat_1 ON (a+b) FROM ab1;
CREATE STATISTICS ab1_exprstat_2 ON (a+b) FROM ab1;
SELECT stxkind FROM pg_statistic_ext WHERE stxname = 'ab1_exprstat_2';
CREATE STATISTICS ab1_exprstat_3 ON (a+b), a FROM ab1;
SELECT stxkind FROM pg_statistic_ext WHERE stxname = 'ab1_exprstat_3';
CREATE STATISTICS ab1_exprstat_4 ON date_trunc('day', d) FROM ab1;
CREATE STATISTICS ab1_exprstat_5 ON date_trunc('day', c) FROM ab1;
CREATE STATISTICS ab1_exprstat_6 ON
  (case a when 1 then true else false end), b FROM ab1;
INSERT INTO ab1
SELECT x / 10, x / 3,
    '2020-10-01'::timestamp + x * interval '1 day',
    '2020-10-01'::timestamptz + x * interval '1 day'
FROM generate_series(1, 100) x;
ANALYZE ab1;
DROP TABLE ab1;
CREATE schema tststats;
CREATE TABLE tststats.t (a int, b int, c text);
CREATE INDEX ti ON tststats.t (a, b);
CREATE SEQUENCE tststats.s;
CREATE VIEW tststats.v AS SELECT * FROM tststats.t;
CREATE MATERIALIZED VIEW tststats.mv AS SELECT * FROM tststats.t;
CREATE TYPE tststats.ty AS (a int, b int, c text);
CREATE TABLE tststats.pt (a int, b int, c text) PARTITION BY RANGE (a, b);
CREATE TABLE tststats.pt1 PARTITION OF tststats.pt FOR VALUES FROM (-10, -10) TO (10, 10);
CREATE STATISTICS tststats.s1 ON a, b FROM tststats.t;
CREATE STATISTICS tststats.s5 ON a, b FROM tststats.mv;
CREATE STATISTICS tststats.s8 ON a, b FROM tststats.pt;
CREATE STATISTICS tststats.s9 ON a, b FROM tststats.pt1;
DROP SCHEMA tststats CASCADE;
CREATE TABLE ndistinct (
    filler1 TEXT,
    filler2 NUMERIC,
    a INT,
    b INT,
    filler3 DATE,
    c INT,
    d INT
)
WITH (autovacuum_enabled = off);
INSERT INTO ndistinct (a, b, c, filler1)
     SELECT i/100, i/100, i/100, (i/100) || ' dollars and zero cents'
       FROM generate_series(1,1000) s(i);
ANALYZE ndistinct;
CREATE STATISTICS s10 ON a, b, c FROM ndistinct;
ANALYZE ndistinct;
TRUNCATE TABLE ndistinct;
INSERT INTO ndistinct (a, b, c, filler1)
     SELECT mod(i,13), mod(i,17), mod(i,19),
            mod(i,23) || ' dollars and zero cents'
       FROM generate_series(1,1000) s(i);
ANALYZE ndistinct;
DROP STATISTICS s10;
CREATE STATISTICS s10 (ndistinct) ON (a+1), (b+100), (2*c) FROM ndistinct;
ANALYZE ndistinct;
DROP STATISTICS s10;
CREATE STATISTICS s10 (ndistinct) ON a, b, (2*c) FROM ndistinct;
ANALYZE ndistinct;
DROP STATISTICS s10;
TRUNCATE ndistinct;
INSERT INTO ndistinct (a, b, c, d)
     SELECT mod(i,3), mod(i,9), mod(i,5), mod(i,20)
       FROM generate_series(1,1000) s(i);
ANALYZE ndistinct;
CREATE STATISTICS s11 (ndistinct) ON a, b FROM ndistinct;
CREATE STATISTICS s12 (ndistinct) ON c, d FROM ndistinct;
ANALYZE ndistinct;
DROP STATISTICS s12;
CREATE STATISTICS s12 (ndistinct) ON (c * 10), (d - 1) FROM ndistinct;
ANALYZE ndistinct;
DROP STATISTICS s12;
CREATE STATISTICS s12 (ndistinct) ON c, d, (c * 10), (d - 1) FROM ndistinct;
ANALYZE ndistinct;
DROP STATISTICS s11;
CREATE STATISTICS s11 (ndistinct) ON a, b, (a*5), (b+1) FROM ndistinct;
ANALYZE ndistinct;
DROP STATISTICS s11;
DROP STATISTICS s12;
CREATE STATISTICS s11 (ndistinct) ON a, b, (a*5), (b+1) FROM ndistinct;
CREATE STATISTICS s12 (ndistinct) ON a, (b+1), (c * 10) FROM ndistinct;
ANALYZE ndistinct;
DROP STATISTICS s11;
DROP STATISTICS s12;
CREATE TABLE functional_dependencies (
    filler1 TEXT,
    filler2 NUMERIC,
    a INT,
    b TEXT,
    filler3 DATE,
    c INT,
    d TEXT
)
WITH (autovacuum_enabled = off);
CREATE INDEX fdeps_ab_idx ON functional_dependencies (a, b);
CREATE INDEX fdeps_abc_idx ON functional_dependencies (a, b, c);
INSERT INTO functional_dependencies (a, b, c, filler1)
     SELECT mod(i, 5), mod(i, 7), mod(i, 11), i FROM generate_series(1,1000) s(i);
ANALYZE functional_dependencies;
CREATE STATISTICS func_deps_stat (dependencies) ON a, b, c FROM functional_dependencies;
ANALYZE functional_dependencies;
TRUNCATE functional_dependencies;
DROP STATISTICS func_deps_stat;
INSERT INTO functional_dependencies (a, b, c, filler1)
     SELECT i, i, i, i FROM generate_series(1,5000) s(i);
ANALYZE functional_dependencies;
CREATE STATISTICS func_deps_stat (dependencies) ON (mod(a,11)), (mod(b::int, 13)), (mod(c, 7)) FROM functional_dependencies;
ANALYZE functional_dependencies;
TRUNCATE functional_dependencies;
DROP STATISTICS func_deps_stat;
INSERT INTO functional_dependencies (a, b, c, filler1)
     SELECT mod(i,100), mod(i,50), mod(i,25), i FROM generate_series(1,5000) s(i);
ANALYZE functional_dependencies;
CREATE STATISTICS func_deps_stat (dependencies) ON a, b, c FROM functional_dependencies;
ANALYZE functional_dependencies;
SELECT dependencies FROM pg_stats_ext WHERE statistics_name = 'func_deps_stat';
ALTER TABLE functional_dependencies ALTER COLUMN c TYPE numeric;
ANALYZE functional_dependencies;
DROP STATISTICS func_deps_stat;
CREATE STATISTICS func_deps_stat (dependencies) ON (a * 2), upper(b), (c + 1) FROM functional_dependencies;
ANALYZE functional_dependencies;
SELECT dependencies FROM pg_stats_ext WHERE statistics_name = 'func_deps_stat';
CREATE TABLE functional_dependencies_multi (
	a INTEGER,
	b INTEGER,
	c INTEGER,
	d INTEGER
)
WITH (autovacuum_enabled = off);
INSERT INTO functional_dependencies_multi (a, b, c, d)
    SELECT
         mod(i,7),
         mod(i,7),
         mod(i,11),
         mod(i,11)
    FROM generate_series(1,5000) s(i);
ANALYZE functional_dependencies_multi;
CREATE STATISTICS functional_dependencies_multi_1 (dependencies) ON a, b FROM functional_dependencies_multi;
CREATE STATISTICS functional_dependencies_multi_2 (dependencies) ON c, d FROM functional_dependencies_multi;
ANALYZE functional_dependencies_multi;
DROP TABLE functional_dependencies_multi;
CREATE TABLE mcv_lists (
    filler1 TEXT,
    filler2 NUMERIC,
    a INT,
    b VARCHAR,
    filler3 DATE,
    c INT,
    d TEXT,
    ia INT[]
)
WITH (autovacuum_enabled = off);
INSERT INTO mcv_lists (a, b, c, filler1)
     SELECT mod(i,37), mod(i,41), mod(i,43), mod(i,47) FROM generate_series(1,5000) s(i);
ANALYZE mcv_lists;
CREATE STATISTICS mcv_lists_stats (mcv) ON a, b, c FROM mcv_lists;
ANALYZE mcv_lists;
TRUNCATE mcv_lists;
DROP STATISTICS mcv_lists_stats;
INSERT INTO mcv_lists (a, b, c, filler1)
     SELECT i, i, i, i FROM generate_series(1,1000) s(i);
ANALYZE mcv_lists;
CREATE STATISTICS mcv_lists_stats (mcv) ON (mod(a,7)), (mod(b::int,11)), (mod(c,13)) FROM mcv_lists;
ANALYZE mcv_lists;
TRUNCATE mcv_lists;
DROP STATISTICS mcv_lists_stats;
INSERT INTO mcv_lists (a, b, c, ia, filler1)
     SELECT mod(i,100), mod(i,50), mod(i,25), array[mod(i,25)], i
       FROM generate_series(1,5000) s(i);
ANALYZE mcv_lists;
CREATE STATISTICS mcv_lists_stats (mcv) ON a, b, c, ia FROM mcv_lists;
ANALYZE mcv_lists;
ALTER TABLE mcv_lists ALTER COLUMN d TYPE VARCHAR(64);
ALTER TABLE mcv_lists ALTER COLUMN c TYPE numeric;
ANALYZE mcv_lists;
TRUNCATE mcv_lists;
DROP STATISTICS mcv_lists_stats;
INSERT INTO mcv_lists (a, b, c, filler1)
     SELECT i, i, i, i FROM generate_series(1,1000) s(i);
ANALYZE mcv_lists;
CREATE STATISTICS mcv_lists_stats_1 ON (mod(a,20)) FROM mcv_lists;
CREATE STATISTICS mcv_lists_stats_2 ON (mod(b::int,10)) FROM mcv_lists;
CREATE STATISTICS mcv_lists_stats_3 ON (mod(c,5)) FROM mcv_lists;
ANALYZE mcv_lists;
DROP STATISTICS mcv_lists_stats_1;
DROP STATISTICS mcv_lists_stats_2;
DROP STATISTICS mcv_lists_stats_3;
CREATE STATISTICS mcv_lists_stats (mcv) ON (mod(a,20)), (mod(b::int,10)), (mod(c,5)) FROM mcv_lists;
ANALYZE mcv_lists;
TRUNCATE mcv_lists;
DROP STATISTICS mcv_lists_stats;
INSERT INTO mcv_lists (a, b, c, filler1)
     SELECT
         (CASE WHEN mod(i,100) = 1 THEN NULL ELSE mod(i,100) END),
         (CASE WHEN mod(i,50) = 1  THEN NULL ELSE mod(i,50) END),
         (CASE WHEN mod(i,25) = 1  THEN NULL ELSE mod(i,25) END),
         i
     FROM generate_series(1,5000) s(i);
ANALYZE mcv_lists;
CREATE STATISTICS mcv_lists_stats (mcv) ON a, b, c FROM mcv_lists;
ANALYZE mcv_lists;
TRUNCATE mcv_lists;
INSERT INTO mcv_lists (a, b, c) SELECT 1, 2, 3 FROM generate_series(1,1000) s(i);
ANALYZE mcv_lists;
TRUNCATE mcv_lists;
DROP STATISTICS mcv_lists_stats;
INSERT INTO mcv_lists (a, b, c, d)
     SELECT
         NULL, 
         (CASE WHEN mod(i,2) = 0 THEN NULL ELSE 'x' END),
         (CASE WHEN mod(i,2) = 0 THEN NULL ELSE 0 END),
         (CASE WHEN mod(i,2) = 0 THEN NULL ELSE 'x' END)
     FROM generate_series(1,5000) s(i);
ANALYZE mcv_lists;
CREATE STATISTICS mcv_lists_stats (mcv) ON a, b, d FROM mcv_lists;
ANALYZE mcv_lists;
CREATE TABLE mcv_lists_uuid (
    a UUID,
    b UUID,
    c UUID
)
WITH (autovacuum_enabled = off);
ANALYZE mcv_lists_uuid;
CREATE STATISTICS mcv_lists_uuid_stats (mcv) ON a, b, c
  FROM mcv_lists_uuid;
ANALYZE mcv_lists_uuid;
DROP TABLE mcv_lists_uuid;
CREATE TABLE mcv_lists_arrays (
    a TEXT[],
    b NUMERIC[],
    c INT[]
)
WITH (autovacuum_enabled = off);
CREATE STATISTICS mcv_lists_arrays_stats (mcv) ON a, b, c
  FROM mcv_lists_arrays;
ANALYZE mcv_lists_arrays;
CREATE TABLE mcv_lists_bool (
    a BOOL,
    b BOOL,
    c BOOL
)
WITH (autovacuum_enabled = off);
INSERT INTO mcv_lists_bool (a, b, c)
     SELECT
         (mod(i,2) = 0), (mod(i,4) = 0), (mod(i,8) = 0)
     FROM generate_series(1,10000) s(i);
ANALYZE mcv_lists_bool;
CREATE STATISTICS mcv_lists_bool_stats (mcv) ON a, b, c
  FROM mcv_lists_bool;
ANALYZE mcv_lists_bool;
CREATE TABLE mcv_lists_partial (
    a INT,
    b INT,
    c INT
);
INSERT INTO mcv_lists_partial (a, b, c)
     SELECT
         mod(i,10),
         mod(i,10),
         mod(i,10)
     FROM generate_series(0,999) s(i);
INSERT INTO mcv_lists_partial (a, b, c)
     SELECT
         i,
         i,
         i
     FROM generate_series(0,99) s(i);
INSERT INTO mcv_lists_partial (a, b, c)
     SELECT
         i,
         i,
         i
     FROM generate_series(0,3999) s(i);
ANALYZE mcv_lists_partial;
CREATE STATISTICS mcv_lists_partial_stats (mcv) ON a, b, c
  FROM mcv_lists_partial;
ANALYZE mcv_lists_partial;
DROP TABLE mcv_lists_partial;
CREATE TABLE mcv_lists_multi (
	a INTEGER,
	b INTEGER,
	c INTEGER,
	d INTEGER
)
WITH (autovacuum_enabled = off);
INSERT INTO mcv_lists_multi (a, b, c, d)
    SELECT
         mod(i,5),
         mod(i,5),
         mod(i,7),
         mod(i,7)
    FROM generate_series(1,5000) s(i);
ANALYZE mcv_lists_multi;
CREATE STATISTICS mcv_lists_multi_1 (mcv) ON a, b FROM mcv_lists_multi;
CREATE STATISTICS mcv_lists_multi_2 (mcv) ON c, d FROM mcv_lists_multi;
ANALYZE mcv_lists_multi;
DROP TABLE mcv_lists_multi;
CREATE TABLE expr_stats (a int, b int, c int);
INSERT INTO expr_stats SELECT mod(i,10), mod(i,10), mod(i,10) FROM generate_series(1,1000) s(i);
ANALYZE expr_stats;
CREATE STATISTICS expr_stats_1 (mcv) ON (a+b), (a-b), (2*a), (3*b) FROM expr_stats;
ANALYZE expr_stats;
DROP STATISTICS expr_stats_1;
DROP TABLE expr_stats;
CREATE TABLE expr_stats (a int, b int, c int);
INSERT INTO expr_stats SELECT mod(i,10), mod(i,10), mod(i,10) FROM generate_series(1,1000) s(i);
ANALYZE expr_stats;
CREATE STATISTICS expr_stats_1 (mcv) ON a, b, (2*a), (3*b), (a+b), (a-b) FROM expr_stats;
ANALYZE expr_stats;
DROP TABLE expr_stats;
CREATE TABLE expr_stats (a int, b name, c text);
ANALYZE expr_stats;
CREATE STATISTICS expr_stats_1 (mcv) ON a, b, (b || c), (c || b) FROM expr_stats;
ANALYZE expr_stats;
DROP TABLE expr_stats;
CREATE TABLE expr_stats_incompatible_test (
    c0 double precision,
    c1 boolean NOT NULL
);
CREATE STATISTICS expr_stat_comp_1 ON c0, c1 FROM expr_stats_incompatible_test;
INSERT INTO expr_stats_incompatible_test VALUES (1234,false), (5678,true);
ANALYZE expr_stats_incompatible_test;
SELECT c0 FROM ONLY expr_stats_incompatible_test WHERE
(
  upper('x') LIKE ('x'||('[0,1]'::int4range))
  AND
  (c0 IN (0, 1) OR c1)
);
DROP TABLE expr_stats_incompatible_test;
CREATE SCHEMA tststats;
CREATE TABLE tststats.priv_test_tbl (
    a int,
    b int
);
INSERT INTO tststats.priv_test_tbl
     SELECT mod(i,5), mod(i,10) FROM generate_series(1,100) s(i);
CREATE STATISTICS tststats.priv_test_stats (mcv) ON a, b
  FROM tststats.priv_test_tbl;
ANALYZE tststats.priv_test_tbl;
create table stts_t1 (a int, b int);
create statistics (ndistinct) on a, b from stts_t1;
create statistics (ndistinct, dependencies) on a, b from stts_t1;
create statistics (ndistinct, dependencies, mcv) on a, b from stts_t1;
create table stts_t2 (a int, b int, c int);
create statistics on b, c from stts_t2;
create table stts_t3 (col1 int, col2 int, col3 int);
create statistics stts_hoge on col1, col2, col3 from stts_t3;
create schema stts_s1;
create schema stts_s2;
create statistics stts_s1.stts_foo on col1, col2 from stts_t3;
create statistics stts_s2.stts_yama (dependencies, mcv) on col1, col3 from stts_t3;
insert into stts_t1 select i,i from generate_series(1,100) i;
analyze stts_t1;
set search_path to public, stts_s1, stts_s2, tststats;
create statistics (mcv) ON a, b, (a+b), (a-b) FROM stts_t1;
create statistics (mcv) ON a, b, (a+b), (a-b) FROM stts_t1;
create statistics (mcv) ON (a+b), (a-b) FROM stts_t1;
drop statistics stts_t1_a_b_expr_expr_stat;
drop statistics stts_t1_a_b_expr_expr_stat1;
drop statistics stts_t1_expr_expr_stat;
set search_path to public, stts_s1;
reset role;
drop table stts_t1, stts_t2, stts_t3;
drop schema stts_s1, stts_s2 cascade;
reset search_path;
SELECT * FROM tststats.priv_test_tbl;
SELECT * FROM tststats.priv_test_tbl
  WHERE a = 1 and tststats.priv_test_tbl.* > (1, 1) is not null;
RESET SESSION AUTHORIZATION;
CREATE VIEW tststats.priv_test_view WITH (security_barrier=true)
    AS SELECT * FROM tststats.priv_test_tbl WHERE false;
RESET SESSION AUTHORIZATION;
ALTER TABLE tststats.priv_test_tbl ENABLE ROW LEVEL SECURITY;
RESET SESSION AUTHORIZATION;
DROP SCHEMA tststats CASCADE;
