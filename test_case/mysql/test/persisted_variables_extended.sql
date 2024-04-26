
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc
--source include/have_plugin_auth.inc

--echo --
--echo -- WL#8688: Support ability to persist SET GLOBAL settings
--echo --

CALL mtr.add_suppression("Failed to set up SSL because of the following *");
SET PERSIST auto_increment_increment=10;
SET @@persist.event_scheduler=0;
SET PERSIST replica_compressed_protocol=1;
SET GLOBAL PERSIST replica_compressed_protocol=1;
SET PERSIST @@global.replica_compressed_protocol=1;
SET PERSIST @@session.replica_compressed_protocol=1;
SET @@persist.@@replica_compressed_protocol=1;
       -- both session and global variables.
SET SESSION auto_increment_increment=3;
SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info
  WHERE VARIABLE_NAME = 'auto_increment_increment';
SET PERSIST innodb_checksum_algorithm=strict_crc32,
    PERSIST innodb_default_row_format=COMPACT,
    PERSIST sql_mode=ANSI_QUOTES,PERSIST innodb_fast_shutdown=0;
SET PERSIST innodb_flush_log_at_trx_commit=0,join_buffer_size=262144;
SET PERSIST innodb_thread_concurrency=32, PERSIST innodb_write_io_threads=32,
    PERSIST innodb_read_io_threads=invalid_val;

-- Set variables to be used in parameters of mysqld.
let $MYSQLD_DATADIR= `SELECT @@datadir`;
let $MYSQL_BASEDIR= `SELECT @@basedir`;
let $MYSQL_SOCKET= `SELECT @@socket`;
let $MYSQL_PIDFILE= `SELECT @@pid_file`;
let $MYSQL_PORT= `SELECT @@port`;
let $MYSQL_MESSAGESDIR= `SELECT @@lc_messages_dir`;
let $MYSQL_HOME=`SELECT @@basedir`;
       -- no config file read (including mysqld-auto.cnf)
let $MYSQL_SERVER_ID= `SELECT @@server_id`;

SELECT @@global.innodb_fast_shutdown;
SELECT @@global.innodb_default_row_format;
SELECT @@global.sql_mode;
SELECT @@global.innodb_flush_log_at_trx_commit;
SELECT @@global.join_buffer_size;
SELECT @@global.innodb_checksum_algorithm;
SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED'
  ORDER BY VARIABLE_NAME;
EOF

--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc
--exec echo "restart:--defaults-file=$MYSQLTEST_VARDIR/tmp/my.cnf" --basedir=$MYSQL_BASEDIR --datadir=$MYSQLD_DATADIR --socket=$MYSQL_SOCKET --pid-file=$MYSQL_PIDFILE --port=$MYSQL_PORT --lc-messages-dir=$MYSQL_MESSAGESDIR --server-id=$MYSQL_SERVER_ID --sort_buffer_size=462144 --secure-file-priv="" --innodb_dedicated_server=OFF --skip-mysqlx > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect


-- Creating sperate extra mysql configuration file.
----write_file $MYSQLTEST_VARDIR/tmp/my_user_extra.cnf
--[mysqld]
--flush_time=1
--innodb_tmpdir=$MYSQLTEST_VARDIR/tmp
--max_allowed_packet=16M
--join_buffer_size=262144
--EOF

-- MTR Bug#24337411
-- There might be global cnf files which contain deprecated variables on some
-- machines and when a defaults-extra-file is passed, global cnf file options
-- are added along with the options from the defaults-extra-file.
-- This causes the server to throw an "unknown variable" error, so this testcase
-- will be commented out.
-- Restart server with defaults-file and defaults-extra-file.
----exec echo "restart:--defaults-extra-file=$MYSQLTEST_VARDIR/tmp/my_user_extra.cnf" --basedir=$MYSQL_BASEDIR --datadir=$MYSQLD_DATADIR --socket=$MYSQL_SOCKET --pid-file=$MYSQL_PIDFILE --port=$MYSQL_PORT --lc-messages-dir=$MYSQL_MESSAGESDIR --secure-file-priv="" --skip-mysqlx > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

----remove_file $MYSQLTEST_VARDIR/tmp/my_user_extra.cnf
--enable_reconnect
--source include/wait_until_connected_again.inc

