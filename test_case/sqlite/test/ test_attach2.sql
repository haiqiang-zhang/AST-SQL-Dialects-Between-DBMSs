ATTACH 'test2.db' AS t2;
PRAGMA database_list;
SELECT name FROM t2.sqlite_master;
SELECT name FROM t2.sqlite_master;
SELECT name FROM main.sqlite_master;
BEGIN;
INSERT INTO t1 VALUES(8,9);
SELECT * FROM t1;
INSERT INTO t2.t1 VALUES(1,2);
SELECT * FROM t1;
ATTACH 'test2.db' as file2;
PRAGMA lock_status;
PRAGMA lock_status;
BEGIN;
SELECT * FROM t1;
PRAGMA lock_status;
PRAGMA lock_status;
SELECT * FROM t1;
PRAGMA lock_status;
PRAGMA lock_status;
INSERT INTO t1 VALUES(1, 2);
PRAGMA lock_status;
PRAGMA lock_status;
BEGIN;
INSERT INTO file2.t1 VALUES(1, 2);
PRAGMA lock_status;
PRAGMA lock_status;
SELECT * FROM file2.t1;
PRAGMA lock_status;
PRAGMA lock_status;
UPDATE file2.t1 SET a=0;
PRAGMA lock_status;
PRAGMA lock_status;
INSERT INTO t1 VALUES(1, 2);
PRAGMA lock_status;
PRAGMA lock_status;
SELECT * FROM t1;
PRAGMA lock_status;
PRAGMA lock_status;
INSERT INTO t1 VALUES(1, 2);
PRAGMA lock_status;
PRAGMA lock_status;
PRAGMA lock_status;
PRAGMA lock_status;
PRAGMA lock_status;
PRAGMA lock_status;
PRAGMA lock_status;
PRAGMA lock_status;
SELECT * FROM file2.t1;
INSERT INTO t1 VALUES(1, 2);
SELECT * FROM t1;
ATTACH 'test.db2' AS aux;
BEGIN;
CREATE TABLE tbl(a, b, c);
BEGIN;
DROP TABLE aux.tbl;
DROP TABLE tbl;
BEGIN;
ATTACH 'test3.db' as aux2;
DETACH aux2;
DETACH aux;
PRAGMA encoding = 'utf16';
CREATE TABLE t2(x);
INSERT INTO t2 VALUES('text2');
PRAGMA encoding = 'utf16';
CREATE TABLE t3(x);
INSERT INTO t3 VALUES('text3');
PRAGMA encoding = 'utf8';
CREATE TABLE t4(x);
INSERT INTO t4 VALUES('text4');
PRAGMA encoding = 'utf16';
ATTACH 'test.db2' AS aux;
SELECT * FROM t2;
SELECT * FROM t4;
SELECT * FROM t3;
SELECT * FROM t2;
