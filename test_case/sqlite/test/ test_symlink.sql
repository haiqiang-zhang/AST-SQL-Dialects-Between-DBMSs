ATTACH 'test.db2' AS aux1;
BEGIN;
PRAGMA journal_mode = wal;
SELECT * FROM t1;
DELETE FROM t1;
PRAGMA journal_mode = delete;
BEGIN;
PRAGMA journal_mode = wal;
SELECT * FROM t1;
DELETE FROM t1;
PRAGMA journal_mode = delete;
PRAGMA journal_mode = wal;
INSERT INTO t1 VALUES('hello', 'world');
CREATE TABLE xyz(x, y, z);
INSERT INTO xyz VALUES(1, 2, 3);
SELECT * FROM xyz;
SELECT * FROM xyz;
