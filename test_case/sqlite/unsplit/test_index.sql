CREATE TABLE test1(f1 int, f2 int, f3 int);
CREATE INDEX index1 ON test1(f1);
SELECT name FROM sqlite_master WHERE type!='meta' ORDER BY name;
SELECT name, sql, tbl_name, type FROM sqlite_master 
           WHERE name='index1';
SELECT name, sql, tbl_name, type FROM sqlite_master 
           WHERE name='index1';
SELECT name FROM sqlite_master WHERE type!='meta' ORDER BY name;
DROP TABLE test1;
SELECT name FROM sqlite_master WHERE type!='meta' ORDER BY name;
CREATE TABLE test1(f1 int, f2 int, f3 int);
DROP TABLE test1;
CREATE TABLE test1(f1 int, f2 int, f3 int, f4 int, f5 int);
CREATE INDEX index01 ON test1(f2);
CREATE INDEX index02 ON test1(f3);
CREATE INDEX index03 ON test1(f4);
CREATE INDEX index04 ON test1(f5);
CREATE INDEX index05 ON test1(f1);
CREATE INDEX index06 ON test1(f2);
CREATE INDEX index07 ON test1(f3);
CREATE INDEX index08 ON test1(f4);
CREATE INDEX index09 ON test1(f5);
CREATE INDEX index10 ON test1(f1);
CREATE INDEX index11 ON test1(f2);
CREATE INDEX index12 ON test1(f3);
CREATE INDEX index13 ON test1(f4);
CREATE INDEX index14 ON test1(f5);
CREATE INDEX index15 ON test1(f1);
CREATE INDEX index16 ON test1(f2);
CREATE INDEX index17 ON test1(f3);
CREATE INDEX index18 ON test1(f4);
CREATE INDEX index19 ON test1(f5);
CREATE INDEX index20 ON test1(f1);
CREATE INDEX index21 ON test1(f2);
CREATE INDEX index22 ON test1(f3);
CREATE INDEX index23 ON test1(f4);
CREATE INDEX index24 ON test1(f5);
CREATE INDEX index25 ON test1(f1);
CREATE INDEX index26 ON test1(f2);
CREATE INDEX index27 ON test1(f3);
CREATE INDEX index28 ON test1(f4);
CREATE INDEX index29 ON test1(f5);
CREATE INDEX index30 ON test1(f1);
CREATE INDEX index31 ON test1(f2);
CREATE INDEX index32 ON test1(f3);
CREATE INDEX index33 ON test1(f4);
CREATE INDEX index34 ON test1(f5);
CREATE INDEX index35 ON test1(f1);
CREATE INDEX index36 ON test1(f2);
CREATE INDEX index37 ON test1(f3);
CREATE INDEX index38 ON test1(f4);
CREATE INDEX index39 ON test1(f5);
CREATE INDEX index40 ON test1(f1);
CREATE INDEX index41 ON test1(f2);
CREATE INDEX index42 ON test1(f3);
CREATE INDEX index43 ON test1(f4);
CREATE INDEX index44 ON test1(f5);
CREATE INDEX index45 ON test1(f1);
CREATE INDEX index46 ON test1(f2);
CREATE INDEX index47 ON test1(f3);
CREATE INDEX index48 ON test1(f4);
CREATE INDEX index49 ON test1(f5);
CREATE INDEX index50 ON test1(f1);
CREATE INDEX index51 ON test1(f2);
CREATE INDEX index52 ON test1(f3);
CREATE INDEX index53 ON test1(f4);
CREATE INDEX index54 ON test1(f5);
CREATE INDEX index55 ON test1(f1);
CREATE INDEX index56 ON test1(f2);
CREATE INDEX index57 ON test1(f3);
CREATE INDEX index58 ON test1(f4);
CREATE INDEX index59 ON test1(f5);
CREATE INDEX index60 ON test1(f1);
CREATE INDEX index61 ON test1(f2);
CREATE INDEX index62 ON test1(f3);
CREATE INDEX index63 ON test1(f4);
CREATE INDEX index64 ON test1(f5);
CREATE INDEX index65 ON test1(f1);
CREATE INDEX index66 ON test1(f2);
CREATE INDEX index67 ON test1(f3);
CREATE INDEX index68 ON test1(f4);
CREATE INDEX index69 ON test1(f5);
CREATE INDEX index70 ON test1(f1);
CREATE INDEX index71 ON test1(f2);
CREATE INDEX index72 ON test1(f3);
CREATE INDEX index73 ON test1(f4);
CREATE INDEX index74 ON test1(f5);
CREATE INDEX index75 ON test1(f1);
CREATE INDEX index76 ON test1(f2);
CREATE INDEX index77 ON test1(f3);
CREATE INDEX index78 ON test1(f4);
CREATE INDEX index79 ON test1(f5);
CREATE INDEX index80 ON test1(f1);
CREATE INDEX index81 ON test1(f2);
CREATE INDEX index82 ON test1(f3);
CREATE INDEX index83 ON test1(f4);
CREATE INDEX index84 ON test1(f5);
CREATE INDEX index85 ON test1(f1);
CREATE INDEX index86 ON test1(f2);
CREATE INDEX index87 ON test1(f3);
CREATE INDEX index88 ON test1(f4);
CREATE INDEX index89 ON test1(f5);
CREATE INDEX index90 ON test1(f1);
CREATE INDEX index91 ON test1(f2);
CREATE INDEX index92 ON test1(f3);
CREATE INDEX index93 ON test1(f4);
CREATE INDEX index94 ON test1(f5);
CREATE INDEX index95 ON test1(f1);
CREATE INDEX index96 ON test1(f2);
CREATE INDEX index97 ON test1(f3);
CREATE INDEX index98 ON test1(f4);
CREATE INDEX index99 ON test1(f5);
SELECT name FROM sqlite_master 
           WHERE type='index' AND tbl_name='test1'
           ORDER BY name;
