
SET NAMES latin1;
SET character_set_connection=utf32;
select hex('a'), hex('a ');

--
-- Check that incomplete utf32 characters in HEX notation
-- are left-padded with zeros
--
select hex(_utf32 0x44);
select hex(_utf32 0x3344);
select hex(_utf32 0x103344);

select hex(_utf32 X'44');
select hex(_utf32 X'3344');
select hex(_utf32 X'103344');


--
-- Check that 0x20 is only trimmed when it is 
-- a part of real SPACE character, not just a part
-- of a multibyte sequence.
-- Note, CYRILLIC LETTER ER is used as an example, which
-- is stored as 0x0420 in UCS2, thus contains 0x20 in the
-- low byte. The second character is THREE-PER-M, U+2004,
-- which contains 0x20 in the high byte.
--

CREATE TABLE t1 (word VARCHAR(64), word2 CHAR(64)) CHARACTER SET utf32;
INSERT INTO t1 VALUES (_koi8r 0xF2, _koi8r 0xF2), (X'2004',X'2004');
SELECT hex(word) FROM t1 ORDER BY word;
SELECT hex(word2) FROM t1 ORDER BY word2;
DELETE FROM t1;

--
-- Check that real spaces are correctly trimmed.
--

INSERT INTO t1 VALUES
  (X'000004200000002000000020',X'000004200000002000000020'),
  (X'000020040000002000000020',X'000020040000002000000020');
SELECT hex(word) FROM t1 ORDER BY word;
SELECT hex(word2) FROM t1 ORDER BY word2;
DROP TABLE t1;

--
-- Check LPAD/RPAD
--
SELECT hex(LPAD(_utf32 X'0420',10,_utf32 X'0421'));
SELECT hex(LPAD(_utf32 X'0420',10,_utf32 X'0000042100000422'));
SELECT hex(LPAD(_utf32 X'0420',10,_utf32 X'000004210000042200000423'));
SELECT hex(LPAD(_utf32 X'000004200000042100000422000004230000042400000425000004260000042700000428000004290000042A0000042B',10,_utf32 X'000004210000042200000423'));

SELECT hex(RPAD(_utf32 X'0420',10,_utf32 X'0421'));
SELECT hex(RPAD(_utf32 X'0420',10,_utf32 X'0000042100000422'));
SELECT hex(RPAD(_utf32 X'0420',10,_utf32 X'000004210000042200000423'));
SELECT hex(RPAD(_utf32 X'000004200000042100000422000004230000042400000425000004260000042700000428000004290000042A0000042B',10,_utf32 X'000004210000042200000423'));

CREATE TABLE t1 SELECT 
LPAD(_utf32 X'0420',10,_utf32 X'0421') l,
RPAD(_utf32 X'0420',10,_utf32 X'0421') r;
select hex(l), hex(r) from t1;
DROP TABLE t1;

create table t1 (f1 char(30));
insert into t1 values ("103000"), ("22720000"), ("3401200"), ("78000");
select lpad(f1, 12, "-o-/") from t1;
drop table t1;
--

SET NAMES latin1;
SET character_set_connection=utf32;

SET NAMES utf8mb3;
SET character_set_connection=utf32;
CREATE TABLE t1 (a VARCHAR(10) CHARACTER SET utf32);
INSERT INTO t1 VALUES ('фыва'),('Фыва'),('фЫва'),('фыВа'),('фывА'),('ФЫВА');
INSERT INTO t1 VALUES ('фывапролдж'),('Фывапролдж'),('фЫвапролдж'),('фыВапролдж');
INSERT INTO t1 VALUES ('фывАпролдж'),('фываПролдж'),('фывапРолдж'),('фывапрОлдж');
INSERT INTO t1 VALUES ('фывапроЛдж'),('фывапролДж'),('фывапролдЖ'),('ФЫВАПРОЛДЖ');
SELECT * FROM t1 WHERE a LIKE '%фЫва%' ORDER BY BINARY a;
SELECT * FROM t1 WHERE a LIKE '%фЫв%' ORDER BY BINARY a;
SELECT * FROM t1 WHERE a LIKE 'фЫва%' ORDER BY BINARY a;
SELECT * FROM t1 WHERE a LIKE 'фЫва%' COLLATE utf32_bin ORDER BY BINARY a;
DROP TABLE t1;

