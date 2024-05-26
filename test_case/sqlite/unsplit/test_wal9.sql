PRAGMA page_size = 1024;
PRAGMA journal_mode = WAL;
PRAGMA wal_autocheckpoint = 0;
CREATE TABLE t(x);
SELECT * FROM t;
BEGIN;
INSERT INTO t VALUES('hello');
