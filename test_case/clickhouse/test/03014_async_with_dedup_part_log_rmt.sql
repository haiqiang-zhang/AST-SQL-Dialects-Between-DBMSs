SET async_insert = 1;
SET wait_for_async_insert = 1;
SET async_insert_deduplicate = 1;
SELECT '-- Inserted part --';
SYSTEM FLUSH LOGS;
SELECT '-- Deduplicated part --';
SYSTEM FLUSH LOGS;
