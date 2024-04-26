--


--disable_warnings
drop table if exists t1;

--
-- Create the example functions from udf_example
--

--replace_result $UDF_EXAMPLE_LIB UDF_EXAMPLE_LIB
eval CREATE FUNCTION metaphon RETURNS STRING SONAME "$UDF_EXAMPLE_LIB";
        RETURNS STRING SONAME "$UDF_EXAMPLE_LIB";
        RETURNS REAL SONAME "$UDF_EXAMPLE_LIB";
SELECT udf_type FROM performance_schema.user_defined_functions
  WHERE udf_name = 'metaphon';
select myfunc_double();
select myfunc_double(1);
select myfunc_double(78654);
select myfunc_nonexist();
select myfunc_int();
select lookup();
select lookup("127.0.0.1");
select lookup(127,0,0,1);
select lookup("localhost");
select reverse_lookup();
set @one = 1;

-- These two function calls should return "localhost", but it's
-- depending on configuration, so just call them and don't log the result
--disable_result_log
select reverse_lookup("127.0.0.1");
select reverse_lookup(127,0,0,1);

-- This function call may return different results depending on platform,
-- so ignore results (see Bug#52060).
select reverse_lookup("localhost");
select avgcost();
select avgcost(100,23.76);
create table t1(sum int, price float(24));
insert into t1 values(100, 50.00), (100, 100.00);
select avgcost(sum, price) from t1;
delete from t1;
insert into t1 values(100, 54.33), (200, 199.99);
select avgcost(sum, price) from t1;
drop table t1;

select metaphon('hello');
CREATE PROCEDURE `XXX1`(in testval varchar(10))
begin
select metaphon(testval);
drop procedure xxx1;
CREATE PROCEDURE `XXX2`()
begin
declare testval varchar(10);
set testval = 'hello';
select metaphon(testval);
drop procedure xxx2;

--
-- Bug#19904: UDF: not initialized *is_null per row
--

CREATE TABLE bug19904(n INT, v varchar(10));
INSERT INTO bug19904 VALUES (1,'one'),(2,'two'),(NULL,NULL),(3,'three'),(4,'four');
SELECT myfunc_double(n) AS f FROM bug19904;
SELECT metaphon(v) AS f FROM bug19904;
DROP TABLE bug19904;

--
-- Bug#21269: DEFINER-clause is allowed for UDF-functions
--

--error ER_PARSE_ERROR
CREATE DEFINER=CURRENT_USER() FUNCTION should_not_parse
RETURNS STRING SONAME "should_not_parse.so";
CREATE DEFINER=someone@somewhere FUNCTION should_not_parse
RETURNS STRING SONAME "should_not_parse.so";
create table t1(f1 int);
insert into t1 values(1),(2);
drop table t1;

-- 
-- Bug #21809: Error 1356 while selecting from view with grouping though 
--              underlying select OK.
--
CREATE TABLE t1(a INT, b INT);
CREATE FUNCTION fn(a int) RETURNS int DETERMINISTIC
BEGIN
    RETURN a;
END
||
DELIMITER ;

CREATE VIEW v1 AS SELECT a, fn(MIN(b)) as c FROM t1 GROUP BY a;

SELECT myfunc_int(a AS attr_name) FROM t1;
SELECT a,c FROM v1;
SELECT a, fn(MIN(b) xx) as c FROM t1 GROUP BY a;
SELECT myfunc_int(fn(MIN(b) xx)) as c FROM t1 GROUP BY a;
SELECT myfunc_int(test.fn(MIN(b) xx)) as c FROM t1 GROUP BY a;

SELECT myfunc_int(fn(MIN(b)) xx) as c FROM t1 GROUP BY a;
SELECT myfunc_int(test.fn(MIN(b)) xx) as c FROM t1 GROUP BY a;
SELECT myfunc_int(MIN(b) xx) as c FROM t1 GROUP BY a;
SELECT test.fn(MIN(b)) as c FROM t1 GROUP BY a;
SELECT myfunc_int(fn(MIN(b))) as c FROM t1 GROUP BY a;
SELECT myfunc_int(test.fn(MIN(b))) as c FROM t1 GROUP BY a;
DROP VIEW v1;
DROP TABLE t1;
DROP FUNCTION fn;

--
-- Bug#24736: UDF functions parsed as Stored Functions
--

select myfunc_double(3);
select myfunc_double(3 AS three);
select myfunc_double(abs(3));
select myfunc_double(abs(3) AS named_param);
select abs(myfunc_double(3));
select abs(myfunc_double(3 AS three));

-- error ER_WRONG_PARAMETERS_TO_NATIVE_FCT
select myfunc_double(abs(3 AS wrong));
select abs(myfunc_double(3) AS wrong);

--
-- BUG#18239: Possible to overload internal functions with stored functions
--

--disable_warnings
drop function if exists pi;
CREATE FUNCTION pi RETURNS STRING SONAME "should_not_parse.so";
DROP FUNCTION IF EXISTS metaphon;
CREATE FUNCTION metaphon(a int) RETURNS int return 0;
SELECT metaphon('a');
SELECT test.metaphon(0);
DROP FUNCTION test.metaphon;
DROP FUNCTION IF EXISTS metaphon;
CREATE FUNCTION metaphon(a int) RETURNS int return 0;
SELECT metaphon('a');
SELECT test.metaphon(0);
DROP FUNCTION test.metaphon;

-- End of Bug#18239

-- Test that Item_sum::eq() works when using an aggregate UDF

create table t1(sum int, price float(24));
select distinct avgcost(sum,price) from t1 order by avgcost(sum,price);
drop table t1;

--
-- Bug#30499132 UDF'S RETURNING STRING EVEN THOUGH RETURN TYPE IS NON-STRING
--

--exec $MYSQL --binary-as-hex=TRUE -e "SELECT myfunc_int(20)";

--
-- Drop the example functions from udf_example
--

DROP FUNCTION metaphon;
DROP FUNCTION myfunc_double;
DROP FUNCTION myfunc_nonexist;
DROP FUNCTION myfunc_int;
DROP FUNCTION sequence;
DROP FUNCTION lookup;
DROP FUNCTION reverse_lookup;
DROP FUNCTION avgcost;

--
-- Bug #15439: UDF name case handling forces DELETE FROM mysql.func to remove 
--             the UDF
-- 
select * from mysql.func;

select IS_const(3);

drop function IS_const;

select * from mysql.func;
select is_const(3);

--
-- Bug#18761: constant expression as UDF parameters not passed in as constant
--
--replace_result $UDF_EXAMPLE_LIB UDF_EXAMPLE_LIB
eval CREATE FUNCTION is_const RETURNS STRING SONAME "$UDF_EXAMPLE_LIB";

select
  is_const(3) as const,
  is_const(3.14) as const,
  is_const('fnord') as const,
  is_const(2+3) as const,
  is_const(rand()) as 'nc rand()',
  is_const(sin(3.14)) as const,
  is_const(upper('test')) as const;

create table bug18761 (n int);
insert into bug18761 values (null),(2);
select
  is_const(3) as const,
  is_const(3.14) as const,
  is_const('fnord') as const,
  is_const(2+3) as const,
  is_const(2+n) as 'nc  2+n  ',
  is_const(sin(n)) as 'nc sin(n)',
  is_const(sin(3.14)) as const,
  is_const(upper('test')) as const,
  is_const(rand()) as 'nc rand()',
  is_const(n) as 'nc   n   ',
  is_const(is_const(n)) as 'nc ic?(n)',
  is_const(is_const('c')) as const
from
  bug18761;
drop table bug18761;
select is_const((1,2,3));

drop function if exists is_const;

--
-- Bug #25382: Passing NULL to an UDF called from stored procedures 
-- crashes server
--
--replace_result $UDF_EXAMPLE_LIB UDF_EXAMPLE_LIB
eval CREATE FUNCTION metaphon RETURNS STRING SONAME "$UDF_EXAMPLE_LIB";
create function f1(p1 varchar(255))
returns varchar(255)
begin
  return metaphon(p1);

create function f2(p1 varchar(255))
returns double
begin
  return myfunc_double(p1);

create function f3(p1 varchar(255))
returns double
begin
  return myfunc_int(p1);

select f3(NULL);
select f2(NULL);
select f1(NULL);

drop function f1;
drop function f2;
drop function f3;
drop function metaphon;
drop function myfunc_double;
drop function myfunc_int;

--
-- Bug#28318  CREATE FUNCTION (UDF) requires a schema
--

--disable_warnings
DROP DATABASE IF EXISTS mysqltest;
CREATE DATABASE mysqltest;
USE mysqltest;
DROP DATABASE mysqltest;
DROP FUNCTION metaphon;
USE test;

--
-- Bug #29804  UDF parameters don't contain correct string length
--

CREATE TABLE const_len_bug (
  str_const varchar(4000),
  result1 varchar(4000),
  result2 varchar(4000)
);
CREATE TRIGGER check_const_len_trigger BEFORE INSERT ON const_len_bug FOR EACH ROW BEGIN
   set NEW.str_const = 'bar';
   set NEW.result2 = check_const_len(NEW.str_const);
END |

CREATE PROCEDURE check_const_len_sp (IN str_const VARCHAR(4000))
BEGIN
DECLARE result VARCHAR(4000);
SET result = check_const_len(str_const);
insert into const_len_bug values(str_const, result, "");
END |
DELIMITER ;

SELECT * from const_len_bug;

DROP FUNCTION check_const_len;
DROP PROCEDURE check_const_len_sp;
DROP TRIGGER check_const_len_trigger;
DROP TABLE const_len_bug;


--
-- Bug #30355: Incorrect ordering of UDF results
--

--replace_result $UDF_EXAMPLE_LIB UDF_EXAMPLE_LIB
eval CREATE FUNCTION sequence RETURNS INTEGER SONAME "$UDF_EXAMPLE_LIB";
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT PRIMARY KEY);
INSERT INTO t1 VALUES (4),(3),(2),(1);
INSERT INTO t2 SELECT * FROM t1;
SELECT sequence() AS seq, a FROM t1 ORDER BY seq ASC;
SELECT sequence() AS seq, a FROM t1 ORDER BY seq DESC;