--echo -- Check values after restart.
-- Global and dynamic Variables values should be taken from mysql-auto.cnf file.
SELECT @@global.innodb_fast_shutdown;
SELECT @@global.innodb_default_row_format;
SELECT @@global.sql_mode;
SELECT @@global.innodb_checksum_algorithm;
SELECT @@global.innodb_flush_log_at_trx_commit;
SELECT @@global.max_digest_length;
SELECT @@global.join_buffer_size;
SELECT @@global.sort_buffer_size;

SELECT VARIABLE_NAME,VARIABLE_SOURCE,MIN_VALUE,MAX_VALUE
  FROM performance_schema.variables_info
  WHERE VARIABLE_NAME IN ('innodb_fast_shutdown','sql_mode',
  'innodb_default_row_format','max_digest_length',
  'innodb_flush_log_at_trx_commit',
  'disconnect_on_expired_password',
  'innodb_checksum_algorithm')
  ORDER BY VARIABLE_NAME;

-- Get rid of previous tests binlog
--disable_query_log
reset binary logs and gtids;

SET PERSIST max_connections=500;
SET PERSIST autocommit=OFF;
SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info
  WHERE VARIABLE_NAME = 'max_connections';
SET GLOBAL max_connections=DEFAULT;
SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info
  WHERE VARIABLE_NAME IN ('max_connections','autocommit');
CREATE TABLE t1 (col1 INT);
DROP TABLE t1;
SET PERSIST log_bin_trust_function_creators=1;

-- String type variables.
SET PERSIST block_encryption_mode= 'aes-128-ecb';
SET PERSIST ft_boolean_syntax= '+ -><()~*:""&|',
    PERSIST log_error_services=DEFAULT;
SET PERSIST innodb_max_dirty_pages_pct=80.99;

-- Slow_query_log variable with persist.
--let $slow_query_log_on=$MYSQLTEST_VARDIR/log/slow_query_on.log;
SET PERSIST slow_query_log=ON;
SET PERSIST slow_query_log_file=DEFAULT;
SET PERSIST slow_query_log=DEFAULT;

-- String type variables.
SELECT @@global.block_encryption_mode;
SELECT @@global.ft_boolean_syntax;
SELECT @@global.log_error_services;
SELECT @@global.innodb_max_dirty_pages_pct;
SELECT VARIABLE_NAME, VARIABLE_SOURCE, MIN_VALUE, MAX_VALUE
  FROM performance_schema.variables_info
  WHERE VARIABLE_NAME IN ('block_encryption_mode',
  'ft_boolean_syntax','log_error_services','innodb_max_dirty_pages_pct')
  ORDER BY VARIABLE_NAME;

SELECT @@global.innodb_fast_shutdown;
SELECT @@global.innodb_default_row_format;
SELECT @@global.sql_mode;
SELECT @@global.innodb_checksum_algorithm;
SELECT @@global.max_digest_length;
SELECT @@global.max_connections;
SELECT @@global.innodb_flush_log_at_trx_commit;
SELECT @@global.join_buffer_size;
SELECT @@global.innodb_flush_sync;
SELECT @@global.autocommit;
SELECT @@session.autocommit;

SELECT VARIABLE_NAME, VARIABLE_SOURCE, MIN_VALUE, MAX_VALUE
  FROM performance_schema.variables_info
  WHERE VARIABLE_NAME IN ('innodb_fast_shutdown','sql_mode',
  'innodb_default_row_format','max_digest_length','max_connections',
  'innodb_flush_log_at_trx_commit','innodb_flush_sync',
  'autocommit','innodb_checksum_algorithm')
  ORDER BY VARIABLE_NAME;
SELECT VARIABLE_NAME,VARIABLE_SOURCE
  FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'LOGIN';

-- Make sure we start with a clean slate. log_tables.test says this is OK.
TRUNCATE TABLE mysql.general_log;

SET @old_log_output=    @@global.log_output;
SET @old_general_log=         @@global.general_log;
SET @old_general_log_file=    @@global.general_log_file;

let $general_file_on = $MYSQLTEST_VARDIR/log/persist_general.log;
SET PERSIST log_output =       'FILE,TABLE';
SET PERSIST general_log=       'ON';

-- Get rid of previous tests binlog
--disable_query_log
reset binary logs and gtids;

SET PERSIST innodb_io_capacity=225;
SET PERSIST innodb_flush_sync=DEFAULT;
SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info
  WHERE VARIABLE_NAME IN('innodb_io_capacity','innodb_flush_sync');
