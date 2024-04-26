
--
-- Testing of misc functions
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
DROP TABLE IF EXISTS t1, t2;

select format(1.5555,0),format(123.5555,1),format(1234.5555,2),format(12345.55555,3),format(123456.5555,4),format(1234567.5555,5),format("12345.2399",2);

select inet_ntoa(inet_aton("255.255.255.255.255.255.255.255"));
select inet_aton("255.255.255.255.255"),inet_aton("255.255.1.255"),inet_aton("0.1.255");
select inet_ntoa(1099511627775),inet_ntoa(4294902271),inet_ntoa(511);

select hex(inet_aton('127'));
select hex(inet_aton('127.1'));
select hex(inet_aton('127.1.1'));

select inet_aton("122.256");
select inet_aton("122.226.");
select inet_aton("");

select length(uuid()), charset(uuid()), length(unhex(replace(uuid(),_utf8mb3'-',_utf8mb3'')));

-- As we can assume we are the only user for the mysqld server, the difference
-- between two calls should be -1
set @a= uuid_short();
set @b= uuid_short();
select @b - @a;

--
-- Test for core dump with nan
--
select length(format('nan', 2)) > 0;

--
-- Test for bug #628
--
select concat("$",format(2500,2));

-- Test for BUG#7716
create table t1 ( a timestamp );
insert into t1 values ( '2004-01-06 12:34' );
select a from t1 where left(a+0,6) in ( left(20040106,6) );
select a from t1 where left(a+0,6) = ( left(20040106,6) );

select a from t1 where right(a+0,6) in ( right(20040106123400,6) );
select a from t1 where right(a+0,6) = ( right(20040106123400,6) );

select a from t1 where mid(a+0,6,3) in ( mid(20040106123400,6,3) );
select a from t1 where mid(a+0,6,3) = ( mid(20040106123400,6,3) );

drop table t1;


--
-- Bug #21531: EXPORT_SET() does not accept args with coercible character sets
--
select export_set(3, _latin1'foo', _utf8mb3'bar', ',', 4);


--
-- Test for BUG#9535
--
--disable_warnings
create table t1 as select uuid(), length(uuid());
drop table t1;

--
-- Bug#6760: Add SLEEP() function (feature request)
--
--   Logics of original test:
--   Reveal that a query with SLEEP does not need less time than estimated.
--
-- Bug#12689: SLEEP() gets incorrectly cached/optimized-away
--
--   Description from bug report (slightly modified)
--
--   Bug 1 (happened all time):
--      SELECT * FROM t1 WHERE SLEEP(1) will only result in a sleep of 1
--      second, regardless of the number of rows in t1.
--   Bug 2 (happened all time):
--      Such a query will also get cached by the query cache, but should not.
--
-- Notes (mleich, 2008-05)
-- =======================
--
-- Experiments around
--    Bug#36345 Test 'func_misc' fails on RHAS3 x86_64
-- showed that the tests for both bugs could produce in case of parallel
-- artificial system time (like via ntpd)
-- - decreases false alarm
-- - increases false success
--
-- We try here to circumvent these issues by reimplementation of the tests
-- and sophisticated scripting, although the cause of the problems is a massive
-- error within the setup of the testing environment.
-- Tests relying on or checking derivates of the system time must never meet
-- parallel manipulations of system time.
--
-- Results of experiments with/without manipulation of system time,
-- information_schema.processlist content, high load on testing box
-- ----------------------------------------------------------------
-- Definition: Predicted_cumulative_sleep_time =
--                #_of_result_rows * sleep_time_per_result_row
--
-- 1. Total (real sleep time) ~= predicted_cumulative_sleep_time !!
-- 2. The state of a session within the PROCESSLIST changes to 'User sleep'
--    if the sessions runs a statement containing the sleep function and the
--    processing of the statement is just within the phase where the sleep
--    is done. (*)
-- 3. NOW() and processlist.time behave "synchronous" to system time and
--    show also the "jumps" caused by system time manipulations. (*)
-- 4. processlist.time is unsigned, the "next" value below 0 is ~ 4G (*)
-- 5. Current processlist.time ~= current real sleep time if the system time
--    was not manipulated. (*)
-- 6. High system load can cause delays of <= 2 seconds.
-- 7. Thanks to Davi for excellent hints and ideas.
--
--    (*)
--    - information_schema.processlist is not available before MySQL 5.1.
--    - Observation of processlist content requires a
--      - "worker" session sending the query with "send" and pulling results
--        with "reap"
--      - session observing the processlist parallel to the worker session
--    Conclusion: Tests based on processlist have too many restrictions.
--
-- Solutions for subtests based on TIMEDIFF of values filled via NOW()
-- -------------------------------------------------------------------
-- Run the following sequence three times
--    1. SELECT <start_time>
--    2. Query with SLEEP
--    3. SELECT <end_time>
-- If TIMEDIFF(<end_time>,<start_time>) is at least two times within a
-- reasonable range assume that we did not met errors we were looking for.
--
-- It is extreme unlikely that we have two system time changes within the
-- < 30 seconds runtime. Even if the unlikely happens, there are so
-- frequent runs of this test on this or another testing box which will
-- catch the problem.
--

