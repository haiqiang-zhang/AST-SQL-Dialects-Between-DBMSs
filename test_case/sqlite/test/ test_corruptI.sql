PRAGMA page_size=1024;
PRAGMA auto_vacuum=0;
CREATE TABLE t1(a);
CREATE INDEX i1 ON t1(a);
INSERT INTO t1 VALUES('abcdefghijklmnop');
SELECT * FROM t1 WHERE a = 10;
SELECT * FROM t1 WHERE a = 10;
CREATE TABLE r(x);
INSERT INTO r VALUES('ABCDEFGHIJK');
CREATE INDEX r1 ON r(x);
SELECT * FROM r WHERE x >= 10.0;
SELECT * FROM r WHERE x >= 10;
PRAGMA auto_vacuum=0;
PRAGMA page_size = 512;
PRAGMA page_size = 65536;
PRAGMA autovacuum = 0;
DELETE FROM t1 WHERE a=0;
PRAGMA page_size = 512;
PRAGMA auto_vacuum = 2;
CREATE TABLE t3(x);
CREATE TABLE t4(x);
CREATE TABLE t5(x);
CREATE TABLE t6(x);
CREATE TABLE t7(x);
CREATE TABLE t8(x);
CREATE TABLE t9(x);
CREATE TABLE t10(x);
CREATE TABLE t11(x);
CREATE TABLE t12(x);
CREATE TABLE t13(x);
CREATE TABLE t100(x);
DROP TABLE t100;
PRAGMA page_count;
CREATE TABLE tx(x);
PRAGMA page_size = 512;
PRAGMA auto_vacuum=0;
INSERT INTO t1 VALUES(zeroblob(300));
INSERT INTO t1 VALUES(zeroblob(600));
DELETE FROM t1 WHERE rowid=2;
PRAGMA auto_vacuum=0;
SELECT name FROM sqlite_master;
PRAGMA writable_schema = 1;
DELETE FROM sqlite_master WHERE name = 'sqlite_autoindex_t1_1';
PRAGMA auto_vacuum=0;
INSERT INTO t1 VALUES(zeroblob(300));
INSERT INTO t1 VALUES(zeroblob(300));
INSERT INTO t1 VALUES(zeroblob(300));
INSERT INTO t1 VALUES(zeroblob(300));
DELETE FROM t1;
PRAGMA integrity_check;
