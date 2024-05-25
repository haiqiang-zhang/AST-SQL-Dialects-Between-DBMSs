DROP DATABASE IF EXISTS db21958734;
CREATE DATABASE db21958734 CHARACTER SET utf8mb3;
ALTER DATABASE db21958734 CHARACTER SET latin1;
CREATE TABLE t1(a VARCHAR(10) CHARACTER SET utf8mb3) CHARACTER SET latin1;
ALTER TABLE t1 CHARACTER SET gbk;
ALTER TABLE t1 MODIFY a VARCHAR(10) CHARACTER SET cp932;
DROP DATABASE db21958734;
SELECT 'x' AS 'ÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¬';
SELECT 'ÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¬';
CREATE TABLE t2(a INT COMMENT "ÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¬");
CREATE TABLE t3(a INT);
CREATE VIEW v1 AS SELECT 'x' AS'ÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¬';
DROP TABLE t1, t2, t3;
PREPARE stmt FROM "SELECT 'x' AS 'ÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¬'";
SELECT 'x' AS 'ÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¬';
SELECT 'ÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¬';
CREATE TABLE t1(ÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¬ INT);
CREATE TABLE t2(a INT COMMENT "ÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¬");
CREATE TABLE t3(a INT);
DROP TABLE t3;
PREPARE stmt FROM "SELECT 'x' AS 'ÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¬'";
DROP TABLE t1;
CREATE TABLE t1 (f1 ENUM('a') COLLATE binary);
DROP TABLE t1;
CREATE TABLE t1 (
  `id` int NOT NULL AUTO_INCREMENT,
  `etype` enum('a','b','c') CHARACTER SET binary COLLATE binary DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
DROP TABLE t1;
CREATE TABLE t1 ( id INT UNSIGNED PRIMARY KEY NOT NULL,
                    val varchar(32) NOT NULL) collate utf8mb4_sv_0900_ai_ci;
CREATE VIEW v2 AS SELECT * FROM t1 WHERE val IN ('data');
SELECT * FROM v2 WHERE val = 'something';
SELECT * FROM v2 WHERE val = 'something';
DROP VIEW v1;
DROP VIEW v2;
DROP TABLE t1;
