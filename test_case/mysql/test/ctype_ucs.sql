DROP TABLE IF EXISTS t1;

SET @test_character_set= 'ucs2';
SET @test_collation= 'ucs2_general_ci';

-- Ordering below is important, since 'SET CHARACTER SET' implicitly sets
-- character_set_connection to character_set_database.
SET NAMES latin1;
SET CHARACTER SET koi8r;
SET character_set_connection=ucs2;

--
-- BUG#49028, error in LIKE with ucs2
--
create table t1 (a varchar(2) character set ucs2 collate ucs2_bin, key(a));
insert into t1 values ('A'),('A'),('B'),('C'),('D'),('A\t');
insert into t1 values ('A\0'),('A\0'),('A\0'),('A\0'),('AZ');
select hex(a) from t1 where a like 'A_' order by a;
select hex(a) from t1 ignore key(a) where a like 'A_' order by a;
drop table t1;

--
-- Check that 0x20 is only trimmed when it is 
-- a part of real SPACE character, not just a part
-- of a multibyte sequence.
-- Note, CYRILLIC LETTER ER is used as an example, which
-- is stored as 0x0420 in UCS2, thus contains 0x20 in the
-- low byte. The second character is THREE-PER-M, U+2004,
-- which contains 0x20 in the high byte.
--

CREATE TABLE t1 (word VARCHAR(64) CHARACTER SET ucs2, word2 CHAR(64) CHARACTER SET ucs2);
INSERT INTO t1 VALUES (_koi8r'�',_koi8r'�'), (X'2004',X'2004');
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
SELECT LPAD(_ucs2 X'0420',10,_ucs2 X'0421');
SELECT LPAD(_ucs2 X'0420',10,_ucs2 X'04210422');
SELECT LPAD(_ucs2 X'0420',10,_ucs2 X'042104220423');
SELECT LPAD(_ucs2 X'0420042104220423042404250426042704280429042A042B',10,_ucs2 X'042104220423');

SELECT RPAD(_ucs2 X'0420',10,_ucs2 X'0421');
SELECT RPAD(_ucs2 X'0420',10,_ucs2 X'04210422');
SELECT RPAD(_ucs2 X'0420',10,_ucs2 X'042104220423');
SELECT RPAD(_ucs2 X'0420042104220423042404250426042704280429042A042B',10,_ucs2 X'042104220423');

CREATE TABLE t1 SELECT 
LPAD(_ucs2 X'0420',10,_ucs2 X'0421') l,
RPAD(_ucs2 X'0420',10,_ucs2 X'0421') r;
DROP TABLE t1;
SELECT '00' UNION SELECT '10' INTO OUTFILE 'tmpp.txt';
CREATE TABLE t1(a INT);
SELECT * FROM t1;

DROP TABLE t1;
let $MYSQLD_DATADIR= `select @@datadir`;
SELECT '00' UNION SELECT '10' INTO OUTFILE 'tmpp2.txt' CHARACTER SET ucs2;
CREATE TABLE t1(a INT);
SELECT * FROM t1;

DROP TABLE t1;
let $MYSQLD_DATADIR= `select @@datadir`;



--
-- BUG3946
--

create table t2(f1 Char(30));
insert into t2 values ("103000"), ("22720000"), ("3401200"), ("78000");
select lpad(f1, 12, "-o-/") from t2;
drop table t2;
--

SET NAMES koi8r;
SET character_set_connection=ucs2;
CREATE TABLE t1 (a VARCHAR(10) CHARACTER SET ucs2);
INSERT INTO t1 VALUES ('����'),('����'),('����'),('����'),('����'),('����');
INSERT INTO t1 VALUES ('����������'),('����������'),('����������'),('����������');
INSERT INTO t1 VALUES ('����������'),('����������'),('����������'),('����������');
INSERT INTO t1 VALUES ('����������'),('����������'),('����������'),('����������');
SELECT * FROM t1 WHERE a LIKE '%����%';
SELECT * FROM t1 WHERE a LIKE '%���%';
SELECT * FROM t1 WHERE a LIKE '����%';
SELECT * FROM t1 WHERE a LIKE '����%' COLLATE ucs2_bin;
DROP TABLE t1;

