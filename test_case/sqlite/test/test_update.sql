SELECT * FROM test1 ORDER BY f1;
UPDATE test1 SET f2=f2*3;
SELECT * FROM test1 ORDER BY f1;
PRAGMA count_changes=on;
SELECT * FROM test1 ORDER BY f1;
SELECT * FROM test1 ORDER BY f1;
SELECT * FROM test1 ORDER BY F1;
PRAGMA count_changes=off;
UPDATE test1 SET F2=f1, F1=f2;
SELECT * FROM test1 ORDER BY F1;
DELETE FROM test1 WHERE f1<=5;
INSERT INTO test1(f1,f2) VALUES(8,88);
INSERT INTO test1(f1,f2) VALUES(8,888);
INSERT INTO test1(f1,f2) VALUES(77,128);
INSERT INTO test1(f1,f2) VALUES(777,128);
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f2=f2+1 WHERE f1==8;
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f2=f2-1 WHERE f1==8 and f2>800;
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f2=f2-1 WHERE f1==8 and f2<800;
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f1=f1+1 WHERE f2==128;
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f1=f1-1 WHERE f1>100 and f2==128;
SELECT * FROM test1 ORDER BY f1,f2;
PRAGMA count_changes=on;
PRAGMA count_changes=off;
SELECT * FROM test1 ORDER BY f1,f2;
CREATE INDEX idx1 ON test1(f1);
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f2=f2+1 WHERE f1==8;
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f2=f2-1 WHERE f1==8 and f2>800;
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f2=f2-1 WHERE f1==8 and f2<800;
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f1=f1+1 WHERE f2==128;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==78 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==778 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
UPDATE test1 SET f1=f1-1 WHERE f1>100 and f2==128;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==78 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==778 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==777 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
PRAGMA count_changes=on;
PRAGMA count_changes=off;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==77 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==778 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==777 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
PRAGMA synchronous=FULL;
DROP INDEX idx1;
CREATE INDEX idx1 ON test1(f2);
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f2=f2+1 WHERE f1==8;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f2==89 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==88 ORDER BY f1,f2;
UPDATE test1 SET f2=f2-1 WHERE f1==8 and f2>800;
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f2=f2-1 WHERE f1==8 and f2<800;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f2==89 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f2==88 ORDER BY f1,f2;
UPDATE test1 SET f1=f1+1 WHERE f2==128;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==78 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==778 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
UPDATE test1 SET f1=f1-1 WHERE f1>100 and f2==128;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==78 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==778 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==777 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
UPDATE test1 SET f1=f1-1 WHERE f1<=100 and f2==128;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==77 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==778 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==777 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
CREATE INDEX idx2 ON test1(f2);
CREATE INDEX idx3 ON test1(f1,f2);
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f2=f2+1 WHERE f1==8;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f2==89 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==88 ORDER BY f1,f2;
UPDATE test1 SET f2=f2-1 WHERE f1==8 and f2>800;
SELECT * FROM test1 ORDER BY f1,f2;
UPDATE test1 SET f2=f2-1 WHERE f1==8 and f2<800;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f2==89 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f2==88 ORDER BY f1,f2;
UPDATE test1 SET f1=f1+1 WHERE f2==128;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==78 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==778 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
UPDATE test1 SET f1=f1-1 WHERE f1>100 and f2==128;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==78 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==778 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==777 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
UPDATE test1 SET f1=f1-1 WHERE f1<=100 and f2==128;
SELECT * FROM test1 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==77 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==778 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==777 ORDER BY f1,f2;
SELECT * FROM test1 WHERE f1==8 ORDER BY f1,f2;
DROP TABLE test1;
CREATE TABLE t1(
       a integer primary key,
       b UNIQUE, 
       c, d,
       e, f,
       UNIQUE(c,d)
    );
