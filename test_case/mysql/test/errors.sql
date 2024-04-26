--

--disable_warnings
drop table if exists t1;
insert into t1 values(1);
delete from t1;
update t1 set a=1;
create table t1 (a int);
select count(test.t1.b) from t1;
select count(not_existing_database.t1) from t1;
select count(not_existing_database.t1.a) from t1;
select count(not_existing_database.t1.a) from not_existing_database.t1;
select 1 from t1 order by 2;
select 1 from t1 group by 2;
select 1 from t1 order by t1.b;
select count(*),b from t1;
drop table t1;

-- End of 4.1 tests

--
-- Bug #6080: Error message for a field with a display width that is too long
--
--error 1439
create table t1 (a int(256));
set sql_mode='traditional';
create table t1 (a varchar(66000));
set sql_mode=default;

--
-- Bug #27513: mysql 5.0.x + NULL pointer DoS
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 (a INT);
SELECT a FROM t1 WHERE a IN(1, (SELECT IF(1=0,1,2/0)));
INSERT INTO t1 VALUES(1);
SELECT a FROM t1 WHERE a IN(1, (SELECT IF(1=0,1,2/0)));
INSERT INTO t1 VALUES(2),(3);
SELECT a FROM t1 WHERE a IN(1, (SELECT IF(1=0,1,2/0)));
DROP TABLE t1;
SET sql_mode = default;
CREATE TABLE t1( a INT );
SELECT b FROM t1;
CREATE TABLE t2 SELECT b FROM t1;
INSERT INTO t1 SELECT b FROM t1;
DROP TABLE t1;
drop table if exists t1, t2;
create table t1 (a int unique);
create table t2 (a int);
drop function if exists f1;
drop function if exists f2;

create function f1() returns int
begin
  insert into t1 (a) values (1);
  insert into t1 (a) values (1);
create function f2() returns int
begin
  insert into t2 (a) values (1);
select f1(), f2();
select * from t1;
select * from t2;
drop table t1;
drop table t2;
drop function f1;
drop function f2;

--
-- testing the value encoding in the error messages
--
-- should be TR\xC3\x9CE, TRÜE, TRÜE
--
SET NAMES utf8mb3;
SET sql_quote_show_create= _binary x'5452C39C45';
SET sql_quote_show_create= _utf8mb3 x'5452C39C45';
SET sql_quote_show_create=_latin1 x'5452DC45';
SET sql_quote_show_create='TRÃœE';
SET sql_quote_show_create=TRÃœE;

SET NAMES latin1;
SET sql_quote_show_create= _binary x'5452C39C45';
SET sql_quote_show_create= _utf8mb3 x'5452C39C45';
SET sql_quote_show_create=_latin1 x'5452DC45';
SET sql_quote_show_create='TRÜE';
SET sql_quote_show_create=TRÜE;

SET NAMES binary;
SET sql_quote_show_create= _binary x'5452C39C45';
SET sql_quote_show_create= _utf8mb3 x'5452C39C45';
SET sql_quote_show_create=_latin1 x'5452DC45';
CREATE TABLE t1(c1 BINARY(10), c2 BINARY(10), c3 BINARY(10),
PRIMARY KEY(c1,c2,c3));
INSERT INTO t1 (c1,c2,c3) VALUES('abc','abc','abc');
INSERT INTO t1 (c1,c2,c3) VALUES('abc','abc','abc');
DROP TABLE t1;

CREATE TABLE t1 (f1 VARBINARY(19) PRIMARY KEY);
INSERT INTO t1 VALUES ('abc\0\0');
INSERT INTO t1 VALUES ('abc\0\0');
DROP TABLE t1;
SELECT (CONVERT('0' USING latin1) IN (CHAR(COT('v') USING utf8mb3),''));

SET NAMES utf8mb3 COLLATE utf8mb3_latvian_ci ;
SELECT UPDATEXML(-73 * -2465717823867977728,@@global.auto_increment_increment,null);

--
-- Bug #13031606 VALUES() IN A SELECT STATEMENT CRASHES SERVER
--
CREATE TABLE t1 (a INT);
CREATE TABLE t2(a INT PRIMARY KEY, b INT);
SELECT '' AS b FROM t1 GROUP BY VALUES(b);
UPDATE t2 SET a=(SELECT '' AS b FROM t1 GROUP BY VALUES(b));
INSERT INTO t2 VALUES (1,0) ON DUPLICATE KEY UPDATE
  b=(SELECT '' AS b FROM t1 GROUP BY VALUES(b));
INSERT INTO t2(a,b) VALUES (1,0) ON DUPLICATE KEY UPDATE
  b=(SELECT VALUES(a)+2 FROM t1);
DROP TABLE t1, t2;

CREATE USER nopriv_user@localhost;
DROP TABLE IF EXISTS t1,t2,t3;
DROP FUNCTION IF EXISTS f;

CREATE TABLE t1 (key1 INT PRIMARY KEY);
CREATE TABLE t2 (key2 INT);
INSERT INTO t1 VALUES (1),(2);

CREATE FUNCTION f() RETURNS INT RETURN 1;

let outfile=$MYSQLTEST_VARDIR/tmp/mytest;
INSERT INTO t2 SELECT MAX(key1) FROM t1 WHERE f() < 1;
SELECT MAX(key1) INTO @dummy FROM t1 WHERE f() < 1;
CREATE TABLE t3 (i INT) AS SELECT MAX(key1) FROM t1 WHERE f() < 1;

DROP TABLE t1,t2;
DROP FUNCTION f;
DROP USER nopriv_user@localhost;

CREATE TABLE t1 (a varchar(1), b varchar(1));

CREATE TABLE t2 (pk integer, a varchar(1), b varchar(1), c date, primary key(pk));
CREATE INDEX idx1 ON t2 (b);

INSERT INTO t1 VALUES ('d','7');
INSERT INTO t2 VALUES (1,'q','7','1970-01-01');
INSERT INTO t2 VALUES (2,'l','7','1970-01-01');
CREATE TABLE insert_select AS
SELECT t2.c AS field3
FROM t1, t2
WHERE t1.b = t2.b AND t1.a <> t2.pk;

DROP TABLE t1, t2;
