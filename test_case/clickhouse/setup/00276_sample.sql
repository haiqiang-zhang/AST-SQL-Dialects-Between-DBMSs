DROP TABLE IF EXISTS sample_00276;
set allow_deprecated_syntax_for_merge_tree=1;
SET min_insert_block_size_rows = 0, min_insert_block_size_bytes = 0;
SET max_block_size = 10;
CREATE TABLE sample_00276 (d Date DEFAULT '2000-01-01', x UInt8) ENGINE = MergeTree(d, x, x, 10);
INSERT INTO sample_00276 (x) SELECT toUInt8(number) AS x FROM system.numbers LIMIT 256;
