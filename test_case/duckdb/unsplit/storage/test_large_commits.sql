PRAGMA wal_autocheckpoint='10KB';
CREATE TABLE test(i INTEGER);
INSERT INTO test SELECT * FROM range(100000) tbl(i);
DROP TABLE test;
