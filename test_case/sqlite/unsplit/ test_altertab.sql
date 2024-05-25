CREATE TABLE t1(a, b, CHECK(t1.a != t1.b));
CREATE TABLE t2(a, b);
CREATE INDEX t2expr ON t2(a) WHERE t2.b>0;
SELECT sql FROM sqlite_master;
ALTER TABLE t1 RENAME TO t1new;
CREATE TABLE t3(c, d);
ALTER TABLE t3 RENAME TO t3new;
DROP TABLE t3new;
SELECT sql FROM sqlite_master;
ALTER TABLE t2 RENAME TO t2new;
SELECT sql FROM sqlite_master;
CREATE TABLE abc(a, b, c);
INSERT INTO abc VALUES(1, 2, 3);
CREATE TABLE txx(a, b, c);
INSERT INTO txx VALUES(1, 2, 3);
CREATE VIEW vvv AS SELECT main.txx.a, txx.b, c FROM txx;
CREATE VIEW uuu AS SELECT main.one.a, one.b, c FROM txx AS one;
CREATE VIEW temp.ttt AS SELECT main.txx.a, txx.b, one.b, main.one.a FROM txx AS one, txx;
SELECT * FROM vvv;
ALTER TABLE txx RENAME TO "t xx";
SELECT * FROM vvv;
SELECT sql FROM sqlite_master WHERE name='vvv';
SELECT * FROM uuu;
SELECT sql FROM sqlite_master WHERE name='uuu';
SELECT * FROM ttt;
SELECT sql FROM sqlite_temp_master WHERE name='ttt';
CREATE table t1(x, y);
CREATE table t2(a, b);
INSERT INTO t1 VALUES(1, 1);
ALTER TABLE t1 RENAME TO t11;
INSERT INTO t11 VALUES(2, 2);
ALTER TABLE t2 RENAME TO t22;
INSERT INTO t11 VALUES(3, 3);
CREATE TABLE t9(a, b, c);
CREATE TABLE t10(a, b, c);
CREATE TEMP TABLE t9(a, b, c);
INSERT INTO temp.t9 VALUES(1, 2, 3);
SELECT * FROM t10;
ALTER TABLE temp.t9 RENAME TO 't1234567890';
CREATE TABLE t1(a, b);
CREATE TABLE t2(a, b);
INSERT INTO t1 VALUES(1, 2);
INSERT INTO t2 VALUES(3, 4);
CREATE VIEW v AS SELECT one.a, one.b, t2.a, t2.b FROM t1 AS one, t2;
SELECT * FROM v;
SELECT  *  FROM v;
DROP VIEW v;
CREATE VIEW temp.vv AS SELECT one.a, one.b, t2.a, t2.b FROM t1 AS one, t2;
SELECT * FROM vv;
SELECT sql FROM sqlite_master WHERE name = 'x2';
CREATE TABLE ddd(db, sql, zOld, zNew, bTemp);
INSERT INTO ddd VALUES(
        'main', 'CREATE TABLE x1(i INTEGER, t TEXT)', 'ddd', NULL, 0
    ), (
        'main', 'CREATE TABLE x1(i INTEGER, t TEXT)', NULL, 'eee', 0
    ), (
        'main', NULL, 'ddd', 'eee', 0
    );
