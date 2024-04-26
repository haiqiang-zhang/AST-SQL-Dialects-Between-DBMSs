SET PERSIST event_scheduler=DISABLED;
SET PERSIST_ONLY event_scheduler=123.456;
SET PERSIST_ONLY event_scheduler=DISABLED;

CREATE DATABASE bug27374791;
USE bug27374791;
CREATE TABLE T( i int);
INSERT INTO T values (9);
SET PERSIST max_connections=31;

-- cleanup
SET GLOBAL max_connections=DEFAULT;
DROP DATABASE bug27374791;

SELECT @@max_binlog_cache_size;
SET PERSIST max_binlog_cache_size= @@global.max_binlog_cache_size;
SELECT * FROM performance_schema.persisted_variables WHERE
  VARIABLE_NAME= 'max_binlog_cache_size';
SET PERSIST_ONLY max_binlog_cache_size= @@global.max_binlog_cache_size;
SELECT * FROM performance_schema.persisted_variables WHERE
  VARIABLE_NAME= 'max_binlog_cache_size';

-- Similar test which fixes this bug without SET PERSIST_ONLY
SET @a=cast(@@max_binlog_cache_size as char);
SELECT @a;

-- Cleanup
RESET PERSIST;
SET GLOBAL max_binlog_cache_size= DEFAULT;

-- default value
--replace_column 6 --##
SELECT @@global.optimizer_trace_offset, @@global.activate_all_roles_on_login,
       @@global.auto_increment_increment, @@global.auto_increment_offset,
       @@global.binlog_error_action, @@global.binlog_format,
       @@global.cte_max_recursion_depth, @@global.eq_range_index_dive_limit,
       @@global.innodb_monitor_disable, @@global.histogram_generation_max_mem_size,
       @@global.innodb_max_dirty_pages_pct, @@global.init_connect,
       @@global.max_join_size;

-- SHOW_SIGNED_LONG
SET PERSIST optimizer_trace_offset = default;
SET PERSIST activate_all_roles_on_login= ON;
SET PERSIST auto_increment_increment= 4, auto_increment_offset= 2;
SET PERSIST binlog_error_action= IGNORE_ERROR, binlog_format= ROW;
SET PERSIST cte_max_recursion_depth= 4294967295, eq_range_index_dive_limit= 4294967295;
SET PERSIST innodb_monitor_disable='latch';
SET PERSIST innodb_max_dirty_pages_pct= 97.3;
SET PERSIST init_connect='SET autocommit=0';
SET PERSIST max_join_size= 18446744073709551615;

-- persisted value
--replace_column 6 --##
SELECT @@global.optimizer_trace_offset, @@global.activate_all_roles_on_login,
       @@global.auto_increment_increment, @@global.auto_increment_offset,
       @@global.binlog_error_action, @@global.binlog_format,
       @@global.cte_max_recursion_depth, @@global.eq_range_index_dive_limit,
       @@global.innodb_monitor_disable,
       @@global.innodb_max_dirty_pages_pct, @@global.init_connect,
       @@global.max_join_size;

SELECT * FROM performance_schema.persisted_variables ORDER BY 1;

-- persisted value after restart
--replace_column 6 --##
SELECT @@global.optimizer_trace_offset, @@global.activate_all_roles_on_login,
       @@global.auto_increment_increment, @@global.auto_increment_offset,
       @@global.binlog_error_action, @@global.binlog_format,
       @@global.cte_max_recursion_depth, @@global.eq_range_index_dive_limit,
       @@global.innodb_monitor_disable,
       @@global.innodb_max_dirty_pages_pct, @@global.init_connect,
       @@global.max_join_size;

SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SET GLOBAL optimizer_trace_offset = default, activate_all_roles_on_login = default,
       auto_increment_increment = default, auto_increment_offset = default,
       binlog_error_action = default, binlog_format = default,
       cte_max_recursion_depth = default, eq_range_index_dive_limit = default,
       innodb_monitor_disable = default,
       innodb_max_dirty_pages_pct = default, init_connect = default,
       max_join_size = default;
SET PERSIST max_join_size= 10000000;
SET PERSIST init_connect='';
SELECT COUNT(DISTINCT MICROSECOND(set_time)) FROM performance_schema.variables_info
  WHERE variable_name IN ('max_join_size', 'init_connect');
