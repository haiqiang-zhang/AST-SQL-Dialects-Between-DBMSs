CREATE TABLE t1(a, b);
CREATE INDEX i1 ON t1(a);
DELETE FROM t1;
DELETE FROM t1 INDEXED BY i1;
DELETE FROM t1 NOT INDEXED;
DELETE FROM main.t1;
DELETE FROM main.t1 INDEXED BY i1;
DELETE FROM main.t1 NOT INDEXED;
DELETE FROM t1 WHERE a>2;
DELETE FROM t1 INDEXED BY i1 WHERE a>2;
DELETE FROM t1 NOT INDEXED WHERE a>2;
DELETE FROM main.t1 WHERE a>2;
DELETE FROM main.t1 INDEXED BY i1 WHERE a>2;
DELETE FROM main.t1 NOT INDEXED WHERE a>2;
PRAGMA foreign_keys = OFF;
DROP table "t1";
CREATE TABLE t1(x, y);
INSERT INTO t1 VALUES(1, 'one');
INSERT INTO t1 VALUES(2, 'two');
INSERT INTO t1 VALUES(3, 'three');
INSERT INTO t1 VALUES(4, 'four');
INSERT INTO t1 VALUES(5, 'five');
CREATE TABLE t2(x, y);
INSERT INTO t2 VALUES(1, 'one');
INSERT INTO t2 VALUES(2, 'two');
INSERT INTO t2 VALUES(3, 'three');
INSERT INTO t2 VALUES(4, 'four');
INSERT INTO t2 VALUES(5, 'five');
CREATE TABLE t3(x, y);
INSERT INTO t3 VALUES(1, 'one');
INSERT INTO t3 VALUES(2, 'two');
INSERT INTO t3 VALUES(3, 'three');
INSERT INTO t3 VALUES(4, 'four');
INSERT INTO t3 VALUES(5, 'five');
CREATE TABLE t4(x, y);
INSERT INTO t4 VALUES(1, 'one');
INSERT INTO t4 VALUES(2, 'two');
INSERT INTO t4 VALUES(3, 'three');
INSERT INTO t4 VALUES(4, 'four');
INSERT INTO t4 VALUES(5, 'five');
CREATE TABLE t5(x, y);
INSERT INTO t5 VALUES(1, 'one');
INSERT INTO t5 VALUES(2, 'two');
INSERT INTO t5 VALUES(3, 'three');
INSERT INTO t5 VALUES(4, 'four');
INSERT INTO t5 VALUES(5, 'five');
CREATE TABLE t6(x, y);
INSERT INTO t6 VALUES(1, 'one');
INSERT INTO t6 VALUES(2, 'two');
INSERT INTO t6 VALUES(3, 'three');
INSERT INTO t6 VALUES(4, 'four');
INSERT INTO t6 VALUES(5, 'five');
DELETE FROM t1;