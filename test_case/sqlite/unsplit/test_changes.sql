PRAGMA journal_mode = off;
CREATE TABLE t1(x INTEGER PRIMARY KEY);
INSERT INTO t1 VALUES(-1);
SELECT count(*) FROM t1;
DELETE FROM t1;
PRAGMA journal_mode = off;
INSERT INTO t1 VALUES(-1);
DELETE FROM t1;
PRAGMA journal_mode = off;
INSERT INTO t1 VALUES(-1);
DELETE FROM t1;
PRAGMA journal_mode = off;
INSERT INTO t1 VALUES(-1);
DELETE FROM t1;
PRAGMA journal_mode = off;
INSERT INTO t1 VALUES(-1);
DELETE FROM t1;
PRAGMA journal_mode = off;
INSERT INTO t1 VALUES(-1);
DELETE FROM t1;
