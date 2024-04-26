--                                                                             #
-- WL7167- Change DDL to update rows for view columns in DD.COLUMNS and other  #
--         dependent values.                                                   #
--                                                                             #
--         Test cases to verify storing view column information in DD.COLUMNS  #
--         table and update view column information and other values on DDL    #
--         operations.                                                         #
--                                                                             #
--##############################################################################

CREATE FUNCTION sf1() RETURNS INT return 0;
CREATE TABLE t1 (f1 INT);
CREATE TABLE t2 (f2 INT);
CREATE TABLE t3 (f3 INT);
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM t2;
SET @view='v2';
CREATE VIEW v3 AS SELECT * FROM v2, t3;
SET @view='v3';
CREATE VIEW v4 AS SELECT sf1() AS sf;
SET @view='v4';
create view v5 as select * from v4;
SET @view='v5';
ALTER TABLE t1 ADD f2 INT;
SET @view='v1';
ALTER TABLE t1 CHANGE f1 f1 CHAR(100);
SET @view='v1';
ALTER TABLE t2 CHANGE f2 f2 CHAR(100);
SET @view='v2';
SET @view='v3';
SET @view='v1';
ALTER TABLE t1 DROP f1;
SET @view='v1';
ALTER TABLE t2 ADD f1 DATETIME;
ALTER TABLE t2 DROP f1;
SET @view='v1';
ALTER TABLE t1 ADD f1 int;
ALTER TABLE t2 CHANGE f2 f5 int;
SET @view='v2';
SET @view='v3';
ALTER TABLE t2 CHANGE f5 f2 int;
SET @view='v2';
SET @view='v3';
DROP TABLE t2;
SET @view='v2';
SET @view='v3';
CREATE TABLE t2(f4 int);
SET @view='v2';
SET @view='v3';
DROP TABLE t2;
CREATE TABLE t2(f2 int);
SET @view='v2';
SET @view='v3';
SET @view='v2';
SET @view='v3';

CREATE VIEW vw AS SELECT * FROM t5;
SET @view='vw';
SET @view='v2';
SET @view='v3';
SET @view='vw';
DROP VIEW vw;
ALTER TABLE t2 RENAME t5;
SET @view='v2';
SET @view='v3';

CREATE VIEW vw AS SELECT * FROM t5;
SET @view='vw';
ALTER TABLE t5 RENAME t2;
SET @view='v2';
SET @view='v3';
SET @view='vw';
DROP VIEW vw;
DROP FUNCTION sf1;
SET @view='v4';
SET @view='v5';
CREATE FUNCTION sf1() RETURNS INT return 0;
SET @view='v4';
SET @view='v5';
SET @view='v3';
DROP VIEW v2;
CREATE VIEW v2 AS SELECT * FROM t2;
SET @view='v3';
SELECT table_schema, table_name, is_updatable FROM information_schema.views
  WHERE table_name='v2';

ALTER VIEW v2 AS SELECT * FROM t2 GROUP BY(f2);
CREATE VIEW vw AS SELECT * FROM v2;
SELECT table_schema, table_name, is_updatable FROM information_schema.views
  WHERE table_name='v2' OR table_name='vw';
ALTER VIEW v2 AS SELECT * FROM t2;
SELECT table_schema, table_name, is_updatable FROM information_schema.views
  WHERE table_name='v2' OR table_name='vw';
DROP VIEW vw;
ALTER TABLE t1 ADD f3 INT;
SET @view='v1';
SET @view='v1';
ALTER TABLE t1 CHANGE f1 f1 INT;
SET @view='v2';
SET @view='v3';
ALTER TABLE t2 CHANGE f2 f2 INT;
SET @view='v2';
SET @view='v3';
SET @view='v1';
ALTER TABLE t1 DROP f1;
SET @view='v1';
ALTER TABLE t1 ADD f1 int;
ALTER TABLE t2 CHANGE f2 f5 int;
SET @view='v2';
SET @view='v3';
ALTER TABLE t2 CHANGE f5 f2 int;
SET @view='v2';
SET @view='v3';
DROP TABLE t2;
SET @view='v2';
SET @view='v3';

-- Cleanup
DROP VIEW v1,v2,v3,v4,v5;
DROP TABLES t1,t3;
DROP FUNCTION sf1;

CREATE TABLE t1 (f1 DATETIME default '2016-11-01');

CREATE FUNCTION f1() RETURNS INT return 1;
CREATE FUNCTION f2() RETURNS INT return 2;

CREATE VIEW v2 AS SELECT f2() AS f2;
CREATE VIEW v1 AS SELECT v2.f2 AS f2,
                         a3.x as f3 from v2,
                  (SELECT a.x FROM (SELECT f1() AS x)
                          as a HAVING a.x=1) as a3;
CREATE VIEW z1 AS SELECT t1.f1 AS f1, v2.f2 AS f2 FROM t1, v2;
DROP FUNCTION f1;
DROP FUNCTION f2;
CREATE FUNCTION f2() RETURNS INT return 2;

-- Cleanup
DROP FUNCTION f2;
DROP VIEW v1, v2, z1;
DROP TABLE t1;
CREATE TABLE t1 (i INT);
CREATE VIEW v1 AS SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT 1 AS i;
DROP TABLE t1;
DROP VIEW v1;
CREATE TABLE t1(f1 LONGTEXT);
CREATE TABLE t2 (f2 INT);
CREATE FUNCTION func(param LONGTEXT) RETURNS LONGTEXT RETURN param;
CREATE VIEW v1 AS SELECT f2 FROM t2;
CREATE VIEW v2 AS SELECT func(f1), f2
                         FROM t1 AS stmt
                         JOIN v1 AS tab1;

SELECT table_name, view_definition FROM information_schema.views
                                   WHERE table_name='v2';
ALTER TABLE t2 MODIFY f2 LONGTEXT;
SELECT table_name, view_definition FROM information_schema.views
                                   WHERE table_name='v2';

-- Cleanup
DROP TABLE t1, t2;
DROP VIEW v1, v2;
DROP FUNCTION func;
