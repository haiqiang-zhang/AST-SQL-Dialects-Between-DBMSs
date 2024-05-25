SET max_block_size = 64, max_insert_block_size = 64, min_insert_block_size_rows = 64;
INSERT INTO test SELECT number AS key, sipHash64(number) AS val FROM numbers(512);
SYSTEM FLUSH LOGS;
OPTIMIZE TABLE test FINAL;
SYSTEM FLUSH LOGS;
ALTER TABLE test UPDATE val = 0 WHERE key % 2 == 0 SETTINGS mutations_sync = 2;
SYSTEM FLUSH LOGS;
DROP TABLE test;
