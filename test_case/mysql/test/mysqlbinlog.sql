
-- source include/have_log_bin.inc

--disable_query_log
CALL mtr.add_suppression("Unsafe statement written to the binary log using statement format since BINLOG_FORMAT = STATEMENT");

-- Deletes all the binary logs
reset binary logs and gtids;

-- we need this for getting fixed timestamps inside of this test
set timestamp=1000000000;
drop table if exists t1,t2,t3,t4,t5,t03,t04;

create table t1 (word varchar(20));
create table t2 (id int auto_increment not null primary key);

-- simple test for simple statement and various events
insert into t1 values ("abirvalg");
insert into t2 values ();

-- test for load data and load data distributed among the several
-- files (we need to fill up first binlog)
load data infile '../../std_data/words.dat' into table t1;
insert into t1 values ("Alas");

-- delimiters are for easier debugging in future
--disable_query_log
select "--- Local --" as "";

--
-- We should use --short-form everywhere because in other case output will
-- be time dependend. Better than nothing.
--
let $MYSQLD_DATADIR= `select @@datadir`;

-- this should not fail but shouldn't produce any working statements
--echo --- Broken LOAD DATA --
--let $mysqlbinlog_parameters= --short-form --local-load=$MYSQLTEST_VARDIR/tmp/ $MYSQLD_DATADIR/binlog.000002 2> /dev/null
--source include/mysqlbinlog.inc
--echo --- Broken LOAD DATA with streaming input --
--let $mysqlbinlog_parameters= --short-form --local-load=$MYSQLTEST_VARDIR/tmp/ - 2> /dev/null < $MYSQLD_DATADIR/binlog.000002
--source include/mysqlbinlog.inc

-- this should show almost nothing
--echo --- --database --
--let $mysqlbinlog_parameters= --short-form --local-load=$MYSQLTEST_VARDIR/tmp/ --database=nottest $MYSQLD_DATADIR/binlog.000001 2> /dev/null
--source include/mysqlbinlog.inc

-- this test for start-position option
--echo --- --start-position --
--let $mysqlbinlog_parameters= --short-form --local-load=$MYSQLTEST_VARDIR/tmp/ --start-position=$binlog_start_pos $MYSQLD_DATADIR/binlog.000002
--source include/mysqlbinlog.inc
--echo --- --start-position with streaming input --
--let $mysqlbinlog_parameters= --short-form --local-load=$MYSQLTEST_VARDIR/tmp/ --start-position=$binlog_start_pos - < $MYSQLD_DATADIR/binlog.000002
--source include/mysqlbinlog.inc

-- These are tests for remote binlog.
-- They should return the same as previous test.

--echo --- Remote --

-- This is broken now
--let $mysqlbinlog_parameters= --short-form --local-load=$MYSQLTEST_VARDIR/tmp/ --read-from-remote-server --user=root --host=127.0.0.1 --port=$MASTER_MYPORT binlog.000001
--source include/mysqlbinlog.inc

-- This is broken too
--echo --- Broken LOAD DATA --
--let $mysqlbinlog_parameters= --short-form --local-load=$MYSQLTEST_VARDIR/tmp/ --read-from-remote-server --user=root --host=127.0.0.1 --port=$MASTER_MYPORT binlog.000002 2> /dev/null
--source include/mysqlbinlog.inc

-- And this too ! (altough it is documented)
--echo --- --database --
--let $mysqlbinlog_parameters= --short-form --local-load=$MYSQLTEST_VARDIR/tmp/ --read-from-remote-server --user=root --host=127.0.0.1 --port=$MASTER_MYPORT --database=nottest binlog.000001 2> /dev/null
--source include/mysqlbinlog.inc

-- Strangely but this works
--echo --- --start-position --
--let $mysqlbinlog_parameters= --short-form --local-load=$MYSQLTEST_VARDIR/tmp/ --read-from-remote-server --start-position=$binlog_start_pos --user=root --host=127.0.0.1 --port=$MASTER_MYPORT binlog.000002
--source include/mysqlbinlog.inc

-- Bug#7853 mysqlbinlog does not accept input from stdin
--echo --- reading stdin --
--let $mysqlbinlog_parameters= --short-form - < $MYSQL_TEST_DIR/std_data/master-bin.000001
--source include/mysqlbinlog.inc

-- postion is constant to correspond to an event in pre-recorded binlog
--let $binlog_start_pos=123
--let $mysqlbinlog_parameters= --short-form --start-position=$binlog_start_pos - < $MYSQL_TEST_DIR/std_data/master-bin.000001
--source include/mysqlbinlog.inc

drop table t1,t2;

