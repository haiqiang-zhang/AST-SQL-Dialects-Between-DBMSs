-- Tag no-parallel: Messes with internal cache

-- Start with empty query cache QC
SYSTEM DROP QUERY CACHE;
SELECT 1 SETTINGS use_query_cache = true;
SELECT 1 SETTINGS use_query_cache = true;
SYSTEM FLUSH LOGS;
SYSTEM DROP QUERY CACHE;
