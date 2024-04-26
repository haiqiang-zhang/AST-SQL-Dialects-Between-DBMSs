
-- When running with valgrind, we switch off --check-testcases, and get
-- different connection_id below, and a content mismatch error.
-- source include/not_valgrind.inc

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

-- Disable concurrent inserts to avoid sporadic test failures as it might
-- affect the the value of variables used throughout the test case.
set @old_concurrent_insert= @@global.concurrent_insert;
set @@global.concurrent_insert= 0;

-- Disable logging to table, since this will also cause table locking and unlocking, which will
-- show up in SHOW STATUS and may cause sporadic failures

SET @old_log_output = @@global.log_output;
SET GLOBAL LOG_OUTPUT = 'FILE';

-- PS causes different statistics
--disable_ps_protocol

connect (con1,localhost,root,,);
select * from performance_schema.session_status where variable_name like 'Table_lock%';

set sql_log_bin=0;
set @old_general_log = @@global.general_log;
set global general_log = 'OFF';
drop table if exists t1;

create table t1(n int);
insert into t1 values(1);
select get_lock('mysqltest_lock', 100);
let $wait_condition= select count(*) from INFORMATION_SCHEMA.PROCESSLIST
                     where STATE = "User lock" and
                           INFO = "update t1 set n = get_lock('mysqltest_lock', 100)";
let $wait_condition= select 1 from INFORMATION_SCHEMA.PROCESSLIST
    where ID = (select connection_id()) and STATE = "Waiting for table level lock";
select release_lock('mysqltest_lock');
select release_lock('mysqltest_lock');
drop table t1;
set global general_log = @old_general_log;

-- End of 4.1 tests

--
-- last_query_cost
--

select 1;
create table t1 (a int);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
select * from t1 where a=6;
select 1;
drop table t1;

--
-- Test for Bug#15933 max_used_connections is wrong after FLUSH STATUS
-- if connections are cached
--
--
-- The first suggested fix from the bug report was chosen
-- (see http://bugs.mysql.com/bug.php?id=15933):
--
--   a) On flushing the status, set max_used_connections to
--   threads_connected, not to 0.
--
--   b) Check if it is necessary to increment max_used_connections when
--   taking a thread from the cache as well as when creating new threads
--

-- Wait for at most $disconnect_timeout seconds for disconnects to finish.
let $disconnect_timeout = 10;