CREATE TABLE t1 (word varchar(64) NOT NULL, PRIMARY KEY (word))
CHARACTER SET utf32;
INSERT INTO t1 (word) VALUES ("cat");
SELECT * FROM t1 WHERE word LIKE "c%";
SELECT * FROM t1 WHERE word LIKE "ca_";
SELECT * FROM t1 WHERE word LIKE "cat";
SELECT * FROM t1 WHERE word LIKE _utf32 x'0000006300000025';
SELECT * FROM t1 WHERE word LIKE _utf32 x'00000063000000610000005F';
DROP TABLE t1;


--
-- Check that INSERT() works fine. 
-- This invokes charpos() function.
select insert(_utf32 0x000000610000006200000063,10,2,_utf32 0x000000640000006500000066);
select insert(_utf32 0x000000610000006200000063,1,2,_utf32 0x000000640000006500000066);

--
-- Check alignment for from-binary-conversion with CAST and CONVERT
--
SELECT hex(cast(0xAA as char character set utf32));
SELECT hex(convert(0xAA using utf32));

--
-- Check alignment for string types
--
CREATE TABLE t1 (a char(10) character set utf32);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a varchar(10) character set utf32);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a text character set utf32);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a mediumtext character set utf32);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a longtext character set utf32);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

--#
--# Bug #5024 Server crashes with queries on fields
--#  with certain charset/collation settings
--#
--
--create table t1 (s1 char character set `ucs2` collate `ucs2_czech_ci`);

--
-- Bug #5081 : UCS2 fields are filled with '0x2020'
-- after extending field length
--
create table t1(a char(1)) default charset utf32;
insert into t1 values ('a'),('b'),('c');
alter table t1 modify a char(5);
select a, hex(a) from t1;
drop table t1;

--
-- Check prepare statement from an UTF32 string
--
set names latin1;
set @ivar= 1234;
set @str1 = 'select ?';
set @str2 = convert(@str1 using utf32);

--
-- Check that utf32 works with ENUM and SET type
--
set names utf8mb3;
create table t1 (a enum('x','y','z') character set utf32);
insert into t1 values ('x');
insert into t1 values ('y');
insert into t1 values ('z');
select a, hex(a) from t1 order by a;
alter table t1 change a a enum('x','y','z','d','e','ä','ö','ü') character set utf32;
insert into t1 values ('D');
insert into t1 values ('E ');
insert into t1 values ('ä');
insert into t1 values ('ö');
insert into t1 values ('ü');
select a, hex(a) from t1 order by a;
drop table t1;

create table t1 (a set ('x','y','z','ä','ö','ü') character set utf32);
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
create table t1(a enum('a','b','c')) default character set utf32;
insert into t1 values('a'),('b'),('c');
alter table t1 add b char(1);
select * from t1 order by a;
drop table t1;

SET NAMES latin1;
SET collation_connection='utf32_general_ci';
SET NAMES latin1;
SET collation_connection='utf32_bin';

--
-- Bug#10344 Some string functions fail for UCS2
--
select hex(substr(_utf32 0x000000e4000000e500000068,1));
select hex(substr(_utf32 0x000000e4000000e500000068,2));
select hex(substr(_utf32 0x000000e4000000e500000068,3));
select hex(substr(_utf32 0x000000e4000000e500000068,-1));
select hex(substr(_utf32 0x000000e4000000e500000068,-2));
select hex(substr(_utf32 0x000000e4000000e500000068,-3));
--# no warnings, negative numbers are allowed
--INSERT INTO t1 VALUES ('-1');
--# this should generate a "Data truncated" warning
--INSERT INTO t1 VALUES ('-1');

--
--#
--# Bug#18691 Converting number to UNICODE string returns invalid result
--#
--SELECT CONVERT(103, CHAR(50) UNICODE);

--#
--# Bug #14583 Bug on query using a LIKE on indexed field with ucs2_bin collation
--#
----disable_warnings
--create table t1(f1 varchar(5) CHARACTER SET utf32 COLLATE utf32_bin NOT NULL) engine=InnoDB;

--
-- Bug#9442 Set parameter make query fail if column character set is UCS2
--
create table t1 (utext varchar(20) character set utf32);
insert into t1 values ("lily");
insert into t1 values ("river");
set @param1='%%';
select utext from t1 where utext like '%%';
drop table t1;

