CREATE TABLE t1(a, b);
INSERT INTO t1 VALUES(1, 2);
BEGIN;
INSERT INTO t1 VALUES(3, 4);
SELECT * FROM t1;
SELECT * FROM t1;
CREATE TABLE t2(a, b);
BEGIN;
INSERT INTO t1 VALUES(5, 6);
INSERT INTO t2 VALUES('a', 'b');
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t1;
SELECT * FROM t2;
CREATE TABLE t3(a, b);
BEGIN;
INSERT INTO t1 VALUES(7, 8);
INSERT INTO t2 VALUES('c', 'd');
INSERT INTO t3 VALUES('i', 'ii');
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
BEGIN;
INSERT INTO t1 VALUES(9, 10);
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;
ATTACH 'test.db2' AS aux;
CREATE TABLE aux.t4(x, y);
INSERT INTO t4 VALUES('A', 'B');
BEGIN;
INSERT INTO t1 VALUES(11, 12);
INSERT INTO t4 VALUES('C', 'D');
SELECT * FROM t1;
SELECT * FROM t4;
SELECT * FROM t1;
SELECT * FROM t4;
BEGIN;
INSERT INTO t1 VALUES(13, 14);
INSERT INTO t4 VALUES('E', 'F');
SELECT * FROM t1;
SELECT * FROM t4;
BEGIN;
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t4;
SELECT * FROM t1;
PRAGMA integrity_check;
PRAGMA integrity_check;
SELECT count(*) FROM t1;
