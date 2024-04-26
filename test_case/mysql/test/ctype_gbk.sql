
--
-- Tests with the gbk character set
--
--disable_warnings
drop table if exists t1;

SET @test_character_set= 'gbk';
SET @test_collation= 'gbk_chinese_ci';

SET NAMES gbk;
SET collation_connection='gbk_chinese_ci';
SET collation_connection='gbk_bin';

--
-- Bug#11987 mysql will truncate the text when
-- the text contain GBK char:"0xA3A0" and "0xA1"
--
SET NAMES gbk;
CREATE TABLE t1 (a text) character set gbk;
INSERT INTO t1 VALUES (0xA3A0),(0xA1A1);
SELECT hex(a) FROM t1 ORDER BY a;
DROP TABLE t1;

--
-- Bugs#15375: Unassigned multibyte codes are broken
-- into parts when converting to Unicode.
-- This query should return 0x003F0041. I.e. it should
-- scan unassigned double-byte character 0xA140, convert
-- it as QUESTION MARK 0x003F and then scan the next
-- character, which is a single byte character 0x41.
--
select hex(convert(_gbk 0xA14041 using ucs2));

-- End of 4.1 tests

--
-- Bug#21620 ALTER TABLE affects other columns
--
create table t1 (c1 text not null, c2 text not null) character set gbk;
alter table t1 change c1 c1 mediumtext  character set gbk not null;
let $default_engine = `select @@SESSION.default_storage_engine`;
drop table t1;

--
-- Bug#35993: severe memory corruption and crash with multibyte conversion
--

CREATE TABLE t1(a MEDIUMTEXT CHARACTER SET gbk,
                b MEDIUMTEXT CHARACTER SET big5);
INSERT INTO t1 VALUES
  (REPEAT(0x1125,200000), REPEAT(0x1125,200000)), ('', ''), ('', '');

SELECT a FROM t1 GROUP BY 1 LIMIT 1 INTO @nullll;
SELECT b FROM t1 GROUP BY 1 LIMIT 1 INTO @nullll;

DROP TABLES t1;
SET NAMES utf8mb3;
SET collation_connection=gbk_chinese_ci;
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
SET @@session.max_error_count = 64;
UPDATE IGNORE t1 SET a=unhex(code) ORDER BY code;
SET @@session.max_error_count = DEFAULT;
SELECT COUNT(*) FROM t1 WHERE a<>'';
SELECT code, hex(upper(a)), hex(lower(a)),a, upper(a), lower(a) FROM t1 WHERE hex(a)<>hex(upper(a)) OR hex(a)<>hex(lower(a));
SELECT * FROM t1
WHERE HEX(CAST(LOWER(a) AS CHAR CHARACTER SET utf8mb3)) <>
      HEX(LOWER(CAST(a AS CHAR CHARACTER SET utf8mb3))) ORDER BY code;
--       U+00E0 LATIN SMALL LETTER A WITH GRAVE
--       U+00E1 LATIN SMALL LETTER A WITH ACUTE
--       U+00E8 LATIN SMALL LETTER E WITH GRAVE
--       U+00E9 LATIN SMALL LETTER E WITH ACUTE
--       U+00EA LATIN SMALL LETTER E WITH CIRCUMFLEX
--       U+00EC LATIN SMALL LETTER I WITH GRAVE
--       U+00ED LATIN SMALL LETTER I WITH ACUTE
--       U+00F2 LATIN SMALL LETTER O WITH GRAVE
--       U+00F3 LATIN SMALL LETTER O WITH ACUTE
--       U+00F9 LATIN SMALL LETTER U WITH GRAVE
--       U+00FA LATIN SMALL LETTER U WITH ACUTE
--       U+00FC LATIN SMALL LETTER U WITH DIAERESIS
--       U+0101 LATIN SMALL LETTER A WITH MACRON
--       U+0113 LATIN SMALL LETTER E WITH MACRON
--       U+011B LATIN SMALL LETTER E WITH CARON
--       U+012B LATIN SMALL LETTER I WITH MACRON
--       U+0144 LATIN SMALL LETTER N WITH ACUTE
--       U+0148 LATIN SMALL LETTER N WITH CARON
--       U+014D LATIN SMALL LETTER O WITH MACRON
--       U+016B LATIN SMALL LETTER U WITH MACRON
--       U+01CE LATIN SMALL LETTER A WITH CARON
--       U+01D0 LATIN SMALL LETTER I WITH CARON
--       U+01D2 LATIN SMALL LETTER O WITH CARON
--       U+01D4 LATIN SMALL LETTER U WITH CARON
--       U+01D6 LATIN SMALL LETTER U WITH DIAERESIS AND MACRON
--       U+01D8 LATIN SMALL LETTER U WITH DIAERESIS AND ACUTE
--       U+01DA LATIN SMALL LETTER U WITH DIAERESIS AND CARON
--       U+01DC LATIN SMALL LETTER U WITH DIAERESIS AND GRAVE
--
SELECT * FROM t1
WHERE HEX(CAST(UPPER(a) AS CHAR CHARACTER SET utf8mb3)) <>
      HEX(UPPER(CAST(a AS CHAR CHARACTER SET utf8mb3))) ORDER BY code;

DROP TABLE t1;




--echo --
--echo -- End of 5.5 tests
--echo --


--echo --
--echo -- Start of 5.6 tests
--echo --

--echo --
--echo -- WL#3664 WEIGHT_STRING
--echo --

set names gbk;

set collation_connection=gbk_bin;

SET NAMES gbk;
