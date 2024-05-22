DROP TABLE IF EXISTS bad_skip_idx;
CREATE TABLE bad_skip_idx
(
  id UInt64,
  value String
) ENGINE MergeTree()
ORDER BY id SETTINGS index_granularity_bytes = 64, min_index_granularity_bytes = 10, vertical_merge_algorithm_min_rows_to_activate = 0, vertical_merge_algorithm_min_columns_to_activate = 0;
-- 7 rows per granule
INSERT INTO bad_skip_idx SELECT number, concat('x', toString(number)) FROM numbers(1000);
INSERT INTO bad_skip_idx SELECT number, concat('xxxxxxxxxx', toString(number)) FROM numbers(1000,1000);
SELECT COUNT(*) from bad_skip_idx WHERE value = 'xxxxxxxxxx1015';
INSERT INTO bad_skip_idx SELECT number, concat('x', toString(number)) FROM numbers(1000);
ALTER TABLE bad_skip_idx ADD INDEX idx value TYPE bloom_filter(0.01) GRANULARITY 4;
OPTIMIZE TABLE bad_skip_idx FINAL;
SELECT COUNT(*) from bad_skip_idx WHERE value = 'xxxxxxxxxx1015';
DROP TABLE IF EXISTS bad_skip_idx;
