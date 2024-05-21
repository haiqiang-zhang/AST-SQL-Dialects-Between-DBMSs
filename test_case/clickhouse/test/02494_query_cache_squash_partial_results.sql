-- Tag no-parallel: Messes with internal cache

SYSTEM DROP QUERY CACHE;
DROP TABLE IF EXISTS t;
CREATE TABLE t(c String) ENGINE=MergeTree ORDER BY c;
SYSTEM STOP MERGES t;
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
INSERT INTO t values ('abc') ('def') ('ghi') ('jkl');
SELECT '-- insert with enabled squashing';
SELECT * FROM t ORDER BY c
SETTINGS max_block_size = 3, use_query_cache = true, query_cache_squash_partial_results = true;
SELECT '-- read from cache';
SELECT * FROM t ORDER BY c
SETTINGS max_block_size = 3, use_query_cache = true;
SYSTEM DROP QUERY CACHE;
SELECT '-- insert with disabled squashing';
SELECT * FROM t ORDER BY c
SETTINGS max_block_size = 3, use_query_cache = true, query_cache_squash_partial_results = false;
SELECT '-- read from cache';
SELECT * FROM t ORDER BY c
SETTINGS max_block_size = 3, use_query_cache = true;
DROP TABLE t;
SYSTEM DROP QUERY CACHE;