PRAGMA legacy_alter_table = 1;
CREATE TABLE t1(a, b, CHECK(t1.a != t1.b));
CREATE TABLE t2(a, b);
CREATE INDEX t2expr ON t2(a) WHERE t2.b>0;
SELECT sql FROM sqlite_master;
CREATE TABLE t3(c, d);
ALTER TABLE t3 RENAME TO t3new;
DROP TABLE t3new;
SELECT sql FROM sqlite_master;
SELECT sql FROM sqlite_master;
PRAGMA legacy_alter_table = 1;
CREATE TABLE abc(a, b, c);
INSERT INTO abc VALUES(1, 2, 3);
PRAGMA legacy_alter_table = 1;
CREATE TABLE txx(a, b, c);
INSERT INTO txx VALUES(1, 2, 3);
CREATE VIEW vvv AS SELECT main.txx.a, txx.b, c FROM txx;
CREATE VIEW uuu AS SELECT main.one.a, one.b, c FROM txx AS one;
CREATE VIEW temp.ttt AS SELECT main.txx.a, txx.b, one.b, main.one.a FROM txx AS one, txx;
SELECT * FROM vvv;
ALTER TABLE txx RENAME TO "t xx";
SELECT sql FROM sqlite_master WHERE name='vvv';
SELECT sql FROM sqlite_master WHERE name='uuu';
SELECT sql FROM sqlite_temp_master WHERE name='ttt';
PRAGMA legacy_alter_table = 1;
PRAGMA legacy_alter_table = 1;
CREATE TABLE t9(a, b, c);
CREATE TABLE t10(a, b, c);
CREATE TEMP TABLE t9(a, b, c);
INSERT INTO temp.t9 VALUES(1, 2, 3);
SELECT * FROM t10;
ALTER TABLE temp.t9 RENAME TO 't1234567890';
INSERT INTO t1 VALUES(1, 2);
INSERT INTO t2 VALUES(3, 4);
CREATE VIEW v AS SELECT one.a, one.b, t2.a, t2.b FROM t1 AS one, t2;
SELECT * FROM v;
SELECT  *  FROM v;
DROP VIEW v;
CREATE VIEW temp.vv AS SELECT one.a, one.b, t2.a, t2.b FROM t1 AS one, t2;
SELECT * FROM vv;
SELECT  *  FROM vv;
SELECT sql FROM sqlite_master WHERE name = 'x2';
CREATE TABLE ddd(db, sql, zOld, zNew, bTemp);
INSERT INTO ddd VALUES(
        'main', 'CREATE TABLE x1(i INTEGER, t TEXT)', 'ddd', NULL, 0
    ), (
        'main', 'CREATE TABLE x1(i INTEGER, t TEXT)', NULL, 'eee', 0
    ), (
        'main', NULL, 'ddd', 'eee', 0
    );
PRAGMA legacy_alter_table = 1;
ATTACH 'test.db2' AS aux;
PRAGMA foreign_keys = on;
SELECT sql FROM aux.sqlite_master WHERE name = 'c1';
PRAGMA legacy_alter_table = 1;
CREATE VIEW v1 AS SELECT * FROM t2;
DROP VIEW v1;
SELECT sql FROM sqlite_temp_master;
SELECT sql FROM sqlite_master WHERE type='trigger';
PRAGMA legacy_alter_table = 1;
SELECT name, tbl_name FROM sqlite_temp_master;
SELECT name, tbl_name FROM sqlite_temp_master;
SELECT name, tbl_name FROM sqlite_temp_master;
PRAGMA legacy_alter_table = 1;
CREATE TEMP TABLE t2(x);
SELECT * FROM t1;
PRAGMA legacy_alter_table = 1;
CREATE VIEW v1 AS SELECT * FROM t1;