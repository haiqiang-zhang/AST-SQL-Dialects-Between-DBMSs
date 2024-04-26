CREATE TABLE t1 (i INTEGER, a VARCHAR(10) COLLATE utf8mb3_phone_ci) COLLATE utf8mb3_phone_ci;
CREATE TABLE t2 (i INTEGER, a VARCHAR(10) COLLATE utf8mb3_phone_ci) COLLATE utf8mb3_phone_ci;
SET @@global.log_error_verbosity = 1;
ALTER TABLE t1 ADD COLUMN (j INTEGER);
SELECT * FROM t1;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
DROP TABLE t2;

CREATE TABLE t1 (a CHAR(1)) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE TABLE t2 (a CHAR(1)) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE FUNCTION f1 (a CHAR(1)) RETURNS CHAR(1) CHARSET utf8mb4 RETURN a;
CREATE VIEW v1 AS SELECT f1(a) AS a FROM t1;
CREATE VIEW v2 AS SELECT 1 FROM v1 JOIN t2 WHERE v1.a = t2.a;

SET @@session.default_collation_for_utf8mb4 = utf8mb4_general_ci;
DROP TABLE t1, t2;
DROP VIEW v1, v2;
DROP FUNCTION f1;
