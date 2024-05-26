CREATE TABLE t1(a, b, c);
ATTACH 'test.db2' AS aux;
PRAGMA table_info = t1;
PRAGMA table_info = t2;
DROP TABLE t1;
DROP TABLE t2;
PRAGMA table_info(t1);
PRAGMA table_info(t2);
CREATE TABLE t1(a, b, c);
CREATE TABLE aux.t2(d, e, f);
SELECT * FROM pragma_table_info('t1');
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1(a, b, c);
CREATE INDEX i1 ON t1(b);
CREATE TABLE aux.t2(d, e, f);
CREATE INDEX aux.i2 ON t2(e);
SELECT * FROM pragma_index_info('i1');
DROP INDEX i1;
DROP INDEX i2;
SELECT * FROM main.sqlite_master, aux.sqlite_master;
CREATE INDEX main.i1 ON t1(b, c);
CREATE INDEX aux.i2 ON t2(e, f);
SELECT * FROM pragma_index_list('t1');
DROP INDEX i1;
DROP INDEX i2;
SELECT * FROM main.sqlite_master, aux.sqlite_master;
CREATE UNIQUE INDEX main.i1 ON t1(a);
CREATE UNIQUE INDEX aux.i2 ON t2(d);
CREATE TABLE main.c1 (a, b, c REFERENCES t1(a));
SELECT * FROM pragma_foreign_key_list('c1');
DROP TABLE c1;
DROP TABLE c2;
SELECT * FROM main.sqlite_master, aux.sqlite_master;
CREATE TABLE main.c1 (a, b, c REFERENCES t1(a));
CREATE TABLE aux.c2 (d, e, r REFERENCES t2(d));
INSERT INTO main.c1 VALUES(1, 2, 3);
INSERT INTO aux.c2 VALUES(4, 5, 6);
pragma foreign_key_check('c1');
pragma foreign_key_check('c2');
DROP TABLE c2;
pragma foreign_key_check('c1');
CREATE TABLE t4(a DEFAULT 'abc' /* comment */, b DEFAULT -1 -- comment
     , c DEFAULT +4.0 /* another comment */
  );
PRAGMA table_info = t4;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1(a INT PRIMARY KEY, b INT);
CREATE TABLE t2(c INT PRIMARY KEY, d INT REFERENCES t1);
SELECT t.name, f."table", f."from", i.name, i.pk
      FROM pragma_table_list() AS t
           JOIN pragma_foreign_key_list(t.name, t.schema) AS f
           JOIN pragma_table_info(f."table", t.schema) AS i
     WHERE i.pk;
