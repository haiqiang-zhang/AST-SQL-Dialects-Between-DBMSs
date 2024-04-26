
SET CHARACTER SET koi8r;
DROP TABLE IF EXISTS �������, t1, t2;

SET CHARACTER SET koi8r;
CREATE TABLE t1 (a CHAR(10) CHARACTER SET cp1251) SELECT _koi8r'�����' AS a;
CREATE TABLE t2 (a CHAR(10) CHARACTER SET utf8mb3);
SELECT a FROM t1;
SELECT HEX(a) FROM t1;
INSERT t2 SELECT * FROM t1;
SELECT HEX(a) FROM t2;
DROP TABLE t1, t2;


--
-- Check that long strings conversion does not fail (bug#2218)
--
CREATE TABLE t1 (description text character set cp1250 NOT NULL);
INSERT INTO t1 (description) VALUES (_latin2'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasssssssssssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddde');
SELECT description FROM t1;
DROP TABLE t1;

-- same with TEXT
CREATE TABLE t1 (a TEXT CHARACTER SET cp1251) SELECT _koi8r'�����' AS a;
CREATE TABLE t2 (a TEXT CHARACTER SET utf8mb3);
SELECT HEX(a) FROM t1;
INSERT t2 SELECT * FROM t1;
SELECT HEX(a) FROM t2;
DROP TABLE t1, t2;

CREATE TABLE `�������`
(
  ���� CHAR(32) CHARACTER SET koi8r NOT NULL COMMENT "����������� ����"
) COMMENT "����������� �������";

SET CHARACTER SET cp1251;


SET CHARACTER SET utf8mb3;

SET CHARACTER SET koi8r;
DROP TABLE �������;
SET CHARACTER SET default;

-- Test for Item_func_conv_charset::fix_fields (bug #3704)
SET NAMES utf8mb3;
CREATE TABLE t1 (t text) DEFAULT CHARSET utf8mb3;
INSERT INTO t1 (t) VALUES ('x');
SELECT 1 FROM t1 WHERE CONCAT(_latin1'x') = t;
DROP TABLE t1;

SET CHARACTER SET koi8r;
CREATE DATABASE ����;
USE ����;
SET CHARACTER SET cp1251;
SET CHARACTER SET koi8r;
DROP DATABASE ����;

SET NAMES koi8r;
SELECT hex('����');
SET character_set_connection=cp1251;
SELECT hex('����');

USE test;

-- Bug#4417
-- Check that identifiers and strings are not converted 
-- when the client character set is binary.

SET NAMES binary;
CREATE TABLE `тест` (`тест` int);
SET NAMES utf8mb3;
DROP TABLE `тест`;
SET NAMES binary;
SET character_set_connection=utf8mb3;
SELECT 'тест' as s;
SET NAMES utf8mb3;
SET character_set_connection=binary;
SELECT 'тест' as s;

-- Bug#4417, another aspect:

--Replace default engine value with static engine string 
--replace_result $DEFAULT_ENGINE ENGINE
-- Check that both "SHOW CREATE TABLE" and "SHOW COLUMNS"
-- return column names and default values in utf8mb3 after "SET NAMES BINARY"

SET NAMES latin1;

CREATE TABLE t1 (`�` CHAR(128) DEFAULT '�', `�1` ENUM('�1','�2') DEFAULT '�2');
SET NAMES binary;
DROP TABLE t1;


--
-- Test that we allow only well-formed utf8mb3 identitiers
--
SET NAMES binary;
CREATE TABLE `good�����` (a int);
SET NAMES utf8mb3;
CREATE TABLE `good�����` (a int);


--
-- Test that we produce a warnign when conversion loses data.
--
set names latin1;
create table t1 (a char(10) character set koi8r, b text character set koi8r);
insert into t1 values ('test','test');
insert ignore into t1 values ('����','����');
drop table t1;

--
-- Try to  apply an automatic conversion in some cases:
-- E.g. when mixing a column to a string, the string
-- is converted into the column character set.
-- If conversion loses data, then error. Otherwise,
-- the string is replaced by its converted representation
--
set names koi8r;
create table t1 (a char(10) character set cp1251);
insert into t1 values (_koi8r'����');
select * from t1 where a=_koi8r'����';
select * from t1 where a=concat(_koi8r'����');
select * from t1 where a=_latin1'����';
drop table t1;
set names latin1;

--
-- Test the same with ascii
--
set names ascii;
create table t1 (a char(1) character set latin1);
insert into t1 values ('a');
select * from t1 where a='a';
drop table t1;
set names latin1;

--
-- Bug#10446 Illegal mix of collations
--
create table t1 (a char(10) character set utf8mb3 COLLATE utf8mb3_bin);
insert into t1 values ('       xxx');
select * from t1 where a=lpad('xxx',10,' ');
drop table t1;

--
-- Check more automatic conversion
--
set names koi8r;
create table t1 (c1 char(10) character set cp1251);
insert into t1 values ('�');
select c1 from t1 where c1 between '�' and '�';
select ifnull(c1,'�'), ifnull(null,c1) from t1;
select if(1,c1,'�'), if(0,c1,'�') from t1;
select coalesce('�',c1), coalesce(null,c1) from t1;
select least(c1,'�'), greatest(c1,'�') from t1;
select locate(c1,'�'), locate('�',c1) from t1;
select field(c1,'�'),field('�',c1) from t1;
select concat(c1,'�'), concat('�',c1) from t1;
select concat_ws(c1,'�','�'), concat_ws('�',c1,'�') from t1;
select replace(c1,'�','�'), replace('�',c1,'�') from t1;
select substring_index(c1,'����',2) from t1;
select elt(1,c1,'�'),elt(1,'�',c1) from t1;
select make_set(3,c1,'�'), make_set(3,'�',c1) from t1;
select insert(c1,1,2,'�'),insert('�',1,2,c1) from t1;
select trim(c1 from '�'),trim('�' from c1) from t1;
select lpad(c1,3,'�'), lpad('�',3,c1) from t1;
select rpad(c1,3,'�'), rpad('�',3,c1) from t1;
drop table t1;
 
--
-- Bug 20695: problem with field default value's character set
--

set names koi8r;
create table t1(a char character set cp1251 default _koi8r 0xFF);
drop table t1;
create table t1(a char character set latin1 default _cp1251 0xFF);