--
-- Check that INSERT works fine. 
-- This invokes charpos() function.
select insert(_ucs2 0x006100620063,10,2,_ucs2 0x006400650066);
select insert(_ucs2 0x006100620063,1,2,_ucs2 0x006400650066);

-- Bug #2390
-- Check alignment for constants
--
SELECT HEX(_ucs2 0x0);
SELECT HEX(_ucs2 0x01);
SELECT HEX(_ucs2 0x012);
SELECT HEX(_ucs2 0x0123);
SELECT HEX(_ucs2 0x01234);
SELECT HEX(_ucs2 0x012345);
SELECT HEX(_ucs2 0x0123456);
SELECT HEX(_ucs2 0x01234567);
SELECT HEX(_ucs2 0x012345678);
SELECT HEX(_ucs2 0x0123456789);
SELECT HEX(_ucs2 0x0123456789A);
SELECT HEX(_ucs2 0x0123456789AB);
SELECT HEX(_ucs2 0x0123456789ABC);
SELECT HEX(_ucs2 0x0123456789ABCD);
SELECT HEX(_ucs2 0x0123456789ABCDE);
SELECT HEX(_ucs2 0x0123456789ABCDEF);

--
-- Check alignment for from-binary-conversion with CAST and CONVERT
--
SELECT hex(cast(0xAA as char character set ucs2));
SELECT hex(convert(0xAA using ucs2));

--
-- Check alignment for string types
--
CREATE TABLE t1 (a char(10) character set ucs2);
INSERT INTO t1 VALUES (0xA),(0xAA),(0xAAA),(0xAAAA),(0xAAAAA);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a varchar(10) character set ucs2);
INSERT INTO t1 VALUES (0xA),(0xAA),(0xAAA),(0xAAAA),(0xAAAAA);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a text character set ucs2);
INSERT INTO t1 VALUES (0xA),(0xAA),(0xAAA),(0xAAAA),(0xAAAAA);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a mediumtext character set ucs2);
INSERT INTO t1 VALUES (0xA),(0xAA),(0xAAA),(0xAAAA),(0xAAAAA);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a longtext character set ucs2);
INSERT INTO t1 VALUES (0xA),(0xAA),(0xAAA),(0xAAAA),(0xAAAAA);
SELECT HEX(a) FROM t1;
DROP TABLE t1;

-- the same should be also done with enum and set


--
-- Bug #5024 Server crashes with queries on fields
--  with certain charset/collation settings
--

create table t1 (s1 char character set `ucs2` collate `ucs2_czech_ci`);
insert into t1 values ('0'),('1'),('2'),('a'),('b'),('c');
select s1 from t1 where s1 > 'a' order by s1;
drop table t1;

--
-- Bug #5081 : UCS2 fields are filled with '0x2020'
-- after extending field length
--
create table t1(a char(1)) default charset = ucs2;
insert into t1 values ('a'),('b'),('c');
alter table t1 modify a char(5);
select a, hex(a) from t1;
drop table t1;

--
-- Check prepare statement from an UCS2 string
--
set names latin1;
set @ivar= 1234;
set @str1 = 'select ?';
set @str2 = convert(@str1 using ucs2);

--
-- Check that ucs2 works with ENUM and SET type
--
set names latin1;
create table t1 (a enum('x','y','z') character set ucs2);
insert into t1 values ('x');
insert into t1 values ('y');
insert into t1 values ('z');
select a, hex(a) from t1 order by a;
alter table t1 change a a enum('x','y','z','d','e','�','�','�') character set ucs2;
insert into t1 values ('D');
insert into t1 values ('E ');
insert into t1 values ('�');
insert into t1 values ('�');
insert into t1 values ('�');
select a, hex(a) from t1 order by a;
drop table t1;

create table t1 (a set ('x','y','z','�','�','�') character set ucs2);
insert into t1 values ('x');
insert into t1 values ('y');
insert into t1 values ('z');
insert into t1 values ('x,y');
insert into t1 values ('x,y,z,�,�,�');
select a, hex(a) from t1 order by a;
drop table t1;

