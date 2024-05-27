DROP TABLE IF EXISTS test_01344;
CREATE TABLE test_01344 (x String, INDEX idx (x) TYPE set(10) GRANULARITY 1) ENGINE = MergeTree ORDER BY tuple() SETTINGS min_bytes_for_wide_part = 0;
INSERT INTO test_01344 VALUES ('Hello, world');