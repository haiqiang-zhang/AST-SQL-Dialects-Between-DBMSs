drop table if exists t1,t2,v1,v2;
drop view if exists t1,t2,v1,v2;

CREATE TABLE `t1` (
  a int not null auto_increment,
  `pseudo` varchar(35) character set latin2 NOT NULL default '',
  `email` varchar(60) character set latin2 NOT NULL default '',
  PRIMARY KEY  (a),
  UNIQUE KEY `email` USING BTREE (`email`)
) ENGINE=HEAP CHARSET=latin1 ROW_FORMAT DYNAMIC;
set @@sql_mode="";
set @@sql_mode="ansi_quotes";
drop table t1;

--
-- BUG#5318 - failure: 'IGNORE_SPACE' affects numeric values after DEFAULT
--
-- Force the usage of the default
set session sql_mode = '';
create table t1 ( min_num   dec(6,6)     default .000001);
drop table t1 ;
set session sql_mode = 'IGNORE_SPACE';
create table t1 ( min_num   dec(6,6)     default 0.000001);
drop table t1 ;
create table t1 ( min_num   dec(6,6)     default .000001);
drop table t1 ;

--
-- Bug #10732: Set SQL_MODE to NULL gives garbled error message
--
--error 1231
set @@SQL_MODE=NULL;

--

--Replace default engine value with static engine string
--replace_result $DEFAULT_ENGINE ENGINE
-- Bug #797: in sql_mode=ANSI, show create table ignores auto_increment
--
set session sql_mode=ansi;
create table t1
(f1 integer auto_increment primary key,
 f2 timestamp not null default current_timestamp on update current_timestamp);
drop table t1;

-- End of 4.1 tests

--
-- test for
--  WL 1941 "NO_C_ESCAPES sql_mode"
--
-- an sql_mode to disable \n, \r, \b, etc escapes in string literals. actually, to
-- disable special meaning of backslash completely. It's not in the SQL standard
-- and it causes some R/3 tests to fail.
--

SET @OLD_SQL_MODE=@@SQL_MODE, @@SQL_MODE='';

CREATE TABLE t1 (p int not null auto_increment, a varchar(20), primary key(p)) charset latin1;
INSERT t1 (a) VALUES
('\\'),
('\n'),
('\b'),
('\r'),
('\t'),
('\x'),
('\a'),
('\aa'),
('\\a'),
('\\aa'),
('_'),
('\_'),
('\\_'),
('\\\_'),
('\\\\_'),
('%'),
('\%'),
('\\%'),
('\\\%'),
('\\\\%')
;

SELECT p, hex(a) FROM t1;

delete from t1 where a in ('\n','\r','\t', '\b');

select
  masks.p,
  masks.a as mask,
  examples.a as example
from
            t1 as masks
  left join t1 as examples on examples.a LIKE masks.a
order by masks.p, example;

DROP TABLE t1;

SET @@SQL_MODE='NO_BACKSLASH_ESCAPES';

CREATE TABLE t1 (p int not null auto_increment, a varchar(20), primary key(p)) charset latin1;
INSERT t1 (a) VALUES
('\\'),
('\n'),
('\b'),
('\r'),
('\t'),
('\x'),
('\a'),
('\aa'),
('\\a'),
('\\aa'),
('_'),
('\_'),
('\\_'),
('\\\_'),
('\\\\_'),
('%'),
('\%'),
('\\%'),
('\\\%'),
('\\\\%')
;

SELECT p, hex(a) FROM t1;

delete from t1 where a in ('\n','\r','\t', '\b');

select
  masks.p,
  masks.a as mask,
  examples.a as example
from
            t1 as masks
  left join t1 as examples on examples.a LIKE masks.a
order by masks.p, example;

DROP TABLE t1;

-- Bug #6368: Make sure backslashes mixed with doubled quotes are handled
-- correctly in NO_BACKSLASH_ESCAPES mode
SET @@SQL_MODE='NO_BACKSLASH_ESCAPES';
SELECT 'a\\b', 'a\\\"b', 'a''\\b', 'a''\\\"b';
SELECT "a\\b", "a\\\'b", "a""\\b", "a""\\\'b";

