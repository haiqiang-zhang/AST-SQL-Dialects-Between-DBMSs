select hex('a'), hex('a ');
select hex(_utf32 0x44);
select hex(_utf32 0x3344);
select hex(_utf32 0x103344);
select hex(_utf32 X'44');
select hex(_utf32 X'3344');
select hex(_utf32 X'103344');
CREATE TABLE t1 (word VARCHAR(64), word2 CHAR(64)) CHARACTER SET utf32;
INSERT INTO t1 VALUES (_koi8r 0xF2, _koi8r 0xF2), (X'2004',X'2004');
SELECT hex(word) FROM t1 ORDER BY word;
SELECT hex(word2) FROM t1 ORDER BY word2;
DELETE FROM t1;
INSERT INTO t1 VALUES
  (X'000004200000002000000020',X'000004200000002000000020'),
  (X'000020040000002000000020',X'000020040000002000000020');
SELECT hex(word) FROM t1 ORDER BY word;
SELECT hex(word2) FROM t1 ORDER BY word2;
DROP TABLE t1;
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
CREATE TABLE t1 (a VARCHAR(10) CHARACTER SET utf32);
SELECT * FROM t1 WHERE a LIKE '%ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ«ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ²ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ°%' ORDER BY BINARY a;
SELECT * FROM t1 WHERE a LIKE '%ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ«ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ²%' ORDER BY BINARY a;
SELECT * FROM t1 WHERE a LIKE 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ«ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ²ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ°%' ORDER BY BINARY a;
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
select insert(_utf32 0x000000610000006200000063,10,2,_utf32 0x000000640000006500000066);
select insert(_utf32 0x000000610000006200000063,1,2,_utf32 0x000000640000006500000066);
SELECT hex(cast(0xAA as char character set utf32));
SELECT hex(convert(0xAA using utf32));
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
create table t1(a char(1)) default charset utf32;
insert into t1 values ('a'),('b'),('c');
alter table t1 modify a char(5);
select a, hex(a) from t1;
drop table t1;
create table t1 (a enum('x','y','z') character set utf32);
insert into t1 values ('x');
insert into t1 values ('y');
insert into t1 values ('z');
select a, hex(a) from t1 order by a;
alter table t1 change a a enum('x','y','z','d','e','ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¤','ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¶','ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¼') character set utf32;
insert into t1 values ('D');
insert into t1 values ('E ');
insert into t1 values ('ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¤');
insert into t1 values ('ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¶');
insert into t1 values ('ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¼');
select a, hex(a) from t1 order by a;
drop table t1;
create table t1 (a set ('x','y','z','ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¤','ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¶','ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¼') character set utf32);
insert into t1 values ('x');
insert into t1 values ('y');
insert into t1 values ('z');
insert into t1 values ('x,y');
insert into t1 values ('x,y,z,ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¤,ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¶,ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¼');
select a, hex(a) from t1 order by a;
drop table t1;
create table t1(a enum('a','b','c')) default character set utf32;
insert into t1 values('a'),('b'),('c');
alter table t1 add b char(1);
select * from t1 order by a;
drop table t1;
select hex(substr(_utf32 0x000000e4000000e500000068,1));
select hex(substr(_utf32 0x000000e4000000e500000068,2));
select hex(substr(_utf32 0x000000e4000000e500000068,3));
select hex(substr(_utf32 0x000000e4000000e500000068,-1));
select hex(substr(_utf32 0x000000e4000000e500000068,-2));
select hex(substr(_utf32 0x000000e4000000e500000068,-3));
create table t1 (utext varchar(20) character set utf32);
insert into t1 values ("lily");
insert into t1 values ("river");
prepare stmt from 'select utext from t1 where utext like ?';
select utext from t1 where utext like '%%';
drop table t1;
deallocate prepare stmt;
CREATE TABLE t1 (
  status enum('active','passive') character set utf32 collate utf32_general_ci 
    NOT NULL default 'passive'
);
ALTER TABLE t1 ADD a int NOT NULL AFTER status;
DROP TABLE t1;
CREATE TABLE t1 (a varchar(64) character set utf32, b decimal(10,3));
INSERT INTO t1 VALUES ("1.1", 0), ("2.1", 0);
update t1 set b=a;
SELECT *, hex(a) FROM t1;
DROP TABLE t1;
create table t1 (utext varchar(20) character set utf32);
insert into t1 values ("lily");
insert into t1 values ("river");
prepare stmt from 'select utext from t1 where utext like ?';
select utext from t1 where utext like '%%';
drop table t1;
deallocate prepare stmt;
select soundex(''),soundex('he'),soundex('hello all folks'),soundex('#3556 in bugdb');
select hex(soundex('')),hex(soundex('he')),hex(soundex('hello all folks')),hex(soundex('#3556 in bugdb'));
select 'mood' sounds like 'mud';
select hex(soundex(_utf32 0x000004100000041100000412));
select hex(soundex(_utf32 0x000000BF000000C0));
create table t1(a blob, b text charset utf32);
select data_type, character_octet_length, character_maximum_length
  from information_schema.columns where table_name='t1';
