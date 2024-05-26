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