-- Wait for any previous disconnects to finish.
FLUSH STATUS;
let $max_used_connections = `SHOW STATUS LIKE 'max_used_connections'`;
let $wait_more = `SELECT @max_used_connections != 1 && @wait_left > 0`;
{
  sleep 1;
  SET @wait_left = @wait_left - 1;
  let $max_used_connections = `SHOW STATUS LIKE 'max_used_connections'`;
  let $wait_more = `SELECT @max_used_connections != 1 && @wait_left > 0`;

-- Prerequisite.
SHOW STATUS LIKE 'max_used_connections';
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';

-- Save original setting.
SET @save_thread_cache_size=@@thread_cache_size;
SET GLOBAL thread_cache_size=3;

-- Check that max_used_connections still reflects maximum value.
SHOW STATUS LIKE 'max_used_connections';
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';

-- Check that after flush max_used_connections equals to current number
-- of connections.  First wait for previous disconnect to finish.
FLUSH STATUS;
let $max_used_connections = `SHOW STATUS LIKE 'max_used_connections'`;
let $wait_more = `SELECT @max_used_connections != 2 && @wait_left > 0`;
{
  sleep 1;
  SET @wait_left = @wait_left - 1;
  let $max_used_connections = `SHOW STATUS LIKE 'max_used_connections'`;
  let $wait_more = `SELECT @max_used_connections != 2 && @wait_left > 0`;
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';

-- Check that max_used_connections is updated when cached thread is
-- reused...
connect (con2,localhost,root,,);
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';

-- ...and when new thread is created.
connect (con3,localhost,root,,);
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';

-- Restore original setting.
connection default;
SET GLOBAL thread_cache_size=@save_thread_cache_size;


--
-- Bug#30377 EXPLAIN loses last_query_cost when used with UNION
--

CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES (1), (2);
SELECT a FROM t1 LIMIT 1;

SELECT a FROM t1 UNION SELECT a FROM t1 ORDER BY a;

SELECT a IN (SELECT a FROM t1) FROM t1 LIMIT 1;

SELECT (SELECT a FROM t1 LIMIT 1) x FROM t1 LIMIT 1;

SELECT * FROM t1 a, t1 b ORDER BY a.a, b.a LIMIT 1;

DROP TABLE t1;


--
-- Bug#30252 Com_create_function is not incremented.
--
flush status;
create function f1 (x INTEGER) returns integer
  begin
    declare ret integer;
    set ret = x * 10;
    return ret;
  end //
DELIMITER ;

drop function f1;

--
-- Bug#37908 Skipped access right check caused server crash.
--
connect (root, localhost, root,,test);
let $root_connection_id= `select connection_id()`;
create database db37908;
create table db37908.t1(f1 int);
insert into db37908.t1 values(1);
create user mysqltest_1@localhost;
create procedure proc37908() begin select 1;
create function func37908() returns int sql security invoker
  return (select * from db37908.t1 limit 1)|
delimiter ;
let $user1_connection_id= `select connection_id()`;
select * from db37908.t1;
drop database db37908;
drop procedure proc37908;
drop function func37908;
DROP USER mysqltest_1@localhost;
let $wait_condition =
  SELECT COUNT(*) = 0
  FROM information_schema.processlist
  WHERE  id in ('$root_connection_id','$user1_connection_id');

--
-- Bug#41131 "Questions" fails to increment - ignores statements instead stored procs
--
connect (con1,localhost,root,,);
DROP PROCEDURE IF EXISTS p1;
DROP FUNCTION IF EXISTS f1;
CREATE FUNCTION f1() RETURNS INTEGER
BEGIN
  DECLARE foo INTEGER;
  SET foo=1;
  SET bar=2;
END $$
CREATE PROCEDURE p1()
  BEGIN
  SELECT 1;
END $$
DELIMITER ;
let $org_queries= `SHOW STATUS LIKE 'Queries'`;
SELECT f1();
let $new_queries= `SHOW STATUS LIKE 'Queries'`;
let $diff= `SELECT SUBSTRING('$new_queries',9)-SUBSTRING('$org_queries',9)`;
DROP PROCEDURE p1;
DROP FUNCTION f1;

-- End of 5.1 tests


--echo --
--echo -- Test coverage for status variables which were introduced by
--echo -- WL#5772 "Add partitioned Table Definition Cache to avoid
--echo -- using LOCK_open and its derivatives in DML queries".
--echo --
create table t1 (i int);
create table t2 (j int);
create table t3 (k int);
set @old_table_open_cache= @@table_open_cache;
select * from t1;
select * from t1;
select * from t2;
select * from t2;
select * from t1 as a, t2 as b, t1 as c, t2 as d, t1 as e, t2 as f;
set @@global.table_open_cache= 4;
select * from t1;
select * from t1 as a, t2 as b, t1 as c, t2 as d, t1 as e, t2 as f;
select * from t3;
set @@global.table_open_cache= @old_table_open_cache;
drop tables t1, t2, t3;

--
-- Bug#11766596: UPDATE A TIMESTAMP VARIABLE EVERY TIME REACHES MAX_USED_CONNECTIONS
--

connect (con1,localhost,root,,);

let $time_1=`SELECT VARIABLE_VALUE FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections_time'`;
let $time_2=`SELECT VARIABLE_VALUE FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections_time'`;

let $time_3=`SELECT VARIABLE_VALUE FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections_time'`;
let $time_4=`SELECT VARIABLE_VALUE FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections_time'`;

-- Restore global concurrent_insert value. Keep in the end of the test file.
--connection default
set @@global.concurrent_insert= @old_concurrent_insert;
SET GLOBAL log_output = 'FILE,TABLE';

-- Wait till we reached the initial number of concurrent sessions
--source include/wait_until_count_sessions.inc

--echo --
--echo -- Bug#28786951 SET LAST_QUERY_COST FOR QUERIES WITH SUBQUERIES AND UNIONS
--echo --

CREATE TABLE t1(x INT, y INT);
INSERT INTO t1 VALUES (1, 2), (3, 4), (5, 6);
        UNION ALL
        SELECT * FROM t1 WHERE y > 0;
        UNION DISTINCT
        SELECT * FROM t1 WHERE y > 0;
        SELECT * FROM t1 WHERE x > 0
        UNION ALL
        SELECT * FROM t1 WHERE y > 0;
        SELECT * FROM t1 WHERE x > 0
        UNION DISTINCT
        SELECT * FROM t1 WHERE y > 0;

DROP TABLE t1;

CREATE TABLE t1 (pk INTEGER PRIMARY KEY,
                 i1 INTEGER,
                 i2 INTEGER NOT NULL,
                 INDEX k1 (i1),
                 INDEX k2 (i1, i2));

INSERT INTO t1 VALUES
  (1, NULL, 43), (11, NULL, 103), (10, 32,50), (9, 12, 43),
  (8, NULL, 13), (7, 48, 90), (6, 56, 90), (5, 87, 84),
  (4, 58, 98), (3, 30, 82), (2, 54, 57), (12, 232, 43),
  (13, 43, 103), (14, 32, 45), (15, 12, 43), (16, 89, 23),
  (17, 48, 90), (18, 56, 90), (19, 87, 84);

CREATE TABLE t2 (pk INTEGER PRIMARY KEY,
                 i1 INTEGER NOT NULL,
                 INDEX k1 (i1));

INSERT INTO t2 VALUES
  (3, 89), (4, 98), (5, 84), (6, 8), (7, 99), (8, 110),
  (9, 84), (10, 98), (11, 103), (12, 50), (13, 84),
  (14, 57), (15, 82), (16, 103), (2, 98), (1, 90);

DROP TABLE t1, t2;

-- Restore default
SET @@global.log_output = @old_log_output;
SET @@global.general_log = @old_general_log;