SELECT argument FROM mysql.general_log WHERE argument LIKE 'SET PERSIST %';
SET PERSIST log_output=DEFAULT ,PERSIST general_log=DEFAULT;
SET GLOBAL general_log_file=  @old_general_log_file;
SET GLOBAL general_log=       @old_general_log;
SET GLOBAL log_output=        @old_log_output;

-- UNSET PERSIST variables by setting variables values to DEFAULT.
SET PERSIST block_encryption_mode=DEFAULT, PERSIST ft_boolean_syntax=DEFAULT,
    PERSIST innodb_checksum_algorithm=DEFAULT,
    PERSIST log_error_services=DEFAULT,
    PERSIST innodb_max_dirty_pages_pct=DEFAULT;

SET PERSIST innodb_fast_shutdown=DEFAULT,PERSIST innodb_default_row_format=DEFAULT,
    PERSIST sql_mode=DEFAULT,PERSIST innodb_flush_log_at_trx_commit=DEFAULT,
    PERSIST max_connections=default, PERSIST join_buffer_size=default,
    PERSIST innodb_flush_sync=DEFAULT,PERSIST innodb_io_capacity=DEFAULT,
    PERSIST log_bin_trust_function_creators=DEFAULT, PERSIST autocommit=DEFAULT;

-- performance_schema.variables_info.SET_USER column represents
-- which user has set the variable.
-- performance_schema.variables_info.SET_HOST column represents
-- host on which the variable is set.
-- Successful execution of SET statement will update these columns
-- (SET_USER,SET_HOST,SET_TIME) accordingly.
--connection default
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'pass1';
SET @@global.max_connections = 100;
SET @@persist.event_scheduler=DEFAULT;
SET PERSIST auto_increment_increment=10;
SET PERSIST innodb_checksum_algorithm=strict_crc32;
SELECT VARIABLE_NAME, VARIABLE_SOURCE, SET_USER, SET_HOST
FROM performance_schema.variables_info
WHERE VARIABLE_NAME IN ('max_connections','event_scheduler',
'auto_increment_increment','innodb_checksum_algorithm');

-- RESET PERSIST statement should have no effect on these new columns.

--connection con1
RESET PERSIST auto_increment_increment;
SELECT VARIABLE_NAME, VARIABLE_SOURCE, SET_USER, SET_HOST
FROM performance_schema.variables_info
WHERE VARIABLE_NAME IN ('auto_increment_increment',
'innodb_checksum_algorithm');

-- Verify SET_USER, SET_HOST column for proxy_user:
select @@global.max_connections into @saved_max_connections;
select @@global.autocommit into @saved_autocommit;

-- Create proxied user:
CREATE USER 'internal_proxied'@'%' IDENTIFIED BY 'proxy_password';

-- Create proxy user 1:
CREATE USER 'external_u1'@'%' IDENTIFIED WITH test_plugin_server AS 'internal_proxied';

-- Create proxy user 2:
CREATE USER 'external_u2'@'%' IDENTIFIED WITH test_plugin_server AS 'internal_proxied';
SET @@global.max_connections=50;
SET @@global.autocommit=1;
SELECT VARIABLE_NAME, SET_USER, SET_HOST, SET_TIME from
performance_schema.variables_info where variable_name='max_connections' or
variable_name='autocommit';
drop USER 'user1'@'localhost';
drop USER 'internal_proxied'@'%';
drop USER 'external_u1'@'%';
drop USER 'external_u2'@'%';
SET GLOBAL max_connections = @saved_max_connections;
SET GLOBAL autocommit = @saved_autocommit;

SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info WHERE VARIABLE_NAME IN
  ('sort_buffer_size', 'max_connections', 'max_digest_length',
   'innodb_fast_shutdown', 'innodb_default_row_format', 'innodb_flush_log_at_trx_commit');

SELECT @@sort_buffer_size, @@max_connections, @@max_digest_length;
SELECT @@innodb_fast_shutdown, @@innodb_default_row_format, @@innodb_flush_log_at_trx_commit;
EOF

--write_file $MYSQLD_DATADIR/innodb.cnf
[mysqld]
innodb_fast_shutdown=1
innodb_default_row_format=REDUNDANT
innodb_flush_log_at_trx_commit=2
EOF