--echo --------------------------------------------------------------------------
--echo -- Test for Bug#6760
-- Number of rows within the intended result set.
SET @row_count = 4;
SET @sleep_time_per_result_row = 1;
SET @max_acceptable_delay = 2;
--            + time for delays caused by high load on testing box
-- Ensure that at least a reasonable fraction of TIMEDIFF belongs to the SLEEP
-- by appropriate setting of variables.
-- Ensure that any "judging" has a base of minimum three attempts.
-- (Test 2 uses all attempts except the first one.)
if (!` SELECT (@sleep_time_per_result_row * @row_count - @max_acceptable_delay >
              @sleep_time_per_result_row) AND (@row_count - 1 >= 3)`)
{
   --echo -- Have to abort because of error in plausibility check
   --echo --#####################################################
   --vertical_results
   SELECT @sleep_time_per_result_row * @row_count - @max_acceptable_delay >
               @sleep_time_per_result_row AS must_be_1,
               @row_count - 1 >= 3 AS must_be_also_1,
               @sleep_time_per_result_row, @row_count, @max_acceptable_delay;
DROP TEMPORARY TABLE IF EXISTS t_history;
DROP TABLE IF EXISTS t1;
CREATE TEMPORARY TABLE t_history (attempt SMALLINT,
start_ts DATETIME, end_ts DATETIME,
start_cached INTEGER, end_cached INTEGER);
CREATE TABLE t1 (f1 BIGINT);
let $num = `SELECT @row_count`;
{
   INSERT INTO t1 VALUES (1);
   dec $num;

-- 1. The majority of queries with SLEEP must need a reasonable time
--    -> SLEEP has an impact on runtime
--       = Replacement for original Bug#6760 test
--    -> total runtime is clear more needed than for one result row needed
--       = Replacement for one of the original Bug#12689 tests
--echo -- Test 1: Does the query with SLEEP need a reasonable time?
eval SELECT COUNT(*) >= $loops - 1 INTO @aux1 FROM t_history
WHERE TIMEDIFF(end_ts,start_ts) - @sleep_time_per_result_row * @row_count
      BETWEEN 0 AND @max_acceptable_delay;
SELECT @aux1 AS "Expect 1";
{
   --echo -- Some tests failed, dumping the content of t_history
   SELECT * FROM t_history;
DROP TABLE t1;
DROP TEMPORARY TABLE t_history;

--
-- Bug #21466: INET_ATON() returns signed, not unsigned
--

create table t1 select INET_ATON('255.255.0.1') as `a`;
drop table t1;

--
-- Bug#26093 (SELECT BENCHMARK() for SELECT statements does not produce
--   valid results)
--

--disable_warnings
drop table if exists table_26093;
drop function if exists func_26093_a;
drop function if exists func_26093_b;

create table table_26093(a int);
insert into table_26093 values
(1), (2), (3), (4), (5),
(6), (7), (8), (9), (10);

create function func_26093_a(x int) returns int
begin
  set @invoked := @invoked + 1;

create function func_26093_b(x int, y int) returns int
begin
  set @invoked := @invoked + 1;

select avg(a) from table_26093;

select benchmark(100, (select avg(a) from table_26093));

set @invoked := 0;
select benchmark(100, (select avg(func_26093_a(a)) from table_26093));
select @invoked;

set @invoked := 0;
select benchmark(100, (select avg(func_26093_b(a, rand())) from table_26093));
select @invoked;
select benchmark(100, (select (a) from table_26093));
select benchmark(100, (select 1, 1));

drop table table_26093;
drop function func_26093_a;
drop function func_26093_b;

--
-- Bug #30832: Assertion + crash with select name_const('test',now());
SELECT NAME_CONST('test', NOW());
SELECT NAME_CONST('test', UPPER('test'));

SELECT NAME_CONST('test', NULL);
SELECT NAME_CONST('test', 1);
SELECT NAME_CONST('test', -1);
SELECT NAME_CONST('test', 1.0);
SELECT NAME_CONST('test', -1.0);
SELECT NAME_CONST('test', 'test');

--
-- Bug #34749: Server crash when using NAME_CONST() with an aggregate function
--

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3);
SELECT NAME_CONST('flag',1)    * MAX(a) FROM t1;
SELECT NAME_CONST('flag',1.5)  * MAX(a) FROM t1;
SELECT NAME_CONST('flag',-1)   * MAX(a) FROM t1;
SELECT NAME_CONST('flag',-1.5) * MAX(a) FROM t1;
SELECT NAME_CONST('flag', SQRT(4)) * MAX(a) FROM t1;
SELECT NAME_CONST('flag',-SQRT(4)) * MAX(a) FROM t1;
DROP TABLE t1;

--
-- Bug #27545: erroneous usage of NAME_CONST with a name as the first parameter
--             resolved against a column name of a derived table hangs the client
--

CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (5), (2);
SELECT NAME_CONST(x,2) FROM (SELECT a x FROM t1) t;

DROP TABLE t1;


--
-- Bug #32559: connection hangs on query with name_const
--
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (), (), ();
SELECT NAME_CONST(a, '1') FROM t1;
SET INSERT_ID= NAME_CONST(a, a);
DROP TABLE t1;

--
-- Bug #31349: ERROR 1062 (23000): Duplicate entry '' for key 'group_key'
--
create table t1 (a int not null);
insert into t1 values (-1), (-2);
select min(a) from t1 group by inet_ntoa(a);
drop table t1;

--
-- BUG#34289 - Incorrect NAME_CONST substitution in stored procedures breaks
-- replication
--

set names latin1;

SELECT NAME_CONST('var', 'value') COLLATE latin1_general_cs;

set names utf8mb4;

--
-- Bug #35848: UUID() returns UUIDs with the wrong time
--
select @@session.time_zone into @save_tz;

-- make sure all times are UTC so the DayNr won't differ
set @@session.time_zone='UTC';
select uuid() into @my_uuid;
select mid(@my_uuid,15,1);
select 24 * 60 * 60 * 1000 * 1000 * 10 into @my_uuid_one_day;
select concat('0',mid(@my_uuid,16,3),mid(@my_uuid,10,4),left(@my_uuid,8)) into @my_uuidate;
select floor(conv(@my_uuidate,16,10)/@my_uuid_one_day) into @my_uuid_date;
select 141427 + datediff(curdate(),'1970-01-01') into @my_uuid_synthetic;
select @my_uuid_date - @my_uuid_synthetic;

set @@session.time_zone=@save_tz;


--
-- Bug#42014: Crash, name_const with collate
--
CREATE TABLE t1 (a DATE);
SELECT * FROM t1 WHERE a = NAME_CONST('reportDate',
  _binary'2009-01-09' COLLATE 'binary');
DROP TABLE t1;

--
-- Bug#35515: Aliases of variables in binary log are ignored with NAME_CONST
--
select NAME_CONST('_id',1234) as id;

--
-- Bug#12735545 - PARSER STACK OVERFLOW WITH NAME_CONST 
--                CONTAINING OR EXPRESSION
--
--error ER_WRONG_ARGUMENTS
SELECT NAME_CONST('a', -(1 OR 2)) OR 1;
SELECT NAME_CONST('a', -(1 AND 2)) OR 1;
SELECT NAME_CONST('a', -(1)) OR 1;

select connection_id() > 0;

CREATE TABLE t1 (a INT, b LONGBLOB);
INSERT INTO t1 VALUES (1, '2'), (2, '3'), (3, '2');

SELECT DISTINCT LEAST(a, (SELECT b FROM t1 LIMIT 1)) FROM t1 UNION SELECT 1;
SELECT DISTINCT GREATEST(a, (SELECT b FROM t1 LIMIT 1)) FROM t1 UNION SELECT 1;

DROP TABLE t1;


--
-- Bug #57283: inet_ntoa() crashes
--
SELECT INET_NTOA(0);
SELECT '1' IN ('1', INET_NTOA(0));

CREATE TABLE t1 (a SET('a'), b INT);
INSERT INTO t1 VALUES ('', 0);

SELECT COALESCE(a) = COALESCE(b) FROM t1;

DROP TABLE t1;

CREATE TABLE t1 (a INT, b LONGBLOB);
INSERT INTO t1 VALUES (1, '2'), (2, '3'), (3, '2');

SELECT DISTINCT LEAST(a, (SELECT b FROM t1 LIMIT 1)) FROM t1 UNION SELECT 1;
SELECT DISTINCT GREATEST(a, (SELECT b FROM t1 LIMIT 1)) FROM t1 UNION SELECT 1;

DROP TABLE t1;


--
-- Bug #57283: inet_ntoa() crashes
--
SELECT INET_NTOA(0);
SELECT '1' IN ('1', INET_NTOA(0));

CREATE TABLE t1 (a INT);

-- NAME_CONST() would seg.fault when used wrongly in a HAVING clause
--error ER_WRONG_ARGUMENTS
SELECT 1 from t1 HAVING NAME_CONST('', a);

DROP TABLE t1;

SELECT INET6_ATON(NULL) IS NULL;
SELECT INET6_ATON(123) IS NULL;
SELECT INET6_ATON(123.45) IS NULL;
SELECT INET6_ATON(str_to_date('2014,2,28 09', '%Y,%m,%d %h')) IS NULL;

SELECT INET6_ATON('1.2.3') IS NULL;
SELECT INET6_ATON('1.2.3.') IS NULL;
SELECT INET6_ATON('1..3.4') IS NULL;
SELECT INET6_ATON('-1.2.3.4') IS NULL;
SELECT INET6_ATON('1.2.3.256') IS NULL;
SELECT INET6_ATON('1.2.3.4.5') IS NULL;
SELECT INET6_ATON('0001.2.3.4') IS NULL;
SELECT INET6_ATON('0x1.2.3.4') IS NULL;
SELECT INET6_ATON('a.2.3.4') IS NULL;

SELECT INET6_ATON('1.2.3.4:80') IS NULL;
SELECT INET6_ATON('1.2.3.4/32') IS NULL;

SELECT INET6_ATON('mysql.com') IS NULL;

SELECT INET6_ATON(':::') IS NULL;
SELECT INET6_ATON(':1:2:3') IS NULL;
SELECT INET6_ATON('1:2:3:') IS NULL;
SELECT INET6_ATON(':1::2:3') IS NULL;
SELECT INET6_ATON('1::2:3:') IS NULL;
SELECT INET6_ATON('::00001') IS NULL;
SELECT INET6_ATON('::00001:2') IS NULL;
SELECT INET6_ATON('::12345') IS NULL;
SELECT INET6_ATON('1020::3040::5060') IS NULL;
SELECT INET6_ATON('::ABCZ') IS NULL;

SELECT INET6_ATON('::0x1.2.3.4') IS NULL;
SELECT INET6_ATON('::1.0x2.3.4') IS NULL;
SELECT INET6_ATON('::a.b.c.d') IS NULL;

SELECT INET6_ATON('::FFFF:0x1.2.3.4') IS NULL;
SELECT INET6_ATON('::FFFF:1.0x2.3.4') IS NULL;
SELECT INET6_ATON('::FFFF:a.b.c.d') IS NULL;

SELECT INET6_ATON('::1.2.3.4:ABCD') IS NULL;
SELECT HEX(INET6_ATON('::ABCD:1.2.3.4'));

SELECT HEX(INET6_ATON('0.0.0.0'));
SELECT HEX(INET6_ATON('00.00.00.00'));
SELECT HEX(INET6_ATON('000.000.000.000'));
SELECT HEX(INET6_ATON('1.2.3.4'));
SELECT HEX(INET6_ATON('01.02.03.04'));
SELECT HEX(INET6_ATON('001.002.003.004'));
SELECT HEX(INET6_ATON('255.255.255.255'));
SELECT HEX(INET6_ATON('::'));
SELECT HEX(INET6_ATON('0::0'));
SELECT HEX(INET6_ATON('1::2'));
SELECT HEX(INET6_ATON('0::'));
SELECT HEX(INET6_ATON('1::'));
SELECT HEX(INET6_ATON('::0'));
SELECT HEX(INET6_ATON('::1'));
SELECT HEX(INET6_ATON('1:2:3:4:5:6:7:8'));
SELECT HEX(INET6_ATON('::2:3:4:5:6:7:8'));
SELECT HEX(INET6_ATON('1::3:4:5:6:7:8'));
SELECT HEX(INET6_ATON('1:2::4:5:6:7:8'));
SELECT HEX(INET6_ATON('1:2:3::5:6:7:8'));
SELECT HEX(INET6_ATON('1:2:3:4::6:7:8'));
SELECT HEX(INET6_ATON('1:2:3:4:5::7:8'));
SELECT HEX(INET6_ATON('1:2:3:4:5:6::8'));
SELECT HEX(INET6_ATON('1:2:3:4:5:6:7::'));
SELECT HEX(INET6_ATON('0000:0000::0000:0001'));
SELECT HEX(INET6_ATON('1234:5678:9abc:def0:4321:8765:cba9:0fed'));
SELECT HEX(INET6_ATON('0000:0000:0000:0000:0000:0000:0000:0001'));
SELECT HEX(INET6_ATON('::C0A8:0102'));
SELECT HEX(INET6_ATON('::c0a8:0102'));
SELECT HEX(INET6_ATON('::192.168.1.2'));
SELECT HEX(INET6_ATON('::FfFf:C0a8:0102'));
SELECT HEX(INET6_ATON('::ffff:c0a8:0102'));
SELECT HEX(INET6_ATON('::ffff:192.168.1.2'));
SELECT HEX(INET6_ATON('::01.2.3.4'));
SELECT HEX(INET6_ATON('::1.02.3.4'));
SELECT HEX(INET6_ATON('::1.2.03.4'));
SELECT HEX(INET6_ATON('::1.2.3.04'));
SELECT HEX(INET6_ATON('::1.2.3.00'));
SELECT HEX(INET6_ATON('::FFFF:01.2.3.4'));
SELECT HEX(INET6_ATON('::FFFF:1.02.3.4'));
SELECT HEX(INET6_ATON('::FFFF:1.2.03.4'));
SELECT HEX(INET6_ATON('::FFFF:1.2.3.04'));
SELECT HEX(INET6_ATON('::FFFF:1.2.3.00'));

SELECT LENGTH(INET6_ATON('0.0.0.0'));
SELECT LENGTH(INET6_ATON('255.255.255.255'));
SELECT LENGTH(INET6_ATON('::'));
SELECT LENGTH(INET6_ATON('1020:3040:5060:7080:90A0:B0C0:D0E0:F010'));

SELECT INET6_NTOA(NULL);
SELECT INET6_NTOA(123);
SELECT INET6_NTOA(123.456);
SELECT INET6_NTOA(str_to_date('2014,2,28 09', '%Y,%m,%d %h'));
SELECT INET6_NTOA(UNHEX('C0A801'));
SELECT INET6_NTOA(UNHEX('C0A80102'));
SELECT INET6_NTOA(UNHEX('C0A8010203'));
SELECT INET6_NTOA(UNHEX('0102030405060708090A0B0C0D0E0F'));
SELECT INET6_NTOA(UNHEX('0102030405060708090A0B0C0D0E0F10'));
SELECT INET6_NTOA(UNHEX('0102030405060708090A0B0C0D0E0F1011'));

SELECT INET6_NTOA('1234'), INET6_NTOA(BINARY('1234'));
SELECT INET6_NTOA('0123456789abcdef'), INET6_NTOA(BINARY('0123456789abcdef'));

SELECT INET6_NTOA(INET6_ATON('::'));
SELECT INET6_NTOA(INET6_ATON('0::0'));
SELECT INET6_NTOA(INET6_ATON('1::2'));
SELECT INET6_NTOA(INET6_ATON('0::'));
SELECT INET6_NTOA(INET6_ATON('1::'));
SELECT INET6_NTOA(INET6_ATON('::0'));
SELECT INET6_NTOA(INET6_ATON('::1'));
SELECT INET6_NTOA(INET6_ATON('1:2:3:4:5:6:7:8'));
SELECT INET6_NTOA(INET6_ATON('::2:3:4:5:6:7:8'));
SELECT INET6_NTOA(INET6_ATON('1::3:4:5:6:7:8'));
SELECT INET6_NTOA(INET6_ATON('1:2::4:5:6:7:8'));
SELECT INET6_NTOA(INET6_ATON('1:2:3::5:6:7:8'));
SELECT INET6_NTOA(INET6_ATON('1:2:3:4::6:7:8'));
SELECT INET6_NTOA(INET6_ATON('1:2:3:4:5::7:8'));
SELECT INET6_NTOA(INET6_ATON('1:2:3:4:5:6::8'));
SELECT INET6_NTOA(INET6_ATON('1:2:3:4:5:6:7::'));
SELECT INET6_NTOA(INET6_ATON('0000:0000::0000:0001'));
SELECT INET6_NTOA(INET6_ATON('1234:5678:9abc:def0:4321:8765:cba9:0fed'));
SELECT INET6_NTOA(INET6_ATON('0000:0000:0000:0000:0000:0000:0000:0001'));
SELECT INET6_NTOA(INET6_ATON('::C0A8:0102'));
SELECT INET6_NTOA(INET6_ATON('::c0a8:0102'));
SELECT INET6_NTOA(INET6_ATON('::192.168.1.2'));
SELECT INET6_NTOA(INET6_ATON('::FfFf:C0a8:0102'));
SELECT INET6_NTOA(INET6_ATON('::ffff:c0a8:0102'));
SELECT INET6_NTOA(INET6_ATON('::ffff:192.168.1.2'));
SELECT INET6_NTOA(INET6_ATON('::01.2.3.4'));
SELECT INET6_NTOA(INET6_ATON('::1.02.3.4'));
SELECT INET6_NTOA(INET6_ATON('::1.2.03.4'));
SELECT INET6_NTOA(INET6_ATON('::1.2.3.04'));
SELECT INET6_NTOA(INET6_ATON('::1.2.3.00'));
SELECT INET6_NTOA(INET6_ATON('::FFFF:01.2.3.4'));
SELECT INET6_NTOA(INET6_ATON('::FFFF:1.02.3.4'));
SELECT INET6_NTOA(INET6_ATON('::FFFF:1.2.03.4'));
SELECT INET6_NTOA(INET6_ATON('::FFFF:1.2.3.04'));
SELECT INET6_NTOA(INET6_ATON('::FFFF:1.2.3.00'));

SELECT HEX(INET_ATON('192.168.1.2'));
SELECT HEX(INET6_ATON('192.168.1.2'));

SELECT HEX(INET_ATON('255.255.255.255'));
SELECT HEX(INET6_ATON('255.255.255.255'));

SELECT HEX(INET_ATON('192.168.08.2'));
SELECT HEX(INET6_ATON('192.168.08.2'));

SELECT HEX(INET_ATON('192.168.0x8.2'));
SELECT HEX(INET6_ATON('192.168.0x8.2'));

SELECT HEX(INET_ATON('1.2.255'));
SELECT HEX(INET6_ATON('1.2.255'));

SELECT HEX(INET_ATON('1.2.256'));
SELECT HEX(INET6_ATON('1.2.256'));

SELECT HEX(INET_ATON('1.0002.3.4'));
SELECT HEX(INET6_ATON('1.0002.3.4'));

SELECT HEX(INET_ATON('1.2.3.4.5'));
SELECT HEX(INET6_ATON('1.2.3.4.5'));

SELECT HEX(INET6_ATON(INET_NTOA(INET_ATON('1.2.3.4')))) AS x;

SELECT IS_IPV4(NULL);
SELECT IS_IPV4(1);
SELECT IS_IPV4(1.0);
SELECT IS_IPV4('1.2.3.4');
SELECT IS_IPV4('001.02.000.255');
SELECT IS_IPV4('::1.2.0.255');
SELECT IS_IPV4('::1');
SELECT IS_IPV4(BINARY('1.2.3.4'));

SELECT IS_IPV6(NULL);
SELECT IS_IPV6(1);
SELECT IS_IPV6(1.0);
SELECT IS_IPV6('1.2.3.4');
SELECT IS_IPV6('001.02.000.255');
SELECT IS_IPV6('::001.02.000.255');
SELECT IS_IPV6('::1.2.0.255');
SELECT IS_IPV6('::1');
SELECT IS_IPV6('0000:0000:0000:0000:0000:0000:0000:0001');
SELECT IS_IPV6(BINARY('0000:0000:0000:0000:0000:0000:0000:0001'));

SELECT IS_IPV4_MAPPED(INET6_ATON('1.2.3.4')),
       IS_IPV4_COMPAT(INET6_ATON('1.2.3.4'));
SELECT IS_IPV4_MAPPED(INET6_ATON('::1.2.3.4')),
       IS_IPV4_COMPAT(INET6_ATON('::1.2.3.4'));
SELECT IS_IPV4_MAPPED(INET6_ATON('::FFFF:1.2.3.4')),
       IS_IPV4_COMPAT(INET6_ATON('::FFFF:1.2.3.4'));
SELECT IS_IPV4_MAPPED(INET6_ATON('::ABCD:1.2.3.4')),
       IS_IPV4_COMPAT(INET6_ATON('::ABCD:1.2.3.4'));
SELECT IS_IPV4_MAPPED(INET6_ATON('::1')),
       IS_IPV4_COMPAT(INET6_ATON('::1'));
SELECT IS_IPV4_MAPPED(INET6_ATON('::')),
       IS_IPV4_COMPAT(INET6_ATON('::'));

-- NOTE: IS_IPV4_COMPAT() / IS_IPV4_MAPPED() could work with "regular strings in
-- binary collation" too, but there is no way to create a "regular string"
-- starting with \0.

--echo
--echo -- -- Checking IS_IPV4_COMPAT()...
--echo

--echo
--echo -- -- Working with a table...
--echo

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;

CREATE TABLE t1(ip INT UNSIGNED);
CREATE TABLE t2(ip VARBINARY(16));

INSERT INTO t1 VALUES
  (INET_ATON('1.2.3.4')), (INET_ATON('255.255.255.255'));
SELECT INET_NTOA(ip) FROM t1;

INSERT INTO t2 SELECT INET6_ATON(INET_NTOA(ip)) FROM t1;
SELECT INET6_NTOA(ip), HEX(ip), LENGTH(ip) FROM t2;
DELETE FROM t2;

INSERT INTO t2 VALUES
  (INET6_ATON('1.2.3.4')), (INET6_ATON('255.255.255.255')),
  (INET6_ATON('::1.2.3.4')), (INET6_ATON('::ffff:255.255.255.255')),
  (INET6_ATON('::')), (INET6_ATON('::1')),
  (INET6_ATON('1020:3040:5060:7080:90A0:B0C0:D0E0:F010'));
SELECT INET6_NTOA(ip), HEX(ip), LENGTH(ip) FROM t2;

DELETE FROM t2;
INSERT INTO t2 VALUES (INET6_ATON('1.0002.3.4'));
INSERT INTO t2 VALUES (INET6_ATON('1.2.255'));
INSERT INTO t2 VALUES (INET6_ATON('1.2.256'));
INSERT INTO t2 VALUES (INET6_ATON('192.168.0x8.2'));

INSERT INTO t2 VALUES (inet_aton("122.256"));
INSERT INTO t2 VALUES (inet_aton("122.226."));
INSERT INTO t2 VALUES (inet_aton(""));

INSERT INTO t2 VALUES (UNHEX('Z0Q80F02'));

SELECT INET6_NTOA(ip), HEX(ip), LENGTH(ip) FROM t2;
DELETE FROM t2;
SET sql_mode = default;
INSERT INTO t2 VALUES (INET6_ATON('1.0002.3.4'));
INSERT INTO t2 VALUES (INET6_ATON('1.2.255'));
INSERT INTO t2 VALUES (INET6_ATON('1.2.256'));
INSERT INTO t2 VALUES (INET6_ATON('192.168.0x8.2'));
INSERT INTO t2 VALUES (inet_aton("122.256"));
INSERT INTO t2 VALUES (inet_aton("122.226."));
INSERT INTO t2 VALUES (inet_aton(""));
INSERT INTO t2 VALUES (UNHEX('Z0Q80F02'));

SELECT INET6_NTOA(ip), HEX(ip), LENGTH(ip) FROM t2;

DROP TABLE t1;
DROP TABLE t2;

select inet_aton("0.255.255.255.255");
select inet_aton("255.255.255.2551");
SELECT IS_IPV4_MAPPED(MIN(AES_ENCRYPT(1,2)));
SELECT IS_IPV4_COMPAT(MIN(AES_ENCRYPT(1,2)));

select format('f','')<=replace(1,1,mid(0xd9,2,1));

-- UUID() is not deterministic and affects warning output.
--disable_warnings
DO DATEDIFF(UUID_TO_BIN(UUID()), 0x32df2ce8);
DROP TABLE t1;

CREATE TABLE t1 (
pk INTEGER PRIMARY KEY,
col_time TIME DEFAULT NULL,
col_varchar VARCHAR(1) DEFAULT NULL,
KEY (col_varchar)
);

INSERT INTO t1 VALUES(5, '11:03:56', 'I');
DROP TABLE t1;
<=>
   (json_objectagg('key2',42 ) and rtrim(""));
