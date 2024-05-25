SYSTEM STOP MERGES mt;
SET max_block_size = 1, min_insert_block_size_rows = 0, min_insert_block_size_bytes = 0;
INSERT INTO mt SELECT * FROM numbers(1000);
SET max_block_size = 65536;
SELECT count(), sum(x) FROM mt;
SYSTEM START MERGES mt;
OPTIMIZE TABLE mt FINAL;
SELECT count(), sum(x) FROM mt;
DROP TABLE mt;
