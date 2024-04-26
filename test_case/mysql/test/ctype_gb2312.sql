
--
-- Tests with the gb2312 character set
--
--disable_warnings
drop table if exists t1;

SET @test_character_set= 'gb2312';
SET @test_collation= 'gb2312_chinese_ci';

SET NAMES gb2312;
SET collation_connection='gb2312_chinese_ci';
SET collation_connection='gb2312_bin';

--
-- Bug#15377 Valid multibyte sequences are truncated on INSERT
--
SET NAMES gb2312;
CREATE TABLE t1 (a text) character set gb2312;
INSERT INTO t1 VALUES (0xA2A1),(0xD7FE);
SELECT hex(a) FROM t1 ORDER BY a;
DROP TABLE t1;

-- End of 4.1 tests


--echo --
--echo -- Start of 5.5 tests
--echo --

--echo --
--echo -- Testing WL#4583 Case conversion in Asian character sets 
--echo --
--
-- Populate t1 with all hex digits
--
SET NAMES utf8mb3;
SET collation_connection=gb2312_chinese_ci;
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

set names gb2312;

set collation_connection=gb2312_bin;

SET NAMES gb2312;
