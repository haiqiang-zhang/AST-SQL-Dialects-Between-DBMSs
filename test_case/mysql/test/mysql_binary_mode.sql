
-- zero => 0x00, newline => 0x0D0A, A => 0x41, B => 0x42

-- 0x410D0A42 => 'A\r\nB'
let $table_name_right= `SELECT 0x410D0A42`;

-- 0x410A42 => 'A\nB'
let $table_name_wrong= `SELECT 0x410A42`;

-- 0x410042 => 'A\0B'
let $char= `SELECT 0x410042`;

let $char= $table_name_right;
let $binlog_file= query_get_value(SHOW BINARY LOG STATUS, File, 1);
let $MYSQLD_DATADIR= `SELECT @@datadir`;

--# disabling result log because the error message has the 
--# table name in the output which is one byte different ('\r') 
--# on unixes and windows.
--disable_result_log
--error 1
--exec $MYSQL test < $MYSQLTEST_VARDIR/tmp/my.sql 2>&1
--enable_result_log

--echo
--echo -- It is not in binary_mode, so table name '0x410D0A42' can be translated to
--echo -- '0x410A42' by mysql depending on the OS - Windows or Unix-like.
--replace_result $table_name_wrong TABLE_NAME_MASKED $table_name_right TABLE_NAME_MASKED
if (`SELECT CONVERT(@@VERSION_COMPILE_OS USING latin1) IN ('Win32', 'Win64', 'Windows')`)
{
  eval DROP TABLE `$table_name_right`;

if (`SELECT CONVERT(@@VERSION_COMPILE_OS USING latin1) NOT IN ('Win32', 'Win64', 'Windows')`)
{
  eval DROP TABLE `$table_name_wrong`;

--
--  BUG#12794048 - MAIN.MYSQL_BINARY_MODE FAILS ON WINDOWS RELEASE BUILD 
--
RESET BINARY LOGS AND GTIDS;

--
-- This test case tests if the table names and their values
-- are handled properly. For that we check 
--

-- 0x610D0A62 => 'a\r\nb'
let $tbl= `SELECT 0x610D0A62`;
{
  --let $assert_cond=  "$tbl1" = "610D0A62" AND "$val1" = "610D0A62"
}
if (`SELECT CONVERT(@@VERSION_COMPILE_OS USING latin1) NOT IN ('Win32', 'Win64', 'Windows')`)
{
  --let $assert_cond=  "$tbl1" = "610A62" AND "$val1" = "610A62"
}
--source include/assert.inc

--let $assert_text= Table and contents created while replaying binary log with --binary-mode set match 0x610D0A62.
--let $assert_cond=  "$tbl2" = "610D0A62" AND "$val2" = "610D0A62"
--source include/assert.inc

RESET BINARY LOGS AND GTIDS;