PRAGMA integrity_check;
REINDEX;
PRAGMA integrity_check;
DROP TABLE test1;
SELECT name FROM sqlite_master 
           WHERE type='index' AND tbl_name='test1'
           ORDER BY name;
CREATE TABLE test1(cnt int, power int);
INSERT INTO test1 VALUES(1,2);
INSERT INTO test1 VALUES(2,4);
INSERT INTO test1 VALUES(3,8);
INSERT INTO test1 VALUES(4,16);
INSERT INTO test1 VALUES(5,32);
INSERT INTO test1 VALUES(6,64);
INSERT INTO test1 VALUES(7,128);
INSERT INTO test1 VALUES(8,256);
INSERT INTO test1 VALUES(9,512);
INSERT INTO test1 VALUES(10,1024);
INSERT INTO test1 VALUES(11,2048);
INSERT INTO test1 VALUES(12,4096);
INSERT INTO test1 VALUES(13,8192);
INSERT INTO test1 VALUES(14,16384);
INSERT INTO test1 VALUES(15,32768);
INSERT INTO test1 VALUES(16,65536);
INSERT INTO test1 VALUES(17,131072);
INSERT INTO test1 VALUES(18,262144);
INSERT INTO test1 VALUES(19,524288);
CREATE INDEX index9 ON test1(cnt);
CREATE INDEX indext ON test1(power);
SELECT name FROM sqlite_master WHERE type!='meta' ORDER BY name;
SELECT cnt FROM test1 WHERE power=4;
SELECT cnt FROM test1 WHERE power=1024;
SELECT power FROM test1 WHERE cnt=6;
DROP INDEX indext;
SELECT power FROM test1 WHERE cnt=6;
SELECT cnt FROM test1 WHERE power=1024;
CREATE INDEX indext ON test1(cnt);
SELECT power FROM test1 WHERE cnt=6;
SELECT cnt FROM test1 WHERE power=1024;
DROP INDEX index9;
SELECT power FROM test1 WHERE cnt=6;
SELECT cnt FROM test1 WHERE power=1024;
DROP INDEX indext;
SELECT power FROM test1 WHERE cnt=6;
SELECT cnt FROM test1 WHERE power=1024;
DROP TABLE test1;
SELECT name FROM sqlite_master WHERE type!='meta' ORDER BY name;
PRAGMA integrity_check;
SELECT name FROM sqlite_master WHERE type!='meta';
CREATE TABLE test1(f1 int, f2 int);
CREATE TABLE test2(g1 real, g2 real);
CREATE INDEX index1 ON test1(f1);
SELECT name FROM sqlite_master WHERE type!='meta' ORDER BY name;
CREATE INDEX IF NOT EXISTS index1 ON test1(f1);
SELECT name FROM sqlite_master WHERE type!='meta' ORDER BY name;
DROP TABLE test1;
DROP TABLE test2;
SELECT name FROM sqlite_master WHERE type!='meta' ORDER BY name;
CREATE TABLE test1(a,b);
CREATE INDEX index1 ON test1(a);
CREATE INDEX index2 ON test1(b);
CREATE INDEX index3 ON test1(a,b);
DROP TABLE test1;
SELECT name FROM sqlite_master WHERE type!='meta' ORDER BY name;
PRAGMA integrity_check;
CREATE TABLE test1(f1 int, f2 int primary key);
INSERT INTO test1 VALUES(1,2);
INSERT INTO test1 VALUES(2,4);
INSERT INTO test1 VALUES(3,8);
INSERT INTO test1 VALUES(4,16);
INSERT INTO test1 VALUES(5,32);
INSERT INTO test1 VALUES(6,64);
INSERT INTO test1 VALUES(7,128);
INSERT INTO test1 VALUES(8,256);
INSERT INTO test1 VALUES(9,512);
INSERT INTO test1 VALUES(10,1024);
INSERT INTO test1 VALUES(11,2048);
INSERT INTO test1 VALUES(12,4096);
INSERT INTO test1 VALUES(13,8192);
INSERT INTO test1 VALUES(14,16384);
INSERT INTO test1 VALUES(15,32768);
INSERT INTO test1 VALUES(16,65536);
INSERT INTO test1 VALUES(17,131072);
INSERT INTO test1 VALUES(18,262144);
INSERT INTO test1 VALUES(19,524288);
SELECT count(*) FROM test1;
SELECT f1 FROM test1 WHERE f2=65536;
SELECT name FROM sqlite_master 
    WHERE type='index' AND tbl_name='test1';
