
SET NAMES latin1;
SET character_set_connection=utf16;
select hex('a'), hex('a ');


-- Check that incomplete utf16 characters in HEX notation
-- are left-padded with zeros
--
select hex(_utf16 0x44);
select hex(_utf16 0x3344);
select hex(_utf16 0x113344);


-- Check that 0x20 is only trimmed when it is 
-- a part of real SPACE character, not just a part
-- of a multibyte sequence.
-- Note, CYRILLIC LETTER ER is used as an example, which
-- is stored as 0x0420 in utf16, thus contains 0x20 in the
-- low byte. The second character is THREE-PER-M, U+2004,
-- which contains 0x20 in the high byte.

CREATE TABLE t1 (word VARCHAR(64), word2 CHAR(64)) CHARACTER SET utf16;
INSERT INTO t1 VALUES (_koi8r 0xF2, _koi8r 0xF2), (X'2004',X'2004');
SELECT hex(word) FROM t1 ORDER BY word;
SELECT hex(word2) FROM t1 ORDER BY word2;
DELETE FROM t1;

--
-- Check that real spaces are correctly trimmed.
--
INSERT INTO t1 VALUES (X'042000200020',X'042000200020'), (X'200400200020', X'200400200020');
SELECT hex(word) FROM t1 ORDER BY word;
SELECT hex(word2) FROM t1 ORDER BY word2;
DROP TABLE t1;


--
-- Check LPAD/RPAD
--
SELECT hex(LPAD(_utf16 X'0420',10,_utf16 X'0421'));
SELECT hex(LPAD(_utf16 X'0420',10,_utf16 X'04210422'));
SELECT hex(LPAD(_utf16 X'0420',10,_utf16 X'042104220423'));
SELECT hex(LPAD(_utf16 X'0420042104220423042404250426042704280429042A042B',10,_utf16 X'042104220423'));
SELECT hex(LPAD(_utf16 X'D800DC00', 10, _utf16 X'0421'));
SELECT hex(LPAD(_utf16 X'0421', 10, _utf16 X'D800DC00'));

SELECT hex(RPAD(_utf16 X'0420',10,_utf16 X'0421'));
SELECT hex(RPAD(_utf16 X'0420',10,_utf16 X'04210422'));
SELECT hex(RPAD(_utf16 X'0420',10,_utf16 X'042104220423'));
SELECT hex(RPAD(_utf16 X'0420042104220423042404250426042704280429042A042B',10,_utf16 X'042104220423'));
SELECT hex(RPAD(_utf16 X'D800DC00', 10, _utf16 X'0421'));
SELECT hex(RPAD(_utf16 X'0421', 10, _utf16 X'D800DC00'));

CREATE TABLE t1 SELECT 
LPAD(_utf16 X'0420',10,_utf16 X'0421') l,
RPAD(_utf16 X'0420',10,_utf16 X'0421') r;
select hex(l), hex(r) from t1;
DROP TABLE t1;

create table t1 (f1 char(30));
insert into t1 values ("103000"), ("22720000"), ("3401200"), ("78000");
select lpad(f1, 12, "-o-/") from t1;
drop table t1;
--

SET NAMES latin1;
SET character_set_connection=utf16;

SET NAMES utf8mb3;
SET character_set_connection=utf16;
CREATE TABLE t1 (a VARCHAR(10) CHARACTER SET utf16);
INSERT INTO t1 VALUES ('фыва'),('Фыва'),('фЫва'),('фыВа'),('фывА'),('ФЫВА');
INSERT INTO t1 VALUES ('фывапролдж'),('Фывапролдж'),('фЫвапролдж'),('фыВапролдж');
INSERT INTO t1 VALUES ('фывАпролдж'),('фываПролдж'),('фывапРолдж'),('фывапрОлдж');
INSERT INTO t1 VALUES ('фывапроЛдж'),('фывапролДж'),('фывапролдЖ'),('ФЫВАПРОЛДЖ');
SELECT * FROM t1 WHERE a LIKE '%фЫва%' ORDER BY BINARY a;
SELECT * FROM t1 WHERE a LIKE '%фЫв%' ORDER BY BINARY a;
SELECT * FROM t1 WHERE a LIKE 'фЫва%' ORDER BY BINARY a;
SELECT * FROM t1 WHERE a LIKE 'фЫва%' COLLATE utf16_bin ORDER BY BINARY a;
DROP TABLE t1;

