drop table if exists t1,t2;
set names utf8mb3;

select left(_utf8mb3 0xD0B0D0B1D0B2,1);
select right(_utf8mb3 0xD0B0D0B2D0B2,1);

select locate('he','hello');
select locate('he','hello',2);
select locate('lo','hello',2);
select locate('HE','hello');
select locate('HE','hello',2);
select locate('LO','hello',2);
select locate('HE','hello' COLLATE utf8mb3_bin);
select locate('HE','hello' COLLATE utf8mb3_bin,2);
select locate('LO','hello' COLLATE utf8mb3_bin,2);

select locate(_utf8mb3 0xD0B1, _utf8mb3 0xD0B0D0B1D0B2);
select locate(_utf8mb3 0xD091, _utf8mb3 0xD0B0D0B1D0B2);
select locate(_utf8mb3 0xD0B1, _utf8mb3 0xD0B0D091D0B2);
select locate(_utf8mb3 0xD091, _utf8mb3 0xD0B0D0B1D0B2 COLLATE utf8mb3_bin);
select locate(_utf8mb3 0xD0B1, _utf8mb3 0xD0B0D091D0B2 COLLATE utf8mb3_bin);

select length(_utf8mb3 0xD0B1), bit_length(_utf8mb3 0xD0B1), char_length(_utf8mb3 0xD0B1);

select 'a' like 'a';
select 'A' like 'a';
select 'A' like 'a' COLLATE utf8mb3_bin;
select _utf8mb3 0xD0B0D0B1D0B2 like concat(_utf8mb3'%',_utf8mb3 0xD0B1,_utf8mb3 '%');

-- Bug #6040: can't retrieve records with umlaut
-- characters in case insensitive manner.
-- Case insensitive search LIKE comparison
-- was broken for multibyte characters:
--character_set latin1
select convert(_latin1'G�nter Andr�' using utf8mb3) like CONVERT(_latin1'G�NTER%' USING utf8mb3);
select CONVERT(_koi8r'����' USING utf8mb3) LIKE CONVERT(_koi8r'����' USING utf8mb3);
select CONVERT(_koi8r'����' USING utf8mb3) LIKE CONVERT(_koi8r'����' USING utf8mb3);

--
-- Check the following:
-- "a"  == "a "
-- "a\0" < "a"
-- "a\0" < "a "

SELECT 'a' = 'a ';
SELECT 'a\0' < 'a';
SELECT 'a\0' < 'a ';
SELECT 'a\t' < 'a';
SELECT 'a\t' < 'a ';

--
-- The same for binary collation
--
SELECT 'a' = 'a ' COLLATE utf8mb3_bin;
SELECT 'a\0' < 'a' COLLATE utf8mb3_bin;
SELECT 'a\0' < 'a ' COLLATE utf8mb3_bin;
SELECT 'a\t' < 'a' COLLATE utf8mb3_bin;
SELECT 'a\t' < 'a ' COLLATE utf8mb3_bin;

CREATE TABLE t1 (a char(10) character set utf8mb3 not null);
INSERT INTO t1 VALUES ('a'),('a\0'),('a\t'),('a ');
SELECT hex(a),STRCMP(a,'a'), STRCMP(a,'a ') FROM t1;
DROP TABLE t1;

--
-- Fix this, it should return 1:
--
--select _utf8mb3 0xD0B0D0B1D0B2 like concat(_utf8mb3'%',_utf8mb3 0xD091,_utf8mb3 '%');
--

--
-- Bug 2367: INSERT() behaviour is different for different charsets.
--
select insert('txs',2,1,'hi'),insert('is ',4,0,'a'),insert('txxxxt',2,4,'es');
select insert("aa",100,1,"b"),insert("aa",1,3,"b");

--
-- LELF() didn't work well with utf8mb3 in some cases too.
--
select char_length(left(@a:='тест',5)), length(@a), @a;


--
-- CREATE ... SELECT
--
create table t1 select date_format("2004-01-19 10:10:10", "%Y-%m-%d");
select * from t1;
drop table t1;

--
-- Bug#22646 LC_TIME_NAMES: Assignment to non-utf8mb3 target fails
--
set names utf8mb3;
set LC_TIME_NAMES='fr_FR';
create table t1 (s1 char(20) character set latin1);
insert into t1 values (date_format('2004-02-02','%M'));
select hex(s1) from t1;
drop table t1;
create table t1 (s1 char(20) character set koi8r);
set LC_TIME_NAMES='ru_RU';
insert into t1 values (date_format('2004-02-02','%M'));
insert into t1 values (date_format('2004-02-02','%b'));
insert into t1 values (date_format('2004-02-02','%W'));
insert into t1 values (date_format('2004-02-02','%a'));
select hex(s1), s1 from t1;
drop table t1;
set LC_TIME_NAMES='en_US';


--
-- Bug #2366  	Wrong utf8mb3 behaviour when data is truncated
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
set names koi8r;
create table t1 (s1 char(1) character set utf8mb3);
insert into t1 values (_koi8r'��');
select s1,hex(s1),char_length(s1),octet_length(s1) from t1;
drop table t1;

create table t1 (s1 tinytext character set utf8mb3);
insert into t1 select repeat('a',300);
insert into t1 select repeat('�',300);
insert into t1 select repeat('a�',300);
insert into t1 select repeat('�a',300);
insert into t1 select repeat('��',300);
select hex(s1) from t1;
select length(s1),char_length(s1) from t1;
drop table t1;

create table t1 (s1 text character set utf8mb3);
insert into t1 select repeat('a',66000);
insert into t1 select repeat('�',66000);
insert into t1 select repeat('a�',66000);
insert into t1 select repeat('�a',66000);
insert into t1 select repeat('��',66000);
select length(s1),char_length(s1) from t1;
drop table t1;
SET sql_mode = default;
create table t1 (s1 char(10) character set utf8mb3);
insert ignore into t1 values (0x41FF);
select hex(s1) from t1;
drop table t1;

create table t1 (s1 varchar(10) character set utf8mb3);
insert ignore into t1 values (0x41FF);
select hex(s1) from t1;
drop table t1;

create table t1 (s1 text character set utf8mb3);
insert ignore into t1 values (0x41FF);
select hex(s1) from t1;
drop table t1;

--
-- Bug 2699
-- utf8mb3 breaks primary keys for cols > 333 characters
--
--error 1071
create table t1 (a text character set utf8mb3, primary key(a(360)));


--
-- Bug 2959
-- utf8mb3 charset breaks joins with mixed column/string constant
--
CREATE TABLE t1 ( a varchar(10) ) CHARACTER SET utf8mb3;
INSERT INTO t1 VALUES ( 'test' );
SELECT a.a, b.a FROM t1 a, t1 b WHERE a.a = b.a;
SELECT a.a, b.a FROM t1 a, t1 b WHERE a.a = 'test' and b.a = 'test';
SELECT a.a, b.a FROM t1 a, t1 b WHERE a.a = b.a and a.a = 'test';
DROP TABLE t1;

create table t1 (a char(255) character set utf8mb3);
insert into t1 values('b'),('b');
select * from t1 where a = 'b';
select * from t1 where a = 'b' and a = 'b';
select * from t1 where a = 'b' and a != 'b';
drop table t1;

--
-- Testing regexp
--
set collation_connection=utf8_general_ci;
set names utf8mb3;

--
-- Bug #3928 regexp [[:>:]] and UTF-8
--
set names utf8mb3;

-- This should return TRUE
--echo -- Not supported by ICU
--error ER_REGEXP_ILLEGAL_ARGUMENT
select  'вася'  rlike '[[:<:]]вася[[:>:]]';
select  'вася ' rlike '[[:<:]]вася[[:>:]]';
select ' вася'  rlike '[[:<:]]вася[[:>:]]';
select ' вася ' rlike '[[:<:]]вася[[:>:]]';

