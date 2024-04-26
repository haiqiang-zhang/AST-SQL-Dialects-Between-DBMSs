
-- source include/force_binlog_format_statement.inc
-- source extra/binlog_tests/ctype_cp932_binlog.test
-- source include/big_test.inc

--disable_query_log
CALL mtr.add_suppression("Unsafe statement written to the binary log using statement format since BINLOG_FORMAT = STATEMENT");

--
-- Bug#18293: Values in stored procedure written to binlog unescaped
--
let $binlog_start= query_get_value(SHOW BINARY LOG STATUS, Position, 1);
CREATE TABLE t4 (s1 CHAR(50) CHARACTER SET latin1,
                 s2 CHAR(50) CHARACTER SET cp932,
                 d DECIMAL(10,2))|
CREATE PROCEDURE bug18293 (IN ins1 CHAR(50),
                           IN ins2 CHAR(50) CHARACTER SET cp932,
                           IN ind DECIMAL(10,2))
  BEGIN
    INSERT INTO t4 VALUES (ins1, ins2, ind);
SELECT HEX(s1),HEX(s2),d FROM t4;
DROP PROCEDURE bug18293;
DROP TABLE t4;
CREATE TABLE t1 (a varchar(16)) character set cp932;
INSERT INTO t1 VALUES (0x8372835E),(0x8352835E);
SELECT hex(a), hex(lower(a)), hex(upper(a)) FROM t1 ORDER BY binary(a);
DROP TABLE t1;
SET NAMES utf8mb3;
SET collation_connection=cp932_japanese_ci;
CREATE TABLE t1 (b VARCHAR(2));
INSERT INTO t1 VALUES ('0'),('1'),('2'),('3'),('4'),('5'),('6'),('7');
INSERT INTO t1 VALUES ('8'),('9'),('A'),('B'),('C'),('D'),('E'),('F');
CREATE TEMPORARY TABLE head AS SELECT concat(b1.b, b2.b) AS head FROM t1 b1, t1 b2;
CREATE TEMPORARY TABLE tail AS SELECT concat(b1.b, b2.b) AS tail FROM t1 b1, t1 b2;
DROP TABLE t1;
CREATE TABLE t1 AS
SELECT concat(head, tail) AS code, ' ' AS a
FROM head, tail
WHERE (head BETWEEN '80' AND 'FF') AND (head NOT BETWEEN 'A1' AND 'DF')
AND (tail BETWEEN '20' AND 'FF')
ORDER BY head, tail;
INSERT t1 (code) SELECT head FROM head
WHERE (head BETWEEN 'A1' AND 'DF')
ORDER BY head;
DROP TEMPORARY TABLE head, tail;

-- Set max_error_count to contain number of warnings in result file.
SET @@session.max_error_count = 64;
UPDATE IGNORE t1 SET a=unhex(code) ORDER BY code;
SET @@session.max_error_count = default;
SELECT COUNT(*) FROM t1;
SELECT COUNT(*) FROM t1 WHERE a<>'' AND OCTET_LENGTH(a)=1;
SELECT COUNT(*) FROM t1 WHERE a<>'' AND OCTET_LENGTH(a)=2;
SELECT code, hex(upper(a)), hex(lower(a)),a, upper(a), lower(a) FROM t1
WHERE hex(a)<>hex(upper(a)) OR hex(a)<>hex(lower(a))
ORDER BY code;
SELECT * FROM t1
WHERE HEX(CAST(LOWER(a) AS CHAR CHARACTER SET utf8mb3)) <>
      HEX(LOWER(CAST(a AS CHAR CHARACTER SET utf8mb3))) ORDER BY code;
SELECT * FROM t1
WHERE HEX(CAST(UPPER(a) AS CHAR CHARACTER SET utf8mb3)) <>
      HEX(UPPER(CAST(a AS CHAR CHARACTER SET utf8mb3))) ORDER BY code;
SELECT HEX(a), HEX(CONVERT(a USING utf8mb3)) as b FROM t1
WHERE a<>'' HAVING b<>'3F' ORDER BY code;

DROP TABLE t1;
SELECT HEX(a), HEX(CONVERT(a using cp932)) as b FROM t1 HAVING b<>'3F' ORDER BY BINARY a;
DROP TABLE t1;

set names cp932;

set collation_connection=cp932_bin;
