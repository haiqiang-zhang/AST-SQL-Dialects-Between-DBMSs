ALTER TABLE p1 RENAME TO p2;
SELECT sql FROM sqlite_master WHERE name LIKE 'c%';
PRAGMA legacy_alter_table = 1;
ALTER TABLE p2 RENAME TO p3;
SELECT sql FROM sqlite_master WHERE name LIKE 'c%';
ALTER TABLE p3 RENAME TO p2;
PRAGMA foreign_keys = 1;
ALTER TABLE p2 RENAME TO p3;
SELECT sql FROM sqlite_master WHERE name LIKE 'c%';
CREATE TABLE log_entry(col1, y);
CREATE INDEX i1 ON log_entry(col1);
ALTER TABLE log_entry RENAME TO newname;
SELECT sql FROM sqlite_master;
CREATE TABLE log_entry(col1, y);
ALTER TABLE log_entry RENAME col1 TO newname;
SELECT sql FROM sqlite_master;
CREATE TABLE t1(a, b, c);
CREATE TABLE t2(x);
SELECT sql FROM sqlite_master;
SELECT sql FROM sqlite_master;
SELECT sql FROM sqlite_master;
SELECT sql FROM sqlite_master;
CREATE VIEW ttt AS
        WITH xyz(x) AS (SELECT col1 FROM log_entry)
        SELECT x FROM xyz;
SELECT sql FROM sqlite_master;
SELECT sql FROM sqlite_master;
ALTER TABLE t1 RENAME TO t1x;
SELECT sql FROM sqlite_master WHERE type = 'trigger';
SELECT sql FROM sqlite_master WHERE type = 'trigger';
SELECT sql FROM sqlite_master WHERE type = 'trigger';
INSERT INTO t2 VALUES(1);
ALTER TABLE t2 RENAME TO t2x;
SELECT sql FROM sqlite_master WHERE name = 'r2';
SELECT sql FROM sqlite_master WHERE name = 'r2';
INSERT INTO t2x VALUES(1);
CREATE TABLE t3(a,b,c,d);
SELECT rowid, * FROM t3;
ALTER TABLE t3 RENAME TO t3x;
SELECT sql FROM sqlite_master WHERE name = 'r3';
SELECT sql FROM sqlite_master WHERE name = 'r3';
CREATE TABLE t1(a,b,c,d,e,f);
INSERT INTO t1 VALUES(1,2,3,4,5,6);
CREATE TABLE t2(x,y,z);
SELECT a,b,c FROM t1 UNION SELECT d,e,f FROM t1 ORDER BY b,c;
INSERT INTO t1 VALUES(2,3,4,5,6,7);
SELECT * FROM t2;
ALTER TABLE t1 RENAME TO xyzzy;
SELECT sql FROM sqlite_master WHERE name='r1';
SELECT sql FROM sqlite_master WHERE name='r1';
CREATE TABLE t1(a, b, c);
CREATE TABLE t3(d, e, f);
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT a, b, c FROM v1;
INSERT INTO t3 VALUES(1, 2, 3);
INSERT INTO t3 VALUES(4, 5, 6);
CREATE TABLE t4(a, b);
CREATE VIEW v4 AS SELECT * FROM t4 WHERE (a=1 AND 0) OR b=2;
SELECT sql FROM sqlite_master WHERE name = 'v4';
CREATE TABLE t0(c0);
CREATE INDEX i0 ON t0(likelihood(1,2) AND 0);
SELECT sql FROM sqlite_master WHERE name='i0';
