CREATE TABLE one(a int PRIMARY KEY, b text);
INSERT INTO one VALUES(1,'one');
INSERT INTO one VALUES(2,'two');
INSERT INTO one VALUES(3,'three');
SELECT b FROM one ORDER BY a;
PRAGMA integrity_check;
CREATE TABLE two(a int PRIMARY KEY, b text);
INSERT INTO two VALUES(1,'I');
INSERT INTO two VALUES(5,'V');
INSERT INTO two VALUES(10,'X');
SELECT b FROM two ORDER BY a;
SELECT b FROM one ORDER BY a;
SELECT b FROM two ORDER BY a;
PRAGMA integrity_check;
BEGIN;
BEGIN TRANSACTION;
BEGIN TRANSACTION 'foo';
BEGIN;
SELECT a FROM one ORDER BY a;
SELECT a FROM two ORDER BY a;
PRAGMA integrity_check;
BEGIN;
UPDATE one SET a = 0 WHERE 0;
SELECT a FROM one ORDER BY a;
SELECT a FROM two ORDER BY a;
SELECT a FROM one ORDER BY a;
INSERT INTO one VALUES(4,'four');
SELECT a FROM two ORDER BY a;
SELECT a FROM one ORDER BY a;
INSERT INTO two VALUES(4,'IV');
SELECT a FROM two ORDER BY a;
SELECT a FROM one ORDER BY a;
SELECT a FROM two ORDER BY a;
SELECT a FROM one ORDER BY a;
SELECT a FROM two ORDER BY a;
SELECT a FROM one ORDER BY a;
PRAGMA integrity_check;
BEGIN TRANSACTION;
UPDATE two SET a = 0 WHERE 0;
SELECT a FROM two ORDER BY a;
SELECT a FROM two ORDER BY a;
SELECT a FROM one ORDER BY a;
BEGIN TRANSACTION;
SELECT a FROM one ORDER BY a;
SELECT a FROM two ORDER BY a;
SELECT a FROM one ORDER BY a;
SELECT a FROM two ORDER BY a;
SELECT a FROM two ORDER BY a;
SELECT a FROM one ORDER BY a;
PRAGMA integrity_check;
DROP TABLE one;
DROP TABLE two;
PRAGMA integrity_check;
SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;
BEGIN TRANSACTION;
SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;
CREATE TABLE one(a text, b int);
SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;
SELECT a,b FROM one ORDER BY b;
INSERT INTO one(a,b) VALUES('hello', 1);
SELECT a,b FROM one ORDER BY b;
SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;
SELECT a,b FROM one ORDER BY b;
SELECT name fROM sqlite_master 
    WHERE type='table' OR type='index'
    ORDER BY name;
BEGIN TRANSACTION;
CREATE TABLE t1(a int, b int, c int);
SELECT name fROM sqlite_master 
    WHERE type='table' OR type='index'
    ORDER BY name;
CREATE INDEX i1 ON t1(a);
SELECT name fROM sqlite_master 
    WHERE type='table' OR type='index'
    ORDER BY name;
SELECT name fROM sqlite_master 
    WHERE type='table' OR type='index'
    ORDER BY name;
BEGIN TRANSACTION;
CREATE TABLE t2(a int, b int, c int);
CREATE INDEX i2a ON t2(a);
CREATE INDEX i2b ON t2(b);
DROP TABLE t1;
SELECT name fROM sqlite_master 
    WHERE type='table' OR type='index'
    ORDER BY name;
SELECT name fROM sqlite_master 
    WHERE type='table' OR type='index'
    ORDER BY name;
BEGIN TRANSACTION;
SELECT name fROM sqlite_master 
    WHERE type='table' OR type='index'
    ORDER BY name;
SELECT name fROM sqlite_master 
    WHERE type='table' OR type='index'
    ORDER BY name;
BEGIN TRANSACTION;
INSERT INTO t2 VALUES(1,2,3);
SELECT name fROM sqlite_master 
    WHERE type='table' OR type='index'
    ORDER BY name;
SELECT name fROM sqlite_master 
    WHERE type='table' OR type='index'
    ORDER BY name;
SELECT * FROM t2;
BEGIN TRANSACTION;
DROP TABLE t2;
SELECT name fROM sqlite_master 
    WHERE type='table' OR type='index'
    ORDER BY name;
SELECT name fROM sqlite_master 
    WHERE type='table' OR type='index'
    ORDER BY name;
PRAGMA integrity_check;
BEGIN TRANSACTION;
CREATE TABLE t1(p,q,r);
SELECT * FROM t1;
INSERT INTO t1 VALUES(1,2,3);
BEGIN TRANSACTION;
DROP TABLE t1;
CREATE TABLE t1(p,q,r);
SELECT * FROM t1;
INSERT INTO t1 VALUES(1,2,3);
SELECT * FROM t1;
BEGIN TRANSACTION;
DROP TABLE t1;
CREATE TABLE t1(a,b,c);
INSERT INTO t1 VALUES(4,5,6);
SELECT * FROM t1;
DROP TABLE t1;
BEGIN TRANSACTION;
CREATE TABLE t1(a,b,c);
INSERT INTO t1 VALUES(4,5,6);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a unique,b,c);
INSERT INTO t1 VALUES(1,2,3);
BEGIN TRANSACTION;
DROP TABLE t1;
CREATE TABLE t1(p unique,q,r);
SELECT * FROM t1;
BEGIN TRANSACTION;
DROP TABLE t1;
CREATE TABLE t1(p unique,q,r);
SELECT * FROM t1;
INSERT INTO t1 VALUES(1,2,3);
SELECT * FROM t1;
BEGIN TRANSACTION;
DROP TABLE t1;
CREATE TABLE t1(a unique,b,c);
INSERT INTO t1 VALUES(4,5,6);
SELECT * FROM t1;
DROP TABLE t1;
BEGIN TRANSACTION;
CREATE TABLE t1(a unique,b,c);
INSERT INTO t1 VALUES(4,5,6);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a integer primary key,b,c);
INSERT INTO t1 VALUES(1,-2,-3);
INSERT INTO t1 VALUES(4,-5,-6);
SELECT * FROM t1;
CREATE INDEX i1 ON t1(b);
SELECT * FROM t1 WHERE b<1;
BEGIN TRANSACTION;
DROP INDEX i1;
SELECT * FROM t1 WHERE b<1;
SELECT * FROM t1 WHERE b<1;
BEGIN TRANSACTION;
DROP TABLE t1;
BEGIN TRANSACTION;
BEGIN TRANSACTION;
CREATE TABLE t1(a int unique,b,c);
INSERT INTO t1 VALUES(1,-2,-3);
INSERT INTO t1 VALUES(4,-5,-6);
SELECT * FROM t1 ORDER BY a;
CREATE INDEX i1 ON t1(b);
SELECT * FROM t1 WHERE b<1;
BEGIN TRANSACTION;
DROP INDEX i1;
SELECT * FROM t1 WHERE b<1;
SELECT * FROM t1 WHERE b<1;
BEGIN TRANSACTION;
DROP TABLE t1;
BEGIN TRANSACTION;
PRAGMA integrity_check;
BEGIN;
BEGIN;
BEGIN;
BEGIN;
BEGIN;
BEGIN;
BEGIN;
BEGIN;
BEGIN;
PRAGMA integrity_check;
PRAGMA integrity_check;
PRAGMA integrity_check;
PRAGMA default_cache_size=10;
BEGIN;
CREATE TABLE t3(x TEXT);
SELECT count(*) FROM t3;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
PRAGMA fullfsync=OFF;
PRAGMA fullfsync=ON;
