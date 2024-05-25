-- Tag no-parallel: Messes with internal cache

-- Tests per-user quotas of the query cache. Settings 'query_cache_max_size_in_bytes' and 'query_cache_max_entries' are actually supposed to
-- be used in a settings profile, together with a readonly constraint. For simplicity, test both settings stand-alone in a stateless test
-- instead of an integration test - the relevant logic will still be covered by that.

SYSTEM DROP QUERY CACHE;
SET query_cache_max_entries = 1;
SELECT 'a' SETTINGS use_query_cache = true;
SELECT 'b' SETTINGS use_query_cache = true;
SELECT count(*) FROM system.query_cache;
-- Run SELECTs again but w/o quota
SET query_cache_max_entries = DEFAULT;
SELECT 'c' SETTINGS use_query_cache = true;
SELECT 'd' SETTINGS use_query_cache = true;
SELECT count(*) FROM system.query_cache;
SYSTEM DROP QUERY CACHE;
SELECT '--';
SET query_cache_max_entries = 1;
SELECT 'a' SETTINGS use_query_cache = true;
SELECT 'b' SETTINGS use_query_cache = true;
SELECT count(*) FROM system.query_cache;
-- Run SELECTs again but w/o quota
SET query_cache_max_entries = DEFAULT;
SELECT 'c' SETTINGS use_query_cache = true;
SELECT 'd' SETTINGS use_query_cache = true;
SELECT count(*) FROM system.query_cache;
SYSTEM DROP QUERY CACHE;
