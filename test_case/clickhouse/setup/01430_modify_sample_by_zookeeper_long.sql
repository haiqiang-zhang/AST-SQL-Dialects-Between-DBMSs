DROP TABLE IF EXISTS modify_sample;
SET min_insert_block_size_rows = 0, min_insert_block_size_bytes = 0;
SET max_block_size = 10;
CREATE TABLE modify_sample (d Date DEFAULT '2000-01-01', x UInt8) ENGINE = MergeTree PARTITION BY d ORDER BY x;
INSERT INTO modify_sample (x) SELECT toUInt8(number) AS x FROM system.numbers LIMIT 256;
ALTER TABLE modify_sample MODIFY SAMPLE BY x;
