
--
-- Tests with the big5 character set
--
--disable_warnings
drop table if exists t1;

SET @test_character_set= 'big5';
SET @test_collation= 'big5_chinese_ci';

SET NAMES big5;

SET collation_connection='big5_chinese_ci';
SET collation_connection='big5_bin';

--
-- Bugs#9357: TEXT columns break string with special word in BIG5 charset.
--
SET NAMES big5;
CREATE TABLE t1 (a text) character set big5;
INSERT INTO t1 VALUES ('ùØ');
SELECT * FROM t1;
DROP TABLE t1;

--
-- BUG#12075 - FULLTEXT non-functional for big5 strings
--
CREATE TABLE t1 (a CHAR(50) CHARACTER SET big5 NOT NULL, FULLTEXT(a));
INSERT INTO t1 VALUES(0xA741ADCCA66EB6DC20A7DAADCCABDCA66E);
SELECT HEX(a) FROM t1 WHERE MATCH(a) AGAINST (0xA741ADCCA66EB6DC IN BOOLEAN MODE);
DROP TABLE t1;

--
-- Bug#12476 Some big5 codes are still missing.
--
set names big5;
create table t1 (a char character set big5);
insert into t1 values (0xF9D6),(0xF9D7),(0xF9D8),(0xF9D9);
insert into t1 values (0xF9DA),(0xF9DB),(0xF9DC);
select hex(a) a, hex(@u:=convert(a using utf8mb3)) b,
hex(convert(@u using big5)) c from t1 order by a;
alter table t1 convert to character set utf8mb3;
select hex(a) from t1 where a = _big5 0xF9DC;
drop table t1;

--
-- Bugs#15375: Unassigned multibyte codes are broken
-- into parts when converting to Unicode.
-- This query should return 0x003F0041. I.e. it should
-- scan unassigned double-byte character 0xC840, convert
-- it as QUESTION MARK 0x003F and then scan the next
-- character, which is a single byte character 0x41.
--
select hex(convert(_big5 0xC84041 using ucs2));

--
-- Bug#26711 "binary content 0x00 sometimes becomes 0x5C 0x00 after dump/load"
--
set names big5;
create table t1 (a blob);
insert into t1 values (0xEE00);
select * into outfile 'test/t1.txt' from t1;
delete from t1;
let $MYSQLD_DATADIR= `select @@datadir`;
select hex(a) from t1;

drop table t1;
SET NAMES utf8mb3;
SET collation_connection=big5_chinese_ci;
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
let $default_engine = `select @@SESSION.default_storage_engine`;
SELECT COUNT(*) FROM t1;
SET @@session.max_error_count = 64;
UPDATE IGNORE t1 SET a=unhex(code) ORDER BY code;
SET @@session.max_error_count = DEFAULT;
SELECT COUNT(*) FROM t1 WHERE a<>'';
SELECT code, hex(a), hex(upper(a)), hex(lower(a))
FROM t1
WHERE hex(a)<>hex(upper(a)) OR hex(a)<>hex(lower(a));
SELECT code, HEX(a) FROM t1
WHERE HEX(CAST(LOWER(a) AS CHAR CHARACTER SET utf8mb3)) <>
      HEX(LOWER(CAST(a AS CHAR CHARACTER SET utf8mb3))) ORDER BY code;
SELECT code, HEX(a) FROM t1
WHERE HEX(CAST(UPPER(a) AS CHAR CHARACTER SET utf8mb3)) <>
      HEX(UPPER(CAST(a AS CHAR CHARACTER SET utf8mb3))) ORDER BY code;
DROP TABLE t1;

set names big5;

set collation_connection=big5_bin;

SET NAMES big5;
