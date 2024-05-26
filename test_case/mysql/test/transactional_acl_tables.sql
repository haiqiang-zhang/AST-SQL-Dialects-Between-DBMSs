SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE PROCEDURE p1() SET PASSWORD FOR u1@h = '12345';
DROP PROCEDURE p1;
CREATE TABLE t1(a INT, b INT);
DROP TABLE t1;
CREATE SCHEMA test1;
CREATE TABLE test1.t1 (a INT);
DROP SCHEMA test1;
CREATE PROCEDURE p1() SET @a :=1;
DROP PROCEDURE p1;
CREATE TABLE t1(a INT);
DROP TABLE t1;
CREATE PROCEDURE p() SET @x = 1;
CREATE PROCEDURE p1() SET @y = 1;
CREATE TABLE t1(a INT);
DROP TABLE t1;
DROP PROCEDURE p;
DROP PROCEDURE p1;
CREATE TABLE t1(a INT);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT);
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
CREATE PROCEDURE p() SET @x = 1;
DROP PROCEDURE p;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
SELECT table_name, engine FROM INFORMATION_SCHEMA.TABLES
WHERE table_schema = 'mysql' AND
      table_name IN ('user', 'db', 'columns_priv', 'procs_priv',
                     'proxies_priv', 'tables_priv')
ORDER BY table_name;
SELECT table_name, engine FROM INFORMATION_SCHEMA.TABLES
WHERE table_schema = 'mysql' AND
      table_name IN ('user', 'db', 'columns_priv', 'procs_priv',
                     'proxies_priv', 'tables_priv')
ORDER BY table_name;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
