DROP TABLE IF EXISTS t0;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t0 (x UInt32, y UInt64) engine = MergeTree ORDER BY (x,y);
CREATE TABLE t1 (x UInt32, y UInt64) engine = MergeTree ORDER BY (x,y);
CREATE TABLE t2 (x UInt32, y UInt64) engine = MergeTree ORDER BY (x,y);
INSERT INTO t1 (x, y) VALUES (0, 0);
SET join_algorithm = 'prefer_partial_merge';
SET any_join_distinct_right_table_keys = 1;
