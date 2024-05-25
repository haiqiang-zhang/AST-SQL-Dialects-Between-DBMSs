drop table if exists t1;
CREATE TABLE t1 (a text) character set gbk;
INSERT INTO t1 VALUES (0xA3A0),(0xA1A1);
SELECT hex(a) FROM t1 ORDER BY a;
DROP TABLE t1;
select hex(convert(_gbk 0xA14041 using ucs2));
create table t1 (c1 text not null, c2 text not null) character set gbk;
alter table t1 change c1 c1 mediumtext  character set gbk not null;
drop table t1;
CREATE TABLE t1(a MEDIUMTEXT CHARACTER SET gbk,
                b MEDIUMTEXT CHARACTER SET big5);
INSERT INTO t1 VALUES
  (REPEAT(0x1125,200000), REPEAT(0x1125,200000)), ('', ''), ('', '');
SELECT a FROM t1 GROUP BY 1 LIMIT 1 INTO @nullll;
SELECT b FROM t1 GROUP BY 1 LIMIT 1 INTO @nullll;
DROP TABLES t1;
CREATE TABLE t1 (b VARCHAR(2));
INSERT INTO t1 VALUES ('0'),('1'),('2'),('3'),('4'),('5'),('6'),('7');
INSERT INTO t1 VALUES ('8'),('9'),('A'),('B'),('C'),('D'),('E'),('F');
CREATE TEMPORARY TABLE head AS SELECT concat(b1.b, b2.b) AS head FROM t1 b1, t1 b2;
CREATE TEMPORARY TABLE tail AS SELECT concat(b1.b, b2.b) AS tail FROM t1 b1, t1 b2;
DROP TABLE t1;
CREATE TABLE t1 AS
SELECT concat(head, tail) AS code, ' ' AS a
FROM head, tail
WHERE (head BETWEEN '80' AND 'FF') AND (tail BETWEEN '20' AND 'FF')
ORDER BY head, tail;
DROP TEMPORARY TABLE head, tail;
UPDATE IGNORE t1 SET a=unhex(code) ORDER BY code;
SELECT COUNT(*) FROM t1 WHERE a<>'';
SELECT code, hex(upper(a)), hex(lower(a)),a, upper(a), lower(a) FROM t1 WHERE hex(a)<>hex(upper(a)) OR hex(a)<>hex(lower(a));
SELECT * FROM t1
WHERE HEX(CAST(LOWER(a) AS CHAR CHARACTER SET utf8mb3)) <>
      HEX(LOWER(CAST(a AS CHAR CHARACTER SET utf8mb3))) ORDER BY code;
SELECT * FROM t1
WHERE HEX(CAST(UPPER(a) AS CHAR CHARACTER SET utf8mb3)) <>
      HEX(UPPER(CAST(a AS CHAR CHARACTER SET utf8mb3))) ORDER BY code;
DROP TABLE t1;
