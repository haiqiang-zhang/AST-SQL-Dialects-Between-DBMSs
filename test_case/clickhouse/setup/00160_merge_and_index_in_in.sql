DROP TABLE IF EXISTS mt_00160;
DROP TABLE IF EXISTS merge_00160;
CREATE TABLE mt_00160 (d Date DEFAULT toDate('2015-05-01'), x UInt64) ENGINE = MergeTree PARTITION BY d ORDER BY x SETTINGS index_granularity = 1, min_bytes_for_wide_part = 0;
CREATE TABLE merge_00160 (d Date, x UInt64) ENGINE = Merge(currentDatabase(), '^mt_00160$');
SET min_insert_block_size_rows = 0, min_insert_block_size_bytes = 0;
SET max_block_size = 1000000;
INSERT INTO mt_00160 (x) SELECT number AS x FROM system.numbers LIMIT 100000;