SET @@SQL_MODE='';
SELECT 'a\\b', 'a\\\"b', 'a''\\b', 'a''\\\"b';
SELECT "a\\b", "a\\\'b", "a""\\b", "a""\\\'b";

--
-- Bug#6877: MySQL should give an error if the requested table type
--           is not available
--

--set session sql_mode = 'NO_ENGINE_SUBSTITUTION';
--# for comparison, lets see the warnings...
--set session sql_mode = '';

--
-- Bug #6903: ANSI_QUOTES does not come into play with SHOW CREATE FUNCTION
-- or PROCEDURE because it displays the SQL_MODE used to create the routine.
--
SET @@SQL_MODE='';
create function `foo` () returns int return 5;
SET @@SQL_MODE='ANSI_QUOTES';
drop function `foo`;

create function `foo` () returns int return 5;
SET @@SQL_MODE='';
drop function `foo`;

--
-- Bug #6903: ANSI_QUOTES should have effect for SHOW CREATE VIEW (Bug #6903)
--
SET @@SQL_MODE='';
create table t1 (a int);
create table t2 (a int);
create view v1 as select a from t1;
SET @@SQL_MODE='ANSI_QUOTES';
create view v2 as select a from t2 where a in (select a from v1);
drop view v2, v1;
drop table t1, t2;

select @@sql_mode;
set sql_mode=2097152;
select @@sql_mode;
set sql_mode=4194304;
select @@sql_mode;
set sql_mode=32+(65536*4);
select @@sql_mode;
set sql_mode=4294967296*2;
select @@sql_mode;

--
-- Test WL921: Retain spaces when retrieving CHAR column values

set sql_mode=PAD_CHAR_TO_FULL_LENGTH;
create table t1 (a int auto_increment primary key, b char(5));
insert into t1 (b) values('a'),('b\t'),('c ');
select concat('x',b,'x') from t1;
set sql_mode=0;
select concat('x',b,'x') from t1;
drop table t1;

SET @@SQL_MODE=@OLD_SQL_MODE;


--
-- Bug #32753: PAD_CHAR_TO_FULL_LENGTH is not documented and interferes
--             with grant tables
--

create user mysqltest_32753@localhost;

-- try to make the user-table space-padded
--connection default
set @OLD_SQL_MODE=@@SESSION.SQL_MODE;
set session sql_mode='PAD_CHAR_TO_FULL_LENGTH';

-- if user-table is affected by PAD_CHAR_TO_FULL_LENGTH, our connect will fail
-- --error 1045
connect (user_32753,localhost,mysqltest_32753,,test,$MASTER_MYPORT,$MASTER_MYSOCK);
select current_user();

-- clean up
--connection default
set session sql_mode=@OLD_SQL_MODE;
drop user mysqltest_32753@localhost;


--
-- Bug#21099 MySQL 5.0.22 silently creates MyISAM tables even though
--           InnoDB specified.
--

SET @org_mode=@@sql_mode;
SET @@sql_mode='traditional';

-- Agreed change was to add NO_ENGINE_SUBSTITUTION to TRADITIONAL sql mode.
SELECT @@sql_mode LIKE '%NO_ENGINE_SUBSTITUTION%';

SET sql_mode=@org_mode;


--
-- Bug#45100: Incomplete DROP USER in case of SQL_MODE = 'PAD_CHAR_TO_FULL_LENGTH'
--

--disable_warnings
DROP TABLE IF EXISTS t1,t2;

-- Generate some prerequisites
CREATE USER 'user_PCTFL'@'localhost' identified by 'PWD';
CREATE USER 'user_no_PCTFL'@'localhost' identified by 'PWD';

CREATE TABLE t1 (f1 BIGINT);
CREATE TABLE t2 (f1 CHAR(3) NOT NULL, f2 CHAR(20));