--
-- Bug#7302 UCS2 data in ENUM fields get truncated when new column is added
--
create table t1(a enum('a','b','c')) default character set ucs2;
insert into t1 values('a'),('b'),('c');
alter table t1 add b char(1);
select * from t1 order by a;
drop table t1;

SET collation_connection='ucs2_general_ci';
SET NAMES latin1;
SET collation_connection='ucs2_bin';

--
-- Bug#10344 Some string functions fail for UCS2
--
select hex(substr(_ucs2 0x00e400e50068,1));
select hex(substr(_ucs2 0x00e400e50068,2));
select hex(substr(_ucs2 0x00e400e50068,3));
select hex(substr(_ucs2 0x00e400e50068,-1));
select hex(substr(_ucs2 0x00e400e50068,-2));
select hex(substr(_ucs2 0x00e400e50068,-3));

SET NAMES latin1;
SET collation_connection='ucs2_swedish_ci';
CREATE TABLE t1 (Field1 int(10) default '0');
INSERT INTO t1 VALUES ('-1');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (Field1 int(10) unsigned default '0');
INSERT IGNORE INTO t1 VALUES ('-1');
DROP TABLE t1;
SET NAMES latin1;

--
-- Bug#18691 Converting number to UNICODE string returns invalid result
--
SELECT CONVERT(103, CHAR(50) UNICODE);
SELECT CONVERT(103.0, CHAR(50) UNICODE);
SELECT CONVERT(-103, CHAR(50) UNICODE);
SELECT CONVERT(-103.0, CHAR(50) UNICODE);

--
-- Bug #14583 Bug on query using a LIKE on indexed field with ucs2_bin collation
--
--disable_warnings
create table t1(f1 varchar(5) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL) engine=InnoDB;
insert into t1 values('a');
create index t1f1 on t1(f1);
select f1 from t1 where f1 like 'a%';
drop table t1;

--
-- Bug#9442 Set parameter make query fail if column character set is UCS2
--
create table t1 (utext varchar(20) character set ucs2);
insert into t1 values ("lily");
insert into t1 values ("river");
set @param1='%%';
select utext from t1 where utext like '%%';
drop table t1;

--
-- Bug #20076: server crashes for a query with GROUP BY if MIN/MAX aggregation
--             over a 'ucs2' field uses a temporary table 
--

CREATE TABLE t1 (id int, s char(5) CHARACTER SET ucs2 COLLATE ucs2_unicode_ci);
INSERT INTO t1 VALUES (1, 'ZZZZZ'), (1, 'ZZZ'), (2, 'ZZZ'), (2, 'ZZZZZ');

SELECT id, MIN(s) FROM t1 GROUP BY id;

DROP TABLE t1;

--
-- Bug #20536: md5() with GROUP BY and UCS2 return different results on myisam/innodb
--

--disable_warnings
drop table if exists bug20536;

set names latin1;
create table bug20536 (id bigint not null auto_increment primary key, name
varchar(255) character set ucs2 not null);
insert into `bug20536` (`id`,`name`) values (1, _latin1 x'7465737431'), (2, "'test\\_2'");
select sha1(name) from bug20536;
select make_set(3, name, upper(name)) from bug20536;
select export_set(5, name, upper(name)) from bug20536;
select export_set(5, name, upper(name), ",", 5) from bug20536;

--
-- Bug #20108: corrupted default enum value for a ucs2 field              
--

CREATE TABLE t1 (
  status enum('active','passive') collate latin1_general_ci 
    NOT NULL default 'passive'
);
ALTER TABLE t1 ADD a int NOT NULL AFTER status;

CREATE TABLE t2 (
  status enum('active','passive') collate ucs2_turkish_ci 
    NOT NULL default 'passive'
);
ALTER TABLE t2 ADD a int NOT NULL AFTER status;

DROP TABLE t1,t2;


-- Some broken functions:  add these tests just to document current behavior.

-- PASSWORD and OLD_PASSWORD don't work with UCS2 strings, but to fix it would
-- not be backwards compatible in all cases, so it's best to leave it alone
-- 2011-11-08 update: change in behavior caused by refactoring of
--   Item_func_password() but since the below test doesn't show correct behavior
--   anyway it is removed.
-- select password(name) from bug20536;

