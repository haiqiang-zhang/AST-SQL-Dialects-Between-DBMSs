DROP FUNCTION IF EXISTS MY_KILL;
SELECT 1;
SELECT 1;
SELECT @id != CONNECTION_ID();
SELECT 4;
SELECT 1;
SELECT 1;
SELECT @id != CONNECTION_ID();
SELECT 4;
CREATE TABLE t1 (id INT PRIMARY KEY AUTO_INCREMENT);
CREATE TABLE t2 (id INT UNSIGNED NOT NULL);
INSERT INTO t1 VALUES
(0),(0),(0),(0),(0),(0),(0),(0), (0),(0),(0),(0),(0),(0),(0),(0),
(0),(0),(0),(0),(0),(0),(0),(0), (0),(0),(0),(0),(0),(0),(0),(0),
(0),(0),(0),(0),(0),(0),(0),(0), (0),(0),(0),(0),(0),(0),(0),(0),
(0),(0),(0),(0),(0),(0),(0),(0), (0),(0),(0),(0),(0),(0),(0),(0);
INSERT t1 SELECT 0 FROM t1 AS a1, t1 AS a2 LIMIT 4032;
INSERT INTO t2 SELECT id FROM t1;
SELECT 1;
DROP TABLE t1, t2;
SELECT 1;
SELECT @id = CONNECTION_ID();
SELECT 1;
SELECT 1;
SELECT @id != CONNECTION_ID();
CREATE TABLE t1 (col1 INT);
DROP TABLE t1;