-- This should return FALSE
--echo -- Not supported by ICU
--error ER_REGEXP_ILLEGAL_ARGUMENT
select  'васяz' rlike '[[:<:]]вася[[:>:]]';
select 'zвася'  rlike '[[:<:]]вася[[:>:]]';
select 'zвасяz' rlike '[[:<:]]вася[[:>:]]';

--
-- Bug #4555
-- ALTER TABLE crashes mysqld with enum column collated utf8_unicode_ci
--
CREATE TABLE t1 (a enum ('Y', 'N') DEFAULT 'N' COLLATE utf8mb3_unicode_ci);
ALTER TABLE t1 ADD COLUMN b CHAR(20);
DROP TABLE t1;

-- Customer Support Center issue # 3299 
-- ENUM and SET multibyte fields computed their length wronly 
-- when converted into a char field
set names utf8mb3;
create table t1 (a enum('aaaa','проба') character set utf8mb3);
insert into t1 values ('проба');
select * from t1;
create table t2 select ifnull(a,a) from t1;
select * from t2;
drop table t1;
drop table t2;

--
-- Bug 4521: unique key prefix interacts poorly with utf8mb3
-- MYISAM: keys with prefix compression, case insensitive collation.
--
create table t1 (c varchar(30) character set utf8mb3, unique(c(10)));
insert into t1 values ('1'),('2'),('3'),('x'),('y'),('z');
insert into t1 values ('aaaaaaaaaa');
insert into t1 values ('aaaaaaaaaaa');
insert into t1 values ('aaaaaaaaaaaa');
insert into t1 values (repeat('b',20));
select c c1 from t1 where c='1';
select c c2 from t1 where c='2';
select c c3 from t1 where c='3';
select c cx from t1 where c='x';
select c cy from t1 where c='y';
select c cz from t1 where c='z';
select c ca10 from t1 where c='aaaaaaaaaa';
select c cb20 from t1 where c=repeat('b',20);
drop table t1;

--
-- Bug 4521: unique key prefix interacts poorly with utf8mb3
-- InnoDB: keys with prefix compression, case insensitive collation.
--
create table t1 (c varchar(30) character set utf8mb3, unique(c(10))) engine=innodb;
insert into t1 values ('1'),('2'),('3'),('x'),('y'),('z');
insert into t1 values ('aaaaaaaaaa');
insert into t1 values ('aaaaaaaaaaa');
insert into t1 values ('aaaaaaaaaaaa');
insert into t1 values (repeat('b',20));
select c c1 from t1 where c='1';
select c c2 from t1 where c='2';
select c c3 from t1 where c='3';
select c cx from t1 where c='x';
select c cy from t1 where c='y';
select c cz from t1 where c='z';
select c ca10 from t1 where c='aaaaaaaaaa';
select c cb20 from t1 where c=repeat('b',20);
drop table t1;
create table t1 (c char(3) character set utf8mb3, unique (c(2)));
insert into t1 values ('1'),('2'),('3'),('4'),('x'),('y'),('z');
insert into t1 values ('a');
insert into t1 values ('aa');
insert into t1 values ('aaa');
insert into t1 values ('b');
insert into t1 values ('bb');
insert into t1 values ('bbb');
insert into t1 values ('а');
insert into t1 values ('аа');
insert into t1 values ('ааа');
insert into t1 values ('б');
insert into t1 values ('бб');
insert into t1 values ('ббб');
insert into t1 values ('ꪪ');
insert into t1 values ('ꪪꪪ');
insert into t1 values ('ꪪꪪꪪ');
drop table t1;
create table t1 (c char(3) character set utf8mb3, unique (c(2))) engine=innodb;
insert into t1 values ('1'),('2'),('3'),('4'),('x'),('y'),('z');
insert into t1 values ('a');
insert into t1 values ('aa');
insert into t1 values ('aaa');
insert into t1 values ('b');
insert into t1 values ('bb');
insert into t1 values ('bbb');
insert into t1 values ('а');
insert into t1 values ('аа');
insert into t1 values ('ааа');
insert into t1 values ('б');
insert into t1 values ('бб');
insert into t1 values ('ббб');
insert into t1 values ('ꪪ');
insert into t1 values ('ꪪꪪ');
insert into t1 values ('ꪪꪪꪪ');
drop table t1;
create table t1 (
c char(10) character set utf8mb3,
unique key a using hash (c(1))
) engine=heap;
insert into t1 values ('a'),('b'),('c'),('d'),('e'),('f');
insert into t1 values ('aa');
insert into t1 values ('aaa');
insert into t1 values ('б');
insert into t1 values ('бб');
insert into t1 values ('ббб');
select c as c_all from t1 order by c;
select c as c_a from t1 where c='a';
select c as c_a from t1 where c='б';
drop table t1;

--
-- Bug 4531: unique key prefix interacts poorly with utf8mb3
-- Check HEAP+BTREE, case insensitive collation
--
create table t1 (
c char(10) character set utf8mb3,
unique key a using btree (c(1))
) engine=heap;
insert into t1 values ('a'),('b'),('c'),('d'),('e'),('f');
insert into t1 values ('aa');
insert into t1 values ('aaa');
insert into t1 values ('б');
insert into t1 values ('бб');
insert into t1 values ('ббб');
select c as c_all from t1 order by c;
select c as c_a from t1 where c='a';
select c as c_a from t1 where c='б';
drop table t1;

--
-- Bug 4531: unique key prefix interacts poorly with utf8mb3
-- Check BDB, case insensitive collation
--
create table t1 (
c char(10) character set utf8mb3,
unique key a (c(1))
) engine=innodb;
insert into t1 values ('a'),('b'),('c'),('d'),('e'),('f');
insert into t1 values ('aa');
insert into t1 values ('aaa');
insert into t1 values ('б');
insert into t1 values ('бб');
insert into t1 values ('ббб');
select c as c_all from t1 order by c;
select c as c_a from t1 where c='a';
select c as c_a from t1 where c='б';
drop table t1;

--
-- Bug 4521: unique key prefix interacts poorly with utf8mb3
-- MYISAM: keys with prefix compression, binary collation.
--
create table t1 (c varchar(30) character set utf8mb3 COLLATE utf8mb3_bin, unique(c(10)));
insert into t1 values ('1'),('2'),('3'),('x'),('y'),('z');
insert into t1 values ('aaaaaaaaaa');
insert into t1 values ('aaaaaaaaaaa');
insert into t1 values ('aaaaaaaaaaaa');
insert into t1 values (repeat('b',20));
select c c1 from t1 where c='1';
select c c2 from t1 where c='2';
select c c3 from t1 where c='3';
select c cx from t1 where c='x';
select c cy from t1 where c='y';
select c cz from t1 where c='z';
select c ca10 from t1 where c='aaaaaaaaaa';
select c cb20 from t1 where c=repeat('b',20);
drop table t1;

--
-- Bug 4521: unique key prefix interacts poorly with utf8mb3
-- MYISAM: fixed length keys, binary collation
--
create table t1 (c char(3) character set utf8mb3 COLLATE utf8mb3_bin, unique (c(2)));
insert into t1 values ('1'),('2'),('3'),('4'),('x'),('y'),('z');
insert into t1 values ('a');
insert into t1 values ('aa');
insert into t1 values ('aaa');
insert into t1 values ('b');
insert into t1 values ('bb');
insert into t1 values ('bbb');
insert into t1 values ('а');
insert into t1 values ('аа');
insert into t1 values ('ааа');
insert into t1 values ('б');
insert into t1 values ('бб');
insert into t1 values ('ббб');
insert into t1 values ('ꪪ');
insert into t1 values ('ꪪꪪ');
insert into t1 values ('ꪪꪪꪪ');
drop table t1;

