PRAGMA integrity_check;
BEGIN;
CREATE TABLE t1(x);
INSERT INTO t1 VALUES('a');
CREATE INDEX i1 ON t1(x);
PRAGMA integrity_check;
BEGIN;
DROP TABLE t1;
CREATE TABLE t1(x);
CREATE INDEX i1 ON t1(x);
PRAGMA integrity_check;
BEGIN;
CREATE TABLE t2(x);
INSERT INTO t2 VALUES(14);
INSERT INTO t2 VALUES(35);
INSERT INTO t2 VALUES(15);
INSERT INTO t2 VALUES(35);
INSERT INTO t2 VALUES(16);