SET GLOBAL max_join_size=DEFAULT, init_connect=DEFAULT;

SELECT @@global.binlog_cache_size;
SELECT @@global.collation_database;
SELECT @@global.optimizer_trace_offset;
SELECT @@global.optimizer_switch;
SELECT @@global.enforce_gtid_consistency;
SELECT @@global.sql_mode;
SET @@global.binlog_cache_size= 4096;

-- persist default values
SET @@persist_only.binlog_cache_size= default,
    @@persist_only.collation_database= default,
    @@persist_only.optimizer_trace_offset= default,
    @@persist_only.optimizer_switch= default,
    @@persist_only.enforce_gtid_consistency= default,
    @@persist_only.sql_mode= default;

SELECT * FROM performance_schema.persisted_variables ORDER BY 1;

-- must have default values.
SELECT @@global.binlog_cache_size;
SELECT @@global.collation_database;
SELECT @@global.optimizer_trace_offset;
SELECT @@global.optimizer_switch;
SELECT @@global.enforce_gtid_consistency;
SELECT @@global.sql_mode;

SELECT * FROM performance_schema.persisted_variables ORDER BY 1;

SET PERSIST mandatory_roles= default;

SELECT * FROM performance_schema.persisted_variables ORDER BY 1;

CREATE DATABASE bug27903874;
USE bug27903874;
SET @@autocommit=FALSE;
CREATE TABLE t(a CHAR (1))ENGINE=InnoDB;
SELECT JSON_OBJECTAGG(id,x) FROM t;
DROP DATABASE bug27903874;

SELECT @@global.innodb_tmpdir;
SET PERSIST innodb_tmpdir = default;
SELECT @@global.innodb_ft_user_stopword_table;
SET PERSIST innodb_ft_user_stopword_table = NULL;
SELECT variable_name FROM performance_schema.variables_info WHERE variable_source='PERSISTED';
SELECT @@global.innodb_tmpdir, @@global.innodb_ft_user_stopword_table;

CREATE USER u1;
SET PERSIST_ONLY ft_query_expansion_limit=80, innodb_api_enable_mdl=1;
SET PERSIST sort_buffer_size=156000,max_connections= 52;
SET PERSIST max_heap_table_size=887808, replica_net_timeout=160;

-- grant SUPER only
--connect(con1, localhost, u1)
SHOW GRANTS;

-- grant SYSTEM_VARIABLES_ADMIN only
--connect(con1, localhost, u1)
SHOW GRANTS;

-- grant PERSIST_RO_VARIABLES_ADMIN only
--connect(con1, localhost, u1)
SHOW GRANTS;

-- grant SYSTEM_VARIABLES_ADMIN and PERSIST_RO_VARIABLES_ADMIN
--connect(con1, localhost, u1)
SHOW GRANTS;
SELECT * FROM performance_schema.persisted_variables;
SET GLOBAL sort_buffer_size = default, max_connections = default,
  replica_net_timeout = default, max_heap_table_size = default;
DROP USER u1;

SELECT @@global.innodb_strict_mode, @@global.innodb_lock_wait_timeout;
SELECT @@global.myisam_sort_buffer_size;
SELECT @@global.myisam_stats_method;
SET PERSIST innodb_strict_mode=0;
SET GLOBAL innodb_lock_wait_timeout = 150;
SELECT @@global.innodb_lock_wait_timeout;
SET PERSIST innodb_lock_wait_timeout = 110;
SELECT @@global.innodb_lock_wait_timeout;
SET GLOBAL myisam_sort_buffer_size=16777216;
SET PERSIST myisam_sort_buffer_size=default;
SELECT @@global.innodb_lock_wait_timeout;
SET PERSIST myisam_stats_method=nulls_equal;
SELECT @@global.innodb_strict_mode;
SELECT @@global.innodb_lock_wait_timeout;
SELECT @@global.myisam_sort_buffer_size;
SELECT @@global.myisam_stats_method;
SELECT variable_name FROM performance_schema.variables_info WHERE variable_source='PERSISTED';
SET GLOBAL innodb_strict_mode=default, innodb_lock_wait_timeout=default,
  myisam_stats_method=default;