SELECT * FROM t1 WHERE a = sequence();
SELECT * FROM t2 WHERE a = sequence();

DROP FUNCTION sequence;
DROP TABLE t1,t2;

--
-- Bug#31767 (DROP FUNCTION name resolution)
--

--disable_warnings
drop function if exists test.metaphon;
drop function if exists metaphon;

select metaphon("Hello");

-- The UDF should not be dropped
drop function if exists test.metaphon;

select metaphon("Hello");

drop function metaphon;

CREATE FUNCTION test.metaphon(a TEXT) RETURNS TEXT return "This is a SF";

create database db_31767;
use db_31767;

use test;

-- Uses the UDF
select metaphon("Hello");

-- Uses the SF
select test.metaphon("Hello");

-- Should drop the UDF, resolving the name the same way select does.
drop function metaphon;

-- Should call the SF
select metaphon("Hello");

-- Drop the SF
drop function metaphon;

-- Change the current database to none.
use db_31767;
drop database db_31767;

drop function if exists no_such_func;
drop function no_such_func;

drop function if exists test.no_such_func;
drop function test.no_such_func;
drop procedure if exists no_such_proc;
drop procedure no_such_proc;

use test;
CREATE TABLE t1 ( a INT );

INSERT INTO t1 VALUES (1), (2), (3);