INSERT INTO t1 VALUES(1,2,3,4,5,6);
INSERT INTO t1 VALUES(2,3,4,4,6,7);
SELECT * FROM t1;
UPDATE t1 SET a=1, e=9 WHERE f=6;
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;
UPDATE t1 SET b=2, e=11 WHERE f=6;
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;
UPDATE t1 SET c=3, d=4, e=13 WHERE f=6;
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;
UPDATE t1 SET e=e+1 WHERE b IN (SELECT b FROM t1);
SELECT b,e FROM t1;
UPDATE t1 SET e=e+1 WHERE a IN (SELECT a FROM t1);
SELECT a,e FROM t1;
UPDATE t1 AS xyz SET e=e+1 WHERE xyz.a IN (SELECT a FROM t1);
SELECT a,e FROM t1;
UPDATE t1 AS xyz SET e=e+1 WHERE EXISTS(SELECT 1 FROM t1 WHERE t1.a<xyz.a);
SELECT a,e FROM t1;
PRAGMA integrity_check;
BEGIN;
CREATE TABLE t2(a);
INSERT INTO t2 VALUES(1);
INSERT INTO t2 VALUES(2);
INSERT INTO t2 SELECT a+2 FROM t2;
INSERT INTO t2 SELECT a+4 FROM t2;
INSERT INTO t2 SELECT a+8 FROM t2;
INSERT INTO t2 SELECT a+16 FROM t2;
INSERT INTO t2 SELECT a+32 FROM t2;
INSERT INTO t2 SELECT a+64 FROM t2;
INSERT INTO t2 SELECT a+128 FROM t2;
INSERT INTO t2 SELECT a+256 FROM t2;
INSERT INTO t2 SELECT a+512 FROM t2;
INSERT INTO t2 SELECT a+1024 FROM t2;
SELECT count(*) FROM t2;
SELECT count(*) FROM t2 WHERE a=rowid;
UPDATE t2 SET rowid=rowid-1;
SELECT count(*) FROM t2 WHERE a=rowid+1;
UPDATE t2 SET rowid=rowid+10000;
UPDATE t2 SET rowid=rowid-9999;
SELECT count(*) FROM t2 WHERE a=rowid;
BEGIN;
INSERT INTO t2 SELECT a+2048 FROM t2;
INSERT INTO t2 SELECT a+4096 FROM t2;
INSERT INTO t2 SELECT a+8192 FROM t2;
SELECT count(*) FROM t2 WHERE a=rowid;
UPDATE t2 SET rowid=rowid-1;
SELECT count(*) FROM t2 WHERE a=rowid+1;
PRAGMA integrity_check;
CREATE TABLE t3(a,b,c);
UPDATE t3 SET a=1;
CREATE TABLE t4(a,b,c);
UPDATE t4 SET a=1;
CREATE TABLE t15(a INTEGER PRIMARY KEY, b);
INSERT INTO t15(a,b) VALUES(10,'abc'),(20,'def'),(30,'ghi');
ALTER TABLE t15 ADD COLUMN c;
CREATE INDEX t15c ON t15(c);
INSERT INTO t15(a,b)
      VALUES(5,'zyx'),(15,'wvu'),(25,'tsr'),(35,'qpo');
UPDATE t15 SET c=printf('y%d',a) WHERE c IS NULL;
SELECT a,b,c,'|' FROM t15 ORDER BY a;
CREATE TABLE t16(a INTEGER PRIMARY KEY ON CONFLICT REPLACE, b UNIQUE);
INSERT INTO t16(a,b) VALUES(1,2),(3,4),(5,6);
UPDATE t16 SET a=a;
SELECT * FROM t16 ORDER BY +a;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(x,y);
INSERT INTO t1(x) VALUES(1);
CREATE INDEX t1x1 ON t1(1) WHERE 3;
UPDATE t1 SET x=2, y=3 WHERE 3;
SELECT * FROM t1;
PRAGMA encoding = 'UTF16';
CREATE TABLE t0(c0 REAL, c1);
INSERT INTO t0(c0,c1) VALUES('xyz',11),('uvw',22);
CREATE INDEX i0 ON t0(c1) WHERE c0 GLOB 3;
CREATE INDEX i1 ON t0(c0,c1) WHERE typeof(c0)='text' AND typeof(c1)='integer';
UPDATE t0 SET c1=345;
SELECT * FROM t0;
PRAGMA encoding = 'utf16';
INSERT INTO t0(c0) VALUES (0), (0);
SELECT * FROM t0;
INSERT INTO t1 VALUES(1,2);
SELECT * FROM t1;
PRAGMA recursive_triggers = true;
PRAGMA integrity_check;
PRAGMA integrity_check;
INSERT INTO t1 VALUES(3,NULL),(6,-54);
BEGIN;
BEGIN;
BEGIN;
DROP TABLE t1;
CREATE TABLE t1(a INTEGER PRIMARY KEY, b INT);