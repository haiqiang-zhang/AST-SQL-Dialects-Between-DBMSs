SET allow_experimental_parallel_reading_from_replicas = 0;
DROP TABLE IF EXISTS test5346;
CREATE TABLE test5346 (`Id` String, `Timestamp` DateTime, `updated` DateTime) 
ENGINE = ReplacingMergeTree(updated) PARTITION BY tuple() ORDER BY (Timestamp, Id);
INSERT INTO test5346 VALUES('1',toDateTime('2020-01-01 00:00:00'),toDateTime('2020-01-01 00:00:00'));
DROP TABLE test5346;
