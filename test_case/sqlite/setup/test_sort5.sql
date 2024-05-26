PRAGMA mmap_size = 10000000;
PRAGMA cache_size = 10;
CREATE TABLE t1(a, b);
BEGIN;
CREATE INDEX i1 ON t1(b);
PRAGMA temp_store = 1;
PRAGMA page_size = 4096;