--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc
--exec echo "restart:--defaults-file=$MYSQLTEST_VARDIR/tmp/my_tmp.cnf" --basedir=$MYSQL_BASEDIR --datadir=$MYSQLD_DATADIR --socket=$MYSQL_SOCKET --pid-file=$MYSQL_PIDFILE --port=$MYSQL_PORT --lc-messages-dir=$MYSQL_MESSAGESDIR --secure-file-priv="" --server-id=$MYSQL_SERVER_ID --innodb_dedicated_server=OFF --skip-mysqlx > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info WHERE VARIABLE_NAME IN
  ('sort_buffer_size', 'max_connections', 'max_digest_length',
   'innodb_fast_shutdown', 'innodb_default_row_format', 'innodb_flush_log_at_trx_commit');

SELECT @@sort_buffer_size, @@max_connections, @@max_digest_length;
SELECT @@innodb_fast_shutdown, @@innodb_default_row_format, @@innodb_flush_log_at_trx_commit;

-- Set valiables to be used in parameters of mysqld.
let $MYSQLD_DATADIR= `SELECT @@datadir`;
let $MYSQL_BASEDIR= `SELECT @@basedir`;
let $MYSQL_SOCKET= `SELECT @@socket`;
let $MYSQL_PIDFILE= `SELECT @@pid_file`;
let $MYSQL_PORT= `SELECT @@port`;
let $MYSQL_MESSAGESDIR= `SELECT @@lc_messages_dir`;
EOF

--echo -- this is the wrong format with event_scheduler value not being string
--write_file $MYSQLD_DATADIR/mysqld-auto.cnf
{ "mysql_server": { "event_scheduler": OFF , "mysql_server_static_options": {"binlog_gtid_simple_recovery": "0" , "ft_query_expansion_limit": "200" } } }
EOF

--echo -- server should fail to start
--echo -- on windows even though server fails to start return code is 0, thus expecting error to be 0 or 1
--error 0,1
--exec $MYSQLD --defaults-file=$MYSQLTEST_VARDIR/tmp/my.cnf --basedir=$MYSQL_BASEDIR --datadir=$MYSQLD_DATADIR --socket=$MYSQL_SOCKET --pid-file=$MYSQL_PIDFILE --port=$MYSQL_PORT --lc-messages-dir=$MYSQL_MESSAGESDIR --daemonize --secure-file-priv=""

--remove_file $MYSQLD_DATADIR/mysqld-auto.cnf
--echo -- this is the wrong format with binlog_gtid_simple_recovery value not being string
--write_file $MYSQLD_DATADIR/mysqld-auto.cnf
{ "mysql_server": { "event_scheduler": "OFF" , "mysql_server_static_options": {"binlog_gtid_simple_recovery": 0 , "ft_query_expansion_limit": "200" } } }
EOF

--echo -- server should fail to start
--error 0,1
--exec $MYSQLD --defaults-file=$MYSQLTEST_VARDIR/tmp/my.cnf --basedir=$MYSQL_BASEDIR --datadir=$MYSQLD_DATADIR --socket=$MYSQL_SOCKET --pid-file=$MYSQL_PIDFILE --port=$MYSQL_PORT --lc-messages-dir=$MYSQL_MESSAGESDIR --daemonize --secure-file-priv=""

--remove_file $MYSQLD_DATADIR/mysqld-auto.cnf
--echo -- this is the wrong format with no ',' between key/value pair
--write_file $MYSQLD_DATADIR/mysqld-auto.cnf
{ "mysql_server": { "event_scheduler": OFF , "mysql_server_static_options": {"binlog_gtid_simple_recovery": "0"  "ft_query_expansion_limit": "200" } } }
EOF

--echo -- server should fail to start
--error 0,1
--exec $MYSQLD --defaults-file=$MYSQLTEST_VARDIR/tmp/my.cnf --basedir=$MYSQL_BASEDIR --datadir=$MYSQLD_DATADIR --socket=$MYSQL_SOCKET --pid-file=$MYSQL_PIDFILE --port=$MYSQL_PORT --lc-messages-dir=$MYSQL_MESSAGESDIR --daemonize --secure-file-priv=""

