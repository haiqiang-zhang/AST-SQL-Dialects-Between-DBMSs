CREATE TABLE t1(x);
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
CREATE INDEX t1i1 ON t1(x);
CREATE TABLE t2 AS SELECT x AS a, x AS b FROM t1;
CREATE INDEX t2i1 ON t2(b);
PRAGMA integrity_check;
INSERT INTO t1 SELECT * FROM t1;
PRAGMA integrity_check;
DELETE FROM t1;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
VACUUM;
PRAGMA integrity_check;
