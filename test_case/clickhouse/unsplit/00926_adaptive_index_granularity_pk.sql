SET send_logs_level = 'fatal';
SELECT '----00489----';
DROP TABLE IF EXISTS pk;
SET max_block_size = 1;
SET max_rows_to_read = 5;
SET max_rows_to_read = 9;
SET max_rows_to_read = 5;
SET max_rows_to_read = 4;
SET max_rows_to_read = 5;
SET max_block_size = 8192;
SELECT '----00607----';
SET max_rows_to_read = 0;
DROP TABLE IF EXISTS merge_tree;
CREATE TABLE merge_tree (x UInt32) ENGINE = MergeTree ORDER BY x SETTINGS index_granularity_bytes = 4, min_index_granularity_bytes=1, write_final_mark = 0;
INSERT INTO merge_tree VALUES (0), (1);
SET force_primary_key = 1;
SET max_rows_to_read = 1;
SELECT count() FROM merge_tree WHERE x = 0;
DROP TABLE merge_tree;
SELECT '----00804----';
SET max_rows_to_read = 0;
SET force_primary_key = 0;
DROP TABLE IF EXISTS large_alter_table_00926;
DROP TABLE IF EXISTS store_of_hash_00926;
SET allow_suspicious_codecs = 1;
CREATE TABLE large_alter_table_00926 (
    somedate Date CODEC(ZSTD, ZSTD, ZSTD(12), LZ4HC(12)),
    id UInt64 CODEC(LZ4, ZSTD, NONE, LZ4HC),
    data String CODEC(ZSTD(2), LZ4HC, NONE, LZ4, LZ4)
) ENGINE = MergeTree() PARTITION BY somedate ORDER BY id SETTINGS min_index_granularity_bytes=30, write_final_mark = 0, min_bytes_for_wide_part = '10M', min_rows_for_wide_part = 0;
CREATE TABLE store_of_hash_00926 (hash UInt64) ENGINE = Memory();
INSERT INTO store_of_hash_00926 SELECT sum(cityHash64(*)) FROM large_alter_table_00926;
ALTER TABLE large_alter_table_00926 MODIFY COLUMN data CODEC(NONE, LZ4, LZ4HC, ZSTD);
OPTIMIZE TABLE large_alter_table_00926;
DETACH TABLE large_alter_table_00926;
ATTACH TABLE large_alter_table_00926;
INSERT INTO store_of_hash_00926 SELECT sum(cityHash64(*)) FROM large_alter_table_00926;
SELECT COUNT(hash) FROM store_of_hash_00926;
DROP TABLE IF EXISTS large_alter_table_00926;
DROP TABLE IF EXISTS store_of_hash_00926;
