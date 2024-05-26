SET allow_experimental_analyzer = 1;
SET query_cache_system_table_handling = 'save';
SYSTEM DROP QUERY CACHE;
SELECT 1 + number from system.numbers LIMIT 1 SETTINGS use_query_cache = true;
SELECT count(*) FROM system.query_cache;
EXPLAIN PLAN SELECT 1 + number from system.numbers LIMIT 1;
EXPLAIN PLAN SELECT 1 + number from system.numbers LIMIT 1 SETTINGS use_query_cache = true;
EXPLAIN PIPELINE SELECT 1 + number from system.numbers LIMIT 1;
EXPLAIN PIPELINE SELECT 1 + number from system.numbers LIMIT 1 SETTINGS use_query_cache = true;
SYSTEM DROP QUERY CACHE;
