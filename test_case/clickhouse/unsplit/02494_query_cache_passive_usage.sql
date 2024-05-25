
SYSTEM DROP QUERY CACHE;
SELECT 1;
SELECT COUNT(*) FROM system.query_cache;
SELECT '-----';
SELECT 1 SETTINGS use_query_cache = true, enable_writes_to_query_cache = false;
SELECT COUNT(*) FROM system.query_cache;
SELECT '-----';
SELECT 1 SETTINGS use_query_cache = true;
SELECT COUNT(*) FROM system.query_cache;
SELECT '-----';
SELECT 1 SETTINGS use_query_cache = true, enable_writes_to_query_cache = false;
SELECT COUNT(*) FROM system.query_cache;
SYSTEM FLUSH LOGS;
SYSTEM DROP QUERY CACHE;
