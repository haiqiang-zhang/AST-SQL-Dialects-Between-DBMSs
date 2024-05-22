-- Tag no-parallel: Messes with internal cache

SYSTEM DROP QUERY CACHE;
SELECT '-- Run a query with query cache not enabled';
SELECT 124437993;
SYSTEM FLUSH LOGS;
SELECT '-- Run a query with query cache enabled';
SELECT 124437994 SETTINGS use_query_cache = 1;
SYSTEM FLUSH LOGS;
SELECT '-- Run the same query with query cache enabled';
SELECT 124437994 SETTINGS use_query_cache = 1;
SYSTEM FLUSH LOGS;
SELECT '-- Throw exception with query cache enabled';
SYSTEM FLUSH LOGS;
SYSTEM DROP QUERY CACHE;
