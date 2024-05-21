-- Tag no-parallel: Messes with internal cache

-- Start with empty query cache (QC)
SYSTEM DROP QUERY CACHE;
-- Besides "use_query_cache", pass two more knobs (one QC-specific knob and one non-QC-specific knob). We just care
-- *that* they are passed and not about their effect.
SELECT 1 SETTINGS use_query_cache = true, query_cache_store_results_of_queries_with_nondeterministic_functions = true, max_threads = 16;
SELECT COUNT(*) FROM system.query_cache;
-- disabling active mode)
SELECT '---';
SELECT 1 SETTINGS use_query_cache = true, enable_writes_to_query_cache = false, max_threads = 16;
-- QC-related settings) such that the keys match regardless. Verify by checking that the second query caused a QC hit.
SYSTEM FLUSH LOGS;
SELECT ProfileEvents['QueryCacheHits'], ProfileEvents['QueryCacheMisses']
FROM system.query_log
WHERE type = 'QueryFinish'
  AND current_database = currentDatabase()
  AND query = 'SELECT 1 SETTINGS use_query_cache = true, enable_writes_to_query_cache = false, max_threads = 16;
';
SYSTEM DROP QUERY CACHE;