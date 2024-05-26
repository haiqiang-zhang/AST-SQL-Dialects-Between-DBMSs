PRAGMA recursive_triggers = on;
CREATE TABLE t1(a, b, c);
CREATE TABLE log(t, a1, b1, c1, a2, b2, c2);
INSERT INTO t1 VALUES('A', 'B', 'C');
SELECT * FROM log;
SELECT * FROM t1;
DELETE FROM log;
UPDATE t1 SET a = 'a';
SELECT * FROM log;
SELECT * FROM t1;
DELETE FROM log;
DELETE FROM t1;
SELECT * FROM log;
SELECT * FROM t1;
CREATE TABLE t4(a, b);
INSERT INTO t4 VALUES(1, 2);
DELETE FROM t4;
SELECT * FROM t4;
CREATE TABLE t5 (a primary key, b, c);
INSERT INTO t5 values (1, 2, 3);
UPDATE OR REPLACE t5 SET a = 4 WHERE a = 1;
CREATE TABLE t6(a INTEGER PRIMARY KEY, b);
INSERT INTO t6 VALUES(1, 2);
UPDATE t6 SET a=a;
DROP TABLE t1;
CREATE TABLE cnt(n);
INSERT INTO cnt VALUES(0);
CREATE TABLE t1(a INTEGER PRIMARY KEY, b UNIQUE, c, d, e);
CREATE INDEX t1cd ON t1(c,d);
INSERT INTO t1 VALUES(1,2,3,4,5);
INSERT INTO t1 VALUES(6,7,8,9,10);
INSERT INTO t1 VALUES(11,12,13,14,15);
CREATE TABLE t2(a PRIMARY KEY);
DELETE FROM t2;
INSERT INTO t2 VALUES(10);
SELECT * FROM t2 ORDER BY rowid;
DELETE FROM t2;
INSERT INTO t2 VALUES(10);
SELECT * FROM t2 ORDER BY rowid;
DELETE FROM t2;
INSERT INTO t2 VALUES(10);
SELECT * FROM t2 ORDER BY rowid;
DELETE FROM t2;
INSERT INTO t2 VALUES(10);
SELECT * FROM t2 ORDER BY rowid;
DELETE FROM t2;
INSERT INTO t2 VALUES(10);
SELECT * FROM t2 ORDER BY rowid;
DELETE FROM t2;
INSERT INTO t2 VALUES(10);
SELECT * FROM t2 ORDER BY rowid;
DELETE FROM t2;
INSERT INTO t2 VALUES(10);
SELECT * FROM t2 ORDER BY rowid;
CREATE TABLE t22(x);
INSERT INTO t22 VALUES(1);
SELECT count(*) FROM t22;
CREATE TABLE t23(x PRIMARY KEY);
INSERT INTO t23 VALUES(1);
CREATE TABLE t3(a, b);
INSERT INTO t3 VALUES(0,0);
SELECT * FROM t3;
CREATE TABLE t3b(x);
INSERT INTO t3b VALUES(1);
INSERT INTO t3b VALUES(1001);
DELETE FROM t3b;
INSERT INTO t3b VALUES(999);
INSERT INTO t3b VALUES(1901);
DELETE FROM t3b;
INSERT INTO t3b VALUES(1900);
INSERT INTO t3b VALUES(2000);
DELETE FROM t3b;
INSERT INTO t3b VALUES(1999);
DROP TABLE log;
DROP TABLE t4;
CREATE TABLE log(t);
CREATE TABLE t4(a TEXT,b INTEGER,c REAL);
DELETE FROM log;
INSERT INTO t4 VALUES('1', '1', '1');
DELETE FROM t4;
SELECT * FROM log ORDER BY rowid;
DELETE FROM log;
INSERT INTO t4(rowid,a,b,c) VALUES(45, 45, 45, 45);
DELETE FROM t4;
SELECT * FROM log ORDER BY rowid;
DELETE FROM log;
INSERT INTO t4(rowid,a,b,c) VALUES(-42.0, -42.0, -42.0, -42.0);
DELETE FROM t4;
SELECT * FROM log ORDER BY rowid;
DELETE FROM log;
INSERT INTO t4(rowid,a,b,c) VALUES(NULL, -42.4, -42.4, -42.4);
DELETE FROM t4;
SELECT * FROM log ORDER BY rowid;
DELETE FROM log;
INSERT INTO t4 VALUES(7, 7, 7);
UPDATE t4 SET a=8, b=8, c=8;
SELECT * FROM log ORDER BY rowid;
DELETE FROM log;
UPDATE t4 SET rowid=2;
SELECT * FROM log ORDER BY rowid;
DELETE FROM log;
UPDATE t4 SET a='9', b='9', c='9';
SELECT * FROM log ORDER BY rowid;
DELETE FROM log;
UPDATE t4 SET a='9.1', b='9.1', c='9.1';
SELECT * FROM log ORDER BY rowid;
DROP TABLE IF EXISTS t5;
CREATE TABLE t5(a INTEGER PRIMARY KEY, b);
CREATE UNIQUE INDEX t5i ON t5(b);
INSERT INTO t5 VALUES(1, 'a');
INSERT INTO t5 VALUES(2, 'b');
INSERT INTO t5 VALUES(3, 'c');
CREATE TABLE t5g(a, b, c);
BEGIN;
DELETE FROM t5 WHERE a=2;
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
INSERT OR REPLACE INTO t5 VALUES(2, 'd');
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
UPDATE OR REPLACE t5 SET a = 2 WHERE a = 3;
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
INSERT OR REPLACE INTO t5 VALUES(4, 'b');
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
UPDATE OR REPLACE t5 SET b = 'b' WHERE b = 'c';
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
INSERT OR REPLACE INTO t5 VALUES(2, 'c');
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
UPDATE OR REPLACE t5 SET a=1, b='b' WHERE a = 3;
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
DELETE FROM t5 WHERE a=2;
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
INSERT OR REPLACE INTO t5 VALUES(2, 'd');
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
UPDATE OR REPLACE t5 SET a = 2 WHERE a = 3;
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
INSERT OR REPLACE INTO t5 VALUES(4, 'b');
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
UPDATE OR REPLACE t5 SET b = 'b' WHERE b = 'c';
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
INSERT OR REPLACE INTO t5 VALUES(2, 'c');
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
UPDATE OR REPLACE t5 SET a=1, b='b' WHERE a = 3;
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
PRAGMA recursive_triggers = off;
BEGIN;
DELETE FROM t5 WHERE a=2;
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
INSERT OR REPLACE INTO t5 VALUES(2, 'd');
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
UPDATE OR REPLACE t5 SET a = 2 WHERE a = 3;
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
INSERT OR REPLACE INTO t5 VALUES(4, 'b');
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
UPDATE OR REPLACE t5 SET b = 'b' WHERE b = 'c';
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
INSERT OR REPLACE INTO t5 VALUES(2, 'c');
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
BEGIN;
UPDATE OR REPLACE t5 SET a=1, b='b' WHERE a = 3;
SELECT * FROM t5g ORDER BY rowid;
SELECT * FROM t5 ORDER BY rowid;
PRAGMA recursive_triggers = on;
PRAGMA recursive_triggers;
PRAGMA recursive_triggers = off;
PRAGMA recursive_triggers;
PRAGMA recursive_triggers = on;
PRAGMA recursive_triggers;
CREATE TABLE t8(x);
CREATE TABLE t7(a, b);
INSERT INTO t7 VALUES(1, 2);
INSERT INTO t7 VALUES(3, 4);
INSERT INTO t7 VALUES(5, 6);
BEGIN;
UPDATE t7 SET b=7 WHERE a = 5;
SELECT * FROM t7;
SELECT * FROM t8;
BEGIN;
UPDATE t7 SET b=7 WHERE a = 1;
SELECT * FROM t7;
SELECT * FROM t8;
BEGIN;
UPDATE t7 SET b=7 WHERE a = 5;
SELECT rowid, * FROM t7;
SELECT * FROM t8;
BEGIN;
UPDATE t7 SET b=7 WHERE a = 1;
SELECT rowid, * FROM t7;
SELECT * FROM t8;
BEGIN;
DELETE FROM t7 WHERE a = 3;
SELECT rowid, * FROM t7;
SELECT * FROM t8;
BEGIN;
DELETE FROM t7 WHERE a = 1;
SELECT rowid, * FROM t7;
SELECT * FROM t8;
CREATE TABLE t9(a,b);
CREATE INDEX t9b ON t9(b);
INSERT INTO t9 VALUES(1,0);
INSERT INTO t9 VALUES(2,1);
INSERT INTO t9 VALUES(3,2);
INSERT INTO t9 SELECT a+3, a+2 FROM t9;
INSERT INTO t9 SELECT a+6, a+5 FROM t9;
SELECT a FROM t9 ORDER BY a;
DELETE FROM t9 WHERE b=4;
SELECT a FROM t9 ORDER BY a;
CREATE TABLE t10(a, updatecnt DEFAULT 0);
INSERT INTO t10(a) VALUES('hello');
UPDATE t10 SET a = 'world';
SELECT * FROM t10;
UPDATE t10 SET a = 'tcl', updatecnt = 5;
SELECT * FROM t10;
CREATE TABLE t11(
      c1,   c2,  c3,  c4,  c5,  c6,  c7,  c8,  c9, c10,
      c11, c12, c13, c14, c15, c16, c17, c18, c19, c20,
      c21, c22, c23, c24, c25, c26, c27, c28, c29, c30,
      c31, c32, c33, c34, c35, c36, c37, c38, c39, c40
    );
