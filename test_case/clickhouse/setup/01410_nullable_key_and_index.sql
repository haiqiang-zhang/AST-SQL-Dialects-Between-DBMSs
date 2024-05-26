DROP TABLE IF EXISTS nullable_key;
DROP TABLE IF EXISTS nullable_key_without_final_mark;
DROP TABLE IF EXISTS nullable_minmax_index;
SET max_threads = 1;
SET optimize_read_in_order=0;
CREATE TABLE nullable_key (k Nullable(int), v int) ENGINE MergeTree ORDER BY k SETTINGS allow_nullable_key = 1, index_granularity = 1;
INSERT INTO nullable_key SELECT number * 2, number * 3 FROM numbers(10);
INSERT INTO nullable_key SELECT NULL, -number FROM numbers(3);
