CREATE TABLE t1(x, y);
CREATE TABLE t2(x, y);
CREATE INDEX i1y ON t1(y);
WITH cnt(i) AS (
      SELECT 1 UNION ALL SELECT i+1 FROM cnt WHERE i<20
    )
    INSERT INTO t1 SELECT i, randomblob(800) FROM cnt;
PRAGMA journal_mode = wal;
PRAGMA cache_size = 5;
PRAGMA integrity_check;
SELECT sum(length(y)) FROM t1;
SELECT sum(length(y)) FROM t1;
PRAGMA integrity_check;
PRAGMA wal_checkpoint;
WITH cnt(i) AS (SELECT 1 UNION ALL SELECT i+1 FROM cnt WHERE i<20)
        INSERT INTO t2 SELECT i, randomblob(800) FROM cnt;
SELECT sum(length(y)) FROM t1;
SELECT sum(length(y)) FROM t1;
PRAGMA integrity_check;
WITH cnt(i) AS (
      SELECT 1 UNION ALL SELECT i+1 FROM cnt WHERE i<20
    )
    INSERT INTO t1 SELECT i, randomblob(800) FROM cnt;
PRAGMA journal_mode = wal;
PRAGMA cache_size = 5;
UPDATE t1 SET y = randomblob(799) WHERE x=4;
PRAGMA integrity_check;
SELECT sum(length(y)) FROM t1;
SELECT sum(length(y)) FROM t1;
PRAGMA integrity_check;
PRAGMA wal_checkpoint;
WITH cnt(i) AS (SELECT 1 UNION ALL SELECT i+1 FROM cnt WHERE i<20)
        INSERT INTO t2 SELECT i, randomblob(800) FROM cnt;
SELECT sum(length(y)) FROM t1;
SELECT sum(length(y)) FROM t1;
PRAGMA integrity_check;
