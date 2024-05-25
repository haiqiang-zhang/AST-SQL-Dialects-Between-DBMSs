-- Tag no-parallel: Messes with internal cache

-- Start with empty query cache (QC).
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
/* Run same query with passive mode again. There must still be one entry in the QC and we must have a QC hit. */

SELECT 1 SETTINGS use_query_cache = true, enable_writes_to_query_cache = false;
SELECT COUNT(*) FROM system.query_cache;
SYSTEM FLUSH LOGS;
SYSTEM DROP QUERY CACHE;
