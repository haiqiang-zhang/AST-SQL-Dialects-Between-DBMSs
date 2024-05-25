SELECT HEX(a) FROM t2;
CREATE TABLE t1 (description text character set cp1250 NOT NULL);
INSERT INTO t1 (description) VALUES (_latin2'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasssssssssssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddde');
SELECT description FROM t1;
DROP TABLE t1;
SELECT HEX(a) FROM t2;
CREATE TABLE `ÃÂÃÂÃÂÃÂÃÂÃÂÃÂ`
(
  ÃÂÃÂÃÂÃÂ CHAR(32) CHARACTER SET koi8r NOT NULL COMMENT "ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ ÃÂÃÂÃÂÃÂ"
) COMMENT "ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ ÃÂÃÂÃÂÃÂÃÂÃÂÃÂ";
DROP TABLE ÃÂÃÂÃÂÃÂÃÂÃÂÃÂ;
CREATE TABLE t1 (t text) DEFAULT CHARSET utf8mb3;
INSERT INTO t1 (t) VALUES ('x');
SELECT 1 FROM t1 WHERE CONCAT(_latin1'x') = t;
DROP TABLE t1;
CREATE DATABASE ÃÂÃÂÃÂÃÂ;
DROP DATABASE ÃÂÃÂÃÂÃÂ;
SELECT hex('ÃÂÃÂÃÂÃÂ');
SELECT hex('ÃÂÃÂÃÂÃÂ');
CREATE TABLE `ÃÂÃÂÃÂÃÂµÃÂÃÂÃÂÃÂ` (`ÃÂÃÂÃÂÃÂµÃÂÃÂÃÂÃÂ` int);
DROP TABLE `ÃÂÃÂÃÂÃÂµÃÂÃÂÃÂÃÂ`;
SELECT 'ÃÂÃÂÃÂÃÂµÃÂÃÂÃÂÃÂ' as s;
SELECT 'ÃÂÃÂÃÂÃÂµÃÂÃÂÃÂÃÂ' as s;
CREATE TABLE t1 (`ÃÂ¤` CHAR(128) DEFAULT 'ÃÂ¤', `ÃÂ¤1` ENUM('ÃÂ¤1','ÃÂ¤2') DEFAULT 'ÃÂ¤2');
DROP TABLE t1;
CREATE TABLE `goodÃÂÃÂÃÂÃÂÃÂ` (a int);
create table t1 (a char(10) character set koi8r, b text character set koi8r);
insert into t1 values ('test','test');
insert ignore into t1 values ('ÃÂÃÂÃÂÃÂ','ÃÂÃÂÃÂÃÂ');
drop table t1;
create table t1 (a char(10) character set cp1251);
drop table t1;
create table t1 (a char(1) character set latin1);
insert into t1 values ('a');
select * from t1 where a='a';
drop table t1;
create table t1 (a char(10) character set utf8mb3 COLLATE utf8mb3_bin);
insert into t1 values ('       xxx');
select * from t1 where a=lpad('xxx',10,' ');
drop table t1;
create table t1 (c1 char(10) character set cp1251);
select substring_index(c1,'ÃÂ¶ÃÂ¶ÃÂÃÂ',2) from t1;
select trim(c1 from 'ÃÂ'),trim('ÃÂ' from c1) from t1;
drop table t1;
create table t1(a char character set cp1251 default _koi8r 0xFF);
drop table t1;