CREATE TABLE t1 (word varchar(64) NOT NULL, PRIMARY KEY (word))
CHARACTER SET utf16;
INSERT INTO t1 (word) VALUES ("cat");
SELECT * FROM t1 WHERE word LIKE "c%";
SELECT * FROM t1 WHERE word LIKE "ca_";
SELECT * FROM t1 WHERE word LIKE "cat";
SELECT * FROM t1 WHERE word LIKE _utf16 x'00630025';
SELECT * FROM t1 WHERE word LIKE _utf16 x'00630061005F';
DROP TABLE t1;


--
-- Check that INSERT() works fine. 
-- This invokes charpos() function.
select insert(_utf16 0x006100620063,10,2,_utf16 0x006400650066);
select insert(_utf16 0x006100620063,1,2,_utf16 0x006400650066);

--
-- Check alignment for from-binary-conversion with CAST and CONVERT
--
SELECT hex(cast(0xAA as char character set utf16));
SELECT hex(convert(0xAA using utf16));

--
-- Check alignment for string types
--
CREATE TABLE t1 (a char(10) character set utf16);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a varchar(10) character set utf16);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a text character set utf16);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a mediumtext character set utf16);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a longtext character set utf16);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

--#
--# Bug #5024 Server crashes with queries on fields
--#  with certain charset/collation settings
--#
--#
--create table t1 (s1 char character set utf16 collate utf16_czech_ci);
--

--
-- Bug #5081 : UCS2 fields are filled with '0x2020'
-- after extending field length
--
create table t1(a char(1)) default charset utf16;
insert into t1 values ('a'),('b'),('c');
alter table t1 modify a char(5);
select a, hex(a) from t1;
drop table t1;

--
-- Check prepare statement from an UTF16 string
--
set names latin1;
set @ivar= 1234;
set @str1 = 'select ?';
set @str2 = convert(@str1 using utf16);

--
-- Check that utf16 works with ENUM and SET type
--
set names utf8mb3;
create table t1 (a enum('x','y','z') character set utf16);
insert into t1 values ('x');
insert into t1 values ('y');
insert into t1 values ('z');
select a, hex(a) from t1 order by a;
alter table t1 change a a enum('x','y','z','d','e','ä','ö','ü') character set utf16;
insert into t1 values ('D');
insert into t1 values ('E ');
insert into t1 values ('ä');
insert into t1 values ('ö');
insert into t1 values ('ü');
select a, hex(a) from t1 order by a;
drop table t1;

create table t1 (a set ('x','y','z','ä','ö','ü') character set utf16);
insert into t1 values ('x');
insert into t1 values ('y');
insert into t1 values ('z');
insert into t1 values ('x,y');
insert into t1 values ('x,y,z,ä,ö,ü');
select a, hex(a) from t1 order by a;
drop table t1;

--
-- Bug#7302 UCS2 data in ENUM fields get truncated when new column is added
--
create table t1(a enum('a','b','c')) default character set utf16;
insert into t1 values('a'),('b'),('c');
alter table t1 add b char(1);
select * from t1 order by a;
drop table t1;

SET NAMES latin1;
SET collation_connection='utf16_general_ci';
SET NAMES latin1;
SET collation_connection='utf16_bin';

