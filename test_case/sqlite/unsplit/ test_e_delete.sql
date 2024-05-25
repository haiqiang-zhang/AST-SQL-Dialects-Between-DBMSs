CREATE TABLE t1(a, b);
CREATE INDEX i1 ON t1(a);
DELETE FROM t1;
DELETE FROM t1 INDEXED BY i1;
DELETE FROM t1 NOT INDEXED;
DELETE FROM main.t1;
DELETE FROM main.t1 INDEXED BY i1;
DELETE FROM main.t1 NOT INDEXED;
DELETE FROM t1 WHERE a>2;
DELETE FROM t1 INDEXED BY i1 WHERE a>2;
DELETE FROM t1 NOT INDEXED WHERE a>2;
DELETE FROM main.t1 WHERE a>2;
DELETE FROM main.t1 INDEXED BY i1 WHERE a>2;
DELETE FROM main.t1 NOT INDEXED WHERE a>2;
PRAGMA foreign_keys = OFF;
DROP table "t1";
CREATE TABLE t1(x, y);
INSERT INTO t1 VALUES(1, 'one');
INSERT INTO t1 VALUES(2, 'two');
INSERT INTO t1 VALUES(3, 'three');
INSERT INTO t1 VALUES(4, 'four');
INSERT INTO t1 VALUES(5, 'five');
CREATE TABLE t2(x, y);
INSERT INTO t2 VALUES(1, 'one');
INSERT INTO t2 VALUES(2, 'two');
INSERT INTO t2 VALUES(3, 'three');
INSERT INTO t2 VALUES(4, 'four');
INSERT INTO t2 VALUES(5, 'five');
CREATE TABLE t3(x, y);
INSERT INTO t3 VALUES(1, 'one');
INSERT INTO t3 VALUES(2, 'two');
INSERT INTO t3 VALUES(3, 'three');
INSERT INTO t3 VALUES(4, 'four');
INSERT INTO t3 VALUES(5, 'five');
CREATE TABLE t4(x, y);
INSERT INTO t4 VALUES(1, 'one');
INSERT INTO t4 VALUES(2, 'two');
INSERT INTO t4 VALUES(3, 'three');
INSERT INTO t4 VALUES(4, 'four');
INSERT INTO t4 VALUES(5, 'five');
CREATE TABLE t5(x, y);
INSERT INTO t5 VALUES(1, 'one');
INSERT INTO t5 VALUES(2, 'two');
INSERT INTO t5 VALUES(3, 'three');
INSERT INTO t5 VALUES(4, 'four');
INSERT INTO t5 VALUES(5, 'five');
CREATE TABLE t6(x, y);
INSERT INTO t6 VALUES(1, 'one');
INSERT INTO t6 VALUES(2, 'two');
INSERT INTO t6 VALUES(3, 'three');
INSERT INTO t6 VALUES(4, 'four');
INSERT INTO t6 VALUES(5, 'five');
DELETE FROM t1;
SELECT * FROM t1;
DELETE FROM main.t2;
SELECT * FROM t2;
DELETE FROM t3 WHERE 1;
SELECT x FROM t3;
DELETE FROM main.t4 WHERE 0;
SELECT x FROM t4;
DELETE FROM t4 WHERE 0.0;
SELECT x FROM t4;
DELETE FROM t4 WHERE NULL;
SELECT x FROM t4;
DELETE FROM t4 WHERE y!='two';
SELECT x FROM t4;
DELETE FROM t4 WHERE y='two';
SELECT x FROM t4;
DELETE FROM t5 WHERE x=(SELECT max(x) FROM t5);
SELECT x FROM t5;
DELETE FROM t5 WHERE (SELECT max(x) FROM t4);
SELECT x FROM t5;
DELETE FROM t5 WHERE (SELECT max(x) FROM t6);
SELECT x FROM t5;
DELETE FROM t6 WHERE y>'seven';
SELECT y FROM t6;
ATTACH 'test.db2' AS aux;
ATTACH 'test.db3' AS aux2;
CREATE TABLE temp.t7(a, b);
INSERT INTO temp.t7 VALUES(1, 2);
CREATE TABLE main.t7(a, b);
INSERT INTO main.t7 VALUES(3, 4);
CREATE TABLE aux.t7(a, b);
INSERT INTO aux.t7 VALUES(5, 6);
CREATE TABLE aux2.t7(a, b);
INSERT INTO aux2.t7 VALUES(7, 8);
CREATE TABLE main.t8(a, b);
INSERT INTO main.t8 VALUES(1, 2);
CREATE TABLE aux.t8(a, b);
INSERT INTO aux.t8 VALUES(3, 4);
CREATE TABLE aux2.t8(a, b);
INSERT INTO aux2.t8 VALUES(5, 6);
CREATE TABLE aux.t9(a, b);
INSERT INTO aux.t9 VALUES(1, 2);
CREATE TABLE aux2.t9(a, b);
INSERT INTO aux2.t9 VALUES(3, 4);
CREATE TABLE aux2.t10(a, b);
INSERT INTO aux2.t10 VALUES(1, 2);
INSERT INTO main.t7 VALUES(1, 2);
UPDATE t9 SET a=1;
INSERT INTO aux.t8 VALUES(1, 2);
SELECT count(*) FROM aux.t9 
        UNION ALL
      SELECT count(*) FROM aux2.t9;
INSERT INTO main.t8 VALUES(1, 2);
SELECT count(*) FROM temp.t7 
        UNION ALL
      SELECT count(*) FROM main.t7
        UNION ALL
      SELECT count(*) FROM aux.t7
        UNION ALL
      SELECT count(*) FROM aux2.t7;
DELETE FROM main.t8 WHERE oid>1;
DELETE FROM aux.t8 WHERE oid>1;
INSERT INTO aux.t9 VALUES(1, 2);
INSERT INTO main.t7 VALUES(3, 4);
SELECT count(*) FROM temp.t7 UNION ALL SELECT count(*) FROM main.t7 UNION ALL
  SELECT count(*) FROM aux.t7  UNION ALL SELECT count(*) FROM aux2.t7;
SELECT count(*) FROM main.t8 UNION ALL SELECT count(*) FROM aux.t8  
  UNION ALL SELECT count(*) FROM aux2.t8;
SELECT count(*) FROM aux.t9  UNION ALL SELECT count(*) FROM aux2.t9;
SELECT count(*) FROM aux2.t10;
DELETE FROM t8;
DELETE FROM t9;
DELETE FROM t10;
INSERT INTO temp.t7 VALUES('hello', 'world');
SELECT count(*) FROM temp.t7 UNION ALL SELECT count(*) FROM main.t7 UNION ALL
  SELECT count(*) FROM aux.t7  UNION ALL SELECT count(*) FROM aux2.t7;
SELECT count(*) FROM main.t8 UNION ALL SELECT count(*) FROM aux.t8  
  UNION ALL SELECT count(*) FROM aux2.t8;
SELECT count(*) FROM aux.t9  UNION ALL SELECT count(*) FROM aux2.t9;
SELECT count(*) FROM aux2.t10;
CREATE INDEX i8 ON t8(a, b);