--
-- Bug 4531: unique key prefix interacts poorly with utf8mb3
-- Check HEAP+HASH, binary collation
--
create table t1 (
c char(10) character set utf8mb3 COLLATE utf8mb3_bin,
unique key a using hash (c(1))
) engine=heap;
insert into t1 values ('a'),('b'),('c'),('d'),('e'),('f');
insert into t1 values ('aa');
insert into t1 values ('aaa');
insert into t1 values ('б');
insert into t1 values ('бб');
insert into t1 values ('ббб');
select c as c_all from t1 order by c;
select c as c_a from t1 where c='a';
select c as c_a from t1 where c='б';
drop table t1;

--
-- Bug 4531: unique key prefix interacts poorly with utf8mb3
-- Check HEAP+BTREE, binary collation
--
create table t1 (
c char(10) character set utf8mb3 COLLATE utf8mb3_bin,
unique key a using btree (c(1))
) engine=heap;
insert into t1 values ('a'),('b'),('c'),('d'),('e'),('f');
insert into t1 values ('aa');
insert into t1 values ('aaa');
insert into t1 values ('б');
insert into t1 values ('бб');
insert into t1 values ('ббб');
select c as c_all from t1 order by c;
select c as c_a from t1 where c='a';
select c as c_a from t1 where c='б';
drop table t1;

--
-- Bug 4531: unique key prefix interacts poorly with utf8mb3
-- Check BDB, binary collation
--
create table t1 (
c char(10) character set utf8mb3 COLLATE utf8mb3_bin,
unique key a (c(1))
) engine=innodb;
insert into t1 values ('a'),('b'),('c'),('d'),('e'),('f');
insert into t1 values ('aa');
insert into t1 values ('aaa');
insert into t1 values ('б');
insert into t1 values ('бб');
insert into t1 values ('ббб');
select c as c_all from t1 order by c;
select c as c_a from t1 where c='a';
select c as c_a from t1 where c='б';
drop table t1;


-- Bug#4594: column index make = failed for gbk, but like works
-- Check MYISAM
--
create table t1 (
  str varchar(255) character set utf8mb3 not null,
  key str  (str(2))
) engine=myisam;
INSERT INTO t1 VALUES ('str');
INSERT INTO t1 VALUES ('str2');
select * from t1 where str='str';
drop table t1;

-- Bug#4594: column index make = failed for gbk, but like works
-- Check InnoDB
--
create table t1 (
  str varchar(255) character set utf8mb3 not null,
  key str  (str(2))
) engine=innodb;
INSERT INTO t1 VALUES ('str');
INSERT INTO t1 VALUES ('str2');
select * from t1 where str='str';
drop table t1;

-- the same for HEAP+BTREE
--

create table t1 (
  str varchar(255) character set utf8mb3 not null,
  key str using btree (str(2))
) engine=heap;
INSERT INTO t1 VALUES ('str');
INSERT INTO t1 VALUES ('str2');
select * from t1 where str='str';
drop table t1;

-- the same for HEAP+HASH
--

create table t1 (
  str varchar(255) character set utf8mb3 not null,
  key str using hash (str(2))
) engine=heap;
INSERT INTO t1 VALUES ('str');
INSERT INTO t1 VALUES ('str2');
select * from t1 where str='str';
drop table t1;

-- the same for BDB
--

create table t1 (
  str varchar(255) character set utf8mb3 not null,
  key str (str(2))
) engine=innodb;
INSERT INTO t1 VALUES ('str');
INSERT INTO t1 VALUES ('str2');
select * from t1 where str='str';
drop table t1;

--
-- Bug #5397: Crash with varchar binary and LIKE
--
CREATE TABLE t1 (a varchar(32) BINARY) CHARACTER SET utf8mb3;
INSERT INTO t1 VALUES ('test');
SELECT a FROM t1 WHERE a LIKE '%te';
DROP TABLE t1;

