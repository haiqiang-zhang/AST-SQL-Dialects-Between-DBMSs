SELECT HEX(c1) FROM t1;
CREATE TABLE t2 SELECT CONVERT(c1 USING ucs2) AS c1 FROM t1;
SELECT HEX(c1) FROM t2;
CREATE TABLE t3 SELECT CONVERT(c1 USING eucjpms) AS c1 FROM t2;
SELECT HEX(c1) FROM t3;
CREATE TABLE t4 SELECT CONVERT(c1 USING cp932) AS c1 FROM t1;
SELECT HEX(c1) FROM t4;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
CREATE TABLE t1(c1 varchar(10)) default character set = eucjpms;
insert into t1 values(_ucs2 0x00F7);
insert into t1 values(_eucjpms 0xA1E0);
insert into t1 values(_ujis 0xA1E0);
insert into t1 values(_sjis 0x8180);
insert into t1 values(_cp932 0x8180);
SELECT HEX(c1) FROM t1;
DROP TABLE t1;
select hex(convert(_eucjpms 0xA5FE41 using ucs2));
select hex(convert(_eucjpms 0x8FABF841 using ucs2));
CREATE TABLE t1 (b VARCHAR(2));
INSERT INTO t1 VALUES ('0'),('1'),('2'),('3'),('4'),('5'),('6'),('7');
INSERT INTO t1 VALUES ('8'),('9'),('A'),('B'),('C'),('D'),('E'),('F');
CREATE TEMPORARY TABLE head AS SELECT concat(b1.b, b2.b) AS head FROM t1 b1, t1 b2;
CREATE TEMPORARY TABLE tail AS SELECT concat(b1.b, b2.b) AS tail FROM t1 b1, t1 b2;
DROP TABLE t1;
CREATE TABLE t1 AS SELECT 'XXXXXX' AS code, ' ' AS a LIMIT 0;
INSERT INTO t1 (code) SELECT concat('8E', head) FROM head
WHERE (head BETWEEN 'A1' AND 'DF') ORDER BY head;
INSERT INTO t1 (code) SELECT concat(head, tail)
FROM head, tail
WHERE (head BETWEEN '80' AND 'FF') AND (head NOT BETWEEN '8E' AND '8F')
AND (tail BETWEEN '20' AND 'FF')
ORDER BY head, tail;
INSERT INTO t1 (code) SELECT concat('8F', head, tail)
FROM head, tail
WHERE (head BETWEEN '80' AND 'FF') AND (tail BETWEEN '20' AND 'FF')
ORDER BY head, tail;
DROP TEMPORARY TABLE head, tail;
UPDATE IGNORE t1 SET a=unhex(code) ORDER BY code;
SELECT COUNT(*) FROM t1;
SELECT COUNT(*) FROM t1 WHERE a<>'';
SELECT COUNT(*) FROM t1 WHERE a<>'' AND OCTET_LENGTH(a)=2;
SELECT * FROM t1 WHERE CHAR_LENGTH(a)=2;
SELECT COUNT(*) FROM t1 WHERE a<>'' AND OCTET_LENGTH(a)=3;
SELECT code, hex(upper(a)), hex(lower(a)),a, upper(a), lower(a) FROM t1 WHERE hex(a)<>hex(upper(a)) OR hex(a)<>hex(lower(a)) ORDER BY code;
SELECT * FROM t1
WHERE HEX(CAST(LOWER(a) AS CHAR CHARACTER SET utf8mb3)) <>
      HEX(LOWER(CAST(a AS CHAR CHARACTER SET utf8mb3))) ORDER BY code;
SELECT * FROM t1
WHERE HEX(CAST(UPPER(a) AS CHAR CHARACTER SET utf8mb3)) <>
      HEX(UPPER(CAST(a AS CHAR CHARACTER SET utf8mb3))) ORDER BY code;
SELECT HEX(a), HEX(CONVERT(a USING utf8mb3)) as b FROM t1
WHERE a<>'' HAVING b<>'3F' ORDER BY code;
DROP TABLE t1;
