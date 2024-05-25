DROP TABLE IF EXISTS order_by_desc;
SET enable_filesystem_cache=0;
CREATE TABLE order_by_desc (u UInt32, s String)
ENGINE MergeTree ORDER BY u PARTITION BY u % 100
SETTINGS index_granularity = 1024, index_granularity_bytes = '10Mi';
INSERT INTO order_by_desc SELECT number, repeat('a', 1024) FROM numbers(1024 * 300);
OPTIMIZE TABLE order_by_desc FINAL;
SYSTEM FLUSH LOGS;
