-- Tag no-fasttest: Test runtime is > 6 sec
-- Tag long: Test runtime is > 6 sec
-- Tag no-parallel: Messes with internal cache

SYSTEM DROP QUERY CACHE;
SELECT 1 SETTINGS use_query_cache = true, query_cache_ttl = 3;
SELECT COUNT(*) FROM system.query_cache;
SELECT stale FROM system.query_cache;
SELECT sleep(3);
SELECT sleep(3);
SELECT stale FROM system.query_cache;
SELECT '---';
SELECT 1 SETTINGS use_query_cache = true, query_cache_ttl = 3;
SELECT COUNT(*) FROM system.query_cache;
SELECT stale FROM system.query_cache;
SYSTEM DROP QUERY CACHE;