-- Grant privilege on a TABLE
GRANT ALL ON t1 TO 'user_PCTFL'@'localhost','user_no_PCTFL'@'localhost';

SET @OLD_SQL_MODE = @@SESSION.SQL_MODE;
SET SESSION SQL_MODE = 'PAD_CHAR_TO_FULL_LENGTH';
DROP USER 'user_PCTFL'@'localhost';
SET SESSION SQL_MODE = @OLD_SQL_MODE;
DROP USER 'user_no_PCTFL'@'localhost';

SELECT * FROM mysql.db WHERE Host = 'localhost' AND User LIKE 'user_%PCTFL';
SELECT * FROM mysql.tables_priv WHERE Host = 'localhost' AND User LIKE 'user_%PCTFL';
SELECT * FROM mysql.columns_priv WHERE Host = 'localhost' AND User LIKE 'user_%PCTFL';

-- Cleanup
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE IF EXISTS test_table;
DROP FUNCTION IF EXISTS test_function;

CREATE TABLE test_table (c1 CHAR(50));

SET @org_mode=@@sql_mode;

SET @@sql_mode='';
CREATE FUNCTION test_function(var CHAR(50)) RETURNS CHAR(50)
BEGIN
  DECLARE char_val CHAR(50);
  SELECT c1 INTO char_val FROM test_table WHERE c1=var;
END
$
DELIMITER ;

SET @var1='abcd\'ef';
SET @var2='abcd\"ef';
SET @var3='abcd\bef';
SET @var4='abcd\nef';
SET @var5='abcd\ref';
SET @var6='abcd\tef';
SET @var7='abcd\\ef';
SET @var8='abcd\%ef';
SET @var9='abcd\_ef';

SET @to_var1='wxyz\'ef';
SET @to_var2='wxyz\"ef';
SET @to_var3='wxyz\bef';
SET @to_var4='wxyz\nef';
SET @to_var5='wxyz\ref';
SET @to_var6='wxyz\tef';
SET @to_var7='wxyz\\ef';
SET @to_var8='wxyz\%ef';
SET @to_var9='wxyz\_ef';

SELECT * FROM test_table;

SELECT * FROM test_table;
select test_function(@to_var1);
SELECT test_function(@to_var2);
SELECT test_function(@to_var3);
SELECT test_function(@to_var4);
SELECT test_function(@to_var5);
SELECT test_function(@to_var6);
SELECT test_function(@to_var7);
SELECT test_function(@to_var8);
SELECT test_function(@to_var9);
DELETE FROM test_table;
DROP FUNCTION test_function;

SET @@sql_mode='NO_BACKSLASH_ESCAPES';
CREATE FUNCTION test_function(var CHAR(50)) RETURNS CHAR(50)
BEGIN
  DECLARE char_val CHAR(50);
  SELECT c1 INTO char_val FROM test_table WHERE c1=var;
END
$
DELIMITER ;

SELECT * FROM test_table;

SELECT * FROM test_table;
select test_function(@to_var1);
SELECT test_function(@to_var2);
SELECT test_function(@to_var3);
SELECT test_function(@to_var4);
SELECT test_function(@to_var5);
SELECT test_function(@to_var6);
SELECT test_function(@to_var7);
SELECT test_function(@to_var8);
SELECT test_function(@to_var9);

DROP TABLE test_table;
DROP FUNCTION test_function;
SET @@sql_mode= @org_mode;
SET @org_mode= @@sql_mode;

SET sql_mode= 'NO_ZERO_DATE';
SELECT @@sql_mode;

SET sql_mode= 'NO_ZERO_IN_DATE';
SELECT @@sql_mode;

SET sql_mode= 'ERROR_FOR_DIVISION_BY_ZERO';
SELECT @@sql_mode;
SET sql_mode= @org_mode;

SET @org_mode=@@sql_mode;

SET @@sql_mode='';
CREATE USER 'user\'s_12601974'@'localhost';
CREATE USER 'user\'s_12601974'@'localhost';
DROP USER 'user\'s_12601974'@'localhost';

