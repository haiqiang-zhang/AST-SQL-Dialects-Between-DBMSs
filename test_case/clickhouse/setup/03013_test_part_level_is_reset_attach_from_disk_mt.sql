SET alter_sync = 2;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a Int) ENGINE = MergeTree ORDER BY tuple();
INSERT INTO test VALUES (1), (2), (3);