SELECT IF( a = 1, a, a ) AS `b` FROM t1 ORDER BY field( `b` + 1, 1 );
SELECT IF( a = 1, a, a ) AS `b` FROM t1 ORDER BY field( `b`, 1 );

DROP TABLE t1;
CREATE TABLE t1 (f1 INT);
INSERT INTO t1 VALUES(1),(50);
DROP FUNCTION myfunc_double;
DROP TABLE t1;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for global read lock" AND
        info = "DROP FUNCTION metaphon";
SELECT metaphon("foo");
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for global read lock";
SELECT reverse_lookup("127.0.0.1");
DROP FUNCTION metaphon;
DROP FUNCTION reverse_lookup;

SELECT my_median(1);
CREATE TABLE t1(a INT, b INT);
SELECT a, my_median(b) from t1 group by a;
INSERT INTO t1 values
(1, 1), (1, 2), (1, 200),
(2, 1), (2, 200), (2, 200), (2, 1000),
(3, 1), (3, 1), (3, 100), (3, 100), (3, 42)
;
SELECT a, my_median(b) from t1 GROUP BY a;

DROP TABLE t1;

CREATE TABLE users(id INTEGER, name VARCHAR(255));
INSERT INTO users(id, name) VALUES (1, 'Jason'), (2, 'Brian');

