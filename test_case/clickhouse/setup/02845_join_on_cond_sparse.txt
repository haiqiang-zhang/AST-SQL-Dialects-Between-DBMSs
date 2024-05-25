DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1 ( id UInt32, attr UInt32 ) ENGINE = MergeTree ORDER BY id
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.1;
INSERT INTO t1 VALUES (0, 0);
CREATE TABLE t2 ( id UInt32, attr UInt32 ) ENGINE = MergeTree ORDER BY id
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.1;
INSERT INTO t2 VALUES (0, 0);
