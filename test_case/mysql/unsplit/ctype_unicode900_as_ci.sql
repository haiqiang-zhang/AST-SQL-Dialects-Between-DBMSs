DROP TABLE IF EXISTS t1;
SELECT HEX(WEIGHT_STRING('aA'));
CREATE TABLE t1 (c VARCHAR(10) CHARACTER SET utf8mb4);
INSERT INTO t1 VALUES (_utf8mb4 0xF09090A7), (_utf8mb4 0xEA8B93), (_utf8mb4 0xC4BC), (_utf8mb4 0xC6AD), (_utf8mb4 0xF090918F), (_utf8mb4 0xEAAD8B);
SELECT HEX(ANY_VALUE(c)), COUNT(c) FROM t1 GROUP BY c COLLATE utf8mb4_0900_as_ci;
DROP TABLE t1;
CREATE TABLE t1 (c1 CHAR(10) COLLATE utf8mb4_0900_as_ci);
DROP TABLE t1;
