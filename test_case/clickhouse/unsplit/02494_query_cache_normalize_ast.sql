
SYSTEM DROP QUERY CACHE;

SELECT 1 SETTINGS use_query_cache = true, query_cache_store_results_of_queries_with_nondeterministic_functions = true, max_threads = 16;
SELECT COUNT(*) FROM system.query_cache;
SELECT '---';
SELECT 1 SETTINGS use_query_cache = true, enable_writes_to_query_cache = false, max_threads = 16;
SYSTEM FLUSH LOGS;
SYSTEM DROP QUERY CACHE;
