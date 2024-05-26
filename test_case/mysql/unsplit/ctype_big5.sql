drop table if exists t1;
CREATE TABLE t1 (a text) character set big5;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a CHAR(50) CHARACTER SET big5 NOT NULL, FULLTEXT(a));
INSERT INTO t1 VALUES(0xA741ADCCA66EB6DC20A7DAADCCABDCA66E);
SELECT HEX(a) FROM t1 WHERE MATCH(a) AGAINST (0xA741ADCCA66EB6DC IN BOOLEAN MODE);
DROP TABLE t1;
create table t1 (a char character set big5);
insert into t1 values (0xF9D6),(0xF9D7),(0xF9D8),(0xF9D9);
insert into t1 values (0xF9DA),(0xF9DB),(0xF9DC);
select hex(a) a, hex(@u:=convert(a using utf8mb3)) b,
hex(convert(@u using big5)) c from t1 order by a;
alter table t1 convert to character set utf8mb3;
select hex(a) from t1 where a = _big5 0xF9DC;
drop table t1;
create table t1 (a blob);
insert into t1 values (0xEE00);
delete from t1;
drop table t1;
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
SELECT COUNT(*) FROM t1;
UPDATE IGNORE t1 SET a=unhex(code) ORDER BY code;
DROP TABLE t1;
