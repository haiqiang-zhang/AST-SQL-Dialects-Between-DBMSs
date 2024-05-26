DROP TABLE IF EXISTS lwd_test;
CREATE TABLE lwd_test (id UInt64 , value String) ENGINE MergeTree() ORDER BY id SETTINGS index_granularity=8192, index_granularity_bytes='10Mi';
INSERT INTO lwd_test SELECT number, randomString(10) FROM system.numbers LIMIT 1000000;
SET mutations_sync = 0;