--
-- Bug#10344 Some string functions fail for UCS2
--
select hex(substr(_utf16 0x00e400e50068,1));
select hex(substr(_utf16 0x00e400e50068,2));
select hex(substr(_utf16 0x00e400e50068,3));
select hex(substr(_utf16 0x00e400e50068,-1));
select hex(substr(_utf16 0x00e400e50068,-2));
select hex(substr(_utf16 0x00e400e50068,-3));
select hex(substr(_utf16 0x00e400e5D800DC00,1));
select hex(substr(_utf16 0x00e400e5D800DC00,2));
select hex(substr(_utf16 0x00e400e5D800DC00,3));
select hex(substr(_utf16 0x00e400e5D800DC00,-1));
select hex(substr(_utf16 0x00e400e5D800DC00,-2));
select hex(substr(_utf16 0x00e400e5D800DC00,-3));

SET NAMES latin1;

--#
--# Bug#8235
--#
--# This bug also helped to find another problem that
--# INSERT of a UCS2 string containing a negative number
--# into a unsigned int column didn't produce warnings.
--# This test covers both problems.
--#
--#SET collation_connection='ucs2_swedish_ci';

--
-- Bug#9442 Set parameter make query fail if column character set is UCS2
--
create table t1 (utext varchar(20) character set utf16);
insert into t1 values ("lily");
insert into t1 values ("river");
set @param1='%%';
select utext from t1 where utext like '%%';
drop table t1;

--#
--# Bug #20076: server crashes for a query with GROUP BY if MIN/MAX aggregation
--#             over a 'ucs2' field uses a temporary table 
--#
--#CREATE TABLE t1 (id int, s char(5) CHARACTER SET ucs2 COLLATE ucs2_unicode_ci);
--#
--#--disable_warnings
--#drop table if exists bug20536;
--#
--#set names latin1;

--
-- Bug #20108: corrupted default enum value for a ucs2 field              
--

CREATE TABLE t1 (
  status enum('active','passive') character set utf16 collate utf16_general_ci 
    NOT NULL default 'passive'
);
ALTER TABLE t1 ADD a int NOT NULL AFTER status;
DROP TABLE t1;
--#  status enum('active','passive') collate ucs2_turkish_ci 
--#    NOT NULL default 'passive'
--#);

--
-- Conversion from an UTF16 string to a decimal column
--
CREATE TABLE t1 (a varchar(64) character set utf16, b decimal(10,3));
INSERT INTO t1 VALUES ("1.1", 0), ("2.1", 0);
update t1 set b=a;
SELECT *, hex(a) FROM t1;
DROP TABLE t1;

--
-- Bug#9442 Set parameter make query fail if column character set is UCS2
--
create table t1 (utext varchar(20) character set utf16);
insert into t1 values ("lily");
insert into t1 values ("river");
set @param1='%%';
select utext from t1 where utext like '%%';
drop table t1;

--
-- Bug#22638 SOUNDEX broken for international characters
--
set names latin1;
set character_set_connection=utf16;
select soundex(''),soundex('he'),soundex('hello all folks'),soundex('--3556 in bugdb');
select hex(soundex('')),hex(soundex('he')),hex(soundex('hello all folks')),hex(soundex('--3556 in bugdb'));
select 'mood' sounds like 'mud';
select hex(soundex(_utf16 0x041004110412));
select hex(soundex(_utf16 0x00BF00C0));
set names latin1;

--
-- Bug #14290: character_maximum_length for text fields
--
create table t1(a blob, b text charset utf16);
select data_type, character_octet_length, character_maximum_length
  from information_schema.columns where table_name='t1';
drop table t1;


set names latin1;
set collation_connection=utf16_general_ci;
select position('bb' in 'abba');

--
-- Testing cs->coll->hash_sort()
--
create table t1 (a varchar(10) character set utf16) engine=heap;
insert into t1 values ('a'),('A'),('b'),('B');
select * from t1 where a='a' order by binary a;
select hex(min(binary a)),count(*) from t1 group by a;
drop table t1;