ATTACH 'test.db2' AS aux;
PRAGMA foreign_keys = on;
CREATE TABLE aux.p1(a INTEGER PRIMARY KEY, b);
CREATE TABLE aux.c1(x INTEGER PRIMARY KEY, y REFERENCES p1(a));
INSERT INTO aux.p1 VALUES(1, 1);
INSERT INTO aux.p1 VALUES(2, 2);
INSERT INTO aux.c1 VALUES(NULL, 2);
CREATE TABLE aux.c2(x INTEGER PRIMARY KEY, y REFERENCES c1(a));
ALTER TABLE aux.p1 RENAME TO ppp;
INSERT INTO aux.c1 VALUES(NULL, 1);
SELECT sql FROM aux.sqlite_master WHERE name = 'c1';
CREATE VIEW v1 AS SELECT * FROM t2;
ALTER TABLE t1 RENAME TO t3;
DROP VIEW v1;
CREATE TABLE aux.t1(x);
SELECT sql FROM sqlite_temp_master;
SELECT sql FROM sqlite_master WHERE type='trigger';
CREATE TABLE main.t1(a, b, c);
INSERT INTO main.t1 VALUES(1, 2, 3);
SELECT name, tbl_name FROM sqlite_temp_master;
SELECT name, tbl_name FROM sqlite_temp_master;
SELECT name, tbl_name FROM sqlite_temp_master;
CREATE TEMP TABLE t2(x);
SELECT * FROM t1;
CREATE TABLE log(c);
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE TABLE x(f1 integer NOT NULL);
CREATE VIEW y AS SELECT f1 AS f1 FROM x;
CREATE TABLE z (f1 integer NOT NULL PRIMARY KEY);
INSERT INTO x VALUES(1), (2), (3);
SELECT * FROM x;
SELECT * FROM x;
SELECT sql FROM sqlite_master WHERE name = 'y';
CREATE TABLE sqlite1234 (id integer);
SELECT name, sql FROM sqlite_master WHERE sql IS NOT NULL;
CREATE TABLE t0 (c0 INTEGER, PRIMARY KEY(c0)) WITHOUT ROWID;
SELECT sql FROM sqlite_master;
SELECT sql FROM sqlite_master;
SELECT sql FROM sqlite_master;
SELECT * FROM t2;
SELECT * FROM t2;
CREATE TABLE a(a);
CREATE VIEW b AS SELECT(SELECT *FROM c JOIN a USING(d, a, a, a) JOIN a) IN();
CREATE VIEW c AS 
      SELECT NULL INTERSECT 
      SELECT NULL ORDER BY
      likelihood(NULL, (d, (SELECT c)));
BEGIN;
PRAGMA writable_schema=ON;
UPDATE sqlite_schema SET sql='CREATE TABLE t1(a INT, b TEXT)' WHERE name LIKE 't1';
PRAGMA schema_version=1234;
PRAGMA integrity_check;
ALTER TABLE t1 ADD COLUMN c INT DEFAULT 78;
SELECT * FROM t1;
CREATE TABLE gigo(a text);
alter table gigo rename to ggiiggoo;
SELECT sql FROM sqlite_master;
SELECT sql FROM sqlite_master;
CREATE TABLE xx(x);
CREATE VIEW v3(b) AS WITH b AS (SELECT b FROM (SELECT * FROM t2)) VALUES(1);
CREATE TABLE t2_a(k,v);
ALTER TABLE t1 RENAME TO t1x;
INSERT INTO t2_a VALUES(2,3);
SELECT * FROM t1x;
create table t_sa (
 c_muyat INTEGER NOT NULL,
 c_d4u TEXT 
 );
alter table t_sa rename column c_muyat to c_dg;
CREATE TABLE t1(a, b, c);
INSERT INTO t1 VALUES('a', 'b', 'c');
CREATE VIEW v0 AS
    WITH p AS ( SELECT 1 FROM t1 ),
         g AS ( SELECT 1 FROM p, t1 )
    SELECT 1 FROM g;
SELECT * FROM v0;
SELECT sql FROM sqlite_schema WHERE name='v0';
CREATE VIEW v2 AS
    WITH p AS ( SELECT 1 FROM t2 ),
         g AS ( SELECT 1 FROM (
           WITH i AS (SELECT 1 FROM p, t2)
           SELECT * FROM i
         )
    )
    SELECT 1 FROM g;
SELECT * FROM v2;
ALTER TABLE t2 RENAME TO t3;
SELECT sql FROM sqlite_schema WHERE name='v2';
CREATE TABLE t4(b,c);
INSERT INTO t2 VALUES(1,2),(1,3),(2,5);
INSERT INTO t4 VALUES(1,2),(1,3),(2,5);
SELECT * FROM v3;
ALTER TABLE t1 RENAME a TO a2;
ALTER TABLE t2 RENAME TO t5;
SELECT sql FROM sqlite_schema WHERE name='v3';
CREATE TABLE t2(a,b,c);
SELECT sql FROM sqlite_schema ORDER BY rowid;
SELECT * FROM vvv;