--
-- Bug #20076: server crashes for a query with GROUP BY if MIN/MAX aggregation
--             over a 'ucs2' field uses a temporary table 
--
--CREATE TABLE t1 (id int, s char(5) CHARACTER SET ucs2 COLLATE ucs2_unicode_ci);

--#
--# Bug #20536: md5() with GROUP BY and UCS2 return different results on myisam/innodb
--#
--
----disable_warnings
--drop table if exists bug20536;

--
-- Bug #20108: corrupted default enum value for a ucs2 field              
--

CREATE TABLE t1 (
  status enum('active','passive') character set utf32 collate utf32_general_ci 
    NOT NULL default 'passive'
);
ALTER TABLE t1 ADD a int NOT NULL AFTER status;
DROP TABLE t1;
--  status enum('active','passive') collate ucs2_turkish_ci 
--    NOT NULL default 'passive'
--);


--# Some broken functions:  add these tests just to document current behavior.
--
--# PASSWORD and OLD_PASSWORD don't work with UCS2 strings, but to fix it would
--# not be backwards compatible in all cases, so it's best to leave it alone
--select password(name) from bug20536;
--# QUOTE doesn't work with UCS2 data.  It would require a total rewrite
--# of Item_func_quote::val_str(), which isn't worthwhile until UCS2 is
--# supported fully as a client character set.
--select quote(name) from bug20536;


--
-- Conversion from an UTF32 string to a decimal column
--
CREATE TABLE t1 (a varchar(64) character set utf32, b decimal(10,3));
INSERT INTO t1 VALUES ("1.1", 0), ("2.1", 0);
update t1 set b=a;
SELECT *, hex(a) FROM t1;
DROP TABLE t1;

--
-- Bug#9442 Set parameter make query fail if column character set is UCS2
--
create table t1 (utext varchar(20) character set utf32);
insert into t1 values ("lily");
insert into t1 values ("river");
set @param1='%%';
select utext from t1 where utext like '%%';
drop table t1;

--
-- Bug#22638 SOUNDEX broken for international characters
--
set names latin1;
set character_set_connection=utf32;
select soundex(''),soundex('he'),soundex('hello all folks'),soundex('--3556 in bugdb');
select hex(soundex('')),hex(soundex('he')),hex(soundex('hello all folks')),hex(soundex('--3556 in bugdb'));
select 'mood' sounds like 'mud';
select hex(soundex(_utf32 0x000004100000041100000412));
select hex(soundex(_utf32 0x000000BF000000C0));
set names latin1;

--
-- Bug #14290: character_maximum_length for text fields
--
create table t1(a blob, b text charset utf32);
select data_type, character_octet_length, character_maximum_length
  from information_schema.columns where table_name='t1';
drop table t1;


set names latin1;
set collation_connection=utf32_general_ci;
select position('bb' in 'abba');

--
-- Testing cs->coll->hash_sort()
--
create table t1 (a varchar(10) character set utf32) engine=heap;
insert into t1 values ('a'),('A'),('b'),('B');
select * from t1 where a='a' order by binary a;
select hex(min(binary a)),count(*) from t1 group by a;
drop table t1;

--
-- Testing cs->cset->numchars()
--
select char_length('abcd'), octet_length('abcd');

--
-- Testing cs->cset->charpos()
--
select left('abcd',2);

--
-- Testing cs->cset->well_formed_length()
--
create table t1 (a varchar(10) character set utf32);
insert into t1 values (_utf32 0x0010FFFF);
insert into t1 values (_utf32 0x00110000);
insert into t1 values (_utf32 0x00110101);
insert into t1 values (_utf32 0x01000101);
insert into t1 values (_utf32 0x11000101);
select hex(a) from t1;
drop table t1;

--
-- Bug#32914 Character sets: illegal characters in utf8mb3 and utf32 columns
--
SET sql_mode = '';
create table t1 (utf32 varchar(2) character set utf32);
insert into t1 values (0x110000);
insert into t1 values (0x00110000);
insert into t1 values (0x11000000110000);
insert into t1 values (0x10000000110000);
insert into t1 values (0x0010000000110000);
insert into t1 values (0x00800037);
insert into t1 values (0x00800037);
drop table t1;
SET sql_mode = default;
select _utf32'a' collate utf32_general_ci = 0xfffd;
select hex(concat(_utf32 0x0410 collate utf32_general_ci, 0x61));
create table t1 (s1 varchar(5) character set utf32);
insert into t1 values (0xfffd);
select case when s1 = 0xfffd then 1 else 0 end from t1;
select hex(s1) from t1 where s1 = 0xfffd;
drop table t1;