drop table t1;
select position('bb' in 'abba');
create table t1 (a varchar(10) character set utf32) engine=heap;
insert into t1 values ('a'),('A'),('b'),('B');
select * from t1 where a='a' order by binary a;
select hex(min(binary a)),count(*) from t1 group by a;
drop table t1;
select char_length('abcd'), octet_length('abcd');
select left('abcd',2);
create table t1 (a varchar(10) character set utf32);
insert into t1 values (_utf32 0x0010FFFF);
select hex(a) from t1;
drop table t1;
create table t1 (utf32 varchar(2) character set utf32);
drop table t1;
select _utf32'a' collate utf32_general_ci = 0xfffd;
select hex(concat(_utf32 0x0410 collate utf32_general_ci, 0x61));
create table t1 (s1 varchar(5) character set utf32);
insert into t1 values (0xfffd);
select case when s1 = 0xfffd then 1 else 0 end from t1;
select hex(s1) from t1 where s1 = 0xfffd;
drop table t1;
create table t1 (a char(10)) character set utf32;
insert into t1 values ('a   ');
select hex(a) from t1;
drop table t1;
select upper('abcd'), lower('ABCD');
create table t1 (a varchar(10) character set utf32);
insert into t1 values (123456);
select a, hex(a) from t1;
drop table t1;
select hex(soundex('a'));
create table t1 (a enum ('a','b','c')) character set utf32;
select * from t1;
drop table t1;
select hex(conv(convert('123' using utf32), -10, 16));
select hex(conv(convert('123' using utf32), 10, 16));
select 1.1 + '1.2';
select 1.1 + '1.2xxx';
select left('aaa','1');
create table t1 (a int);
insert into t1 values ('-1234.1e2');
insert ignore into t1 values ('-1234.1e2xxxx');
insert into t1 values ('-1234.1e2    ');
select * from t1;
drop table t1;
create table t1 (a int);
insert into t1 values ('1 ');
insert ignore into t1 values ('1 x');
select * from t1;
drop table t1;
create table t1 (a varchar(150) character set utf32 primary key);
drop table t1;
create table t1 (a varchar(333) character set utf32, key(a))
row_format=dynamic;
insert into t1 values (repeat('a',333)), (repeat('b',333));
drop table t1;
select hex(char(0x01 using utf32));
select hex(char(0x0102 using utf32));
select hex(char(0x010203 using utf32));
select hex(char(0x01020304 using utf32));
create table t1 (s1 varchar(1) character set utf32, s2 text character set utf32);
create index i on t1 (s1);
insert into t1 values (char(256 using utf32), char(256 using utf32));
select hex(s1), hex(s2) from t1;
drop table t1;
CREATE TABLE t1 AS SELECT repeat('a',2) as s1 LIMIT 0;
INSERT INTO t1 VALUES ('ab'),('AE'),('ab'),('AE');
SELECT * FROM t1 ORDER BY s1;
SELECT * FROM t1 ORDER BY s1;
DROP TABLE t1;
CREATE TABLE t1 (
  s1 TINYTEXT CHARACTER SET utf32,
  s2 TEXT CHARACTER SET utf32,
  s3 MEDIUMTEXT CHARACTER SET utf32,
  s4 LONGTEXT CHARACTER SET utf32
);
SELECT *, HEX(s1) FROM t1;
SELECT *, HEX(s1) FROM t1;
SELECT *, HEX(s1) FROM t1;
CREATE TABLE t2 AS SELECT CONCAT(s1) FROM t1;
DROP TABLE t1, t2;
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
CREATE TABLE t1 AS SELECT format(123,2,'no_NO');
SELECT * FROM t1;
DROP TABLE t1;
SELECT CASE _latin1'a' WHEN _utf32'a' THEN 'A' END;
SELECT CASE _utf32'a' WHEN _latin1'a' THEN 'A' END;
CREATE TABLE t1 (s1 CHAR(5) CHARACTER SET utf32);
INSERT INTO t1 VALUES ('a');
SELECT CASE s1 WHEN 'a' THEN 'b' ELSE 'c' END FROM t1;
DROP TABLE t1;
SELECT id, CHAR_LENGTH(GROUP_CONCAT(body)) AS l
FROM (SELECT 'a' AS id, REPEAT('foo bar', 100) AS body
UNION ALL
SELECT 'a' AS id, REPEAT('bla bla', 100) AS body) t1
GROUP BY id
ORDER BY l DESC;
select hex(weight_string(_utf32 0x10000));
select hex(weight_string(_utf32 0x10001));
CREATE TABLE t1 (v VARCHAR(10) CHARACTER SET utf32);
INSERT INTO t1 VALUES(x'D7FF');
INSERT INTO t1 VALUES(x'E000');
INSERT INTO t1 VALUES(x'10FFFF');
SELECT HEX(v) FROM t1;
DROP TABLE t1;