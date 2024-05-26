SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (key UInt8) ENGINE = Memory;
INSERT INTO t1 VALUES (1),(2);
SET join_algorithm = 'full_sorting_merge';
