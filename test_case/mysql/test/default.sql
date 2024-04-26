
--
-- test of already fixed bugs
--
--disable_warnings
drop table if exists t1,t2,t3,t4,t5,t6;
drop database if exists mysqltest;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 (a varchar(30) binary NOT NULL DEFAULT ' ',
                 b varchar(1) binary NOT NULL DEFAULT ' ',
		 c varchar(4) binary NOT NULL DEFAULT '0000',
		 d tinyblob NULL,
		 e tinyblob NULL,
		 f tinyblob NULL,
		 g tinyblob NULL,
		 h tinyblob NULL,
		 i tinyblob NULL,
		 j tinyblob NULL,
		 k tinyblob NULL,
		 l tinyblob NULL,
		 m tinyblob NULL,
		 n tinyblob NULL,
		 o tinyblob NULL,
		 p tinyblob NULL,
                 q varchar(30) binary NOT NULL DEFAULT ' ',
                 r varchar(30) binary NOT NULL DEFAULT ' ',
		 s tinyblob NULL,
                 t varchar(4) binary NOT NULL DEFAULT ' ',
                 u varchar(1) binary NOT NULL DEFAULT ' ',
                 v varchar(30) binary NOT NULL DEFAULT ' ',
                 w varchar(30) binary NOT NULL DEFAULT ' ',
		 x tinyblob NULL,
                 y varchar(5) binary NOT NULL DEFAULT ' ',
                 z varchar(20) binary NOT NULL DEFAULT ' ',
                 a1 varchar(30) binary NOT NULL DEFAULT ' ',
		 b1 tinyblob NULL)
ENGINE=InnoDB DEFAULT CHARACTER SET = latin1 COLLATE latin1_bin;

INSERT into t1 (b) values ('1');
SELECT * from t1;

CREATE TABLE t2 (a varchar(30) binary NOT NULL DEFAULT ' ',
                 b varchar(1) binary NOT NULL DEFAULT ' ',
		 c varchar(4) binary NOT NULL DEFAULT '0000',
		 d tinyblob NULL,
		 e tinyblob NULL,
		 f tinyblob NULL,
		 g tinyblob NULL,
		 h tinyblob NULL,
		 i tinyblob NULL,
		 j tinyblob NULL,
		 k tinyblob NULL,
		 l tinyblob NULL,
		 m tinyblob NULL,
		 n tinyblob NULL,
		 o tinyblob NULL,
		 p tinyblob NULL,
                 q varchar(30) binary NOT NULL DEFAULT ' ',
                 r varchar(30) binary NOT NULL DEFAULT ' ',
		 s tinyblob NULL,
                 t varchar(4) binary NOT NULL DEFAULT ' ',
                 u varchar(1) binary NOT NULL DEFAULT ' ',
                 v varchar(30) binary NOT NULL DEFAULT ' ',
                 w varchar(30) binary NOT NULL DEFAULT ' ',
		 x tinyblob NULL,
                 y varchar(5) binary NOT NULL DEFAULT ' ',
                 z varchar(20) binary NOT NULL DEFAULT ' ',
                 a1 varchar(30) binary NOT NULL DEFAULT ' ',
		 b1 tinyblob NULL)
DEFAULT CHARACTER SET = latin1 COLLATE latin1_bin;
INSERT into t2 (b) values ('1');
SELECT * from t2;

drop table t1;
drop table t2;


--
-- Bug#20691: DATETIME col (NOT NULL, NO DEFAULT) may insert garbage when specifying DEFAULT
--
-- From the docs:
--  If the column can take NULL as a value, the column is defined with an
--  explicit DEFAULT NULL clause. This is the same as before 5.0.2.
--
--  If the column cannot take NULL as the value, MySQL defines the column with
--  no explicit DEFAULT clause. For data entry, if an INSERT or REPLACE
--  statement includes no value for the column, MySQL handles the column
--  according to the SQL mode in effect at the time:
--
--    * If strict SQL mode is not enabled, MySQL sets the column to the
--      implicit default value for the column data type.
--
--    * If strict mode is enabled, an error occurs for transactional tables and
--      the statement is rolled back. For non-transactional tables, an error
--      occurs, but if this happens for the second or subsequent row of a
--      multiple-row statement, the preceding rows will have been inserted.
--
create table bug20691 (i int, d datetime NOT NULL, dn datetime not null default '0000-00-00 00:00:00');
insert into bug20691 values (1, DEFAULT, DEFAULT), (1, '1975-07-10 07:10:03', '1978-01-13 14:08:51'), (1, DEFAULT, DEFAULT);
insert into bug20691 (i) values (2);
insert into bug20691 values (3, DEFAULT, DEFAULT), (3, '1975-07-10 07:10:03', '1978-01-13 14:08:51'), (3, DEFAULT, DEFAULT);
insert into bug20691 (i) values (4);
insert into bug20691 values (5, DEFAULT, DEFAULT), (5, '1975-07-10 07:10:03', '1978-01-13 14:08:51'), (5, DEFAULT, DEFAULT);
SET sql_mode = 'ALLOW_INVALID_DATES';
insert into bug20691 values (6, DEFAULT, DEFAULT), (6, '1975-07-10 07:10:03', '1978-01-13 14:08:51'), (6, DEFAULT, DEFAULT);
SET sql_mode = default;
insert into bug20691 values (7, DEFAULT, DEFAULT), (7, '1975-07-10 07:10:03', '1978-01-13 14:08:51'), (7, DEFAULT, DEFAULT);
select * from bug20691 order by i asc;
drop table bug20691;

