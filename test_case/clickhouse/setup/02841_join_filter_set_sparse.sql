DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1 (s String) ENGINE = MergeTree ORDER BY s
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.5;
INSERT INTO t1 SELECT if (number % 13 = 0, toString(number), '') FROM numbers(2000);
CREATE TABLE t2 (s String) ENGINE = MergeTree ORDER BY s
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.5;
INSERT INTO t2 SELECT if (number % 14 = 0, toString(number), '') FROM numbers(2000);
