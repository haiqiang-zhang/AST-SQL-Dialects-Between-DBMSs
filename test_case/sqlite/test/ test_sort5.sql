PRAGMA mmap_size = 10000000;
PRAGMA cache_size = 10;
CREATE TABLE t1(a, b);
BEGIN;
CREATE INDEX i1 ON t1(b);
PRAGMA temp_store = 1;
PRAGMA page_size = 4096;
VACUUM;
PRAGMA cache_size = 1000;
WITH x(i, j) AS (
        SELECT 1, randomblob(100)
        UNION ALL
        SELECT i+1, randomblob(100) FROM x WHERE i<10000
      )
      SELECT * FROM x ORDER BY j;
PRAGMA page_size = 1024;
VACUUM;
PRAGMA cache_size = 1000;
WITH x(i, j) AS (
        SELECT 1, randomblob(100)
        UNION ALL
        SELECT i+1, randomblob(100) FROM x WHERE i<10000
      )
      SELECT * FROM x ORDER BY j;
PRAGMA page_size = 4096;
VACUUM;
PRAGMA cache_size = -1000;
WITH x(i, j) AS (
        SELECT 1, randomblob(100)
        UNION ALL
        SELECT i+1, randomblob(100) FROM x WHERE i<10000
      )
      SELECT * FROM x ORDER BY j;
PRAGMA page_size = 1024;
VACUUM;
PRAGMA cache_size = -1000;
WITH x(i, j) AS (
        SELECT 1, randomblob(100)
        UNION ALL
        SELECT i+1, randomblob(100) FROM x WHERE i<10000
      )
      SELECT * FROM x ORDER BY j;
PRAGMA page_size = 4096;
VACUUM;
PRAGMA cache_size = -9000;
WITH x(i, j) AS (
        SELECT 1, randomblob(100)
        UNION ALL
        SELECT i+1, randomblob(100) FROM x WHERE i<10000
      )
      SELECT * FROM x ORDER BY j;
PRAGMA page_size = 1024;
VACUUM;
PRAGMA cache_size = -9000;
WITH x(i, j) AS (
        SELECT 1, randomblob(100)
        UNION ALL
        SELECT i+1, randomblob(100) FROM x WHERE i<10000
      )
      SELECT * FROM x ORDER BY j;