DROP table test1;
SELECT name FROM sqlite_master WHERE type!='meta';
PRAGMA integrity_check;
CREATE TABLE tab1(a int);
EXPLAIN CREATE INDEX idx1 ON tab1(a);
SELECT name FROM sqlite_master WHERE tbl_name='tab1';
CREATE INDEX idx1 ON tab1(a);
SELECT name FROM sqlite_master WHERE tbl_name='tab1' ORDER BY name;
PRAGMA integrity_check;
CREATE TABLE t1(a int, b int);
CREATE INDEX i1 ON t1(a);
INSERT INTO t1 VALUES(1,2);
INSERT INTO t1 VALUES(2,4);
INSERT INTO t1 VALUES(3,8);
INSERT INTO t1 VALUES(1,12);
SELECT b FROM t1 WHERE a=1 ORDER BY b;
SELECT b FROM t1 WHERE a=2 ORDER BY b;
DELETE FROM t1 WHERE b=12;
SELECT b FROM t1 WHERE a=1 ORDER BY b;
DELETE FROM t1 WHERE b=2;
SELECT b FROM t1 WHERE a=1 ORDER BY b;
DELETE FROM t1;
INSERT INTO t1 VALUES (1,1);
INSERT INTO t1 VALUES (1,2);
INSERT INTO t1 VALUES (1,3);
INSERT INTO t1 VALUES (1,4);
INSERT INTO t1 VALUES (1,5);
INSERT INTO t1 VALUES (1,6);
INSERT INTO t1 VALUES (1,7);
INSERT INTO t1 VALUES (1,8);
INSERT INTO t1 VALUES (1,9);
INSERT INTO t1 VALUES (2,0);
SELECT b FROM t1 WHERE a=1 ORDER BY b;
DELETE FROM t1 WHERE b IN (2, 4, 6, 8);
SELECT b FROM t1 WHERE a=1 ORDER BY b;
DELETE FROM t1 WHERE b>2;
SELECT b FROM t1 WHERE a=1 ORDER BY b;
DELETE FROM t1 WHERE b=1;
SELECT b FROM t1 WHERE a=1 ORDER BY b;
SELECT b FROM t1 ORDER BY b;
PRAGMA integrity_check;
CREATE TABLE t3(
      a text,
      b int,
      c float,
      PRIMARY KEY(b)
    );
