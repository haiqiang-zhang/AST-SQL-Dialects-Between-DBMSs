DROP TABLE IF EXISTS part_log_profile_events_r1 SYNC;
DROP TABLE IF EXISTS part_log_profile_events_r2 SYNC;
SET max_block_size = 64, max_insert_block_size = 64, min_insert_block_size_rows = 64;
SYSTEM FLUSH LOGS;
