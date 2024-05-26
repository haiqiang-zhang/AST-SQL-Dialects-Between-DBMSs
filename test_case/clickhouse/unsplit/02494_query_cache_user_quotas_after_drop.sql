SYSTEM DROP QUERY CACHE;
SET query_cache_max_entries = 1;
SELECT 'a' SETTINGS use_query_cache = true;
SELECT 'b' SETTINGS use_query_cache = true;
SELECT count(*) FROM system.query_cache;
SET query_cache_max_entries = DEFAULT;
SELECT 'c' SETTINGS use_query_cache = true;
SELECT 'd' SETTINGS use_query_cache = true;
SYSTEM DROP QUERY CACHE;
SELECT '--';
SET query_cache_max_entries = 1;
SELECT 'a' SETTINGS use_query_cache = true;
SELECT 'b' SETTINGS use_query_cache = true;
SET query_cache_max_entries = DEFAULT;
SELECT 'c' SETTINGS use_query_cache = true;
SELECT 'd' SETTINGS use_query_cache = true;
SYSTEM DROP QUERY CACHE;
