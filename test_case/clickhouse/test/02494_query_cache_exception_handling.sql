-- Tag no-parallel: Messes with internal cache

SYSTEM DROP QUERY CACHE;
SELECT COUNT(*) FROM system.query_cache;
SYSTEM DROP QUERY CACHE;
