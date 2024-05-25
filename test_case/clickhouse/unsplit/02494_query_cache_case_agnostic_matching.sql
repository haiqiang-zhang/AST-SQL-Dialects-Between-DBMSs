-- Tag no-parallel: Messes with internal cache

-- Start with empty query cache (QC)
SYSTEM DROP QUERY CACHE;
SELECT 1 SETTINGS use_query_cache = true;
SELECT COUNT(*) FROM system.query_cache;
SELECT '---';
select 1 SETTINGS use_query_cache = true;
SELECT COUNT(*) FROM system.query_cache;
SYSTEM FLUSH LOGS;
SYSTEM DROP QUERY CACHE;
