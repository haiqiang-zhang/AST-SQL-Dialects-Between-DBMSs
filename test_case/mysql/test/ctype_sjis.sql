select 'a' like 'a';
select 'A' like 'a';
select hex(@utf81);
create table t1 (a char(10) character set sjis);
insert into t1 values (0x878A);
drop table t1;
create table t1(c enum(0x9353,0x9373) character set sjis);
insert into t1 values (0x9353);
insert into t1 values (0x9373);
drop table t1;
CREATE TABLE t1 (
 c char(16) default NULL
) DEFAULT CHARSET=sjis;
insert into t1 values(0xb1),(0xb2),(0xb3);
drop table t1;
CREATE TABLE t1 (a varchar(16)) character set sjis;
INSERT INTO t1 VALUES (0x8372835E),(0x8352835E);
SELECT hex(a), hex(lower(a)), hex(upper(a)) FROM t1 ORDER BY binary(a);
DROP TABLE t1;
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
AND   (tail BETWEEN '20' AND 'FF')
ORDER BY head, tail;
INSERT t1 (code) SELECT head FROM head WHERE (head BETWEEN 'A1' AND 'DF');
DROP TEMPORARY TABLE head, tail;
UPDATE IGNORE t1 SET a=unhex(code) ORDER BY code;
SELECT COUNT(*) FROM t1;
SELECT code, hex(upper(a)), hex(lower(a)),a, upper(a), lower(a)
FROM t1
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
