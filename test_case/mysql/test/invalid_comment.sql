--# This file contains BINARY DATA.
--# EDIT WITH CARE USING AN APPROPRIATE TOOL.

--echo --
--echo -- Bug#33148961 FAILURE TO UPGRADE FROM 5.7, INVALID utf8mb3 CHARACTER STRING
--echo --
--echo -- Test for invalid comment strings when creating table, field, index,
--echo -- partition, subpartition, tablespace, procedure, function, event.
--echo --

-- Set the client charset equal to the system charset. This is done to avoid the
-- conversion of string literals by the parser when the charset differs.
SET NAMES utf8mb3;

-- To allow testing of invalid binary data in the comment strings
--character_set binary

--echo
--echo -- Test CREATE statements with invalid comments.

--echo
--error ER_COMMENT_CONTAINS_INVALID_STRING
CREATE TABLE t1 (a int) COMMENT 'tab🐬';
CREATE TABLE t2 (a int COMMENT 'col🐬');
CREATE TABLE t3 (a int, INDEX idx1(a) COMMENT 'idx🐬');
CREATE TABLE t4 (a int) PARTITION BY RANGE (a) (PARTITION p1 VALUES LESS THAN (0) COMMENT 'part🐬');
CREATE TABLE t5 (a int) PARTITION BY RANGE (a) SUBPARTITION BY HASH(a) SUBPARTITIONS 1 (PARTITION p1 VALUES LESS THAN (0)(SUBPARTITION sp1 COMMENT 'subpart🐬'));
CREATE VIEW v1 AS SELECT 'view🐬';
CREATE PROCEDURE sp1() COMMENT 'proc🐬' BEGIN END;
CREATE FUNCTION sf1() RETURNS INT DETERMINISTIC COMMENT 'func🐬' RETURN 0;
CREATE EVENT evt1 ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR COMMENT 'evt🐬' DO SELECT 0;
CREATE TABLE t1 (a int);
ALTER TABLE t1 COMMENT 'tab🐬';
ALTER TABLE t1 MODIFY a int COMMENT 'col🐬';
ALTER TABLE t1 ADD b int COMMENT 'col🐬';
ALTER TABLE t1 ADD INDEX idx1(a) COMMENT 'idx🐬';
ALTER TABLE t1 PARTITION BY RANGE (a) (PARTITION p1 VALUES LESS THAN (0) COMMENT 'part🐬');
ALTER TABLE t1 PARTITION BY RANGE (a) SUBPARTITION BY HASH(a) SUBPARTITIONS 1 (PARTITION p1 VALUES LESS THAN (0)(SUBPARTITION sp1 COMMENT 'subpart🐬'));
DROP TABLE t1;
CREATE VIEW v1 AS SELECT 0;
ALTER VIEW v1 AS SELECT 'view🐬';
DROP VIEW v1;
CREATE PROCEDURE sp1() BEGIN END;
ALTER PROCEDURE sp1 COMMENT 'proc🐬';
DROP PROCEDURE sp1;
CREATE FUNCTION sf1() RETURNS INT DETERMINISTIC RETURN 0;
ALTER FUNCTION sf1 COMMENT 'func🐬';
DROP FUNCTION sf1;
CREATE EVENT evt1 ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR DO SELECT 0;
ALTER EVENT evt1 COMMENT 'evt🐬';
DROP EVENT evt1;
CREATE TABLESPACE ts1 ADD DATAFILE 'df1.ibd' COMMENT 'ts🐬';
CREATE PROCEDURE p1() BEGIN /* 'SP body comment: 🐬' */ END;
CREATE FUNCTION f1() RETURNS INT DETERMINISTIC RETURN /* 'SF body comment: 🐬' */ 0;
SET NAMES DEFAULT;
