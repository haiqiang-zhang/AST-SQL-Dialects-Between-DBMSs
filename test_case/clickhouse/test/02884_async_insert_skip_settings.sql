SET async_insert = 1;
SET async_insert_deduplicate = 1;
SET wait_for_async_insert = 0;
SET async_insert_busy_timeout_min_ms = 100000;
SET async_insert_busy_timeout_max_ms = 1000000;
SET insert_deduplication_token = '1';
SET log_comment = 'async_insert_skip_settings_1';
SET insert_deduplication_token = '2';
SET log_comment = 'async_insert_skip_settings_2';
SET insert_deduplication_token = '1';
SET log_comment = 'async_insert_skip_settings_3';
SET insert_deduplication_token = '3';
SET log_comment = 'async_insert_skip_settings_4';
SYSTEM FLUSH LOGS;
SELECT length(entries.bytes) FROM system.asynchronous_inserts
WHERE database = currentDatabase() AND table = 't_async_insert_skip_settings'
ORDER BY first_update;
SYSTEM FLUSH ASYNC INSERT QUEUE;
SYSTEM FLUSH LOGS;