INSERT INTO t3 VALUES('x1x',1,0.1);
INSERT INTO t3 VALUES('x2x',2,0.2);
INSERT INTO t3 VALUES('x3x',3,0.3);
INSERT INTO t3 VALUES('x4x',4,0.4);
INSERT INTO t3 VALUES('x5x',5,0.5);
INSERT INTO t3 VALUES('x6x',6,0.6);
INSERT INTO t3 VALUES('x7x',7,0.7);
INSERT INTO t3 VALUES('x8x',8,0.8);
INSERT INTO t3 VALUES('x9x',9,0.9);
INSERT INTO t3 VALUES('x10x',10,0.10);
INSERT INTO t3 VALUES('x11x',11,0.11);
INSERT INTO t3 VALUES('x12x',12,0.12);
INSERT INTO t3 VALUES('x13x',13,0.13);
INSERT INTO t3 VALUES('x14x',14,0.14);
INSERT INTO t3 VALUES('x15x',15,0.15);
INSERT INTO t3 VALUES('x16x',16,0.16);
INSERT INTO t3 VALUES('x17x',17,0.17);
INSERT INTO t3 VALUES('x18x',18,0.18);
INSERT INTO t3 VALUES('x19x',19,0.19);
INSERT INTO t3 VALUES('x20x',20,0.20);
INSERT INTO t3 VALUES('x21x',21,0.21);
INSERT INTO t3 VALUES('x22x',22,0.22);
INSERT INTO t3 VALUES('x23x',23,0.23);
INSERT INTO t3 VALUES('x24x',24,0.24);
INSERT INTO t3 VALUES('x25x',25,0.25);
INSERT INTO t3 VALUES('x26x',26,0.26);
INSERT INTO t3 VALUES('x27x',27,0.27);
INSERT INTO t3 VALUES('x28x',28,0.28);
INSERT INTO t3 VALUES('x29x',29,0.29);
INSERT INTO t3 VALUES('x30x',30,0.30);
INSERT INTO t3 VALUES('x31x',31,0.31);
INSERT INTO t3 VALUES('x32x',32,0.32);
INSERT INTO t3 VALUES('x33x',33,0.33);
INSERT INTO t3 VALUES('x34x',34,0.34);
INSERT INTO t3 VALUES('x35x',35,0.35);
INSERT INTO t3 VALUES('x36x',36,0.36);
INSERT INTO t3 VALUES('x37x',37,0.37);
INSERT INTO t3 VALUES('x38x',38,0.38);
INSERT INTO t3 VALUES('x39x',39,0.39);
INSERT INTO t3 VALUES('x40x',40,0.40);
INSERT INTO t3 VALUES('x41x',41,0.41);
INSERT INTO t3 VALUES('x42x',42,0.42);
INSERT INTO t3 VALUES('x43x',43,0.43);
INSERT INTO t3 VALUES('x44x',44,0.44);
INSERT INTO t3 VALUES('x45x',45,0.45);
INSERT INTO t3 VALUES('x46x',46,0.46);
INSERT INTO t3 VALUES('x47x',47,0.47);
INSERT INTO t3 VALUES('x48x',48,0.48);
INSERT INTO t3 VALUES('x49x',49,0.49);
INSERT INTO t3 VALUES('x50x',50,0.50);
SELECT c FROM t3 WHERE b==10;
PRAGMA integrity_check;
CREATE TABLE t4(a NUM,b);
INSERT INTO t4 VALUES('0.0',1);
INSERT INTO t4 VALUES('0.00',2);
INSERT INTO t4 VALUES('abc',3);
INSERT INTO t4 VALUES('-1.0',4);
INSERT INTO t4 VALUES('+1.0',5);
INSERT INTO t4 VALUES('0',6);
INSERT INTO t4 VALUES('00000',7);
SELECT a FROM t4 ORDER BY b;
SELECT a FROM t4 WHERE a==0 ORDER BY b;
SELECT a FROM t4 WHERE a<0.5 ORDER BY b;
SELECT a FROM t4 WHERE a>-0.5 ORDER BY b;
CREATE INDEX t4i1 ON t4(a);
SELECT a FROM t4 WHERE a==0 ORDER BY b;
SELECT a FROM t4 WHERE a<0.5 ORDER BY b;
SELECT a FROM t4 WHERE a>-0.5 ORDER BY b;
PRAGMA integrity_check;
CREATE TABLE t5(
      a int UNIQUE,
      b float PRIMARY KEY,
      c varchar(10),
      UNIQUE(a,c)
   );
