{
  --disable_query_log
  -- Avoid warnings since binlog_format is deprecated
  --disable_warnings
  SET @saved_binlog_format= @@SESSION.binlog_format;
  SET SESSION binlog_format= STATEMENT;

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--error ER_UNKNOWN_STORAGE_ENGINE
CREATE TABLE t1(a int) ENGINE=EXAMPLE;
CREATE TABLE t1 (a int PRIMARY KEY) ENGINE=EXAMPLE;
CREATE TABLE t1 (a int, KEY (a)) ENGINE=EXAMPLE;


CREATE TABLE t1(a int) ENGINE=EXAMPLE;
INSERT INTO t1 VALUES (0);
SELECT * FROM t1;
SELECT * FROM t1 WHERE a = 0;
UPDATE t1 SET a = 1 WHERE a = 0;
DELETE FROM t1 WHERE a = 0;
DROP TABLE t1;

DROP TABLE t1;

-- a couple of tests for variables
set global example_ulong_var=500;
set global example_enum_var= e1;
select * from performance_schema.global_status where variable_name like 'example%' order by variable_name;

SET GLOBAL example_enum_var= e1;
SET GLOBAL example_enum_var= e2;
SET GLOBAL example_enum_var= impossible;



--
-- Bug #32757 hang with sql_mode set when setting some global variables
--
--replace_regex /\.dll/.so/
eval INSTALL PLUGIN example SONAME '$EXAMPLE_PLUGIN';

select @@session.sql_mode into @old_sql_mode;

-- first, try normal sql_mode (no error, send OK)
set session sql_mode='';
set global example_ulong_var=500;
select @@global.example_ulong_var;
set global example_ulong_var=1111;
select @@global.example_ulong_var;

-- now, try STRICT (error occurrs, no message is sent, so send default)
set session sql_mode='STRICT_ALL_TABLES';
set global example_ulong_var=500;
select @@global.example_ulong_var;
set global example_ulong_var=1111;
select @@global.example_ulong_var;

set session sql_mode=@old_sql_mode;

-- finally, show that conditions that already raised an error are not
-- adversely affected (error was already sent, do nothing)
--error ER_INCORRECT_GLOBAL_LOCAL_VAR
set session old=bla;

SET GLOBAL example_double_var = -0.1;
SELECT @@GLOBAL.example_double_var;

SET GLOBAL example_double_var = 0.000001;
SELECT @@GLOBAL.example_double_var;

SET GLOBAL example_double_var = 0.4;
SELECT @@GLOBAL.example_double_var;

SET GLOBAL example_double_var = 123.456789;
SELECT @@GLOBAL.example_double_var;

SET GLOBAL example_double_var = 500;
SELECT @@GLOBAL.example_double_var;

SET GLOBAL example_double_var = 999.999999;
SELECT @@GLOBAL.example_double_var;

SET GLOBAL example_double_var = 1000.51;
SELECT @@GLOBAL.example_double_var;

SET SESSION example_double_thdvar = -0.1;
SELECT @@SESSION.example_double_thdvar;

SET SESSION example_double_thdvar = 0.000001;
SELECT @@SESSION.example_double_thdvar;

SET SESSION example_double_thdvar = 0.4;
SELECT @@SESSION.example_double_thdvar;

SET SESSION example_double_thdvar = 123.456789;
SELECT @@SESSION.example_double_thdvar;

SET SESSION example_double_thdvar = 500;
SELECT @@SESSION.example_double_thdvar;

SET SESSION example_double_thdvar = 999.999999;
SELECT @@SESSION.example_double_thdvar;

SET SESSION example_double_thdvar = 1000.51;
SELECT @@SESSION.example_double_thdvar;

-- Innodb is now builtin plugin and not dynamically loaded
--error ER_PLUGIN_DELETE_BUILTIN
UNINSTALL PLUGIN innodb;

SET SESSION example_create_count_thdvar = 0;
SET SESSION example_last_create_thdvar = '';

CREATE TABLE t10(a INT) ENGINE=EXAMPLE;
SELECT @@SESSION.example_create_count_thdvar;
SELECT @@SESSION.example_last_create_thdvar;

CREATE TABLE t20(a INT) ENGINE=EXAMPLE;
SELECT @@SESSION.example_create_count_thdvar;
SELECT @@SESSION.example_last_create_thdvar;

DROP TABLE t10, t20;
SET GLOBAL DEBUG='+d,set_uninstall_sync_point';
SET DEBUG_SYNC='before_store_plugin_name SIGNAL uninstall_plugin WAIT_FOR plugin_uninstalled';
SET DEBUG_SYNC='now WAIT_FOR uninstall_plugin';
SET DEBUG_SYNC='now SIGNAL plugin_uninstalled';
SET DEBUG_SYNC='RESET';
SET GLOBAL DEBUG='-d,set_uninstall_sync_point';

-- Wait till we reached the initial number of concurrent sessions
--source include/wait_until_count_sessions.inc

--echo --
--echo -- Bug#51770: UNINSTALL PLUGIN requires no privileges
--echo --

CREATE USER bug51770@localhost;
DROP USER bug51770@localhost;

--
-- BUG#58246: INSTALL PLUGIN not secure & crashable
--
-- The bug consisted of not recognizing / on Windows, so checking / on
-- all platforms should cover this case.

let $path = `select CONCAT_WS('/', '..', '$EXAMPLE_PLUGIN')`;

if (`SELECT @@global.log_bin AND @@global.binlog_format = 'ROW'`)
{
  --disable_query_log
  --disable_warnings
  SET SESSION binlog_format= @saved_binlog_format;

SELECT * FROM performance_schema.global_status WHERE variable_name LIKE 'example_func_example' ORDER BY variable_name;
SELECT @@GLOBAL.example_signed_int_var;

SET GLOBAL example_signed_int_var = -2147483648;
SELECT @@GLOBAL.example_signed_int_var;

SET GLOBAL example_signed_int_var = -100;
SELECT @@GLOBAL.example_signed_int_var;

SET GLOBAL example_signed_int_var = 0;
SELECT @@GLOBAL.example_signed_int_var;

SET GLOBAL example_signed_int_var = 100;
SELECT @@GLOBAL.example_signed_int_var;

SET GLOBAL example_signed_int_var = 2147483647;
SELECT @@GLOBAL.example_signed_int_var;

SET GLOBAL example_signed_int_var = -2147483649;
SELECT @@GLOBAL.example_signed_int_var;

SET GLOBAL example_signed_int_var = 2147483648;
SELECT @@GLOBAL.example_signed_int_var;
SELECT @@SESSION.example_signed_int_thdvar;

SET SESSION example_signed_int_thdvar = -2147483648;
SELECT @@SESSION.example_signed_int_thdvar;

SET SESSION example_signed_int_thdvar = -100;
SELECT @@SESSION.example_signed_int_thdvar;

SET SESSION example_signed_int_thdvar = 0;
SELECT @@SESSION.example_signed_int_thdvar;

SET SESSION example_signed_int_thdvar = 100;
SELECT @@SESSION.example_signed_int_thdvar;

SET SESSION example_signed_int_thdvar = 2147483647;
SELECT @@SESSION.example_signed_int_thdvar;

SET SESSION example_signed_int_thdvar = -2147483649;
SELECT @@SESSION.example_signed_int_thdvar;

SET SESSION example_signed_int_thdvar = 2147483648;
SELECT @@SESSION.example_signed_int_thdvar;
SELECT @@GLOBAL.example_signed_long_var;

SET GLOBAL example_signed_long_var = -9223372036854775808;
SELECT @@GLOBAL.example_signed_long_var IN (-2147483648, -9223372036854775808);

SET GLOBAL example_signed_long_var = -100;
SELECT @@GLOBAL.example_signed_long_var;

SET GLOBAL example_signed_long_var = 0;
SELECT @@GLOBAL.example_signed_long_var;

SET GLOBAL example_signed_long_var = 100;
SELECT @@GLOBAL.example_signed_long_var;

SET GLOBAL example_signed_long_var = 9223372036854775807;
SELECT @@GLOBAL.example_signed_long_var IN (2147483647, 9223372036854775807);
SET GLOBAL example_signed_long_var = -9223372036854775809;
SELECT @@GLOBAL.example_signed_long_var IN (2147483647, 9223372036854775807);

SET GLOBAL example_signed_long_var = 9223372036854775808;
SELECT @@GLOBAL.example_signed_long_var IN (2147483647, 9223372036854775807);
SELECT @@SESSION.example_signed_long_thdvar;

SET SESSION example_signed_long_thdvar = -9223372036854775808;
SELECT @@SESSION.example_signed_long_thdvar IN (-2147483648, -9223372036854775808);

SET SESSION example_signed_long_thdvar = -100;
SELECT @@SESSION.example_signed_long_thdvar;

SET SESSION example_signed_long_thdvar = 0;
SELECT @@SESSION.example_signed_long_thdvar;

SET SESSION example_signed_long_thdvar = 100;
SELECT @@SESSION.example_signed_long_thdvar;

SET SESSION example_signed_long_thdvar = 9223372036854775807;
SELECT @@SESSION.example_signed_long_thdvar IN (2147483647, 9223372036854775807);
SET SESSION example_signed_long_thdvar = -9223372036854775809;
SELECT @@SESSION.example_signed_long_thdvar IN (2147483647, 9223372036854775807);

SET SESSION example_signed_long_thdvar = 9223372036854775808;
SELECT @@SESSION.example_signed_long_thdvar IN (2147483647, 9223372036854775807);
SELECT @@GLOBAL.example_signed_longlong_var;

SET GLOBAL example_signed_longlong_var = -9223372036854775808;
SELECT @@GLOBAL.example_signed_longlong_var;

SET GLOBAL example_signed_longlong_var = -100;
SELECT @@GLOBAL.example_signed_longlong_var;

SET GLOBAL example_signed_longlong_var = 0;
SELECT @@GLOBAL.example_signed_longlong_var;

SET GLOBAL example_signed_longlong_var = 100;
SELECT @@GLOBAL.example_signed_longlong_var;

SET GLOBAL example_signed_longlong_var = 9223372036854775807;
SELECT @@GLOBAL.example_signed_longlong_var;
SET GLOBAL example_signed_longlong_var = -9223372036854775809;
SELECT @@GLOBAL.example_signed_longlong_var;

SET GLOBAL example_signed_longlong_var = 9223372036854775808;
SELECT @@GLOBAL.example_signed_longlong_var;
SELECT @@SESSION.example_signed_longlong_thdvar;

SET SESSION example_signed_longlong_thdvar = -9223372036854775808;
SELECT @@SESSION.example_signed_longlong_thdvar;

SET SESSION example_signed_longlong_thdvar = -100;
SELECT @@SESSION.example_signed_longlong_thdvar;

SET SESSION example_signed_longlong_thdvar = 0;
SELECT @@SESSION.example_signed_longlong_thdvar;

SET SESSION example_signed_longlong_thdvar = 100;
SELECT @@SESSION.example_signed_longlong_thdvar;

SET SESSION example_signed_longlong_thdvar = 9223372036854775807;
SELECT @@SESSION.example_signed_longlong_thdvar;
SET SESSION example_signed_longlong_thdvar = -9223372036854775809;
SELECT @@SESSION.example_signed_longlong_thdvar;

SET SESSION example_signed_longlong_thdvar = 9223372036854775808;
SELECT @@SESSION.example_signed_longlong_thdvar;