SET GLOBAL avoid_temporal_upgrade=TRUE;
SET PERSIST_ONLY avoid_temporal_upgrade=TRUE;
SET PERSIST avoid_temporal_upgrade=TRUE;

SELECT @@global.skip_name_resolve;
CREATE USER 'bug28749668'@'%';
SET PERSIST_ONLY skip_name_resolve=0;
SELECT @@global.skip_name_resolve;
SELECT * FROM performance_schema.persisted_variables;
DROP USER 'bug28749668'@'%';

-- Set variables to be used in parameters of mysqld.
let $MYSQLD_DATADIR= `SELECT @@datadir`;
let $MYSQL_BASEDIR= `SELECT @@basedir`;
let $MYSQL_SOCKET= `SELECT @@socket`;
let $MYSQL_PIDFILE= `SELECT @@pid_file`;
let $MYSQL_PORT= `SELECT @@port`;
let $MYSQL_MESSAGESDIR= `SELECT @@lc_messages_dir`;
let MYSQLD_LOG=$MYSQL_TMP_DIR/server.log;
EOF

--echo -- server should fail to start
--error 0,1
--exec $MYSQLD_CMD --basedir=$MYSQL_BASEDIR --datadir=$MYSQLD_DATADIR --socket=$MYSQL_SOCKET --pid-file=$MYSQL_PIDFILE --port=$MYSQL_PORT --lc-messages-dir=$MYSQL_MESSAGESDIR --daemonize --secure-file-priv="" > $MYSQLD_LOG 2>&1

--let $assert_text=Server should fail to start as mysqld-auto.cnf file is with wrong JSON format.
--let $assert_file=$MYSQLD_LOG
--let $assert_select=Persisted config file is corrupt. Please ensure mysqld-auto.cnf file is valid JSON.
--let $assert_count=1
--source include/assert_grep.inc

--remove_file $MYSQLD_DATADIR/mysqld-auto.cnf
--remove_file $MYSQLD_LOG

--echo -- start server with all defaults
--source include/start_mysqld.inc

--echo --
--echo -- Bug #32761053: SET PERSIST_ONLY ... = DEFAULT IS BROKEN FOR ENUM VARIABLES
--echo --

SET PERSIST_ONLY replica_exec_mode = DEFAULT;
SELECT * FROM performance_schema.persisted_variables
  WHERE variable_name='replica_exec_mode';
SELECT VARIABLE_NAME, VARIABLE_SOURCE FROM performance_schema.variables_info
  WHERE variable_name LIKE 'skip_%_start' ORDER BY 1;
SET PERSIST_ONLY skip_replica_start = ON;
SELECT VARIABLE_NAME, VARIABLE_SOURCE FROM performance_schema.variables_info
  WHERE variable_name LIKE 'skip_%_start' ORDER BY 1;
SELECT VARIABLE_NAME, VARIABLE_SOURCE FROM performance_schema.variables_info
  WHERE variable_name LIKE 'skip_%_start' ORDER BY 1;

SET PERSIST temptable_use_mmap=FALSE;
SET PERSIST avoid_temporal_upgrade=TRUE;

SET PERSIST_ONLY temptable_use_mmap=FALSE;
SET PERSIST_ONLY avoid_temporal_upgrade=TRUE;

-- set to default
--let $restart_parameters=restart:
--source include/restart_mysqld.inc


--echo --
--echo -- Bug #34751419: component system variable behaves differently from command-line and set persist
--echo --

call mtr.add_suppression("Duplicate variable name 'test_component.int_sys_var'");
SET PERSIST test_component.bool_sys_var = OFF;
SET PERSIST test_component.bool_ro_sys_var = OFF;
SET PERSIST replica_preserve_commit_order = OFF;

-- Cleanup
RESET PERSIST test_component.bool_sys_var;
SET GLOBAL replica_preserve_commit_order = DEFAULT;
SET PERSIST_ONLY report_host = NULL;
SET PERSIST_ONLY report_host = DEFAULT;

SET PERSIST ssl_crl = NULL;
SET GLOBAL ssl_crl = DEFAULT;
