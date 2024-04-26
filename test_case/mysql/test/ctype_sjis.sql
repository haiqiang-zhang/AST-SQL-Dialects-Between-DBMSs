
set names sjis;

select 'a' like 'a';
select 'A' like 'a';
select 'A' like 'a' collate sjis_bin;

set @sjis1= _sjis   0xa1a2a3a4a5a6a7a8a9aaabacadaeaf;
set @sjis2= _sjis 0xb0b1b2b3b4b5b6b7b8b9babbbcbdbebf;
set @sjis3= _sjis 0xc0c1c2c3c4c5c6c7c8c9cacbcccdcecf;
set @sjis4= _sjis 0xd0d1d2d3d4d5d6d7d8d9dadbdcdddedf;

set @utf81= CONVERT(@sjis1 USING utf8mb3);
set @utf82= CONVERT(@sjis2 USING utf8mb3);
set @utf83= CONVERT(@sjis3 USING utf8mb3);
set @utf84= CONVERT(@sjis4 USING utf8mb3);

select hex(@utf81);
select hex(@utf82);
select hex(@utf83);
select hex(@utf84);

select hex(CONVERT(@utf81 USING sjis));
select hex(CONVERT(@utf82 USING sjis));
select hex(CONVERT(@utf83 USING sjis));
select hex(CONVERT(@utf84 USING sjis));

--
-- Allow to insert extra CP932 characters
-- into a SJIS column
--
create table t1 (a char(10) character set sjis);
insert into t1 values (0x878A);
select hex(a) from t1;
drop table t1;

--
-- Bug #6206 ENUMs are not case sensitive even if declared BINARY
--
create table t1(c enum(0x9353,0x9373) character set sjis);
insert into t1 values (0x9353);
insert into t1 values (0x9373);
select hex(c) from t1;
drop table t1;

--
-- Bug #6223 Japanese half-width kana characters get truncated
--
SET NAMES sjis;
CREATE TABLE t1 (
 c char(16) default NULL
) DEFAULT CHARSET=sjis;
insert into t1 values(0xb1),(0xb2),(0xb3);
select hex(c) from t1;
drop table t1;


SET collation_connection='sjis_japanese_ci';
SET collation_connection='sjis_bin';

-- Check parsing of string literals in SJIS with multibyte characters that
-- have an embedded \ in them. (Bug #8303)

--character_set sjis
SET NAMES sjis;
SELECT HEX('�����@�\') FROM DUAL;

-- End of 4.1 tests

--echo -- Start of 5.1 tests

--echo Bug--44352 UPPER/LOWER function doesn't work correctly on cp932 and sjis environment.
CREATE TABLE t1 (a varchar(16)) character set sjis;
INSERT INTO t1 VALUES (0x8372835E),(0x8352835E);
SELECT hex(a), hex(lower(a)), hex(upper(a)) FROM t1 ORDER BY binary(a);
DROP TABLE t1;
SELECT QUOTE('�\');
SET NAMES utf8mb3;
SET collation_connection=sjis_japanese_ci;
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
-- 
INSERT t1 (code) SELECT head FROM head WHERE (head BETWEEN 'A1' AND 'DF');
DROP TEMPORARY TABLE head, tail;
SET @@session.max_error_count = 64;
UPDATE IGNORE t1 SET a=unhex(code) ORDER BY code;
SET @@session.max_error_count = DEFAULT;
SELECT COUNT(*) FROM t1;
SELECT COUNT(*) FROM t1 WHERE a<>'' AND OCTET_LENGTH(a)=1;
SELECT COUNT(*) FROM t1 WHERE a<>'' AND OCTET_LENGTH(a)=2;
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
SELECT HEX(a), HEX(CONVERT(a using sjis)) as b FROM t1 HAVING b<>'3F' ORDER BY BINARY a;
DROP TABLE t1;

set names sjis;


set collation_connection=sjis_bin;

SET NAMES sjis;