INSERT INTO t5 VALUES(1,2,3);
SELECT * FROM t5;
SELECT name FROM sqlite_master WHERE type='index' AND tbl_name='t5';
INSERT INTO t5 VALUES('a','b','c');
SELECT * FROM t5;
PRAGMA integrity_check;
CREATE TABLE t6(a,b,c);
CREATE INDEX t6i1 ON t6(a,b);
INSERT INTO t6 VALUES('','',1);
INSERT INTO t6 VALUES('',NULL,2);
INSERT INTO t6 VALUES(NULL,'',3);
INSERT INTO t6 VALUES('abc',123,4);
INSERT INTO t6 VALUES(123,'abc',5);
SELECT c FROM t6 ORDER BY a,b;
SELECT c FROM t6 WHERE a='';
SELECT c FROM t6 WHERE b='';
SELECT c FROM t6 WHERE a>'';
SELECT c FROM t6 WHERE a>='';
SELECT c FROM t6 WHERE a>123;
SELECT c FROM t6 WHERE a>=123;
SELECT c FROM t6 WHERE a<'abc';
SELECT c FROM t6 WHERE a<='abc';
SELECT c FROM t6 WHERE a<='';
SELECT c FROM t6 WHERE a<'';
PRAGMA integrity_check;
DELETE FROM t1;
SELECT * FROM t1;
INSERT INTO t1 VALUES('1.234e5',1);
INSERT INTO t1 VALUES('12.33e04',2);
INSERT INTO t1 VALUES('12.35E4',3);
INSERT INTO t1 VALUES('12.34e',4);
INSERT INTO t1 VALUES('12.32e+4',5);
INSERT INTO t1 VALUES('12.36E+04',6);
INSERT INTO t1 VALUES('12.36E+',7);
INSERT INTO t1 VALUES('+123.10000E+0003',8);
INSERT INTO t1 VALUES('+',9);
INSERT INTO t1 VALUES('+12347.E+02',10);
INSERT INTO t1 VALUES('+12347E+02',11);
INSERT INTO t1 VALUES('+.125E+04',12);
INSERT INTO t1 VALUES('-.125E+04',13);
INSERT INTO t1 VALUES('.125E+0',14);
INSERT INTO t1 VALUES('.125',15);
SELECT b FROM t1 ORDER BY a, b;
SELECT b FROM t1 WHERE typeof(a) IN ('integer','real') ORDER BY b;
PRAGMA integrity_check;
CREATE TABLE t7(c UNIQUE PRIMARY KEY);
DROP TABLE t7;
CREATE TABLE t7(c UNIQUE PRIMARY KEY);
DROP TABLE t7;
CREATE TABLE t7(c PRIMARY KEY, UNIQUE(c) );
DROP TABLE t7;
CREATE TABLE t7(c, d , UNIQUE(c, d), PRIMARY KEY(c, d) );
DROP TABLE t7;
CREATE TABLE t7(c, d , UNIQUE(c), PRIMARY KEY(c, d) );
DROP TABLE t7;
CREATE TABLE t7(c, d UNIQUE, UNIQUE(c), PRIMARY KEY(c, d) );
SELECT name FROM sqlite_master WHERE tbl_name = 't7' AND type = 'index';
DROP INDEX IF EXISTS no_such_index;
DROP TABLE t7;
CREATE TABLE t7(a UNIQUE PRIMARY KEY);
CREATE TABLE t8(a UNIQUE PRIMARY KEY ON CONFLICT ROLLBACK);
INSERT INTO t7 VALUES(1);
INSERT INTO t8 VALUES(1);
BEGIN;
BEGIN;
DROP TABLE t7;
DROP TABLE t8;
REINDEX;
PRAGMA integrity_check;
CREATE INDEX "t6i2" ON t6(c);
DROP INDEX "t6i2";
DROP INDEX "t6i1";
CREATE TEMP TABLE t6(x);
INSERT INTO temp.t6 values(1),(5),(9);
CREATE INDEX temp.i21 ON t6(x);
SELECT x FROM t6 ORDER BY x DESC;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a, b TEXT);
CREATE UNIQUE INDEX IF NOT EXISTS x1 ON t1(b==0);
CREATE INDEX IF NOT EXISTS x2 ON t1(a || 0) WHERE b;
INSERT INTO t1(a,b) VALUES('a',1),('a',0);
SELECT a, b, '|' FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a TEXT, b REAL);
CREATE UNIQUE INDEX t1x1 ON t1(a GLOB b);
INSERT INTO t1(a,b) VALUES('0.0','1'),('1.0','1');
SELECT * FROM t1;
REINDEX;
DROP TABLE t1;
CREATE TABLE t1(a REAL);
CREATE UNIQUE INDEX index_0 ON t1(TYPEOF(a));
INSERT OR IGNORE INTO t1(a) VALUES (0.1),(FALSE);
SELECT * FROM t1;
REINDEX;