--
-- Testing cs->cset->lengthsp()
--
create table t1 (a char(10)) character set utf32;
insert into t1 values ('a   ');
select hex(a) from t1;
drop table t1;

--
-- Testing cs->cset->caseup() and cs->cset->casedn()
--
select upper('abcd'), lower('ABCD');

--
-- TODO: str_to_datetime() is broken and doesn't work with ucs2 and utf32
-- Testing cs->cset->snprintf()
--
--create table t1 (a date);

--
-- Testing cs->cset->l10tostr
-- !!! Not used in the code

--
-- Testing cs->cset->ll10tostr
--
create table t1 (a varchar(10) character set utf32);
insert into t1 values (123456);
select a, hex(a) from t1;
drop table t1;

--
-- Testing cs->cset->fill
-- SOUNDEX fills strings with DIGIT ZERO up to four characters
select hex(soundex('a'));

--
-- Testing cs->cset->strntol
-- !!! Not used in the code

--
-- Testing cs->cset->strntoul
--
create table t1 (a enum ('a','b','c')) character set utf32;
insert into t1 values ('1');
select * from t1;
drop table t1;

--
-- Testing cs->cset->strntoll and cs->cset->strntoull
--
set names latin1;
select hex(conv(convert('123' using utf32), -10, 16));
select hex(conv(convert('123' using utf32), 10, 16));

--
-- Testing cs->cset->strntod
--
set names latin1;
set character_set_connection=utf32;
select 1.1 + '1.2';
select 1.1 + '1.2xxx';

-- Testing strntoll10_utf32
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
create table t1 (a varchar(17000) character set utf32);
drop table t1;
SET sql_mode = default;

--
-- Testing that maximim possible key length is 767 for InnoDB
--
--Minimized the varchar length for InnoDB so that it does not throw max keylength exceeded error
create table t1 (a varchar(150) character set utf32 primary key);
drop table t1;
create table t1 (a varchar(334) character set utf32 primary key) ROW_FORMAT=COMPACT;

--
-- Testing mi_check with long key values
--
SET sql_mode = '';
create table t1 (a varchar(333) character set utf32, key(a))
row_format=dynamic;
insert into t1 values (repeat('a',333)), (repeat('b',333));
drop table t1;
SET sql_mode = default;
SET collation_connection=utf32_general_ci;
SET NAMES latin1;

--
-- Test basic regex functionality
--
set collation_connection=utf32_general_ci;
set names latin1;


-- TODO: add tests for all engines

--
-- Bug #36418 Character sets: crash if char(256 using utf32)
--
select hex(char(0x01 using utf32));
select hex(char(0x0102 using utf32));
select hex(char(0x010203 using utf32));
select hex(char(0x01020304 using utf32));
create table t1 (s1 varchar(1) character set utf32, s2 text character set utf32);
create index i on t1 (s1);
insert into t1 values (char(256 using utf32), char(256 using utf32));
select hex(s1), hex(s2) from t1;
drop table t1;