INSERT INTO t11 VALUES(
      1,   2,  3,  4,  5,  6,  7,  8,  9, 10,
      11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
      21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
      31, 32, 33, 34, 35, 36, 37, 38, 39, 40
    );
UPDATE t11 SET c4=35, c33=22, c1=5;
SELECT * FROM t11;
DROP TABLE log;
CREATE TABLE log(a, b);
DROP TABLE t1;
DELETE FROM log;
CREATE TABLE t1(a, b);
INSERT INTO t1 DEFAULT VALUES;
SELECT * FROM log;
DELETE FROM log;
INSERT INTO t1 DEFAULT VALUES;
SELECT * FROM log;
DELETE FROM log;
INSERT INTO t1 DEFAULT VALUES;
SELECT * FROM log;
DROP TABLE t1;
DELETE FROM log;
CREATE TABLE t1(a DEFAULT 1, b DEFAULT 'abc');
INSERT INTO t1 DEFAULT VALUES;
SELECT * FROM log;
DELETE FROM log;
INSERT INTO t1 DEFAULT VALUES;
SELECT * FROM log;
DELETE FROM log;
INSERT INTO t1 DEFAULT VALUES;
SELECT * FROM log;
DROP TABLE t1;
DELETE FROM log;
CREATE TABLE t1(a, b DEFAULT 4.5);
INSERT INTO t1 DEFAULT VALUES;
SELECT * FROM log;
DELETE FROM log;
INSERT INTO t1 DEFAULT VALUES;
SELECT * FROM log;
DELETE FROM log;
INSERT INTO t1 DEFAULT VALUES;
SELECT * FROM log;
DROP TABLE t2;
DELETE FROM log;
CREATE TABLE t2(a, b);
CREATE VIEW v2 AS SELECT * FROM t2;
SELECT a, b, a IS NULL, b IS NULL FROM log;
INSERT INTO t1 VALUES(1, 2);
INSERT INTO t1 VALUES(3, 4);
INSERT INTO t1 VALUES(5, 6);
PRAGMA recursive_triggers = ON;
CREATE TABLE t12(a, b);
INSERT INTO t12 VALUES(1, 2);
UPDATE t12 SET a=a+1, b=b+1;
INSERT INTO t2 VALUES(1234567, 3);
CREATE TABLE empty(x);
CREATE TABLE not_empty(x);
INSERT INTO not_empty VALUES(2);
SELECT * FROM t5;
INSERT INTO t2 VALUES(1234567, 3);
INSERT INTO not_empty VALUES(2);
SELECT * FROM t5;
PRAGMA recursive_triggers = 1;
CREATE TABLE node(
      id int not null primary key, 
      pid int not null default 0 references node,
      key varchar not null, 
      path varchar default '',
      unique(pid, key)
      );
INSERT INTO node(id, pid, key) VALUES(9, 0, 'test');
INSERT INTO node(id, pid, key) VALUES(90, 9, 'test1');
INSERT INTO node(id, pid, key) VALUES(900, 90, 'test2');
DELETE FROM node WHERE id=9;
SELECT * FROM node;
CREATE TABLE   x1  (x);
CREATE TABLE   x2  (a, b);
CREATE TABLE '"x2"'(a, b);
INSERT INTO x2 VALUES(1, 2);
INSERT INTO x2 VALUES(3, 4);
INSERT INTO '"x2"' SELECT * FROM x2;
DELETE FROM """x2""" WHERE a=1;
UPDATE """x2""" SET b = 11 WHERE a = 3;
INSERT INTO x1 VALUES('go!');
SELECT * FROM x2;
SELECT * FROM """x2""";
CREATE TABLE xyz(x INTEGER PRIMARY KEY, y, z);
