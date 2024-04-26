
-- Several subtests modify global variables. Save the initial values only here,
-- but reset to the initial values per subtest.
SET @old_general_log= @@global.general_log;
SET @old_general_log_file= @@global.general_log_file;
SET @old_slow_query_log= @@global.slow_query_log;
SET @old_slow_query_log_file= @@global.slow_query_log_file;

set global general_log= OFF;
set global general_log= ON;
create table t1(f1 int);
select * from mysql.general_log;
set global general_log= OFF;
drop table t1;
select * from mysql.general_log;
set global general_log= ON;
--    start_time ... sql_text
--    TIMESTAMP  ... set session long_query_time=...
-- (Bug#40377 sporadic pushbuild failure in log_state: result mismatch)
--replace_result 2 <long_query_time>
set @long_query_time = 2;
set session long_query_time = @long_query_time;
select sleep(@long_query_time + 1);
select * from mysql.slow_log where sql_text NOT LIKE '%slow_log%';

set global slow_query_log= ON;
set session long_query_time = @long_query_time;
select sleep(@long_query_time + 1);
select * from mysql.slow_log where sql_text NOT LIKE '%slow_log%';

set global general_log= ON;
set global general_log= OFF;
set global general_log= OFF;
set global slow_query_log= ON;
set global slow_query_log= OFF;
set global slow_query_log= OFF;

set global general_log= ON;
create table t1(f1 int);
drop table t1;
select * from mysql.general_log;
set global general_log= OFF;
select * from mysql.general_log;
set global general_log= ON;

-- Can't set general_log_file to a non existing file
--error ER_WRONG_VALUE_FOR_VAR
set global general_log_file='/not existing path/log.master';

-- Can't set general_log_file to a directory
--replace_result $MYSQLTEST_VARDIR MYSQLTEST_VARDIR
--error ER_WRONG_VALUE_FOR_VAR
eval set global general_log_file='$MYSQLTEST_VARDIR';

-- Can't set general_log_file to empty string
--error ER_WRONG_VALUE_FOR_VAR
set global general_log_file='';
set global general_log= OFF;
set global general_log= ON;
create table t1(f1 int);
drop table t1;
set global general_log= OFF;
set global general_log_file=default;
set global general_log= ON;
create table t1(f1 int);
drop table t1;

set global general_log= default;
set global slow_query_log= default;
set global general_log_file= default;
set global slow_query_log_file= default;
set global general_log=ON;
set global log_output=default;
set global general_log=OFF;
set global log_output=FILE;
set global general_log=ON;
create table t1(f1 int);
select * from mysql.general_log;
set global general_log=OFF;
set global log_output="FILE,TABLE";
set global general_log=ON;
drop table t1;
select * from mysql.general_log;

-- Reset to initial values
SET @@global.general_log = @old_general_log;
SET @@global.general_log_file = @old_general_log_file;
SET @@global.slow_query_log = @old_slow_query_log;
SET @@global.slow_query_log_file = @old_slow_query_log_file;

--
-- Bug#29129 (Resetting general_log while the GLOBAL READ LOCK is set causes
--            a deadlock)
--

-- Test ON->OFF transition under a GLOBAL READ LOCK
SET GLOBAL general_log = ON;
SET GLOBAL slow_query_log = ON;

SET GLOBAL general_log = OFF;
SET GLOBAL slow_query_log = OFF;

-- Test OFF->ON transition under a GLOBAL READ LOCK
FLUSH TABLES WITH READ LOCK;

SET GLOBAL general_log = ON;
SET GLOBAL slow_query_log = ON;

-- Test ON->OFF transition under a GLOBAL READ_ONLY
SET GLOBAL READ_ONLY = ON;

SET GLOBAL general_log = OFF;
SET GLOBAL slow_query_log = OFF;

SET GLOBAL READ_ONLY = OFF;

-- Test OFF->ON transition under a GLOBAL READ_ONLY
SET GLOBAL READ_ONLY = ON;

SET GLOBAL general_log = ON;
SET GLOBAL slow_query_log = ON;

SET GLOBAL READ_ONLY = OFF;

-- Reset to initial values
SET GLOBAL general_log = @old_general_log;
SET GLOBAL slow_query_log = @old_slow_query_log;

--
-- Bug#31604: server crash when setting slow_query_log_file/general_log_file
--

--error ER_WRONG_VALUE_FOR_VAR
SET GLOBAL general_log_file= CONCAT('/not existing path/log.maste', 'r');
SET GLOBAL general_log_file= NULL;
SET GLOBAL slow_query_log_file= CONCAT('/not existing path/log.maste', 'r');
SET GLOBAL slow_query_log_file= NULL;

-- Reset to initial values in case a setting above was successful.
SET GLOBAL general_log_file= @old_general_log_file;
SET GLOBAL slow_query_log_file= @old_slow_query_log_file;
SET GLOBAL general_log_file = 'bug32748.query.log';
SET GLOBAL slow_query_log_file = 'bug32748.slow.log';

-- Reset to initial values
--echo
SET GLOBAL general_log_file = @old_general_log_file;
SET GLOBAL slow_query_log_file = @old_slow_query_log_file;

SET @old_log_output = @@global.log_output;
SET GLOBAL log_output = "TABLE";
SET GLOBAL slow_query_log = ON;
SET GLOBAL long_query_time = 0.001;

-- clear slow_log of any residual slow queries
TRUNCATE TABLE mysql.slow_log;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (b INT, PRIMARY KEY (b));
INSERT INTO t2 VALUES (3),(4);
INSERT INTO t1 VALUES (1+sleep(.01)),(2);
INSERT INTO t1 SELECT b+sleep(.01) from t2;
UPDATE t1 SET a=a+sleep(.01) WHERE a>2;
UPDATE t1 SET a=a+sleep(.01) ORDER BY a DESC;
UPDATE t2 set b=b+sleep(.01) limit 1;
UPDATE t1 SET a=a+sleep(.01) WHERE a in (SELECT b from t2);
DELETE FROM t1 WHERE a=a+sleep(.01) ORDER BY a LIMIT 2;

SELECT rows_examined,sql_text FROM mysql.slow_log;
DROP TABLE t1,t2;

-- Store away the special DEFAULT value so we
-- can compare it later, then try to set the
-- general_log_file using different functions
-- and expressions.

SET GLOBAL general_log_file = DEFAULT;
SELECT @@general_log_file INTO @my_glf;

SET GLOBAL general_log_file = 'BUG38124.LOG';
SELECT @@general_log_file;

SET GLOBAL general_log_file = concat('BUG38124-2.LOG');
SELECT @@general_log_file;

SET GLOBAL general_log_file = substr('BUG38124-2.LOG',3,6);
SELECT @@general_log_file;

SET GLOBAL general_log_file = DEFAULT;
SELECT @@general_log_file = @my_glf;


--# Reset to initial values
SET GLOBAL general_log_file = @old_general_log_file;

--
-- Cleanup
--
-- Disconnect must be done last to avoid delayed 'Quit' message in general log
--echo -- Close connection con1
disconnect con1;

-- Reset global system variables to initial values if forgotten somewhere above.
SET GLOBAL long_query_time = DEFAULT;
SET GLOBAL log_output = @old_log_output;
SET global general_log = @old_general_log;
SET global general_log_file = @old_general_log_file;
SET global slow_query_log = @old_slow_query_log;
SET global slow_query_log_file = @old_slow_query_log_file;
