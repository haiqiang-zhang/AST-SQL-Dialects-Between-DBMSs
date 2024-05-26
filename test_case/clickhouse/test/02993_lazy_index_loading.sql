SELECT round(primary_key_bytes_in_memory, -7), round(primary_key_bytes_in_memory_allocated, -7) FROM system.parts WHERE database = currentDatabase() AND table = 'test';
DETACH TABLE test;
SET max_memory_usage = '50M';
ATTACH TABLE test;
SELECT primary_key_bytes_in_memory, primary_key_bytes_in_memory_allocated FROM system.parts WHERE database = currentDatabase() AND table = 'test';
SET max_memory_usage = '200M';
SELECT s != '' FROM test LIMIT 1;
DROP TABLE test;