--
-- Testing cs->cset->numchars()
--
select char_length('abcd'), octet_length('abcd');
select char_length(_utf16 0xD800DC00), octet_length(_utf16 0xD800DC00);
select char_length(_utf16 0xD87FDFFF), octet_length(_utf16 0xD87FDFFF);

--
-- Testing cs->cset->charpos()
--
select left('abcd',2);
select hex(left(_utf16 0xD800DC00D87FDFFF, 1));
select hex(right(_utf16 0xD800DC00D87FDFFF, 1));

--
-- Testing cs->cset->well_formed_length()
--
create table t1 (a varchar(10) character set utf16);
insert into t1 values (_utf16 0xD800);
insert into t1 values (_utf16 0xDC00);
insert into t1 values (_utf16 0xD800D800);
insert into t1 values (_utf16 0xD800E800);
insert into t1 values (_utf16 0xD8000800);
insert into t1 values (_utf16 0xD800DC00);
insert into t1 values (_utf16 0xD800DCFF);
insert into t1 values (_utf16 0xDBFFDC00);
insert into t1 values (_utf16 0xDBFFDCFF);
select hex(a) from t1;
drop table t1;

--
-- Bug#32393 Character sets: illegal characters in utf16 columns
--
-- Tests that cs->cset->wc_mb() doesn't accept surrogate parts
--
-- via alter
--
SET sql_mode = '';
create table t1 (s1 varchar(50) character set ucs2);
insert into t1 values (0xdf84);
alter table t1 modify column s1 varchar(50) character set utf16;
select hex(s1) from t1;
drop table t1;
SET sql_mode = default;
create table t1 (s1 varchar(5) character set ucs2, s2 varchar(5) character set utf16);
insert into t1 (s1) values (0xdf84);
update ignore t1 set s2 = s1;
select hex(s2) from t1;
drop table t1;



--
-- Testing cs->cset->lengthsp()
--
create table t1 (a char(10)) character set utf16;
insert into t1 values ('a   ');
select hex(a) from t1;
drop table t1;

--
-- Testing cs->cset->caseup() and cs->cset->casedn()
--
select upper('abcd'), lower('ABCD');

--
-- TODO: str_to_datetime() is broken and doesn't work with ucs2 and utf16
-- Testing cs->cset->snprintf()
--
--create table t1 (a date);

--
-- Testing cs->cset->l10tostr
-- !!! Not used in the code

--
-- Testing cs->cset->ll10tostr
--
create table t1 (a varchar(10) character set utf16);
insert into t1 values (123456);
select a, hex(a) from t1;
drop table t1;


-- Testing cs->cset->fill
-- SOUNDEX fills strings with DIGIT ZERO up to four characters
select hex(soundex('a'));

--
-- Testing cs->cset->strntol
-- !!! Not used in the code

--
-- Testing cs->cset->strntoul
--
create table t1 (a enum ('a','b','c')) character set utf16;
insert into t1 values ('1');
select * from t1;
drop table t1;

--
-- Testing cs->cset->strntoll and cs->cset->strntoull
--
set names latin1;
select hex(conv(convert('123' using utf16), -10, 16));
select hex(conv(convert('123' using utf16), 10, 16));

--
-- Testing cs->cset->strntod
--
set names latin1;
set character_set_connection=utf16;
select 1.1 + '1.2';
select 1.1 + '1.2xxx';

-- Testing strntoll10_utf16
-- Testing cs->cset->strtoll10
select left('aaa','1');

--
-- Testing cs->cset->strntoull10rnd
--
create table t1 (a int);
insert into t1 values ('-1234.1e2');
insert ignore into t1 values ('-1234.1e2xxxx');
insert into t1 values ('-1234.1e2    ');
select * from t1;
drop table t1;

