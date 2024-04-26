SELECT _filename'abcd';
SELECT CONVERT(_latin1'abcd' USING filename);
SELECT CAST(_latin1'abcd' AS CHAR CHARACTER SET filename);
SET NAMES 'filename';
SET NAMES 'utf8mb3';
SET CHARACTER_SET_CLIENT=17;
SET CHARACTER_SET_CLIENT=33;
DROP DATABASE IF EXISTS db21958734;
CREATE DATABASE db21958734 CHARACTER SET filename;
CREATE DATABASE db21958734 COLLATE filename;
CREATE DATABASE db21958734 CHARACTER SET utf8mb3;
ALTER DATABASE db21958734 CHARACTER SET filename;
ALTER DATABASE db21958734 COLLATE filename;
ALTER DATABASE db21958734 CHARACTER SET latin1;
USE db21958734;
CREATE TABLE t1(a VARCHAR(10)) CHARACTER SET filename;
CREATE TABLE t1(a VARCHAR(10)) COLLATE filename;
CREATE TABLE t1(a VARCHAR(10) CHARACTER SET filename);
CREATE TABLE t1(a VARCHAR(10) COLLATE filename);
CREATE TABLE t1(a VARCHAR(10) CHARACTER SET utf8mb3) CHARACTER SET latin1;
ALTER TABLE t1 CHARACTER SET filename;
ALTER TABLE t1 COLLATE filename;
ALTER TABLE t1 CHARACTER SET gbk;
ALTER TABLE t1 MODIFY a VARCHAR(10) CHARACTER SET filename;
ALTER TABLE t1 MODIFY a VARCHAR(10) COLLATE filename;
ALTER TABLE t1 MODIFY a VARCHAR(10) CHARACTER SET cp932;
DROP DATABASE db21958734;

USE test;
SET NAMES utf8mb4;
SELECT 'x' AS '🐬';
SELECT '🐬';
CREATE TABLE 🐬(a INT);
CREATE TABLE t1(🐬 INT);
CREATE TABLE t2(a INT COMMENT "🐬");
CREATE TABLE t3(a INT);
CREATE VIEW v1 AS SELECT 'x' AS'🐬';
DROP TABLE 🐬;
DROP TABLE t1, t2, t3;

SET NAMES utf8mb3;
SELECT 'x' AS '🐬';
SELECT '🐬';
CREATE TABLE 🐬(a INT);
CREATE TABLE t1(🐬 INT);
CREATE TABLE t2(a INT COMMENT "🐬");
CREATE TABLE t3(a INT);
CREATE VIEW v1 AS SELECT 'x' AS'🐬';
DROP TABLE t3;

SET NAMES default;

CREATE TABLE t1 (f1 CHAR(20) COLLATE binary);
DROP TABLE t1;

CREATE TABLE t1 (f1 ENUM('a') COLLATE binary);
DROP TABLE t1;

-- Test the DDL from bug page.
CREATE TABLE t1 (
  `id` int NOT NULL AUTO_INCREMENT,
  `etype` enum('a','b','c') CHARACTER SET binary COLLATE binary DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
DROP TABLE t1;

SELECT member_role
FROM performance_schema.replication_group_members
WHERE member_host = @@hostname AND member_role='PRIMARY';
set @old_collation = @@collation_connection;

CREATE TABLE t1 ( id INT UNSIGNED PRIMARY KEY NOT NULL,
                    val varchar(32) NOT NULL) collate utf8mb4_sv_0900_ai_ci;
SET session collation_connection = 'utf8mb4_sv_0900_ai_ci';
CREATE VIEW v1 AS SELECT * FROM t1 WHERE val = 'data';
CREATE VIEW v2 AS SELECT * FROM t1 WHERE val IN ('data') ;
SELECT * FROM v1 WHERE val = 'something';
SELECT * FROM v2 WHERE val = 'something';
SET session collation_connection = 'utf8mb4_general_ci';
SELECT * FROM v1 WHERE val = 'something';
SELECT * FROM v2 WHERE val = 'something';

-- Cleanup and restore
DROP VIEW v1;
DROP VIEW v2;
DROP TABLE t1;
SET session collation_connection = @old_collation;
