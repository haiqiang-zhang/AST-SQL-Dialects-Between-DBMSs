CREATE TABLE t1(a, b, c);
INSERT INTO t1 VALUES(0, 0, 0);
INSERT INTO t1 VALUES(0, 1, 1);
INSERT INTO t1 VALUES(1, 0, 2);
INSERT INTO t1 VALUES(1, 1, 3);
CREATE INDEX i1 ON t1(a, b);
SELECT c FROM t1 WHERE (a, b) >= (1, 0);
SELECT c FROM t1 WHERE (a, b) > (1, 0);
CREATE TABLE t2(a INTEGER, b INTEGER, c INTEGER, d INTEGER);
CREATE INDEX i2 ON t2(a, b, c);
SELECT d FROM t2 WHERE (a, b) > (2, 2);
SELECT d FROM t2 WHERE (a, b) >= (2, 2);
SELECT d FROM t2 WHERE a=1 AND (b, c) >= (1, 2);
SELECT d FROM t2 WHERE a=1 AND (b, c) > (1, 2);
CREATE TABLE t3(a, b, c, w);
DROP INDEX IF EXISTS i3;
DROP INDEX IF EXISTS i3;
CREATE INDEX i3 ON t3(a, b, c);
DROP INDEX IF EXISTS i3;
CREATE INDEX i3 ON t3(a, b);
DROP INDEX IF EXISTS i3;
CREATE INDEX i3 ON t3(a);
CREATE TABLE t4(a, b, c);
INSERT INTO t4 VALUES(NULL, NULL, NULL);
INSERT INTO t4 VALUES(NULL, NULL, 0);
INSERT INTO t4 VALUES(NULL, NULL, 1);
INSERT INTO t4 VALUES(NULL,    0, NULL);
INSERT INTO t4 VALUES(NULL,    0, 0);
INSERT INTO t4 VALUES(NULL,    0, 1);
INSERT INTO t4 VALUES(NULL,    1, NULL);
INSERT INTO t4 VALUES(NULL,    1, 0);
INSERT INTO t4 VALUES(NULL,    1, 1);
INSERT INTO t4 VALUES(   0, NULL, NULL);
INSERT INTO t4 VALUES(   0, NULL, 0);
INSERT INTO t4 VALUES(   0, NULL, 1);
INSERT INTO t4 VALUES(   0,    0, NULL);
INSERT INTO t4 VALUES(   0,    0, 0);
INSERT INTO t4 VALUES(   0,    0, 1);
INSERT INTO t4 VALUES(   0,    1, NULL);
INSERT INTO t4 VALUES(   0,    1, 0);
INSERT INTO t4 VALUES(   0,    1, 1);
INSERT INTO t4 VALUES(   1, NULL, NULL);
INSERT INTO t4 VALUES(   1, NULL, 0);
INSERT INTO t4 VALUES(   1, NULL, 1);
INSERT INTO t4 VALUES(   1,    0, NULL);
INSERT INTO t4 VALUES(   1,    0, 0);
INSERT INTO t4 VALUES(   1,    0, 1);
INSERT INTO t4 VALUES(   1,    1, NULL);
INSERT INTO t4 VALUES(   1,    1, 0);
INSERT INTO t4 VALUES(   1,    1, 1);
DROP INDEX IF EXISTS i4;
SELECT rowid FROM t4 WHERE (a IS 0) AND (b IS 0) AND (c IS 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 0) AND (b == 0) AND (c == 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c < 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c <= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c > 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c >= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 1) AND (b IS 1) AND (c IS 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 1) AND (b == 1) AND (c == 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c < 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c <= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c > 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c >= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 0) AND (b IS 0) AND (c IS NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 0) AND (b == 0) AND (c == NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c < NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c <= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c > NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c >= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 0) AND (b IS NULL) AND (c IS 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 0) AND (b == NULL) AND (c == 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < NULL) OR (a == 0 AND b == NULL AND c < 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < NULL) OR (a == 0 AND b == NULL AND c <= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > NULL) OR (a == 0 AND b == NULL AND c > 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > NULL) OR (a == 0 AND b == NULL AND c >= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS NULL) AND (b IS 0) AND (c IS 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == NULL) AND (b == 0) AND (c == 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 0) OR (a == NULL AND b == 0 AND c < 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 0) OR (a == NULL AND b == 0 AND c <= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 0) OR (a == NULL AND b == 0 AND c > 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 0) OR (a == NULL AND b == 0 AND c >= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 1) AND (b IS 1) AND (c IS NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 1) AND (b == 1) AND (c == NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c < NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c <= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c > NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c >= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 1) AND (b IS NULL) AND (c IS 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 1) AND (b == NULL) AND (c == 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < NULL) OR (a == 1 AND b == NULL AND c < 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < NULL) OR (a == 1 AND b == NULL AND c <= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > NULL) OR (a == 1 AND b == NULL AND c > 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > NULL) OR (a == 1 AND b == NULL AND c >= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS NULL) AND (b IS 1) AND (c IS 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == NULL) AND (b == 1) AND (c == 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 1) OR (a == NULL AND b == 1 AND c < 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 1) OR (a == NULL AND b == 1 AND c <= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 1) OR (a == NULL AND b == 1 AND c > 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 1) OR (a == NULL AND b == 1 AND c >= 1) ORDER BY +rowid;
DROP INDEX IF EXISTS i4;
CREATE INDEX i4 ON t4(a, b, c);
SELECT rowid FROM t4 WHERE (a IS 0) AND (b IS 0) AND (c IS 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 0) AND (b == 0) AND (c == 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c < 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c <= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c > 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c >= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 1) AND (b IS 1) AND (c IS 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 1) AND (b == 1) AND (c == 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c < 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c <= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c > 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c >= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 0) AND (b IS 0) AND (c IS NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 0) AND (b == 0) AND (c == NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c < NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c <= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c > NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c >= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 0) AND (b IS NULL) AND (c IS 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 0) AND (b == NULL) AND (c == 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < NULL) OR (a == 0 AND b == NULL AND c < 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < NULL) OR (a == 0 AND b == NULL AND c <= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > NULL) OR (a == 0 AND b == NULL AND c > 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > NULL) OR (a == 0 AND b == NULL AND c >= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS NULL) AND (b IS 0) AND (c IS 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == NULL) AND (b == 0) AND (c == 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 0) OR (a == NULL AND b == 0 AND c < 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 0) OR (a == NULL AND b == 0 AND c <= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 0) OR (a == NULL AND b == 0 AND c > 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 0) OR (a == NULL AND b == 0 AND c >= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 1) AND (b IS 1) AND (c IS NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 1) AND (b == 1) AND (c == NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c < NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c <= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c > NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c >= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 1) AND (b IS NULL) AND (c IS 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 1) AND (b == NULL) AND (c == 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < NULL) OR (a == 1 AND b == NULL AND c < 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < NULL) OR (a == 1 AND b == NULL AND c <= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > NULL) OR (a == 1 AND b == NULL AND c > 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > NULL) OR (a == 1 AND b == NULL AND c >= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS NULL) AND (b IS 1) AND (c IS 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == NULL) AND (b == 1) AND (c == 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 1) OR (a == NULL AND b == 1 AND c < 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 1) OR (a == NULL AND b == 1 AND c <= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 1) OR (a == NULL AND b == 1 AND c > 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 1) OR (a == NULL AND b == 1 AND c >= 1) ORDER BY +rowid;
DROP INDEX IF EXISTS i4;
CREATE INDEX i4 ON t4(a, b);
SELECT rowid FROM t4 WHERE (a IS 0) AND (b IS 0) AND (c IS 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 0) AND (b == 0) AND (c == 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c < 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c <= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c > 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c >= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 1) AND (b IS 1) AND (c IS 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 1) AND (b == 1) AND (c == 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c < 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c <= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c > 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c >= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 0) AND (b IS 0) AND (c IS NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 0) AND (b == 0) AND (c == NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c < NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c <= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c > NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c >= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 0) AND (b IS NULL) AND (c IS 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 0) AND (b == NULL) AND (c == 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < NULL) OR (a == 0 AND b == NULL AND c < 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < NULL) OR (a == 0 AND b == NULL AND c <= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > NULL) OR (a == 0 AND b == NULL AND c > 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > NULL) OR (a == 0 AND b == NULL AND c >= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS NULL) AND (b IS 0) AND (c IS 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == NULL) AND (b == 0) AND (c == 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 0) OR (a == NULL AND b == 0 AND c < 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 0) OR (a == NULL AND b == 0 AND c <= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 0) OR (a == NULL AND b == 0 AND c > 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 0) OR (a == NULL AND b == 0 AND c >= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 1) AND (b IS 1) AND (c IS NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 1) AND (b == 1) AND (c == NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c < NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c <= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c > NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c >= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 1) AND (b IS NULL) AND (c IS 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 1) AND (b == NULL) AND (c == 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < NULL) OR (a == 1 AND b == NULL AND c < 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < NULL) OR (a == 1 AND b == NULL AND c <= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > NULL) OR (a == 1 AND b == NULL AND c > 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > NULL) OR (a == 1 AND b == NULL AND c >= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS NULL) AND (b IS 1) AND (c IS 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == NULL) AND (b == 1) AND (c == 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 1) OR (a == NULL AND b == 1 AND c < 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 1) OR (a == NULL AND b == 1 AND c <= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 1) OR (a == NULL AND b == 1 AND c > 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 1) OR (a == NULL AND b == 1 AND c >= 1) ORDER BY +rowid;
DROP INDEX IF EXISTS i4;
CREATE INDEX i4 ON t4(a);
SELECT rowid FROM t4 WHERE (a IS 0) AND (b IS 0) AND (c IS 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 0) AND (b == 0) AND (c == 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c < 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c <= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c > 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c >= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 1) AND (b IS 1) AND (c IS 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 1) AND (b == 1) AND (c == 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c < 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c <= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c > 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c >= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 0) AND (b IS 0) AND (c IS NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 0) AND (b == 0) AND (c == NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c < NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < 0) OR (a == 0 AND b == 0 AND c <= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c > NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > 0) OR (a == 0 AND b == 0 AND c >= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 0) AND (b IS NULL) AND (c IS 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 0) AND (b == NULL) AND (c == 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < NULL) OR (a == 0 AND b == NULL AND c < 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 0) OR (a == 0 AND b < NULL) OR (a == 0 AND b == NULL AND c <= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > NULL) OR (a == 0 AND b == NULL AND c > 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 0) OR (a == 0 AND b > NULL) OR (a == 0 AND b == NULL AND c >= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS NULL) AND (b IS 0) AND (c IS 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == NULL) AND (b == 0) AND (c == 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 0) OR (a == NULL AND b == 0 AND c < 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 0) OR (a == NULL AND b == 0 AND c <= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 0) OR (a == NULL AND b == 0 AND c > 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 0) OR (a == NULL AND b == 0 AND c >= 0) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 1) AND (b IS 1) AND (c IS NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 1) AND (b == 1) AND (c == NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c < NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < 1) OR (a == 1 AND b == 1 AND c <= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c > NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > 1) OR (a == 1 AND b == 1 AND c >= NULL) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS 1) AND (b IS NULL) AND (c IS 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == 1) AND (b == NULL) AND (c == 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < NULL) OR (a == 1 AND b == NULL AND c < 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < 1) OR (a == 1 AND b < NULL) OR (a == 1 AND b == NULL AND c <= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > NULL) OR (a == 1 AND b == NULL AND c > 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > 1) OR (a == 1 AND b > NULL) OR (a == 1 AND b == NULL AND c >= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a IS NULL) AND (b IS 1) AND (c IS 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a == NULL) AND (b == 1) AND (c == 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 1) OR (a == NULL AND b == 1 AND c < 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a < NULL) OR (a == NULL AND b < 1) OR (a == NULL AND b == 1 AND c <= 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 1) OR (a == NULL AND b == 1 AND c > 1) ORDER BY +rowid;
SELECT rowid FROM t4 WHERE (a > NULL) OR (a == NULL AND b > 1) OR (a == NULL AND b == 1 AND c >= 1) ORDER BY +rowid;
CREATE TABLE r1(a TEXT, iB TEXT);
CREATE TABLE r2(x TEXT, zY INTEGER);
CREATE INDEX r1ab ON r1(a, iB);
INSERT INTO r1 VALUES(35, 35);
INSERT INTO r2 VALUES(35, 36);
INSERT INTO r2 VALUES(35, 4);
INSERT INTO r2 VALUES(35, 35);
SELECT * FROM r1, r2 WHERE (x IS a) AND (+zY IS iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x == a) AND (+zY == iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x < a) OR (x == a AND +zY < iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x < a) OR (x == a AND +zY <= iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x > a) OR (x == a AND +zY > iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x > a) OR (x == a AND +zY >= iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x IS a) AND (zY IS iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x == a) AND (zY == iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x < a) OR (x == a AND zY < iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x < a) OR (x == a AND zY <= iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x > a) OR (x == a AND zY > iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x > a) OR (x == a AND zY >= iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x IS a) AND (zY IS +iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x == a) AND (zY == +iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x < a) OR (x == a AND zY < +iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x < a) OR (x == a AND zY <= +iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x > a) OR (x == a AND zY > +iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x > a) OR (x == a AND zY >= +iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (+x IS a) AND (zY IS iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (+x == a) AND (zY == iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (+x < a) OR (+x == a AND zY < iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (+x < a) OR (+x == a AND zY <= iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (+x > a) OR (+x == a AND zY > iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (+x > a) OR (+x == a AND zY >= iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x IS +a) AND (zY IS iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x == +a) AND (zY == iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x < +a) OR (x == +a AND zY < iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x < +a) OR (x == +a AND zY <= iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x > +a) OR (x == +a AND zY > iB) ORDER BY iB;
SELECT * FROM r1, r2 WHERE (x > +a) OR (x == +a AND zY >= iB) ORDER BY iB;
