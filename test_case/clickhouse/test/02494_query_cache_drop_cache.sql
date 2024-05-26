SYSTEM DROP QUERY CACHE;
SELECT 1 SETTINGS use_query_cache = true;
SELECT count(*) FROM system.query_cache;
SYSTEM DROP QUERY CACHE;