--
-- Bug#14157 utf8mb3 encoding in binlog without set character_set_client
--
flush logs;
create table if not exists t5 (a int);
set names latin1;
create temporary table `äöüÄÖÜ` (a int);
insert into `äöüÄÖÜ` values (1);
insert into t5 select * from `äöüÄÖÜ`
EOF
--exec $MYSQL test < $MYSQLTEST_VARDIR/tmp/bug14157.sql
--remove_file $MYSQLTEST_VARDIR/tmp/bug14157.sql

-- resulted binlog, parly consisting of multi-byte utf8mb3 chars,
-- must be digestable for both client and server. In 4.1 the client
-- should use default-character-set same as the server.
flush logs;
select * from t5  /* must be (1),(1) */;
drop table t5;

--
-- Bug#22645 LC_TIME_NAMES: Statement not replicated
-- Check that a dump created by mysqlbinlog reproduces
-- lc_time_names dependent values correctly
--
flush logs;
create table t5 (c1 int, c2 varchar(128) character set latin1 not null);
insert into t5 values (1, date_format('2001-01-01','%W'));
set lc_time_names=de_DE;
insert into t5 values (2, date_format('2001-01-01','%W'));
set lc_time_names=en_US;
insert into t5 values (3, date_format('2001-01-01','%W'));
select * from t5 order by c1;
drop table t5;
select * from t5 order by c1;
drop table t5;

--
-- Bug#20396 Bin Log does not get DELIMETER cmd - Recover StoredProc fails
--
--disable_warnings
drop procedure if exists p1;
create procedure p1()
begin
select 1;
drop procedure p1;
drop procedure p1;

--
-- Some coverage of not normally used parts
--
--disable_query_log
--exec $MYSQL_BINLOG --version 2>&1 > /dev/null
--exec $MYSQL_BINLOG --help 2>&1 > /dev/null
--enable_query_log

--
-- Bug#15126 character_set_database is not replicated
-- (LOAD DATA INFILE need it)
--

flush logs;
create table t1 (a varchar(64) character set utf8mb3);
set character_set_database=koi8r;
set character_set_database=latin1;
set character_set_database=koi8r;
set character_set_database=latin1;
select hex(a) from t1;
drop table t1;

--
-- Bug#28293 missed '#' sign in the hex dump when the dump length
--           is divisible by 16.
--

CREATE TABLE t1 (c1 CHAR(10));
INSERT INTO t1 VALUES ('0123456789');
let $master_binlog_file= query_get_value(SHOW BINARY LOG STATUS, File, 1);
DROP TABLE t1;

-- We create a table, patch, and load the output into it
-- By using LINES STARTING BY '#' + SELECT WHERE a LIKE 'Query'
-- We can easily see if a 'Query' line is missing the '#' character
-- as described in the original bug

--disable_query_log
CREATE TABLE patch (a BLOB);
     INTO TABLE patch FIELDS TERMINATED BY '' LINES STARTING BY '--';
SELECT COUNT(*) AS `BUG--28293_expect_3` FROM patch WHERE a LIKE '%Query%';
DROP TABLE patch;

--
-- Bug#29928 incorrect connection_id() restoring from mysqlbinlog out
--
FLUSH LOGS;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(connection_id());
let $a= `SELECT a FROM t1`;
let $master_binlog_file= query_get_value(SHOW BINARY LOG STATUS, File, 1);
let $outfile= $MYSQLTEST_VARDIR/tmp/bug29928.sql;
DROP TABLE t1;
let $b= `SELECT a FROM t1`;
let $c= `SELECT $a=$b`;
DROP TABLE t1;

-- Set the timestamp back to default
set timestamp= default;
let $master_binlog_file= query_get_value(SHOW BINARY LOG STATUS, File, 1);

SET BINLOG_FORMAT='ROW';
CREATE DATABASE mysqltest1;
CREATE USER untrusted@localhost;
USE mysqltest1;
CREATE TABLE t1 (a INT, b CHAR(64));
INSERT INTO t1 VALUES (1,USER());
let $master_binlog_file= query_get_value(SHOW BINARY LOG STATUS, File, 1);
INSERT INTO t1 VALUES (1,USER());

SELECT * FROM t1;
DROP DATABASE mysqltest1;
DROP USER untrusted@localhost;

-- Testing that various kinds of events can be read and restored properly.

connection default;
USE test;
SET BINLOG_FORMAT = STATEMENT;
CREATE TABLE t1 (a_real FLOAT, an_int INT, a_decimal DECIMAL(5,2), a_string CHAR(32));
SET @a_real = rand(20) * 1000;
SET @an_int = 1000;
SET @a_decimal = CAST(rand(19) * 999 AS DECIMAL(5,2));
SET @a_string = 'Just a test';
INSERT INTO t1 VALUES (@a_real, @an_int, @a_decimal, @a_string);
let $master_binlog_file= query_get_value(SHOW BINARY LOG STATUS, File, 1);
DROP TABLE t1;
DROP TABLE t1;

--
-- Bug#37313 BINLOG Contains Incorrect server id
--

