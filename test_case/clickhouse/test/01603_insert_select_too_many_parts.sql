SYSTEM STOP MERGES too_many_parts;
SET max_block_size = 1, min_insert_block_size_rows = 0, min_insert_block_size_bytes = 0;
SET max_threads=1, max_insert_threads=1;
SELECT count() FROM too_many_parts;
DROP TABLE too_many_parts;