SET sql_mode = '';
create table bug20691 (
  a set('one', 'two', 'three') not null,
  b enum('small', 'medium', 'large', 'enormous', 'ellisonego') not null,
  c time not null,
  d date not null,
  e int not null,
  f long not null,
  g blob not null,
  h datetime not null,
  i decimal not null,
  x int);
insert into bug20691 values (2, 3, 5, '0007-01-01', 11, 13, 17, '0019-01-01 00:00:00', 23, 1);
insert into bug20691 (x) values (2);
insert into bug20691 values (2, 3, 5, '0007-01-01', 11, 13, 17, '0019-01-01 00:00:00', 23, 3);
insert into bug20691 values (DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, 4);
select * from bug20691 order by x asc;
drop table bug20691;

create table t1 (id int not null);
insert into t1 values(default);

create view v1 (c) as select id from t1;
insert into t1 values(default);
drop view v1;
drop table t1;

--
-- Bug #39002: crash with
--             INSERT ... SELECT ... ON DUPLICATE KEY UPDATE col=DEFAULT
--

create table t1 (a int unique);
create table t2 (b int default 10);
insert into t1 (a) values (1);
insert into t2 (b) values (1);

insert into t1 (a) select b from t2 on duplicate key update a=default;
select * from t1;

insert into t1 (a) values (1);
insert into t1 (a) select b from t2 on duplicate key update a=default(b);
select * from t1;

drop table t1, t2;
SET sql_mode = default;

-- Bug#29906966: Failed assertion when trying to create a column with literal

--error ER_INVALID_DEFAULT
CREATE TABLE ts(ts TIMESTAMP DEFAULT TIMESTAMP'2019-10-01 01:02:03');
CREATE TABLE dt(dt DATETIME DEFAULT TIMESTAMP'2019-10-01 01:02:03');
CREATE TABLE ints(a INT DEFAULT TIMESTAMP'2019-10-01 01:02:03');
CREATE TABLE t(t TIME DEFAULT TIME'01:02:03');
CREATE TABLE d(d DATE DEFAULT DATE'2019-10-01');

-- For this test, keep in mind that we have two similar-but-distinct tools,
-- mysqldump and the newer mysqlpump. Both will be tested here.

--echo
--echo -- Create a table with a binary default that is not valid UTF-8.
-- There's no guarantee such a default is valid in a target character-set
-- like UTF-8, which means that if we just print the value as part of a
-- SHOW CREATE TABLE statement (of which we promised the client we'd send
-- it in UTF-8), the total of the SHOW CREATE TABLE statement may be an
-- invalid string. This is bad at the best of times, but really not what
-- we want in a database dump, i.e. any form of backup.
CREATE TABLE t1 (f1 BINARY(6)  NOT NULL DEFAULT 0x414243FAFA00,
                 f2 VARCHAR(6) CHARACTER SET ujis DEFAULT 0xA4A2,
                 f3 BIT(4) DEFAULT b'1101');
SELECT data_type,character_set_name,
       column_default
  FROM information_schema.columns
 WHERE table_name='t1'
   AND column_name='f1';

-- This is an interesting one.
-- We get a field 'column_default' with that contains the default value,
-- a character that when represented in ujis has the value 0xA4A2.
-- Since for our convenience, the field is then converted to the
-- character-set we're actually using (UTF-8, this is confirmed by
-- the third column in our select giving a UTF-8 readable character),
-- just taking HEX(column_default) would give an unexpted value
-- (namely, the hex-representation of the UTF-8 encoded character,
-- not the hex-representation of the ujis encoded character).
-- To get the hex-representation of the ujis-encoded character
-- (i.e. the same hex-value as in the CREATE-statement), we must
-- therefore convert the character-set *back* to ujis:
--   HEX(CONVERT(column_default USING ujis))
-- Thus, the default is _ujis 0xA4A2, this is converted to utf-8
-- for our "convenience", and we converted it right back. :-/
SELECT data_type,
       character_set_name,HEX(CONVERT(column_default USING ujis)),
       column_default
  FROM information_schema.columns
 WHERE table_name='t1'
   AND column_name='f2';

SELECT data_type,
       character_set_name,
       column_default
  FROM information_schema.columns
 WHERE table_name='t1'
   AND column_name='f3';
INSERT INTO t1 VALUES(DEFAULT,DEFAULT,DEFAULT);
SELECT "--base--";
SELECT HEX(f1),HEX(f2),HEX(f3) FROM t1;
DROP TABLE t1;
INSERT INTO t1 VALUES(DEFAULT,DEFAULT,DEFAULT);
SELECT "--base,dump--";
SELECT HEX(f1),HEX(f2),HEX(f3) FROM t1;
DROP TABLE t1;
INSERT INTO t1 VALUES(DEFAULT,DEFAULT,DEFAULT);
SELECT "--base,dump,pump--";
SELECT HEX(f1),HEX(f2),HEX(f3) FROM t1;

DROP TABLE t1;
