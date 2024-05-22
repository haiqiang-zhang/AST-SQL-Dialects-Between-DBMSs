-- Tag no-parallel: Messes with internal cache

-- (it's silly to use what will be tested below but we have to assume other tests cluttered the query cache)
SYSTEM DROP QUERY CACHE;
SELECT 1 SETTINGS use_query_cache = true;
SELECT count(*) FROM system.query_cache;
SYSTEM DROP QUERY CACHE;
SELECT count(*) FROM system.query_cache;
