PRAGMA encoding=utf16le;
PRAGMA encoding;
CREATE TABLE t1(x,y);
INSERT INTO t1 VALUES('abc''123',5);
SELECT * FROM t1;
SELECT quote(x) || ' ' || quote(y) FROM t1;
DELETE FROM t1;
INSERT INTO t1 VALUES(x'616263646566',NULL);
SELECT * FROM t1;
SELECT quote(x) || ' ' || quote(y) FROM t1;
PRAGMA encoding;
CREATE TABLE t2(a);
INSERT INTO t2 VALUES(x'61006200630064006500');
SELECT CAST(a AS text) FROM t2 WHERE CAST(a AS text) LIKE 'abc%';
SELECT rowid FROM t2
       WHERE CAST(a AS text) LIKE CAST(x'610062002500' AS text);
ATTACH 'test.db' AS utf16;
SELECT 1 FROM utf16.sqlite_master LIMIT 1;