let $binlog_file=  $MYSQLTEST_VARDIR/tmp/mysqlbinlog_bug37313.binlog;
let $save_server_id= `SELECT @@global.server_id`;
let $s_id_max= `SELECT (1 << 32) - 1`;
let $s_id_unsigned= `SELECT @a LIKE "%server id $s_id_max%" /* must return 1 */`;

--
-- Bug #41943: mysqlbinlog.exe crashes if --hexdump option is used
--

RESET BINARY LOGS AND GTIDS;

-- We do not need the results, just make sure that mysqlbinlog does not crash
--exec $MYSQL_BINLOG --hexdump --read-from-remote-server --user=root --host=127.0.0.1 --port=$MASTER_MYPORT  binlog.000001 >/dev/null

--
-- #46998
-- This test verifies if the 'BEGIN', 'COMMIT' and 'ROLLBACK' are output 
-- in regardless of database filtering
--

RESET BINARY LOGS AND GTIDS;

-- The following three test cases were wrtten into binlog_transaction.000001
-- Test case1: Test if the 'BEGIN' and 'COMMIT' are output for the 'test' database 
-- in transaction1 base on innodb engine tables
-- use test;

-- Test case2: Test if the 'BEGIN' and 'ROLLBACK' are output for the 'test' database 
-- in transaction2 base on innodb and myisam engine tables
-- use test;

-- Test case3: Test if the 'BEGIN' and 'COMMIT' are output for the 'test' database 
-- in transaction3 base on NDB engine tables
-- use test;

--
-- BUG#38468 Memory leak detected when using mysqlbinlog utility;
CREATE TABLE t1 SELECT 1;
DROP TABLE t1;

-- Write an empty file for comparison
write_file $MYSQLTEST_VARDIR/tmp/mysqlbinlog.warn.empty;
EOF

-- Before fix of BUG#38468, this would generate some warnings
--exec $MYSQL_BINLOG $MYSQLD_DATADIR/binlog.000001 >/dev/null 2> $MYSQLTEST_VARDIR/tmp/mysqlbinlog.warn

-- Make sure the command above does not generate any error or warnings
diff_files $MYSQLTEST_VARDIR/tmp/mysqlbinlog.warn $MYSQLTEST_VARDIR/tmp/mysqlbinlog.warn.empty;

-- Cleanup for this part of test
remove_file $MYSQLTEST_VARDIR/tmp/mysqlbinlog.warn.empty;

--
-- WL#3126 TCP address binding for mysql client library;

--
-- WL#5625: Deprecate mysqlbinlog options --base64-output=always and --base64-output
--

--echo -- Expect error for unknown argument.
--error 1
--exec $MYSQL_BINLOG --base64-output=always std_data/master-bin.000001 > /dev/null 2> $MYSQLTEST_VARDIR/tmp/mysqlbinlog.warn
--cat_file $MYSQLTEST_VARDIR/tmp/mysqlbinlog.warn

--echo -- Expect error for unknown argument again.
--error 1
--exec $MYSQL_BINLOG --base64-output std_data/master-bin.000001 > /dev/null 2> $MYSQLTEST_VARDIR/tmp/mysqlbinlog.warn
--cat_file $MYSQLTEST_VARDIR/tmp/mysqlbinlog.warn

-- Clean up this part of the test.
--remove_file $MYSQLTEST_VARDIR/tmp/mysqlbinlog.warn

-- BUG#50914
-- This test verifies if the approach of the mysqlbinlog prints
-- "use $database" statements to its output stream will cause
-- "No Database Selected" error when dropping and recreating
-- that database.
--
RESET BINARY LOGS AND GTIDS;
CREATE DATABASE test1;
USE test1;
CREATE TABLE t1(id int);
DROP DATABASE test1;
CREATE DATABASE test1;
USE test1;
CREATE TABLE t1(id int);
DROP TABLE t1;
DROP DATABASE test1;
let $master_binlog= query_get_value(SHOW BINARY LOG STATUS, File, 1);

let $MYSQLD_DATADIR= `SELECT @@datadir`;

let $binlog_file= query_get_value(SHOW BINARY LOG STATUS, File, 1);

--
-- BUG#11766427 BUG#59530: Filter by server id in mysqlbinlog fails
-- This test checks that the format description log event is not
-- filtered out by the --server-id option.
--
RESET BINARY LOGS AND GTIDS;
USE test;
CREATE TABLE t1 (a INT);
SET GLOBAL SERVER_ID = 2;
DROP TABLE t1;

--
-- WL#9632: mysqlbinlog: generate deprecation warning for --short-form
--

RESET BINARY LOGS AND GTIDS;

--
-- WL#9633: mysqlbinlog: generate deprecation warning for --stop-never-slave-server-id
--

RESET BINARY LOGS AND GTIDS;
