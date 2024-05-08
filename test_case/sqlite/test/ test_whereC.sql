CREATE TABLE t1(i INTEGER PRIMARY KEY, a, b INTEGER);
INSERT INTO t1 VALUES(1, 1, 1);
INSERT INTO t1 VALUES(2, 1, 1);
INSERT INTO t1 VALUES(3, 1, 2);
INSERT INTO t1 VALUES(4, 1, 2);
INSERT INTO t1 VALUES(5, 1, 2);
INSERT INTO t1 VALUES(6, 1, 3);
INSERT INTO t1 VALUES(7, 1, 3);
INSERT INTO t1 VALUES(8, 2, 1);
INSERT INTO t1 VALUES(9, 2, 1);
INSERT INTO t1 VALUES(10, 2, 2);
INSERT INTO t1 VALUES(11, 2, 2);
INSERT INTO t1 VALUES(12, 2, 2);
INSERT INTO t1 VALUES(13, 2, 3);
INSERT INTO t1 VALUES(14, 2, 3);
INSERT INTO t1 VALUES(15, 2, 1);
INSERT INTO t1 VALUES(16, 2, 1);
INSERT INTO t1 VALUES(17, 2, 2);
INSERT INTO t1 VALUES(18, 2, 2);
INSERT INTO t1 VALUES(19, 2, 2);
INSERT INTO t1 VALUES(20, 2, 3);
INSERT INTO t1 VALUES(21, 2, 3);
CREATE INDEX i1 ON t1(a, b);
SELECT i FROM t1 WHERE a=1 AND b=2 AND i>3;
SELECT i FROM t1 WHERE a=1 AND b=2 AND i>3 ORDER BY i ASC;
SELECT i FROM t1 WHERE a=1 AND b=2 AND i>3 ORDER BY i DESC;
SELECT i FROM t1 WHERE rowid='12';
SELECT i FROM t1 WHERE rowid='12' ORDER BY i ASC;
SELECT i FROM t1 WHERE rowid='12' ORDER BY i DESC;
SELECT i FROM t1 WHERE a=1 AND b='2';
SELECT i FROM t1 WHERE a=1 AND b='2' ORDER BY i ASC;
SELECT i FROM t1 WHERE a=1 AND b='2' ORDER BY i DESC;
SELECT i FROM t1 WHERE a=1 AND b='2' AND i>'3';
SELECT i FROM t1 WHERE a=1 AND b='2' AND i>'3' ORDER BY i ASC;
SELECT i FROM t1 WHERE a=1 AND b='2' AND i>'3' ORDER BY i DESC;
SELECT i FROM t1 WHERE a=1 AND b='2' AND i<5;
SELECT i FROM t1 WHERE a=1 AND b='2' AND i<5 ORDER BY i ASC;
SELECT i FROM t1 WHERE a=1 AND b='2' AND i<5 ORDER BY i DESC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i<12;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i<12 ORDER BY i ASC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i<12 ORDER BY i DESC;
SELECT i FROM t1 WHERE a IN(1, 2) AND b=2 AND i<11;
SELECT i FROM t1 WHERE a IN(1, 2) AND b=2 AND i<11 ORDER BY i ASC;
SELECT i FROM t1 WHERE a IN(1, 2) AND b=2 AND i<11 ORDER BY i DESC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i BETWEEN 10 AND 12;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i BETWEEN 10 AND 12 ORDER BY i ASC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i BETWEEN 10 AND 12 ORDER BY i DESC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i BETWEEN 11 AND 12;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i BETWEEN 11 AND 12 ORDER BY i ASC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i BETWEEN 11 AND 12 ORDER BY i DESC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i BETWEEN 10 AND 11;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i BETWEEN 10 AND 11 ORDER BY i ASC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i BETWEEN 10 AND 11 ORDER BY i DESC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i BETWEEN 12 AND 10;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i BETWEEN 12 AND 10 ORDER BY i ASC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i BETWEEN 12 AND 10 ORDER BY i DESC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i<NULL;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i<NULL ORDER BY i ASC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i<NULL ORDER BY i DESC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i>=NULL;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i>=NULL ORDER BY i ASC;
SELECT i FROM t1 WHERE a=2 AND b=2 AND i>=NULL ORDER BY i DESC;
SELECT i FROM t1 WHERE a=1 AND b='2' AND i<4.5;
SELECT i FROM t1 WHERE a=1 AND b='2' AND i<4.5 ORDER BY i ASC;
SELECT i FROM t1 WHERE a=1 AND b='2' AND i<4.5 ORDER BY i DESC;
SELECT i FROM t1 WHERE rowid IS '12';
SELECT i FROM t1 WHERE rowid IS '12' ORDER BY i ASC;
SELECT i FROM t1 WHERE rowid IS '12' ORDER BY i DESC;