CREATE TABLE user_values(id INTEGER, user_id INTEGER, value INTEGER);
INSERT INTO user_values(id, user_id, value) VALUES (1,1,1), (2,2,10);

let $query = SELECT my_median(value) FROM user_values;

let $query = SELECT user_id, my_median(value) FROM user_values GROUP BY user_id;

let $query =
SELECT users.id, my_median(value)
FROM users,user_values
WHERE users.id = user_values.user_id
GROUP BY users.id;

DROP TABLE users, user_values;

DROP FUNCTION my_median;

SET autocommit= 0;
SET innodb_lock_wait_timeout= 1;

-- Create an auxiliary connection.
--echo
--echo -- Connection: con1
--connect (con1, localhost, root,,)
let $con1_id= `SELECT CONNECTION_ID()`;

-- Test Plan:
-- A. Check that UDF statements are not vulnerable to the lock-wait-timeout.
-- B. Check the implicit  transactional nature of UDF DDL.
-- C. Check it's possible to change the UDF meta table storage engine via
--    ALTER TABLE.

--echo
--echo --######################################################
--echo -- A.1. Checking lock-wait-timeout with CREATE USER
--echo --######################################################
--connection default
-- Start a transaction and insert a new row into mysql.func.
START TRANSACTION;
let $is_windows = `select convert(@@version_compile_os using latin1) IN ("Win32","Win64","Windows")`;

if (!$is_windows)
{
--replace_result udf_example.so UDF_EXAMPLE_LIB
--send CREATE FUNCTION metaphon RETURNS STRING SONAME "udf_example.so";
let $wait_condition=
    SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
    WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Drop the created function (cleanup).
DROP FUNCTION metaphon;
SELECT name FROM mysql.func WHERE name ='metaphon' FOR UPDATE;

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;
SELECT name FROM mysql.func WHERE name = 'metaphon';
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1),(2),(3);
SELECT * FROM t1;
SELECT * FROM mysql.func;
SELECT * FROM mysql.func;
DROP FUNCTION metaphon;
DROP TABLE t1;
SELECT is_const((1,2,3));
DROP FUNCTION  is_const;
SELECT * FROM performance_schema.user_defined_functions
  WHERE udf_name = 'is_const';
     SONAME "$UDF_EXAMPLE_LIB";
CREATE TABLE t1(fld1 INT);
let $query =
  SELECT avgcost(T.TABLE_ROWS, 0e0)
  FROM INFORMATION_SCHEMA.TABLES T,
       INFORMATION_SCHEMA.COLUMNS C
  WHERE C.TABLE_SCHEMA = T.TABLE_SCHEMA AND
        C.TABLE_NAME = T.TABLE_NAME
        AND C.TABLE_SCHEMA = DATABASE();

-- Without the patch, evaluating $query in a different session triggers an ASAN error.
--connect (con1, localhost, root,,)
--eval $query

--connection default
--disconnect con1

DROP TABLE t1;
DROP FUNCTION avgcost;
     SONAME "$UDF_EXAMPLE_LIB";
CREATE TABLE t1(f1 INTEGER, f2 INTEGER);
INSERT INTO t1 VALUES (1,100),(1,2),(2,100),(2,3);
let $query =
  SELECT * FROM (SELECT f1, my_median(f2) as median
                 FROM t1 GROUP BY f1) as dt
  WHERE median != 1;

DROP TABLE t1;
DROP FUNCTION my_median;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4);

SELECT a FROM t1 WHERE a = sequence();
SELECT a FROM (SELECT sequence() AS seq, a FROM t1) AS dt WHERE a = seq;

DROP FUNCTION sequence;
DROP TABLE t1;
SELECT METAPHON(1000000000000*1000000000000);
SELECT METAPHON(CAST(1000000000000*1000000000000 AS DOUBLE));
SELECT METAPHON(CAST(1000000000000*1000000000000 AS DECIMAL));
SELECT METAPHON(CAST(1000000000000*1000000000000 AS CHAR(100)));

DROP FUNCTION metaphon;
