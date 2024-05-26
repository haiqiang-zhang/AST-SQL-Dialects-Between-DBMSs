DROP TABLE IF EXISTS lwd_test_02521;
CREATE TABLE lwd_test_02521 (id UInt64, value String, event_time DateTime)
ENGINE MergeTree()
ORDER BY id
SETTINGS min_bytes_for_wide_part = 0, index_granularity = 8192, index_granularity_bytes = '10Mi';
INSERT INTO lwd_test_02521 SELECT number, randomString(10), now() - INTERVAL 2 MONTH FROM numbers(50000);
INSERT INTO lwd_test_02521 SELECT number, randomString(10), now() FROM numbers(50000);
