SELECT a,b,c FROM t1 ORDER BY a;
INSERT INTO t1(a,b,c) VALUES(3,2,5);
SELECT a,b,c FROM t1 ORDER BY a;
SELECT a,b,c FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1(
    a INT PRIMARY KEY ON CONFLICT REPLACE, 
    b UNIQUE ON CONFLICT IGNORE,
    c UNIQUE ON CONFLICT FAIL
  );
INSERT INTO t1(a,b,c) VALUES(1,2,3), (2,3,4);
SELECT a,b,c FROM t1 ORDER BY a;
INSERT INTO t1(a,b,c) VALUES(3,2,5);
SELECT a,b,c FROM t1 ORDER BY a;
SELECT a,b,c FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1(
    a INT PRIMARY KEY ON CONFLICT REPLACE, 
    b UNIQUE ON CONFLICT IGNORE,
    c UNIQUE ON CONFLICT FAIL
  ) WITHOUT ROWID;
INSERT INTO t1(a,b,c) VALUES(1,2,3), (2,3,4);
SELECT a,b,c FROM t1 ORDER BY a;
INSERT INTO t1(a,b,c) VALUES(3,2,5);
SELECT a,b,c FROM t1 ORDER BY a;
SELECT a,b,c FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1(
    b UNIQUE ON CONFLICT IGNORE,
    c UNIQUE ON CONFLICT FAIL,
    a INT PRIMARY KEY ON CONFLICT REPLACE
  ) WITHOUT ROWID;
INSERT INTO t1(a,b,c) VALUES(1,2,3), (2,3,4);
SELECT a,b,c FROM t1 ORDER BY a;
INSERT INTO t1(a,b,c) VALUES(3,2,5);
SELECT a,b,c FROM t1 ORDER BY a;
SELECT a,b,c FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1(
    b UNIQUE ON CONFLICT IGNORE,
    a INT PRIMARY KEY ON CONFLICT REPLACE,
    c UNIQUE ON CONFLICT FAIL
  );
INSERT INTO t1(a,b,c) VALUES(1,2,3), (2,3,4);
SELECT a,b,c FROM t1 ORDER BY a;
INSERT INTO t1(a,b,c) VALUES(3,2,5);
SELECT a,b,c FROM t1 ORDER BY a;
SELECT a,b,c FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1(
    c UNIQUE ON CONFLICT FAIL,
    a INT PRIMARY KEY ON CONFLICT REPLACE,
    b UNIQUE ON CONFLICT IGNORE
  );
INSERT INTO t1(a,b,c) VALUES(1,2,3), (2,3,4);
SELECT a,b,c FROM t1 ORDER BY a;
INSERT INTO t1(a,b,c) VALUES(3,2,5);
SELECT a,b,c FROM t1 ORDER BY a;
SELECT a,b,c FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1(
    a UNIQUE ON CONFLICT REPLACE, 
    b INTEGER PRIMARY KEY ON CONFLICT IGNORE,
    c UNIQUE ON CONFLICT FAIL
  );
INSERT INTO t1(a,b,c) VALUES(1,2,3), (2,3,4);
SELECT a,b,c FROM t1 ORDER BY a;
INSERT INTO t1(a,b,c) VALUES(3,2,5);
SELECT a,b,c FROM t1 ORDER BY a;
SELECT a,b,c FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1(
    a UNIQUE ON CONFLICT REPLACE, 
    b INT PRIMARY KEY ON CONFLICT IGNORE,
    c UNIQUE ON CONFLICT FAIL
  );
INSERT INTO t1(a,b,c) VALUES(1,2,3), (2,3,4);
SELECT a,b,c FROM t1 ORDER BY a;
INSERT INTO t1(a,b,c) VALUES(3,2,5);
SELECT a,b,c FROM t1 ORDER BY a;
SELECT a,b,c FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1(
    a UNIQUE ON CONFLICT REPLACE, 
    b INT PRIMARY KEY ON CONFLICT IGNORE,
    c UNIQUE ON CONFLICT FAIL
  ) WITHOUT ROWID;
INSERT INTO t1(a,b,c) VALUES(1,2,3), (2,3,4);
SELECT a,b,c FROM t1 ORDER BY a;
INSERT INTO t1(a,b,c) VALUES(3,2,5);
SELECT a,b,c FROM t1 ORDER BY a;
SELECT a,b,c FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1(
    a UNIQUE ON CONFLICT REPLACE, 
    b UNIQUE ON CONFLICT IGNORE,
    c INTEGER PRIMARY KEY ON CONFLICT FAIL
  );
INSERT INTO t1(a,b,c) VALUES(1,2,3), (2,3,4);
SELECT a,b,c FROM t1 ORDER BY a;
INSERT INTO t1(a,b,c) VALUES(3,2,5);
SELECT a,b,c FROM t1 ORDER BY a;
SELECT a,b,c FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1(
    a UNIQUE ON CONFLICT REPLACE, 
    b UNIQUE ON CONFLICT IGNORE,
    c PRIMARY KEY ON CONFLICT FAIL
  ) WITHOUT ROWID;
INSERT INTO t1(a,b,c) VALUES(1,2,3), (2,3,4);
SELECT a,b,c FROM t1 ORDER BY a;
INSERT INTO t1(a,b,c) VALUES(3,2,5);
SELECT a,b,c FROM t1 ORDER BY a;
SELECT a,b,c FROM t1 ORDER BY a;
CREATE TABLE t2(a INTEGER PRIMARY KEY, b TEXT);
INSERT INTO t2 VALUES(111, '111');
REPLACE INTO t2 VALUES(NULL, '112'), (111, '111B');
SELECT * FROM t2;
PRAGMA recursive_triggers = true;
CREATE TABLE t0 (c0 UNIQUE, c1 UNIQUE);
INSERT INTO t0 VALUES(1, NULL);
INSERT INTO t0 VALUES(0, NULL);
UPDATE OR REPLACE t0 SET c1 = 1;
PRAGMA integrity_check;
SELECT * FROM t0;
PRAGMA integrity_check;
SELECT * FROM t2;
CREATE TABLE log(x);
CREATE INDEX i1 ON t1(a);
UPDATE t1 SET b=3;
SELECT * FROM t1;
SELECT * FROM log;