--
-- Testing cs->cset->scan
--
create table t1 (a int);
insert into t1 values ('1 ');
insert ignore into t1 values ('1 x');
select * from t1;
drop table t1;

--
-- Testing auto-conversion to TEXT
--
SET sql_mode = '';
create table t1 (a varchar(17000) character set utf16);
drop table t1;
SET sql_mode = default;

--
-- Testing that maximim possible key length is 767 bytes for InnoDB
--
--Minimized the varchar length for InnoDB so that it does not throw max keylength exceeded error
create table t1 (a varchar(150) character set utf16 primary key);
drop table t1;
create table t1 (a varchar(334) character set utf16 primary key) ROW_FORMAT=COMPACT;

--
-- Conversion to utf8mb3
--
create table t1 (a char(1) character set utf16);
insert into t1 values (0xD800DC00),(0xD800DCFF),(0xDB7FDC00),(0xDB7FDCFF);
insert into t1 values (0x00C0), (0x00FF),(0xE000), (0xFFFF);
select hex(a), hex(@a:=convert(a using utf8mb4)), hex(convert(@a using utf16)) from t1;
drop table t1;

--
-- Test basic regex functionality
--
set collation_connection=utf16_general_ci;
set names latin1;

--
-- Test how character set works with date/time
--
SET collation_connection=utf16_general_ci;
SET NAMES latin1;

--
-- Bug#33073 Character sets: ordering fails with utf32
--
SET collation_connection=utf16_general_ci;
CREATE TABLE t1 AS SELECT repeat('a',2) as s1 LIMIT 0;
INSERT INTO t1 VALUES ('ab'),('AE'),('ab'),('AE');
SELECT * FROM t1 ORDER BY s1;
SET max_sort_length=4;
SELECT * FROM t1 ORDER BY s1;
DROP TABLE t1;
SET max_sort_length=DEFAULT;
SET NAMES latin1;
CREATE TABLE t1 (
  s1 TINYTEXT CHARACTER SET utf16,
  s2 TEXT CHARACTER SET utf16,
  s3 MEDIUMTEXT CHARACTER SET utf16,
  s4 LONGTEXT CHARACTER SET utf16
);
SET NAMES utf8mb3, @@character_set_results=NULL;
SELECT *, HEX(s1) FROM t1;
SET NAMES latin1;
SELECT *, HEX(s1) FROM t1;
SET NAMES utf8mb3;
SELECT *, HEX(s1) FROM t1;
CREATE TABLE t2 AS SELECT CONCAT(s1) FROM t1;
DROP TABLE t1, t2;
SELECT CASE _latin1'a' WHEN _utf16'a' THEN 'A' END;
SELECT CASE _utf16'a' WHEN _latin1'a' THEN 'A' END;
CREATE TABLE t1 (s1 CHAR(5) CHARACTER SET utf16);
INSERT INTO t1 VALUES ('a');
SELECT CASE s1 WHEN 'a' THEN 'b' ELSE 'c' END FROM t1;
DROP TABLE t1;

SELECT space(date_add(101, INTERVAL CHAR('1' USING utf16) hour_second));

SET NAMES utf8mb3, @@character_set_connection=utf16;
SELECT id, CHAR_LENGTH(GROUP_CONCAT(body)) AS l
FROM (SELECT 'a' AS id, REPEAT('foo bar', 100) AS body
UNION ALL
SELECT 'a' AS id, REPEAT('bla bla', 100) AS body) t1
GROUP BY id
ORDER BY l DESC;


--
--# TODO: add tests for all engines
--

--echo --
--echo -- End of 5.5 tests
--echo --


--echo --
--echo -- Start of 5.6 tests
--echo --

--echo --
--echo -- WL#3664 WEIGHT_STRING
--echo --

set collation_connection=utf16_general_ci;
select hex(weight_string(_utf16 0xD800DC00));
select hex(weight_string(_utf16 0xD800DC01));

set collation_connection=utf16_bin;
