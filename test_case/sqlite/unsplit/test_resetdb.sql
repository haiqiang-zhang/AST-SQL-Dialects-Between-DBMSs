PRAGMA integrity_check;
PRAGMA journal_mode;
PRAGMA page_count;
PRAGMA quick_check;
PRAGMA page_count;
PRAGMA page_size;
PRAGMA quick_check;
PRAGMA journal_mode;
PRAGMA integrity_check;
PRAGMA journal_mode;
PRAGMA page_size;
PRAGMA page_count;
PRAGMA quick_check;
PRAGMA page_count;
PRAGMA page_size;
PRAGMA journal_mode;
PRAGMA quick_check;
PRAGMA page_count;
PRAGMA page_size;
PRAGMA journal_mode;
PRAGMA quick_check;
PRAGMA journal_mode = wal;
CREATE TABLE t1(a);
INSERT INTO t1 VALUES(1), (2), (3), (4);
SELECT * FROM t1;
SELECT * FROM sqlite_master;
PRAGMA integrity_check;
PRAGMA page_count;
PRAGMA integrity_check;
PRAGMA encoding = 'utf8';
PRAGMA encoding;
CREATE TEMP TABLE t2(x);
INSERT INTO t2 VALUES('hello world');
SELECT name FROM sqlite_schema;
SELECT * FROM t1;
SELECT * FROM t2;