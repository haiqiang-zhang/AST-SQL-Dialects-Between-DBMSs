SELECT COUNT(*) from bad_skip_idx WHERE value = 'xxxxxxxxxx1015';
INSERT INTO bad_skip_idx SELECT number, concat('x', toString(number)) FROM numbers(1000);
ALTER TABLE bad_skip_idx ADD INDEX idx value TYPE bloom_filter(0.01) GRANULARITY 4;
OPTIMIZE TABLE bad_skip_idx FINAL;
SELECT COUNT(*) from bad_skip_idx WHERE value = 'xxxxxxxxxx1015';
DROP TABLE IF EXISTS bad_skip_idx;
