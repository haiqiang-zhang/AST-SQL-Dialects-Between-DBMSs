-- Tag no-parallel: Messes with internal cache

SYSTEM DROP QUERY CACHE;
DROP TABLE IF EXISTS t;
CREATE TABLE t(c String) ENGINE=MergeTree ORDER BY c;
INSERT INTO t SELECT multiIf(n = 0, 'abc', n = 1, 'def', n = 2, 'abc', n = 3, 'jkl', '<unused>') FROM (SELECT number % 4 AS n FROM numbers(1200));
OPTIMIZE TABLE t FINAL;
SELECT '-- insert with enabled compression';
SELECT * FROM t ORDER BY c
SETTINGS use_query_cache = true, query_cache_compress_entries = true;
SELECT '-- read from cache';
SELECT * FROM t ORDER BY c
SETTINGS use_query_cache = true;
SYSTEM DROP QUERY CACHE;
SELECT '-- insert with disabled compression';
SELECT * FROM t ORDER BY c
SETTINGS use_query_cache = true, query_cache_compress_entries = false;
SELECT '-- read from cache';
SELECT * FROM t ORDER BY c
SETTINGS use_query_cache = true;
DROP TABLE t;
SYSTEM DROP QUERY CACHE;
