PRAGMA page_size = 512;
PRAGMA auto_vacuum = 0;
CREATE TABLE t1(a, b, c);
CREATE INDEX i1 ON t1(b, a, c);
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
PRAGMA page_size = 1024;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
PRAGMA page_size = 2048;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
PRAGMA page_size = 4096;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
PRAGMA page_size = 8192;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
PRAGMA page_size = 16384;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
PRAGMA page_size = 32768;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
PRAGMA page_size = 65536;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
PRAGMA page_size = 512;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
UPDATE t1 SET c = randomblob(100000);
PRAGMA page_size = 1024;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
UPDATE t1 SET c = randomblob(100000);
PRAGMA page_size = 2048;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
UPDATE t1 SET c = randomblob(100000);
PRAGMA page_size = 4096;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
UPDATE t1 SET c = randomblob(100000);
PRAGMA page_size = 8192;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
UPDATE t1 SET c = randomblob(100000);
PRAGMA page_size = 16384;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
UPDATE t1 SET c = randomblob(100000);
PRAGMA page_size = 32768;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
UPDATE t1 SET c = randomblob(100000);
PRAGMA page_size = 65536;
PRAGMA auto_vacuum = 0;
INSERT INTO t1(a, b) VALUES(1, 2), (3, 4), (5, 6);
DELETE FROM t1 WHERE a=3;
UPDATE t1 SET c = randomblob(100000);
