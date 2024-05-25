PREPARE check_view_columns FROM
  'SELECT table_name, column_name, column_type FROM information_schema.columns
   WHERE table_name= ? ORDER BY table_name, column_name';
PREPARE check_view_status FROM
  'SELECT table_name, table_comment FROM information_schema.tables WHERE
   table_name= ?';
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM t2;
CREATE VIEW v3 AS SELECT * FROM v2, t3;
ALTER TABLE t1 ADD f2 INT;
ALTER TABLE t1 CHANGE f1 f1 CHAR(100);
ALTER TABLE t2 CHANGE f2 f2 CHAR(100);
ALTER TABLE t1 DROP f1;
ALTER TABLE t2 ADD f1 DATETIME;
ALTER TABLE t2 DROP f1;
ALTER TABLE t1 ADD f1 int;
ALTER TABLE t2 CHANGE f2 f5 int;
ALTER TABLE t2 CHANGE f5 f2 int;
DROP TABLE t2;
CREATE TABLE t2(f4 int);
DROP TABLE t2;
CREATE TABLE t2(f2 int);
ALTER TABLE t2 RENAME t5;
CREATE VIEW vw AS SELECT * FROM t5;
ALTER TABLE t5 RENAME t2;
DROP VIEW vw;
DROP VIEW v2;
CREATE VIEW v2 AS SELECT * FROM t2;
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
LOCK TABLE t1 WRITE;
ALTER TABLE t1 ADD f3 INT;
UNLOCK TABLES;
LOCK TABLE t1 WRITE;
ALTER TABLE t1 CHANGE f1 f1 INT;
UNLOCK TABLES;
LOCK TABLE t2 WRITE;
ALTER TABLE t2 CHANGE f2 f2 INT;
UNLOCK TABLES;
LOCK TABLE t1 WRITE;
ALTER TABLE t1 DROP f1;
UNLOCK TABLES;
LOCK TABLE t1 WRITE;
ALTER TABLE t1 ADD f1 int;
UNLOCK TABLES;
LOCK TABLE t2 WRITE;
ALTER TABLE t2 CHANGE f2 f5 int;
UNLOCK TABLES;
LOCK TABLE t2 WRITE;
ALTER TABLE t2 CHANGE f5 f2 int;
UNLOCK TABLES;
LOCK TABLE t2 WRITE;
DROP TABLE t2;
UNLOCK TABLES;
DROP TABLES t1,t3;
DEALLOCATE PREPARE check_view_columns;
DEALLOCATE PREPARE check_view_status;
CREATE TABLE t1 (f1 DATETIME default '2016-11-01');
DROP TABLE t1;
CREATE TABLE t1 (i INT);
DROP TABLE t1;
CREATE TABLE t1 ENGINE=InnoDB SELECT 1 AS i;
DROP TABLE t1;
DROP VIEW v1;
CREATE TABLE t1(f1 LONGTEXT);
CREATE TABLE t2 (f2 INT);
CREATE VIEW v1 AS SELECT f2 FROM t2;
SELECT table_name, view_definition FROM information_schema.views
                                   WHERE table_name='v2';
ALTER TABLE t2 MODIFY f2 LONGTEXT;
SELECT table_name, view_definition FROM information_schema.views
                                   WHERE table_name='v2';
DROP TABLE t1, t2;
DROP VIEW v1, v2;
