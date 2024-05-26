WITH ii(i) AS ( VALUES(1) UNION ALL SELECT i+1 FROM ii WHERE i<1000 )
  INSERT INTO t1 SELECT i, i FROM ii;
PRAGMA wal_checkpoint;
SELECT count(*) FROM t1;
PRAGMA wal_checkpoint;
PRAGMA wal_checkpoint;
PRAGMA wal_checkpoint;
CREATE TEMP TABLE z1(a, b);
INSERT INTO z1 SELECT * FROM t1;
PRAGMA wal_autocheckpoint = 10;
CREATE TABLE t2(x, y);
CREATE TABLE t3(x, y);
CREATE TABLE t4(x, y);
