DROP TABLE IF EXISTS test_bloom_filter_index;
SELECT UserID FROM test_bloom_filter_index WHERE (CounterID, EventTime) IN (SELECT toUInt32(25703952), toDateTime('2014-03-19 23:59:58'));
DROP TABLE IF EXISTS test_bloom_filter_index;
CREATE TABLE test_bloom_filter_index(`uint8` UInt8, `uint16` UInt16, `index_column` UInt64,  INDEX test1 `index_column` TYPE bloom_filter GRANULARITY 1) ENGINE = MergeTree() PARTITION BY tuple() ORDER BY tuple();
INSERT INTO test_bloom_filter_index SELECT number, number, number FROM numbers(10000);
SELECT * FROM test_bloom_filter_index WHERE (`uint16`, `index_column`) IN (SELECT toUInt16(2), toUInt64(2));
DROP TABLE IF EXISTS test_bloom_filter_index;