-- QUOTE doesn't work with UCS2 data.  It would require a total rewrite
-- of Item_func_quote::val_str(), which isn't worthwhile until UCS2 is
-- supported fully as a client character set.
select quote(name) from bug20536;

drop table bug20536;

--
-- Bug #31615: crash after set names ucs2 collate xxx
--
--error 1231
set names ucs2;
set names ucs2 collate ucs2_bin;
set character_set_client= ucs2;
set character_set_client= concat('ucs', substr('2', 1));

--
-- Conversion from an UCS2 string to a decimal column
--
CREATE TABLE t1 (a varchar(64) character set ucs2, b decimal(10,3));
INSERT INTO t1 VALUES ("1.1", 0), ("2.1", 0);
update t1 set b=a;
SELECT * FROM t1;
DROP TABLE t1;

--
-- Bug#9442 Set parameter make query fail if column character set is UCS2
--
create table t1 (utext varchar(20) character set ucs2);
insert into t1 values ("lily");
insert into t1 values ("river");
set @param1='%%';
select utext from t1 where utext like '%%';
drop table t1;

--
-- Bug#22638 SOUNDEX broken for international characters
--
set names latin1;
set character_set_connection=ucs2;
select soundex(''),soundex('he'),soundex('hello all folks'),soundex('--3556 in bugdb');
select hex(soundex('')),hex(soundex('he')),hex(soundex('hello all folks')),hex(soundex('--3556 in bugdb'));
select 'mood' sounds like 'mud';
select hex(soundex(_ucs2 0x041004110412));
select hex(soundex(_ucs2 0x00BF00C0));
set names latin1;

--
-- Bug #14290: character_maximum_length for text fields
--
create table t1(a blob, b text charset utf8mb3, c text charset ucs2);
select data_type, character_octet_length, character_maximum_length
  from information_schema.columns where table_name='t1';
drop table t1;

--
-- Bug#28925 GROUP_CONCAT inserts wrong separators for a ucs2 column
--
create table t1 (a char(1) character set ucs2);
insert into t1 values ('a'),('b'),('c');
select hex(group_concat(a)) from t1;
select collation(group_concat(a)) from t1;
drop table t1;

set names latin1;
create table t1 (a char(1) character set latin1);
insert into t1 values ('a'),('b'),('c');
set character_set_connection=ucs2;
select hex(group_concat(a separator ',')) from t1;
select collation(group_concat(a separator ',')) from t1;
drop table t1;
set names latin1;

--
-- Bug#29499 Converting 'del' from ascii to Unicode results in 'question mark'
--
create table t1 (s1 char(1) character set ascii, s2 char(1) character set ucs2);
insert into t1 (s1) values (0x7f);
update t1 set s2 = s1;
select hex(s2) from t1;
select hex(convert(s1 using latin1)) from t1;
drop table t1;

--
-- Conversion from UCS2 to ASCII is possible
-- if the UCS2 string consists of only ASCII characters
--
create table t1 (a varchar(15) character set ascii not null, b int);
insert into t1 values ('a',1);
select concat(a,if(b<10,_ucs2 0x0061,_ucs2 0x0062)) from t1;
select concat(a,if(b>10,_ucs2 0x0061,_ucs2 0x0062)) from t1;
select * from t1 where a=if(b<10,_ucs2 0x0061,_ucs2 0x0062);
select * from t1 where a=if(b>10,_ucs2 0x0061,_ucs2 0x0062);

--
-- Conversion from UCS2 to ASCII is not possible if 
-- the UCS2 string has non-ASCII characters
--
--error ER_CANT_AGGREGATE_2COLLATIONS
select concat(a,if(b<10,_ucs2 0x00C0,_ucs2 0x0062)) from t1;
select concat(a,if(b>10,_ucs2 0x00C0,_ucs2 0x0062)) from t1;
select concat(a,if(b<10,_ucs2 0x0062,_ucs2 0x00C0)) from t1;
select concat(a,if(b>10,_ucs2 0x0062,_ucs2 0x00C0)) from t1;
select * from t1 where a=if(b<10,_ucs2 0x00C0,_ucs2 0x0062);
select * from t1 where a=if(b<10,_ucs2 0x0062,_ucs2 0x00C0);
drop table t1;