--
-- Bug#33073 Character sets: ordering fails with utf32
--
SET collation_connection=utf32_general_ci;
CREATE TABLE t1 AS SELECT repeat('a',2) as s1 LIMIT 0;
INSERT INTO t1 VALUES ('ab'),('AE'),('ab'),('AE');
SELECT * FROM t1 ORDER BY s1;
SET max_sort_length=4;
SELECT * FROM t1 ORDER BY s1;
DROP TABLE t1;
SET max_sort_length=DEFAULT;
SET NAMES latin1;
CREATE TABLE t1 (
  s1 TINYTEXT CHARACTER SET utf32,
  s2 TEXT CHARACTER SET utf32,
  s3 MEDIUMTEXT CHARACTER SET utf32,
  s4 LONGTEXT CHARACTER SET utf32
);
SET NAMES utf8mb4, @@character_set_results=NULL;
SELECT *, HEX(s1) FROM t1;
SET NAMES latin1;
SELECT *, HEX(s1) FROM t1;
SET NAMES utf8mb4;
SELECT *, HEX(s1) FROM t1;
CREATE TABLE t2 AS SELECT CONCAT(s1) FROM t1;
DROP TABLE t1, t2;
SET collation_connection=utf32_general_ci;
CREATE TABLE t1 AS SELECT HEX(0x00) AS my_col;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (utf32 CHAR(5) CHARACTER SET utf32, latin1 CHAR(5) CHARACTER SET latin1);
INSERT INTO t1 (utf32) VALUES (0xc581);
UPDATE IGNORE t1 SET latin1 = utf32;
DELETE FROM t1;
INSERT INTO t1 (utf32) VALUES (0x100cc);
UPDATE IGNORE t1 SET latin1 = utf32;
DROP TABLE t1;
SET collation_connection=utf32_general_ci;
CREATE TABLE t1 AS SELECT format(123,2,'no_NO');
SELECT * FROM t1;
DROP TABLE t1;
SELECT CASE _latin1'a' WHEN _utf32'a' THEN 'A' END;
SELECT CASE _utf32'a' WHEN _latin1'a' THEN 'A' END;
CREATE TABLE t1 (s1 CHAR(5) CHARACTER SET utf32);
INSERT INTO t1 VALUES ('a');
SELECT CASE s1 WHEN 'a' THEN 'b' ELSE 'c' END FROM t1;
DROP TABLE t1;

SET NAMES utf8mb3, @@character_set_connection=utf32;
SELECT id, CHAR_LENGTH(GROUP_CONCAT(body)) AS l
FROM (SELECT 'a' AS id, REPEAT('foo bar', 100) AS body
UNION ALL
SELECT 'a' AS id, REPEAT('bla bla', 100) AS body) t1
GROUP BY id
ORDER BY l DESC;

set collation_connection=utf32_general_ci;
select hex(weight_string(_utf32 0x10000));
select hex(weight_string(_utf32 0x10001));

set collation_connection=utf32_bin;
CREATE TABLE  table425 (b1
SET('wgrpqu','Oklahoma','grpquarwkazzjeiwvdmdivjqsxmhjwagewclcfykywlcnemiuaabr
rifnhuufzasunkrcpvasdqkxbwptigbpnesqigwegcnfeuvrgnecpthmhffqbythjwpukqubzpomnt
rddrwhzjtqvbjiklcekxqyoxsolbxthdcprswpjxixmvfwmsyseblwcvumvyvbitxqjxdzdytunqvv
rmpyxrencqhuyrfluezqekmqpwutxnzddrbjycyoyqbzsoxvillooqxuvoxcgohdbytybwcqxdwtqr
ebgjzbycekyjgbpmqadutrqluyxhrdodxqqjwasfkvetfobocgpftrhvxugmmszwpoglvarsfiljrz
imqeplevleqdhepkhcfrahcpjj') NULL ) DEFAULT CHARACTER SET = utf32;
CREATE FUNCTION hello (s SET('wgrpqu','Oklahoma','grpquarwkazzjeiwvdmdivjqsxmh
jwagewclcfykywlcnemiuaabrrifnhuufzasunkrcpvasdqkxbwptigbpnesqigwegcnfeuvrgnecp
thmhffqbythjwpukqubzpomntrddrwhzjtqvbjiklcekxqyoxsolbxthdcprswpjxixmvfwmsysebl
wcvumvyvbitxqjxdzdytunqvvrmpyxrencqhuyrfluezqekmqpwutxnzddrbjycyoyqbzsoxvilloo
qxuvoxcgohdbytybwcqxdwtqrebgjzbycekyjgbpmqadutrqluyxhrdodxqqjwasfkvetfobocgpft
rhvxugmmszwpoglvarsfiljrzimqeplevleqdhepkhcfrahcpjj') CHARACTER SET utf32)
RETURNS CHAR(50) DETERMINISTIC RETURN CONCAT('Hello, ',s,'!');

CREATE TABLE t1 (v VARCHAR(10) CHARACTER SET utf32);
INSERT INTO t1 VALUES(x'D7FF');
INSERT INTO t1 VALUES(x'D800');
INSERT INTO t1 VALUES(x'D83C');
INSERT INTO t1 VALUES(x'DFFF');

INSERT INTO t1 VALUES(x'E000');
INSERT INTO t1 VALUES(x'10FFFF');
INSERT INTO t1 VALUES(x'110000');

SELECT HEX(v) FROM t1;

DROP TABLE t1;