SYSTEM STOP MERGES too_many_parts;
SET max_block_size = 1, min_insert_block_size_rows = 0, min_insert_block_size_bytes = 0, max_threads=100, max_insert_threads=100;
INSERT INTO too_many_parts SELECT * FROM numbers_mt(100);
SELECT count() FROM too_many_parts;
DROP TABLE too_many_parts;