--remove_file $MYSQLD_DATADIR/mysqld-auto.cnf
--echo -- this is the wrong format with wrong static variables group name
--write_file $MYSQLD_DATADIR/mysqld-auto.cnf
{ "mysql_server": { "event_scheduler": OFF , "mysql_xxxx_static_options": {"binlog_gtid_simple_recovery": "0" , "ft_query_expansion_limit": "200" } } }
EOF

--echo -- server should fail to start
--error 0,1
--exec $MYSQLD --defaults-file=$MYSQLTEST_VARDIR/tmp/my.cnf --basedir=$MYSQL_BASEDIR --datadir=$MYSQLD_DATADIR --socket=$MYSQL_SOCKET --pid-file=$MYSQL_PIDFILE --port=$MYSQL_PORT --lc-messages-dir=$MYSQL_MESSAGESDIR --daemonize --secure-file-priv=""

--remove_file $MYSQLD_DATADIR/mysqld-auto.cnf
--echo -- this is the wrong format with group name
--write_file $MYSQLD_DATADIR/mysqld-auto.cnf
{ "xxxx_server": { "event_scheduler": OFF , "mysql_server_static_options": {"binlog_gtid_simple_recovery": "0" , "ft_query_expansion_limit": "200" } } }
EOF

--echo -- server should fail to start
--error 0,1
--exec $MYSQLD --defaults-file=$MYSQLTEST_VARDIR/tmp/my.cnf --basedir=$MYSQL_BASEDIR --datadir=$MYSQLD_DATADIR --socket=$MYSQL_SOCKET --pid-file=$MYSQL_PIDFILE --port=$MYSQL_PORT --lc-messages-dir=$MYSQL_MESSAGESDIR --daemonize --secure-file-priv=""

--remove_file $MYSQLD_DATADIR/mysqld-auto.cnf
--remove_file $MYSQLTEST_VARDIR/tmp/my.cnf

--echo -- start server with all defaults
--source include/start_mysqld.inc

--echo --
--echo -- Bug#26100122: SERVER CRASHES WHEN SET PERSIST CALLS WITH A LONG STATEMENT
--echo --

set @a=repeat('A',2000);
set @b=repeat('A',24000);
SET GLOBAL init_connect=default;
CREATE USER bug25677422;
SET PERSIST sort_buffer_size=256000;
SET PERSIST max_heap_table_size=999424, replica_net_timeout=124;
SET PERSIST_ONLY innodb_read_io_threads= 16;
SET PERSIST long_query_time= 8.3452;
SET PERSIST_ONLY innodb_redo_log_capacity= 8388608, ft_query_expansion_limit= 80;
SELECT VARIABLE_NAME, VARIABLE_SOURCE, SET_USER
  FROM performance_schema.variables_info WHERE VARIABLE_NAME IN
  ('sort_buffer_size', 'max_heap_table_size', 'replica_net_timeout',
   'long_query_time', 'innodb_read_io_threads', 'innodb_redo_log_capacity',
   'ft_query_expansion_limit');
SELECT VARIABLE_NAME, VARIABLE_SOURCE, SET_USER
  FROM performance_schema.variables_info WHERE VARIABLE_NAME IN
  ('sort_buffer_size', 'max_heap_table_size', 'replica_net_timeout',
   'long_query_time', 'innodb_read_io_threads', 'innodb_redo_log_capacity',
   'ft_query_expansion_limit');

SELECT VARIABLE_NAME FROM performance_schema.variables_info WHERE
  VARIABLE_SOURCE = 'PERSISTED';
SELECT VARIABLE_NAME, VARIABLE_SOURCE, SET_USER
  FROM performance_schema.variables_info WHERE VARIABLE_NAME IN
  ('sort_buffer_size', 'max_heap_table_size', 'replica_net_timeout',
   'long_query_time', 'innodb_read_io_threads', 'innodb_redo_log_capacity',
   'ft_query_expansion_limit');
SELECT VARIABLE_NAME, VARIABLE_SOURCE, SET_USER
  FROM performance_schema.variables_info WHERE VARIABLE_NAME IN
  ('sort_buffer_size', 'max_heap_table_size', 'replica_net_timeout',
   'long_query_time', 'innodb_read_io_threads', 'innodb_redo_log_capacity',
   'ft_query_expansion_limit');
DROP USER bug25677422;
SET GLOBAL sort_buffer_size=DEFAULT, max_heap_table_size=DEFAULT,
  replica_net_timeout=DEFAULT, long_query_time=DEFAULT;

SELECT 'END OF TEST';
