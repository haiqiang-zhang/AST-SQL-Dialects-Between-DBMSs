CREATE TABLE t1(a INTEGER PRIMARY KEY, b TEXT, c DEFAULT 0);
CREATE UNIQUE INDEX t1x1 ON t1(b);
INSERT INTO t1(a,b) VALUES(1,2) ON CONFLICT DO NOTHING;
INSERT INTO t1(a,b) VALUES(1,99),(99,2) ON CONFLICT DO NOTHING;
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1(a,b) VALUES(2,3) ON CONFLICT(a) DO NOTHING;
INSERT INTO t1(a,b) VALUES(2,99) ON CONFLICT(a) DO NOTHING;
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1(a,b) VALUES(3,4) ON CONFLICT(b) DO NOTHING;
INSERT INTO t1(a,b) VALUES(99,4) ON CONFLICT(b) DO NOTHING;
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1(a,b) VALUES(5,6) ON CONFLICT(b COLLATE binary) DO NOTHING;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a INTEGER PRIMARY KEY, b INT, c DEFAULT 0);
CREATE UNIQUE INDEX t1x1 ON t1(a+b);
INSERT INTO t1(a,b) VALUES(7,8) ON CONFLICT(a+b) DO NOTHING;
INSERT INTO t1(a,b) VALUES(8,7),(9,6) ON CONFLICT(a+b) DO NOTHING;
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DROP INDEX t1x1;
DELETE FROM t1;
CREATE UNIQUE INDEX t1x1 ON t1(b) WHERE b>10;
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1(a,b) VALUES(1,2),(3,2),(4,20),(5,20)
         ON CONFLICT(b) WHERE b>10 DO NOTHING;
SELECT *, 'x' FROM t1 ORDER BY b, a;
DROP TABLE IF EXISTS t2;
CREATE TABLE t2(a TEXT UNIQUE, b INT DEFAULT 1);
INSERT INTO t2(a) VALUES('one'),('two'),('three');
PRAGMA count_changes=ON;
PRAGMA count_changes=OFF;
SELECT a, b FROM t2 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1(x INTEGER PRIMARY KEY, y INT UNIQUE);
INSERT INTO t1(x,y) SELECT 1,2 WHERE true
    ON CONFLICT(x) DO UPDATE SET y=max(t1.y,excluded.y) AND true;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(b UNIQUE, a INT PRIMARY KEY) WITHOUT ROWID;
INSERT OR IGNORE INTO t1(a) VALUES('1') ON CONFLICT(a) DO NOTHING;
PRAGMA integrity_check;
DELETE FROM t1;
INSERT OR IGNORE INTO t1(a) VALUES('1'),(1) ON CONFLICT(a) DO NOTHING;
PRAGMA integrity_check;
DROP TABLE t1;
CREATE TABLE t1(a INTEGER PRIMARY KEY, b INT, c INT, d INT, e INT);
CREATE UNIQUE INDEX t1b ON t1(b);
CREATE UNIQUE INDEX t1e ON t1(e);
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,3,4,5);
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,33,44,5)
    ON CONFLICT(e) DO UPDATE SET c=excluded.c;
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,3,4,5);
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,33,44,5)
    ON CONFLICT(a) DO UPDATE SET c=excluded.c;
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,3,4,5);
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,33,44,5)
    ON CONFLICT(b) DO UPDATE SET c=excluded.c;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a INT, b INT, c INT, d INT, e INT);
CREATE UNIQUE INDEX t1a ON t1(a);
CREATE UNIQUE INDEX t1b ON t1(b);
CREATE UNIQUE INDEX t1e ON t1(e);
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,3,4,5);
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,33,44,5)
    ON CONFLICT(e) DO UPDATE SET c=excluded.c;
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,3,4,5);
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,33,44,5)
    ON CONFLICT(a) DO UPDATE SET c=excluded.c;
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,3,4,5);
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,33,44,5)
    ON CONFLICT(b) DO UPDATE SET c=excluded.c;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a INT PRIMARY KEY, b INT, c INT, d INT, e INT) WITHOUT ROWID;
CREATE UNIQUE INDEX t1a ON t1(a);
CREATE UNIQUE INDEX t1b ON t1(b);
CREATE UNIQUE INDEX t1e ON t1(e);
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,3,4,5);
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,33,44,5)
    ON CONFLICT(e) DO UPDATE SET c=excluded.c;
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,3,4,5);
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,33,44,5)
    ON CONFLICT(a) DO UPDATE SET c=excluded.c;
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,3,4,5);
INSERT INTO t1(a,b,c,d,e) VALUES(1,2,33,44,5)
    ON CONFLICT(b) DO UPDATE SET c=excluded.c;
SELECT * FROM t1;
DROP TABLE IF EXISTS t0;
CREATE TABLE t0(c0 REAL UNIQUE, c1);
CREATE UNIQUE INDEX test800i0 ON t0(0 || c1);
INSERT INTO t0(c0, c1) VALUES (1, 2),  (2, 1);
INSERT INTO t0(c0) VALUES (1) ON CONFLICT(c0) DO UPDATE SET c1=excluded.c0;
PRAGMA integrity_check;
REINDEX;
SELECT * FROM t1;
CREATE UNIQUE INDEX t1x ON t1(b+3);