--
-- Bug#35720 ucs2 + pad_char_to_full_length = failure
--
CREATE TABLE t1 (s1 CHAR(5) CHARACTER SET UCS2);
INSERT INTO t1 VALUES ('a');
SET @@sql_mode=pad_char_to_full_length;
SELECT HEX(s1) FROM t1;
SET @@sql_mode=default;
SELECT HEX(s1) FROM t1;
DROP TABLE t1;

set collation_connection=ucs2_general_ci;
set names latin1;
select hex(char(0x41 using ucs2));

--
-- Bug#37575: UCASE fails on monthname
--
SET character_set_connection=ucs2;
SELECT CHARSET(DAYNAME(19700101));
SELECT CHARSET(MONTHNAME(19700101));
SELECT LOWER(DAYNAME(19700101));
SELECT LOWER(MONTHNAME(19700101));
SELECT UPPER(DAYNAME(19700101));
SELECT UPPER(MONTHNAME(19700101));
SELECT HEX(MONTHNAME(19700101));
SELECT HEX(DAYNAME(19700101));
SET LC_TIME_NAMES=ru_RU;
SET NAMES utf8mb3;
SET character_set_connection=ucs2;
SELECT CHARSET(DAYNAME(19700101));
SELECT CHARSET(MONTHNAME(19700101));
SELECT LOWER(DAYNAME(19700101));
SELECT LOWER(MONTHNAME(19700101));
SELECT UPPER(DAYNAME(19700101));
SELECT UPPER(MONTHNAME(19700101));
SELECT HEX(MONTHNAME(19700101));
SELECT HEX(DAYNAME(19700101));
SET character_set_connection=latin1;
CREATE TABLE t1 (a CHAR(1) CHARSET ascii, b CHAR(1) CHARSET latin1);
CREATE VIEW v1 AS SELECT 1 from t1
WHERE t1.b <=> (SELECT a FROM t1 WHERE a < SOME(SELECT '1'));
DROP VIEW v1;
DROP TABLE t1;
SELECT HEX(CHAR(COALESCE(NULL, CHAR(COUNT('%s') USING ucs2), 1, @@global.license, NULL) USING cp850));
SELECT CONVERT(QUOTE(CHAR(0xf5 using ucs2)), SIGNED);

SET NAMES latin1;
SET collation_connection=ucs2_general_ci;
SET NAMES latin1;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 (c1 SET('','') CHARACTER SET ucs2);
INSERT INTO t1 VALUES ('');
SELECT COALESCE(c1) FROM t1 ORDER BY 1;
DROP TABLE t1;
SET sql_mode = default;

set collation_connection=ucs2_general_ci;

set collation_connection=ucs2_bin;
select hex(char(0x01 using ucs2));
select hex(char(0x0102 using ucs2));
select hex(char(0x010203 using ucs2));
select hex(char(0x01020304 using ucs2));
CREATE TABLE t1 (f1 CHAR(255) unicode);
INSERT INTO t1 values ('abc'),('bcd'),('abc');
ALTER TABLE t1 ADD UNIQUE Index_1 (f1);
DROP TABLE t1;
SET collation_connection=ucs2_general_ci;
SET NAMES latin1;
SET collation_connection=ucs2_german2_ci;
SET NAMES latin1;
SELECT CONVERT(CHAR(NULL USING ucs2), UNSIGNED);

CREATE TABLE t1 (a DECIMAL(2,0));

SET sql_mode=default;
INSERT INTO t1 VALUES (CONVERT('9e99999999' USING ucs2));

INSERT IGNORE INTO t1 VALUES (CONVERT('aaa' USING ucs2));

DROP TABLE t1;

SELECT CONVERT('-9223372036854775808' USING utf16le) & 0;
SELECT CONVERT('-9223372036854775808' USING utf8mb4) & 0;
SELECT CAST(CONVERT("-9223372036854775808" USING utf16le) AS SIGNED);
SELECT CAST(CONVERT("-9223372036854775807" USING utf16le) AS SIGNED);

SELECT CAST(CONVERT("-9223372036854775808" USING utf32) AS SIGNED);
SELECT CAST(CONVERT("-9223372036854775807" USING utf32) AS SIGNED);
