CREATE TABLE t1 (i Int64, j Int64) ENGINE = Memory;
INSERT INTO t1 SELECT number, number FROM system.numbers LIMIT 100;
CREATE TABLE t2 (k Int64, l Int64, m Int64, n Int64) ENGINE = Memory;
CREATE MATERIALIZED VIEW mv1 TO t2 AS
    WITH
    (SELECT max(i) FROM t1) AS t1
    SELECT
           t1 as k, -- Using local cache x 4
           t1 as l,
           t1 as m,
           t1 as n
    FROM t1
    LIMIT 5;
set allow_experimental_analyzer = 0;
INSERT INTO t1
WITH
    (SELECT max(i) FROM t1) AS t1
SELECT
       number as i,
       t1 + t1 + t1 AS j -- Using global cache
FROM system.numbers
LIMIT 100
SETTINGS
    min_insert_block_size_rows=5,
    max_insert_block_size=5,
    min_insert_block_size_rows_for_materialized_views=5,
    max_block_size=5,
    max_threads=1;
SELECT k, l, m, n, count()
FROM t2
GROUP BY k, l, m, n
ORDER BY k, l, m, n;
SYSTEM FLUSH LOGS;
truncate table t2;
set allow_experimental_analyzer = 1;
INSERT INTO t1
WITH
    (SELECT max(i) FROM t1) AS t1
SELECT
       number as i,
       t1 + t1 + t1 AS j -- Using global cache
FROM system.numbers
LIMIT 100
SETTINGS
    min_insert_block_size_rows=5,
    max_insert_block_size=5,
    min_insert_block_size_rows_for_materialized_views=5,
    max_block_size=5,
    max_threads=1;
SYSTEM FLUSH LOGS;
DROP TABLE mv1;
set allow_experimental_analyzer = 0;
CREATE TABLE t3 (z Int64) ENGINE = Memory;
CREATE MATERIALIZED VIEW mv2 TO t3 AS
SELECT
   -- This includes an unnecessarily complex query to verify that the local cache is used (since it uses t1)
    sum(i) + sum(j) + (SELECT * FROM (SELECT min(i) + min(j) FROM (SELECT * FROM system.one _a, t1 _b))) AS z
FROM t1;
INSERT INTO t1
SELECT 0 as i, number as j from numbers(100)
SETTINGS
    min_insert_block_size_rows=5,
    max_insert_block_size=5,
    min_insert_block_size_rows_for_materialized_views=5,
    max_block_size=5,
    max_threads=1;
SELECT * FROM t3 ORDER BY z ASC;
SYSTEM FLUSH LOGS;
truncate table t3;
set allow_experimental_analyzer = 1;
INSERT INTO t1
SELECT 0 as i, number as j from numbers(100)
SETTINGS
    min_insert_block_size_rows=5,
    max_insert_block_size=5,
    min_insert_block_size_rows_for_materialized_views=5,
    max_block_size=5,
    max_threads=1;
SELECT * FROM t3 ORDER BY z ASC;
SYSTEM FLUSH LOGS;
DROP TABLE mv2;
set allow_experimental_analyzer = 0;
CREATE TABLE t4 (z Int64) ENGINE = Memory;
CREATE MATERIALIZED VIEW mv3 TO t4 AS
SELECT
    -- This includes an unnecessarily complex query but now it uses t2 so it can be cached
    min(i) + min(j) + (SELECT * FROM (SELECT min(k) + min(l) FROM (SELECT * FROM system.one _a, t2 _b))) AS z
FROM t1;
INSERT INTO t1
SELECT number as i, number as j from numbers(100)
    SETTINGS
    min_insert_block_size_rows=5,
    max_insert_block_size=5,
    min_insert_block_size_rows_for_materialized_views=5,
    max_block_size=5,
    max_threads=1;
SYSTEM FLUSH LOGS;
SELECT * FROM t4 ORDER BY z ASC;
truncate table t4;
set allow_experimental_analyzer = 1;
INSERT INTO t1
SELECT number as i, number as j from numbers(100)
    SETTINGS
    min_insert_block_size_rows=5,
    max_insert_block_size=5,
    min_insert_block_size_rows_for_materialized_views=5,
    max_block_size=5,
    max_threads=1;
SYSTEM FLUSH LOGS;
SELECT * FROM t4 ORDER BY z ASC;
DROP TABLE mv3;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
