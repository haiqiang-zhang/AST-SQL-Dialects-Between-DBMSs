DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1 (x UInt32, s String) engine = Memory;
CREATE TABLE t2 (x UInt32, s String) engine = Memory;
INSERT INTO t1 (x, s) VALUES (0, 'a1'), (1, 'a2'), (2, 'a3'), (3, 'a4'), (4, 'a5');
INSERT INTO t2 (x, s) VALUES (2, 'b1'), (4, 'b2'), (5, 'b4');
SET join_algorithm = 'prefer_partial_merge';
SET join_use_nulls = 0;
SET any_join_distinct_right_table_keys = 0;
