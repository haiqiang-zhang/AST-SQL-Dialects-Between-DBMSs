DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1 (x UInt64, y UInt64) ENGINE = MergeTree ORDER BY y
AS SELECT sipHash64(number, 't1_x') % 100 AS x, sipHash64(number, 't1_y') % 100 AS y FROM numbers(100);
CREATE TABLE t2 (x UInt64, y UInt64) ENGINE = MergeTree ORDER BY y
AS SELECT sipHash64(number, 't2_x') % 100 AS x, sipHash64(number, 't2_y') % 100 AS y FROM numbers(100);
SET max_rows_in_set_to_optimize_join = 1000;
SET join_algorithm = 'full_sorting_merge';