--
-- Bug #5723: length(<varchar utf8mb3 field>) returns varying results
--
SET NAMES utf8mb3;
CREATE TABLE t1 (
  subject varchar(255) character set utf8mb3 COLLATE utf8mb3_unicode_ci,
  p varchar(15) character set utf8mb3
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t1 VALUES ('谷川俊二と申しますが、インターネット予約の会員登録をしましたところ、メールアドレスを間違えてしまい会員ＩＤが受け取ることが出来ませんでした。間違えアドレスはtani-shun@n.vodafone.ne.jpを書き込みました。どうすればよいですか？ その他、住所等は間違えありません。連絡ください。よろしくお願いします。m(__)m','040312-000057');
INSERT INTO t1 VALUES ('aaa','bbb');
SELECT length(subject) FROM t1;
SELECT length(subject) FROM t1 ORDER BY 1;
DROP TABLE t1;

--
-- Bug #5832 SELECT doesn't return records in some cases
--
CREATE TABLE t1 (
    id       int unsigned NOT NULL auto_increment,
    list_id  smallint unsigned NOT NULL,
    term     TEXT NOT NULL,
    PRIMARY KEY(id),
    INDEX(list_id, term(4))
) ENGINE=MYISAM CHARSET=utf8mb3;
INSERT INTO t1 SET list_id = 1, term = "letterc";
INSERT INTO t1 SET list_id = 1, term = "letterb";
INSERT INTO t1 SET list_id = 1, term = "lettera";
INSERT INTO t1 SET list_id = 1, term = "letterd";
SELECT id FROM t1 WHERE (list_id = 1) AND (term = "letterc");
SELECT id FROM t1 WHERE (list_id = 1) AND (term = "letterb");
SELECT id FROM t1 WHERE (list_id = 1) AND (term = "lettera");
SELECT id FROM t1 WHERE (list_id = 1) AND (term = "letterd");
DROP TABLE t1;


--
-- Bug #6043 erratic searching for diacriticals in indexed MyISAM UTF-8 table
--
SET NAMES latin1;
CREATE TABLE t1 (
    id int unsigned NOT NULL auto_increment,
    list_id smallint unsigned NOT NULL,
    term text NOT NULL,
    PRIMARY KEY(id),
    INDEX(list_id, term(19))
) ENGINE=MyISAM CHARSET=utf8mb3;
INSERT INTO t1 set list_id = 1, term = "test�test";
INSERT INTO t1 set list_id = 1, term = "testetest";
INSERT INTO t1 set list_id = 1, term = "test�test";
SELECT id, term FROM t1 where (list_id = 1) AND (term = "test�test");
SELECT id, term FROM t1 where (list_id = 1) AND (term = "testetest");
SELECT id, term FROM t1 where (list_id = 1) AND (term = "test�test");
DROP TABLE t1;

--
-- Bug #6019 SELECT tries to use too short prefix index on utf8mb3 data
--
set names utf8mb3;
create table t1 (
  a int primary key,
  b varchar(6),
  index b3(b(3))
) engine=innodb character set=utf8mb3;
insert into t1 values(1,'foo'),(2,'foobar');
select * from t1 where b like 'foob%';
alter table t1 engine=innodb;
select * from t1 where b like 'foob%';
drop table t1;

--
-- Test for calculate_interval_lengths() function
--
create table t1 (
  a enum('петя','вася','анюта') character set utf8mb3 not null default 'анюта',
  b set('петя','вася','анюта') character set utf8mb3 not null default 'анюта'
);
create table t2 select concat(a,_utf8mb3'') as a, concat(b,_utf8mb3'')as b from t1;
drop table t2;
drop table t1;

--
-- Bug #6787 LIKE not working properly with _ and utf8mb3 data
--
select 'c' like '\_' as want0;

--
-- SUBSTR with negative offset didn't work with multi-byte strings
--
SELECT SUBSTR('вася',-2);


--
-- Bug #7730 Server crash using soundex on an utf8mb3 table
--
create table t1 (id integer, a varchar(100) character set utf8mb3 COLLATE utf8mb3_unicode_ci);
insert into t1 values (1, 'Test');
select * from t1 where soundex(a) = soundex('Test');
select * from t1 where soundex(a) = soundex('TEST');
select * from t1 where soundex(a) = soundex('test');
drop table t1;

--
-- Bug#22638 SOUNDEX broken for international characters
--
select soundex(_utf8mb3 0xE99885E8A788E99A8FE697B6E69BB4E696B0E79A84E696B0E997BB);
select hex(soundex(_utf8mb3 0xE99885E8A788E99A8FE697B6E69BB4E696B0E79A84E696B0E997BB));
select soundex(_utf8mb3 0xD091D092D093);
select hex(soundex(_utf8mb3 0xD091D092D093));


SET collation_connection='utf8_general_ci';
SET collation_connection='utf8_bin';

--
-- Bug #7874 CONCAT() gives wrong results mixing
-- latin1 field and utf8mb3 string literals
--
CREATE TABLE t1 (
	user varchar(255) NOT NULL default ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO t1 VALUES ('one'),('two');
SELECT CHARSET('a');
SELECT user, CONCAT('<', user, '>') AS c FROM t1;
DROP TABLE t1;

--
-- Bug#8785
-- the same problem with the above, but with nested CONCATs
--
create table t1 (f1 varchar(1) not null) default charset utf8mb3;
insert into t1 values (''), ('');
select concat(concat(_latin1'->',f1),_latin1'<-') from t1;
drop table t1;

--
-- Bug#8385: utf8_general_ci treats Cyrillic letters I and SHORT I as the same
--
select convert(_koi8r'�' using utf8mb3) < convert(_koi8r'�' using utf8mb3);

--
-- Bugs#5980: NULL requires a characterset in a union
--
set names latin1;
create table t1 (a varchar(10)) character set utf8mb3;
insert into t1 values ('test');
select ifnull(a,'') from t1;
drop table t1;
select repeat(_utf8mb3'+',3) as h union select NULL;
select ifnull(NULL, _utf8mb3'string');

--
-- Bug#9509 Optimizer: wrong result after AND with comparisons
--
set names utf8mb3;
create table t1 (s1 char(5) character set utf8mb3 COLLATE utf8mb3_lithuanian_ci);
insert into t1 values ('I'),('K'),('Y');
select * from t1 where s1 < 'K' and s1 = 'Y';
select * from t1 where 'K' > s1 and s1 = 'Y';
drop table t1;

create table t1 (s1 char(5) character set utf8mb3 COLLATE utf8mb3_czech_ci);
insert into t1 values ('c'),('d'),('h'),('ch'),('CH'),('cH'),('Ch'),('i');
select * from t1 where s1 > 'd' and s1 = 'CH';
select * from t1 where 'd' < s1 and s1 = 'CH';
select * from t1 where s1 = 'cH' and s1 <> 'ch';
select * from t1 where 'cH' = s1 and s1 <> 'ch';
drop table t1;

--
-- Bug#10714: Inserting double value into utf8mb3 column crashes server
--
create table t1 (a varchar(255)) default character set utf8mb3;
insert into t1 values (1.0);
drop table t1;

--
-- Bug#10253 compound index length and utf8mb3 char set
-- produces invalid query results
--
create table t1 (
 id int not null,
 city varchar(20) not null,
 key (city(7),id)
) character set=utf8mb3;
insert into t1 values (1,'Durban North');
insert into t1 values (2,'Durban');
select * from t1 where city = 'Durban';
select * from t1 where city = 'Durban ';
drop table t1;

--
-- Bug #11819 CREATE TABLE with a SET DEFAULT 0 and utf8mb3 crashes server.
--
--error 1067
create table t1 (x set('A', 'B') default 0) character set utf8mb3;
create table t1 (x enum('A', 'B') default 0) character set utf8mb3;


--
-- Test for bug #11167: join for utf8mb3 varchar value longer than 255 bytes 
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
SET NAMES utf8mb3;

CREATE TABLE t1 (
  `id` int(20) NOT NULL auto_increment,
  `country` varchar(100) NOT NULL default '',
  `shortcode` varchar(100) NOT NULL default '',
  `operator` varchar(100) NOT NULL default '',
  `momid` varchar(30) NOT NULL default '',
  `keyword` varchar(160) NOT NULL default '',
  `content` varchar(160) NOT NULL default '',
  `second_token` varchar(160) default NULL,
  `gateway_id` int(11) NOT NULL default '0',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `msisdn` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `MSCCSPK_20030521130957121` (`momid`),
  KEY `IX_mobile_originated_message_keyword` (`keyword`),
  KEY `IX_mobile_originated_message_created` (`created`),
  KEY `IX_mobile_originated_message_support` (`msisdn`,`momid`,`keyword`,`gateway_id`,`created`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

INSERT INTO t1 VALUES 
(1,'blah','464','aaa','fkc1c9ilc20x0hgae7lx6j09','ERR','ERR Имри.Афимим.Аеимимримдмримрмрирор имримримримр имридм ирбднримрфмририримрфмфмим.Ад.Д имдимримрад.Адимримримрмдиримримримр м.Дадимфшьмримд им.Адимимрн имадми','ИМРИ.АФИМИМ.АЕИМИМРИМДМРИМРМРИРОР',3,'2005-06-01 17:30:43','1234567890'),
(2,'blah','464','aaa','haxpl2ilc20x00bj4tt2m5ti','11','11 g','G',3,'2005-06-02 22:43:10','1234567890');

CREATE TABLE t2 (
  `msisdn` varchar(15) NOT NULL default '',
  `operator_id` int(11) NOT NULL default '0',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  UNIQUE KEY `PK_user` (`msisdn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO t2 VALUES ('1234567890',2,'2005-05-24 13:53:25');
SELECT content, t2.msisdn FROM t1, t2 WHERE t1.msisdn = '1234567890';

DROP TABLE t1,t2;
SET sql_mode = default;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create table t1 (a char(20) character set utf8mb3);
insert into t1 values ('123456'),('андрей');
alter table t1 modify a char(2) character set utf8mb3;
select char_length(a), length(a), a from t1 order by a;
drop table t1;
SET sql_mode = default;
set names utf8mb3;
select 'andre%' like 'andreñ%' escape 'ñ';

--
-- Bugs#11754: SET NAMES utf8mb3 followed by SELECT "A\\" LIKE "A\\" returns 0
--
set names utf8mb3;
select 'a\\' like 'a\\';
select 'aa\\' like 'a%\\';

create table t1 (a char(10), key(a)) character set utf8mb3;
insert into t1 values ("a"),("abc"),("abcd"),("hello"),("test");
select * from t1 where a like "abc%";
select * from t1 where a like concat("abc","%");
select * from t1 where a like "ABC%";
select * from t1 where a like "test%";
select * from t1 where a like "te_t";
select * from t1 where a like "%a%";
select * from t1 where a like "%abcd%";
select * from t1 where a like "%abc\d%";
drop table t1;


--
-- Bug#9557 MyISAM utf8mb3 table crash
--
CREATE TABLE t1 (
  a varchar(255) NOT NULL default '',
  KEY a (a)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE utf8mb3_general_ci;
insert into t1 values (_utf8mb3 0xe880bd);
insert into t1 values (_utf8mb3 0x5b);
select hex(a) from t1;
drop table t1;

--
-- Bug#13751 find_in_set: Illegal mix of collations
--
set names 'latin1';
create table t1 (a varchar(255)) default charset=utf8mb3;
select * from t1 where find_in_set('-1', a);
drop table t1;

--
-- Bug#13233: select distinct char(column) fails with utf8mb3
--
create table t1 (a int);
insert into t1 values (48),(49),(50);
set names utf8mb3;
select distinct char(a) from t1;
drop table t1;

--
-- Bug#15581: COALESCE function truncates mutli-byte TINYTEXT values
--
CREATE TABLE t1 (t TINYTEXT CHARACTER SET utf8mb3);
INSERT INTO t1 VALUES(REPEAT('a', 100));
CREATE TEMPORARY TABLE t2 SELECT COALESCE(t) AS bug FROM t1;
SELECT LENGTH(bug) FROM t2;
DROP TABLE t2;
DROP TABLE t1;

--
-- Bug#17313: N'xxx' and _utf8mb3'xxx' are not equivalent
--
CREATE TABLE t1 (item varchar(255)) default character set utf8mb3;
INSERT INTO t1 VALUES (N'\\');
INSERT INTO t1 VALUES (_utf8mb3'\\');
INSERT INTO t1 VALUES (N'Cote d\'Ivoire');
INSERT INTO t1 VALUES (_utf8mb3'Cote d\'Ivoire');
SELECT item FROM t1 ORDER BY item;
DROP TABLE t1;

--
-- Bug#17705: Corruption of compressed index when index length changes between
-- 254 and 256
--

SET NAMES utf8mb3;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a VARCHAR(255), KEY(a)) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
INSERT INTO t1 VALUES('uuABCDEFGHIGKLMNOPRSTUVWXYZ̈bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
INSERT INTO t1 VALUES('uu');
INSERT INTO t1 VALUES('uU');
INSERT INTO t1 VALUES('uu');
INSERT INTO t1 VALUES('uuABC');
INSERT INTO t1 VALUES('UuABC');
INSERT INTO t1 VALUES('uuABC');
alter table t1 add b int;
INSERT INTO t1 VALUES('uuABCDEFGHIGKLMNOPRSTUVWXYZ̈bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',1);
INSERT INTO t1 VALUES('uuABCDEFGHIGKLMNOPRSTUVWXYZ̈bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',2);
delete from t1 where b=1;
INSERT INTO t1 VALUES('UUABCDEFGHIGKLMNOPRSTUVWXYZ̈bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',1);
INSERT INTO t1 VALUES('uuABCDEFGHIGKLMNOPRSTUVWXYZ̈bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',3);
INSERT INTO t1 VALUES('uuABCDEFGHIGKLMNOPRSTUVWXYZ̈bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',4);
delete from t1 where b=3;
INSERT INTO t1 VALUES('uUABCDEFGHIGKLMNOPRSTUVWXYZ̈bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',3);
drop table t1;

--
-- Bug#20471 LIKE search fails with indexed utf8mb3 char column
--
set names utf8mb3;
create table t1 (s1 char(5) character set utf8mb3);
insert into t1 values
('a'),('b'),(null),('ペテルグル'),('ü'),('Y');
create index it1 on t1 (s1);
select s1 as before_delete_general_ci from t1 where s1 like 'ペテ%';
delete from t1 where s1 = 'Y';
select s1 as after_delete_general_ci from t1 where s1 like 'ペテ%';
drop table t1;

set names utf8mb3;
create table t1 (s1 char(5) character set utf8mb3 COLLATE utf8mb3_unicode_ci);
insert into t1 values
('a'),('b'),(null),('ペテルグル'),('ü'),('Y');
create index it1 on t1 (s1);
select s1 as before_delete_unicode_ci from t1 where s1 like 'ペテ%';
delete from t1 where s1 = 'Y';
select s1 as after_delete_unicode_ci from t1 where s1 like 'ペテ%';
drop table t1;

set names utf8mb3;
create table t1 (s1 char(5) character set utf8mb3 COLLATE utf8mb3_bin);
insert into t1 values
('a'),('b'),(null),('ペテルグル'),('ü'),('Y');
create index it1 on t1 (s1);
select s1 as before_delete_bin from t1 where s1 like 'ペテ%';
delete from t1 where s1 = 'Y';
select s1 as after_delete_bin from t1 where s1 like 'ペテ%';
drop table t1;

-- additional tests from duplicate bug#20744 MySQL return no result

set names utf8mb3;
create table t1 (a varchar(30) not null primary key)
engine=innodb  default character set utf8mb3 COLLATE utf8mb3_general_ci;
insert into t1 values ('あいうえおかきくけこさしすせそ');
insert into t1 values ('さしすせそかきくけこあいうえお');
select a as gci1 from t1 where a like 'さしすせそかきくけこあいうえお%';
select a as gci2 from t1 where a like 'あいうえおかきくけこさしすせそ';
drop table t1;

set names utf8mb3;
create table t1 (a varchar(30) not null primary key)
engine=innodb default character set utf8mb3 COLLATE utf8mb3_unicode_ci;
insert into t1 values ('あいうえおかきくけこさしすせそ');
insert into t1 values ('さしすせそかきくけこあいうえお');
select a as uci1 from t1 where a like 'さしすせそかきくけこあいうえお%';
select a as uci2 from t1 where a like 'あいうえおかきくけこさしすせそ';
drop table t1;

set names utf8mb3;
create table t1 (a varchar(30) not null primary key)
engine=innodb default character set utf8mb3 COLLATE utf8mb3_bin;
insert into t1 values ('あいうえおかきくけこさしすせそ');
insert into t1 values ('さしすせそかきくけこあいうえお');
select a as bin1 from t1 where a like 'さしすせそかきくけこあいうえお%';
select a as bin2 from t1 where a like 'あいうえおかきくけこさしすせそ';
drop table t1;



--
-- Bug#14896: Comparison with a key in a partial index over mb chararacter field
--

SET NAMES utf8mb3;
CREATE TABLE t1 (id int PRIMARY KEY,
                 a varchar(16) COLLATE utf8mb3_unicode_ci NOT NULL default '',
                 b int,
                 f varchar(128) default 'XXX',
                 INDEX (a(4))
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
INSERT INTO t1(id, a, b) VALUES
  (1, 'cccc', 50), (2, 'cccc', 70), (3, 'cccc', 30),
  (4, 'cccc', 30), (5, 'cccc', 20), (6, 'bbbbbb', 40),
  (7, 'dddd', 30), (8, 'aaaa', 10), (9, 'aaaa', 50),
  (10, 'eeeee', 40), (11, 'bbbbbb', 60);
SELECT id, a, b FROM t1;
SELECT id, a, b FROM t1 WHERE a BETWEEN 'aaaa' AND 'bbbbbb';
SELECT id, a FROM t1 WHERE a='bbbbbb';
SELECT id, a FROM t1 WHERE a='bbbbbb' ORDER BY b;

DROP TABLE t1;

--
-- Bug#16674: LIKE predicate for a utf8mb3 character set column
--

SET NAMES utf8mb3;

CREATE TABLE t1 (
  a CHAR(13) DEFAULT '',
  INDEX(a)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8_general_ci;
INSERT INTO t1 VALUES 
 ('Käli Käli 2-4'), ('Käli Käli 2-4'),
 ('Käli Käli 2+4'), ('Käli Käli 2+4'),
 ('Käli Käli 2-6'), ('Käli Käli 2-6');
INSERT INTO t1 SELECT * FROM t1;

CREATE TABLE t2 (
  a CHAR(13) DEFAULT '',
  INDEX(a)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

INSERT INTO t2 VALUES
 ('Kali Kali 2-4'), ('Kali Kali 2-4'),
 ('Kali Kali 2+4'), ('Kali Kali 2+4'),
 ('Kali Kali 2-6'), ('Kali Kali 2-6');
INSERT INTO t2 SELECT * FROM t2;

SELECT a FROM t1 WHERE a LIKE 'Käli Käli 2+4';
SELECT a FROM t2 WHERE a LIKE 'Kali Kali 2+4';

DROP TABLE t1,t2;

CREATE TABLE t1 (
  a char(255) DEFAULT '', 
  KEY(a(10))
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8_general_ci;
INSERT INTO t1 VALUES ('Käli Käli 2-4');
SELECT * FROM t1 WHERE a LIKE 'Käli Käli 2%';
INSERT INTO t1 VALUES ('Käli Käli 2-4');
SELECT * FROM t1 WHERE a LIKE 'Käli Käli 2%';
DROP TABLE t1;

CREATE TABLE t1 (
  a char(255) DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8_general_ci;
INSERT INTO t1 VALUES ('Käli Käli 2-4');
INSERT INTO t1 VALUES ('Käli Käli 2-4');
SELECT * FROM t1 WHERE a LIKE 'Käli Käli 2%';
ALTER TABLE t1 ADD KEY (a(10));
SELECT * FROM t1 WHERE a LIKE 'Käli Käli 2%';
DROP TABLE t1;

--
-- Bug#18359: LIKE predicate for a 'utf8mb3' text column with a partial index
--            (see bug #16674 as well)
--

SET NAMES latin2;

CREATE TABLE t1 (
  id int(11) NOT NULL default '0',
  tid int(11) NOT NULL default '0',
  val text NOT NULL,
  INDEX idx(tid, val(10))
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

INSERT INTO t1 VALUES
  (40988,72,'VOLN� ADSL'),(41009,72,'VOLN� ADSL'),
  (41032,72,'VOLN� ADSL'),(41038,72,'VOLN� ADSL'),
  (41063,72,'VOLN� ADSL'),(41537,72,'VOLN� ADSL Office'),
  (42141,72,'VOLN� ADSL'),(42565,72,'VOLN� ADSL Combi'),
  (42749,72,'VOLN� ADSL'),(44205,72,'VOLN� ADSL');

SELECT * FROM t1 WHERE tid=72 and val LIKE 'VOLNY ADSL';
SELECT * FROM t1 WHERE tid=72 and val LIKE 'VOLN� ADSL';
SELECT * FROM t1 WHERE tid=72 and val LIKE '%VOLN� ADSL';

ALTER TABLE t1 DROP KEY idx;
ALTER TABLE t1 ADD KEY idx (tid,val(11));

SELECT * FROM t1 WHERE tid=72 and val LIKE 'VOLN� ADSL';

DROP TABLE t1;

--
-- Bug 20709: problem with utf8mb3 fields in temporary tables
--

create table t1(a char(200) COLLATE utf8mb3_unicode_ci NOT NULL default '')
  default charset=utf8mb3 collate=utf8_unicode_ci;
insert into t1 values (unhex('65')), (unhex('C3A9')), (unhex('65'));
select distinct a from t1;
select a from t1 group by a;
drop table t1;

--
-- Bug #20204: "order by" changes the results returned
--

create table t1(a char(10)) default charset utf8mb3;
insert into t1 values ('123'), ('456');
  select substr(z.a,-1), z.a from t1 as y join t1 as z on y.a=z.a order by 1;
select substr(z.a,-1), z.a from t1 as y join t1 as z on y.a=z.a order by 1;
drop table t1;

--
-- Bug #34349: Passing invalid parameter to CHAR() in an ORDER BY causes
-- MySQL to hang
--

SET CHARACTER SET utf8mb3;
CREATE DATABASE crashtest DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_bin;
USE crashtest;
CREATE TABLE crashtest (crash char(10)) DEFAULT CHARSET=utf8mb3;
INSERT INTO crashtest VALUES ('35'), ('36'), ('37');
SELECT * FROM crashtest ORDER BY CHAR(crash USING utf8mb3);
INSERT INTO crashtest VALUES ('-1000');
SELECT * FROM crashtest ORDER BY CHAR(crash USING utf8mb3);
DROP TABLE crashtest;
DROP DATABASE crashtest;
USE test;
SET CHARACTER SET default;

-- End of 4.1 tests

--
-- Test for bug #11484: wrong results for a DISTINCT varchar column in uft8. 
--

CREATE TABLE t1(id varchar(20) NOT NULL) DEFAULT CHARSET=utf8mb3;
INSERT INTO t1 VALUES ('xxx'), ('aa'), ('yyy'), ('aa');

SELECT id FROM t1;
SELECT DISTINCT id FROM t1;
SELECT DISTINCT id FROM t1 ORDER BY id;

DROP TABLE t1;

--
-- Bug#20095 Changing length of VARCHAR field with utf8mb3
-- collation does not truncate values
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create table t1 (
  a varchar(26) not null
) default character set utf8mb3;
insert into t1 (a) values ('abcdefghijklmnopqrstuvwxyz');
select * from t1;
alter table t1 change a a varchar(20) character set utf8mb3 not null;
select * from t1;
alter table t1 change a a char(15) character set utf8mb3 not null;
select * from t1;
alter table t1 change a a char(10) character set utf8mb3 not null;
select * from t1;
alter table t1 change a a varchar(5) character set utf8mb3 not null;
select * from t1;
drop table t1;

--
-- Check that do_varstring2_mb produces a warning
--
create table t1 (
  a varchar(4000) not null
) default character set utf8mb3;
insert into t1 values (repeat('a',4000));
alter table t1 change a a varchar(3000) character set utf8mb3 not null;
select length(a) from t1;
drop table t1;
SET sql_mode = default;

--
--  Bug#10504: Character set does not support traditional mode
--  Bug#14146: CHAR(...USING ...) and CONVERT(CHAR(...) USING...)
--             produce different results
--
set names utf8mb3;
select hex(char(1 using utf8mb3));
select char(0xd1,0x8f using utf8mb3);
select char(0xd18f using utf8mb3);
select char(53647 using utf8mb3);
select char(0xff,0x8f using utf8mb3);
select convert(char(0xff,0x8f) using utf8mb3);
set sql_mode=traditional;
select char(0xff,0x8f using utf8mb3);
select char(195 using utf8mb3);
select char(196 using utf8mb3);
select char(2557 using utf8mb3);
select convert(char(0xff,0x8f) using utf8mb3);

--
-- Check convert + char + using
--
select hex(convert(char(2557 using latin1) using utf8mb3));

--
-- char() without USING returns "binary" by default, any argument is ok
--
select hex(char(195));
select hex(char(196));
select hex(char(2557));



--
-- Bug#12891: UNION doesn't return DISTINCT result for multi-byte characters
--
set names utf8mb3;
create table t1 (a char(1)) default character set utf8mb3;
create table t2 (a char(1)) default character set utf8mb3;
insert into t1 values('a'),('a'),(0xE38182),(0xE38182);
insert into t1 values('i'),('i'),(0xE38184),(0xE38184);
select * from t1 union distinct select * from t2;
drop table t1,t2;


--
-- Bug#12371: executing prepared statement fails (illegal mix of collations)
--
set names utf8mb3;
create table t1 (a char(10), b varchar(10));
insert into t1 values ('bar','kostja');
insert into t1 values ('kostja','bar');
set @a:='bar';
set @a:='kostja';
set @a:=null;
drop table if exists t1;


--
-- Bug#21505 Create view - illegal mix of collation for operation 'UNION'
--
--disable_warnings
drop table if exists t1;
drop view if exists v1, v2;
set names utf8mb3;
create table t1(col1 varchar(12) character set utf8mb3 COLLATE utf8mb3_unicode_ci);
insert into t1 values('t1_val');
create view v1 as select 'v1_val' as col1;
select coercibility(col1), collation(col1) from v1;
create view v2 as select col1 from v1 union select col1 from t1;
select coercibility(col1), collation(col1)from v2;
drop view v1, v2;
create view v1 as select 'v1_val' COLLATE utf8mb3_swedish_ci as col1;
select coercibility(col1), collation(col1) from v1;
create view v2 as select col1 from v1 union select col1 from t1;
select coercibility(col1), collation(col1) from v2;
drop view v1, v2;
drop table t1;

--
-- Check conversion of NCHAR strings to subset (e.g. latin1).
-- Conversion is possible if string repertoire is ASCII.
-- Conversion is not possible if the string have extended characters
--
set names utf8mb3;
create table t1 (a varchar(10) character set latin1, b int);
insert into t1 values ('a',1);
select concat(a, if(b>10, N'x', N'y')) from t1;
select concat(a, if(b>10, N'æ', N'ß')) from t1;
drop table t1;

-- Conversion tests for character set introducers
set names utf8mb3;
create table t1 (a varchar(10) character set latin1, b int);
insert into t1 values ('a',1);
select concat(a, if(b>10, _utf8mb3'x', _utf8mb3'y')) from t1;
select concat(a, if(b>10, _utf8mb3'æ', _utf8mb3'ß')) from t1;
drop table t1;

-- Conversion tests for introducer + HEX string
set names utf8mb3;
create table t1 (a varchar(10) character set latin1, b int);
insert into t1 values ('a',1);
select concat(a, if(b>10, _utf8mb3 0x78, _utf8mb3 0x79)) from t1;
select concat(a, if(b>10, _utf8mb3 0xC3A6, _utf8mb3 0xC3AF)) from t1;
drop table t1;

-- Conversion tests for "text_literal TEXT_STRING_literal" syntax structure
set names utf8mb3;
create table t1 (a varchar(10) character set latin1, b int);
insert into t1 values ('a',1);
select concat(a, if(b>10, 'x' 'x', 'y' 'y')) from t1;
select concat(a, if(b>10, 'x' 'æ', 'y' 'ß')) from t1;
drop table t1;

--
-- Bug#19960: Inconsistent results when joining
-- InnoDB tables using partial utf8mb3 indexes
--

CREATE TABLE t1 (
  colA int(11) NOT NULL,
  colB varchar(255) character set utf8mb3 NOT NULL,
   PRIMARY KEY  (colA)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t1 (colA, colB) VALUES (1, 'foo'), (2, 'foo bar');
CREATE TABLE t2 (
  colA int(11) NOT NULL,
  colB varchar(255) character set utf8mb3 NOT NULL,
   KEY bad  (colA,colB(3))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t2 (colA, colB) VALUES (1, 'foo'),(2, 'foo bar');
SELECT * FROM t1 JOIN t2 ON t1.colA=t2.colA AND t1.colB=t2.colB
WHERE t1.colA < 3;
DROP TABLE t1, t2;

--
-- Bug#29205: truncation of utf8mb3 values when the UNION statement
-- forces collation to the binary charset
--

SELECT 'н1234567890' UNION SELECT _binary '1';
SELECT 'н1234567890' UNION SELECT 1;

SELECT '1' UNION SELECT 'н1234567890';
SELECT 1 UNION SELECT 'н1234567890';

CREATE TABLE t1 (c VARCHAR(11)) CHARACTER SET utf8mb3;
CREATE TABLE t2 (b CHAR(1) CHARACTER SET binary, i INT);

INSERT INTO t1 (c) VALUES ('н1234567890');
INSERT INTO t2 (b, i) VALUES ('1', 1);

SELECT c FROM t1 UNION SELECT b FROM t2;
SELECT c FROM t1 UNION SELECT i FROM t2;

SELECT b FROM t2 UNION SELECT c FROM t1;
SELECT i FROM t2 UNION SELECT c FROM t1;

DROP TABLE t1, t2;

--
-- Bug#30982: CHAR(..USING..) can return a not-well-formed string
-- Bug #30986: Character set introducer followed by a HEX string can return bad result
--
set sql_mode=traditional;
select hex(char(0xFF using utf8mb3));
select hex(convert(0xFF using utf8mb3));
select hex(_utf8mb3 0x616263FF);
select hex(_utf8mb3 X'616263FF');
select hex(_utf8mb3 B'001111111111');
select (_utf8mb3 X'616263FF');
set sql_mode=default;
select hex(char(0xFF using utf8mb3));
select hex(convert(0xFF using utf8mb3));
select hex(_utf8mb3 0x616263FF);
select hex(_utf8mb3 X'616263FF');
select hex(_utf8mb3 B'001111111111');
select (_utf8mb3 X'616263FF');
CREATE TABLE t1 (id int not null primary key, name varchar(10)) character set utf8mb3;
INSERT INTO t1 VALUES
(2,'一二三01'),(3,'一二三09'),(4,'一二三02'),(5,'一二三08'),
(6,'一二三11'),(7,'一二三91'),(8,'一二三21'),(9,'一二三81');
SELECT * FROM t1 ORDER BY BINARY(name);
DROP TABLE t1;

--
-- Bug #36772: When using utf8mb3, CONVERT with GROUP BY returns truncated results
--
CREATE TABLE t1 (a INT NOT NULL, b INT NOT NULL);
INSERT INTO t1 VALUES (70000, 1092), (70001, 1085), (70002, 1065);
SELECT CONVERT(a, CHAR), CONVERT(b, CHAR) FROM t1 GROUP BY b;
SELECT CONVERT(a, CHAR), CONVERT(b, CHAR) FROM t1;
ALTER TABLE t1 ADD UNIQUE (b);
SELECT CONVERT(a, CHAR), CONVERT(b, CHAR) FROM t1 GROUP BY b;
DROP INDEX b ON t1;
SELECT CONVERT(a, CHAR), CONVERT(b, CHAR) FROM t1 GROUP BY b;
ALTER TABLE t1 ADD INDEX (b);
SELECT CONVERT(a, CHAR), CONVERT(b, CHAR) from t1 GROUP BY b;

DROP TABLE t1;


--
-- Bug #57272: crash in rpad() when using utf8mb3
--
SELECT LENGTH(RPAD(0.0115E88, 61297, _utf8mb3'яэюя'));
SELECT LENGTH(RPAD(0.0115E88, 61297, _utf8mb3'йцуя'));
SELECT HEX(RPAD(0x20, 2, _utf8mb3 0xD18F));
SELECT HEX(RPAD(0x20, 4, _utf8mb3 0xD18F));
SELECT HEX(LPAD(0x20, 2, _utf8mb3 0xD18F));
SELECT HEX(LPAD(0x20, 4, _utf8mb3 0xD18F));

SELECT HEX(RPAD(_utf8mb3 0xD18F, 3, 0x20));
SELECT HEX(LPAD(_utf8mb3 0xD18F, 3, 0x20));

SELECT HEX(INSERT(_utf8mb3 0xD18F, 2, 1, 0x20));
SELECT HEX(INSERT(_utf8mb3 0xD18FD18E, 2, 1, 0x20));
CREATE TABLE t1 (a VARCHAR(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_mysql500_ci);
INSERT INTO t1 VALUES ('a'),('r'),('s'),(_latin1 0xDF),(_latin1 0xF7),('t'),('z');
SELECT * FROM t1 ORDER BY a;
SELECT a, COUNT(*) FROM t1 GROUP BY a;
DROP TABLE t1;

--
-- WL#1213: utf8mb3 is an alias for utf8mb3
--
SET NAMES utf8mb3;
CREATE TABLE t1 (a CHAR CHARACTER SET utf8mb3 COLLATE utf8mb3_bin);
DROP TABLE t1;
SELECT _utf8mb3'test';

--
-- Bug#26180: Can't add columns to tables created with utf8mb3 text indexes
--
CREATE TABLE t1 (
  clipid INT NOT NULL,
  Tape TINYTEXT,
  PRIMARY KEY (clipid),
  KEY tape(Tape(85))
) CHARACTER SET=utf8mb3;
ALTER TABLE t1 ADD mos TINYINT DEFAULT 0 AFTER clipid;
DROP TABLE t1;

--
-- Bug#26474: Add Sinhala script (Sri Lanka) collation to MySQL
--
--disable_warnings
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (
        predicted_order int NOT NULL,
        utf8_encoding VARCHAR(10) NOT NULL
) CHARACTER SET utf8mb3;
INSERT INTO t1 VALUES (19, x'E0B696'), (30, x'E0B69AE0B798'), (61, x'E0B6AF'), (93, x'E0B799'), (52, x'E0B6A6'), (73, x'E0B6BBE0B78AE2808D'), (3, x'E0B686'), (56, x'E0B6AA'), (55, x'E0B6A9'), (70, x'E0B6B9'), (94, x'E0B79A'), (80, x'E0B785'), (25, x'E0B69AE0B791'), (48, x'E0B6A2'), (13, x'E0B690'), (86, x'E0B793'), (91, x'E0B79F'), (81, x'E0B786'), (79, x'E0B784'), (14, x'E0B691'), (99, x'E0B78A'), (8, x'E0B68B'), (68, x'E0B6B7'), (22, x'E0B69A'), (16, x'E0B693'), (33, x'E0B69AE0B7B3'), (38, x'E0B69AE0B79D'), (21, x'E0B683'), (11, x'E0B68E'), (77, x'E0B782'), (40, x'E0B69AE0B78A'), (101, x'E0B78AE2808DE0B6BB'), (35, x'E0B69AE0B79A'), (1, x'E0B7B4'), (9, x'E0B68C'), (96, x'E0B79C'), (6, x'E0B689'), (95, x'E0B79B'), (88, x'E0B796'), (64, x'E0B6B3'), (26, x'E0B69AE0B792'), (82, x'E0B78F'), (28, x'E0B69AE0B794'), (39, x'E0B69AE0B79E'), (97, x'E0B79D'), (2, x'E0B685'), (75, x'E0B780'), (34, x'E0B69AE0B799'), (69, x'E0B6B8'), (83, x'E0B790'), (18, x'E0B695'), (90, x'E0B7B2'), (17, x'E0B694'), (72, x'E0B6BB'), (66, x'E0B6B5'), (59, x'E0B6AD'), (44, x'E0B69E'), (15, x'E0B692'), (23, x'E0B69AE0B78F'), (65, x'E0B6B4'), (42, x'E0B69C'), (63, x'E0B6B1'), (85, x'E0B792'), (47, x'E0B6A1'), (49, x'E0B6A3'), (92, x'E0B7B3'), (78, x'E0B783'), (36, x'E0B69AE0B79B'), (4, x'E0B687'), (24, x'E0B69AE0B790'), (87, x'E0B794'), (37, x'E0B69AE0B79C'), (32, x'E0B69AE0B79F'), (29, x'E0B69AE0B796'), (43, x'E0B69D'), (62, x'E0B6B0'), (100, x'E0B78AE2808DE0B6BA'), (60, x'E0B6AE'), (45, x'E0B69F'), (12, x'E0B68F'), (46, x'E0B6A0'), (50, x'E0B6A5'), (51, x'E0B6A4'), (5, x'E0B688'), (76, x'E0B781'), (89, x'E0B798'), (74, x'E0B6BD'), (10, x'E0B68D'), (57, x'E0B6AB'), (71, x'E0B6BA'), (58, x'E0B6AC'), (27, x'E0B69AE0B793'), (54, x'E0B6A8'), (84, x'E0B791'), (31, x'E0B69AE0B7B2'), (98, x'E0B79E'), (53, x'E0B6A7'), (41, x'E0B69B'), (67, x'E0B6B6'), (7, x'E0B68A'), (20, x'E0B682');
SELECT predicted_order, hex(utf8_encoding) FROM t1 ORDER BY utf8_encoding COLLATE utf8mb3_sinhala_ci;
DROP TABLE t1;
SET NAMES utf8mb3 COLLATE utf8mb3_sinhala_ci;
CREATE TABLE t1 (s1 VARCHAR(10) COLLATE utf8mb3_sinhala_ci);
INSERT INTO t1 VALUES ('a'),('ae'),('af');
SELECT s1,hex(s1) FROM t1 ORDER BY s1;
SELECT * FROM t1 ORDER BY s1;
DROP TABLE t1;
CREATE TABLE t1 (
  s1 TINYTEXT CHARACTER SET utf8mb3,
  s2 TEXT CHARACTER SET utf8mb3,
  s3 MEDIUMTEXT CHARACTER SET utf8mb3,
  s4 LONGTEXT CHARACTER SET utf8mb3
);
SET NAMES utf8mb3, @@character_set_results=NULL;
SELECT *, HEX(s1) FROM t1;
SET NAMES latin1;
SELECT *, HEX(s1) FROM t1;
SET NAMES utf8mb3;
SELECT *, HEX(s1) FROM t1;
CREATE TABLE t2 AS SELECT CONCAT(s1) FROM t1;
DROP TABLE t1, t2;


SET NAMES utf8mb3;
SELECT @@collation_connection;
CREATE TABLE t1 (a MEDIUMINT NULL) ENGINE=MYISAM;
INSERT INTO t1 VALUES (1234567);
SELECT GROUP_CONCAT(IFNULL(a,'')) FROM t1;
SELECT GROUP_CONCAT(IF(a,a,'')) FROM t1;
SELECT GROUP_CONCAT(CASE WHEN a THEN a ELSE '' END) FROM t1;
SELECT COALESCE(a,'') FROM t1 GROUP BY 1;
CREATE TABLE t2 AS
SELECT
  CONCAT(a),
  IFNULL(a,''),
  IF(a,a,''),
  CASE WHEN a THEN a ELSE '' END,
  COALESCE(a,'')
FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT CONCAT_WS(1,2,3) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT INSERT(1133,3,0,22) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT LCASE(a) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT UCASE(a) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT REPEAT(1,2) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT LEFT(123,2) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT RIGHT(123,2) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT LTRIM(123) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT RTRIM(123) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT ELT(1,111,222,333) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT REPLACE(111,2,3) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT SUBSTRING_INDEX(111,111,1) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT MAKE_SET(111,222,3) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT SOUNDEX(1) FROM t1;
DROP TABLE t2;

CREATE TABLE t2 AS SELECT EXPORT_SET(1,'ST_Y','N','',8);
DROP TABLE t2;

DROP TABLE t1;
SET NAMES utf8mb3;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (0), (0), (1), (0), (0);
SELECT COUNT(*) FROM t1, t1 t2 
GROUP BY INSERT('', t2.a, t1.a, (@@global.max_binlog_size));
DROP TABLE t1;
SET NAMES latin1;
SET NAMES utf8mb3;

SET NAMES utf8mb3;
SELECT id, CHAR_LENGTH(GROUP_CONCAT(body)) AS l
FROM (SELECT 'a' AS id, REPEAT('foo bar', 100) AS body
UNION ALL
SELECT 'a' AS id, REPEAT('bla bla', 100) AS body) t1
GROUP BY id
ORDER BY l DESC;

set names utf8mb3;

set @@collation_connection=utf8_bin;
set max_sort_length=5;
select @@max_sort_length;
create table t1 (a varchar(128) character set utf8mb3 COLLATE utf8mb3_general_ci);
insert into t1 values ('a'),('b'),('c');
select * from t1 order by a;
alter table t1 modify a varchar(128) character set utf8mb3 COLLATE utf8mb3_bin;
select * from t1 order by a;
drop table t1;
set max_sort_length=default;

SET NAMES utf8mb3;

SET NAMES utf8mb3;
CREATE TABLE t1(c1 INT);
INSERT INTO t1 VALUES(1),(2),(3);
SELECT hex(convert( substr(_utf8mb3 0xE5A4A7E4B88DE58897E9A2A0E58F8AE58C97E788B1E5B094E585B0E88194E59088E78E8BE59BBD, 1, 15), BINARY)) FROM t1;
SELECT hex(convert( substr('大不列颠及北爱尔兰联合王国', 1, 15), BINARY)) FROM t1;
DROP TABLE t1;

CREATE TABLE t1(c1 TINYTEXT CHARACTER SET utf8mb4);
CREATE TABLE t2(c2 TINYTEXT CHARACTER SET latin1);

INSERT INTO t1 (c1) VALUES(REPEAT('A', 255));
INSERT INTO t1 (c1) VALUES(REPEAT('A', 256));

INSERT INTO t1 (c1) VALUES(REPEAT(X'C385', 127));
INSERT INTO t1 (c1) VALUES(REPEAT(X'C385', 128));
INSERT INTO t1 (c1) VALUES(REPEAT(X'C385', 129));
INSERT INTO t1 (c1) VALUES(CONCAT('a', REPEAT(X'C385', 128)));
INSERT INTO t2 (c2) VALUES(REPEAT(_utf8mb4 0xE0B295, 128));

DROP TABLE t1;
DROP TABLE t2;