CREATE USER 'user\"s_12601974'@'localhost';
CREATE USER 'user\"s_12601974'@'localhost';
DROP USER 'user\"s_12601974'@'localhost';

CREATE USER 'user\bs_12601974'@'localhost';
CREATE USER 'user\bs_12601974'@'localhost';
DROP USER 'user\bs_12601974'@'localhost';

CREATE USER 'user\ns_12601974'@'localhost';
CREATE USER 'user\ns_12601974'@'localhost';
DROP USER 'user\ns_12601974'@'localhost';

CREATE USER 'user\rs_12601974'@'localhost';
CREATE USER 'user\rs_12601974'@'localhost';
DROP USER 'user\rs_12601974'@'localhost';

CREATE USER 'user\ts_12601974'@'localhost';
CREATE USER 'user\ts_12601974'@'localhost';
DROP USER 'user\ts_12601974'@'localhost';

CREATE USER 'user\\s_12601974'@'localhost';
CREATE USER 'user\\s_12601974'@'localhost';
DROP USER 'user\\s_12601974'@'localhost';

CREATE USER 'user\%s_12601974'@'localhost';

CREATE USER 'user\%s_12601974'@'localhost';
DROP USER 'user\%s_12601974'@'localhost';

CREATE USER 'user\_s_12601974'@'localhost';
CREATE USER 'user\_s_12601974'@'localhost';
DROP USER 'user\_s_12601974'@'localhost';

SET @@sql_mode='NO_BACKSLASH_ESCAPES';
CREATE USER 'user\"s_12601974'@'localhost';
CREATE USER 'user\"s_12601974'@'localhost';
DROP USER 'user\"s_12601974'@'localhost';

CREATE USER 'user\bs_12601974'@'localhost';
CREATE USER 'user\bs_12601974'@'localhost';
DROP USER 'user\bs_12601974'@'localhost';

CREATE USER 'user\ns_12601974'@'localhost';
CREATE USER 'user\ns_12601974'@'localhost';
DROP USER 'user\ns_12601974'@'localhost';

CREATE USER 'user\rs_12601974'@'localhost';
CREATE USER 'user\rs_12601974'@'localhost';
DROP USER 'user\rs_12601974'@'localhost';

CREATE USER 'user\ts_12601974'@'localhost';
CREATE USER 'user\ts_12601974'@'localhost';
DROP USER 'user\ts_12601974'@'localhost';

CREATE USER 'user\\s_12601974'@'localhost';
CREATE USER 'user\\s_12601974'@'localhost';
DROP USER 'user\\s_12601974'@'localhost';

CREATE USER 'user\%s_12601974'@'localhost';
CREATE USER 'user\%s_12601974'@'localhost';
DROP USER 'user\%s_12601974'@'localhost';

CREATE USER 'user\%s_12601974'@'localhost';
CREATE USER 'user\%s_12601974'@'localhost';
DROP USER 'user\%s_12601974'@'localhost';

CREATE USER 'user\_s_12601974'@'localhost';
CREATE USER 'user\_s_12601974'@'localhost';
DROP USER 'user\_s_12601974'@'localhost';
SET @@sql_mode= @org_mode;
SELECT '\'';
SET SQL_MODE=DEFAULT;
CREATE TABLE test(id INT, count DOUBLE);
INSERT INTO test VALUES (1,0), (2,0);
UPDATE test SET count = count + 1 WHERE id = '1invalid';
SET @a = '1invalid';
SET SQL_MODE='';
SELECT * FROM test;
SET SQL_MODE=DEFAULT;
DROP TABLE test;

CREATE USER 'user1'@'localhost';
SET sql_mode= 'PAD_CHAR_TO_FULL_LENGTH';
SET PASSWORD FOR 'user1'@'localhost'= 'abc';
SELECT LENGTH(authentication_string) FROM mysql.user WHERE user= 'user1';
DROP USER 'user1'@'localhost';
SET sql_mode= DEFAULT;
