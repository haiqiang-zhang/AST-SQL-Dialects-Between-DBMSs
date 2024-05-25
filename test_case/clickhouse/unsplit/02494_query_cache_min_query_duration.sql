SYSTEM DROP QUERY CACHE;
SELECT 1 SETTINGS use_query_cache = true;
SELECT COUNT(*) FROM system.query_cache;
SYSTEM DROP QUERY CACHE;
SELECT '---';
SELECT 1 SETTINGS use_query_cache = true, query_cache_min_query_duration = 10000;
SELECT COUNT(*) FROM system.query_cache;
SYSTEM DROP QUERY CACHE;
