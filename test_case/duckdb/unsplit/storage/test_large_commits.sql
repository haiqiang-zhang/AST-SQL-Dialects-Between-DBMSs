PRAGMA force_compression='${compression}';
PRAGMA wal_autocheckpoint='10KB';
CREATE TABLE test(i INTEGER);;
INSERT INTO test SELECT * FROM range(100000) tbl(i);
DROP TABLE test;
SELECT MIN(i), MAX(i), COUNT(*) FROM test;
SELECT MIN(i), MAX(i), COUNT(*) FROM test;
