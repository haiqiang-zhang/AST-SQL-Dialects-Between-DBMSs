DROP DATABASE bug27374791;
SELECT @@max_binlog_cache_size;
SELECT * FROM performance_schema.persisted_variables WHERE
  VARIABLE_NAME= 'max_binlog_cache_size';
SELECT * FROM performance_schema.persisted_variables WHERE
  VARIABLE_NAME= 'max_binlog_cache_size';
SELECT @a;
SELECT @@global.optimizer_trace_offset, @@global.activate_all_roles_on_login,
       @@global.auto_increment_increment, @@global.auto_increment_offset,
       @@global.binlog_error_action, @@global.binlog_format,
       @@global.cte_max_recursion_depth, @@global.eq_range_index_dive_limit,
       @@global.innodb_monitor_disable, @@global.histogram_generation_max_mem_size,
       @@global.innodb_max_dirty_pages_pct, @@global.init_connect,
       @@global.max_join_size;
SELECT @@global.optimizer_trace_offset, @@global.activate_all_roles_on_login,
       @@global.auto_increment_increment, @@global.auto_increment_offset,
       @@global.binlog_error_action, @@global.binlog_format,
       @@global.cte_max_recursion_depth, @@global.eq_range_index_dive_limit,
       @@global.innodb_monitor_disable,
       @@global.innodb_max_dirty_pages_pct, @@global.init_connect,
       @@global.max_join_size;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT @@global.optimizer_trace_offset, @@global.activate_all_roles_on_login,
       @@global.auto_increment_increment, @@global.auto_increment_offset,
       @@global.binlog_error_action, @@global.binlog_format,
       @@global.cte_max_recursion_depth, @@global.eq_range_index_dive_limit,
       @@global.innodb_monitor_disable,
       @@global.innodb_max_dirty_pages_pct, @@global.init_connect,
       @@global.max_join_size;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT COUNT(DISTINCT MICROSECOND(set_time)) FROM performance_schema.variables_info
  WHERE variable_name IN ('max_join_size', 'init_connect');
SELECT @@global.binlog_cache_size;
SELECT @@global.collation_database;
SELECT @@global.optimizer_trace_offset;
SELECT @@global.optimizer_switch;
SELECT @@global.enforce_gtid_consistency;
SELECT @@global.sql_mode;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT @@global.binlog_cache_size;
SELECT @@global.collation_database;
SELECT @@global.optimizer_trace_offset;
SELECT @@global.optimizer_switch;
SELECT @@global.enforce_gtid_consistency;
SELECT @@global.sql_mode;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
CREATE DATABASE bug27903874;
DROP DATABASE bug27903874;
SELECT @@global.innodb_tmpdir;
SELECT @@global.innodb_ft_user_stopword_table;
SELECT variable_name FROM performance_schema.variables_info WHERE variable_source='PERSISTED';
SELECT @@global.innodb_tmpdir, @@global.innodb_ft_user_stopword_table;
SELECT * FROM performance_schema.persisted_variables;
SELECT @@global.innodb_strict_mode, @@global.innodb_lock_wait_timeout;
SELECT @@global.myisam_sort_buffer_size;
SELECT @@global.myisam_stats_method;
SELECT @@global.innodb_lock_wait_timeout;
SELECT @@global.innodb_lock_wait_timeout;
SELECT @@global.innodb_lock_wait_timeout;
SELECT @@global.innodb_strict_mode;
SELECT @@global.innodb_lock_wait_timeout;
SELECT @@global.myisam_sort_buffer_size;
SELECT @@global.myisam_stats_method;
SELECT variable_name FROM performance_schema.variables_info WHERE variable_source='PERSISTED';
SELECT @@global.skip_name_resolve;
SELECT @@global.skip_name_resolve;
SELECT * FROM performance_schema.persisted_variables;
SELECT * FROM performance_schema.persisted_variables
  WHERE variable_name='replica_exec_mode';
SELECT VARIABLE_NAME, VARIABLE_SOURCE FROM performance_schema.variables_info
  WHERE variable_name LIKE 'skip_%_start' ORDER BY 1;
SELECT VARIABLE_NAME, VARIABLE_SOURCE FROM performance_schema.variables_info
  WHERE variable_name LIKE 'skip_%_start' ORDER BY 1;
SELECT VARIABLE_NAME, VARIABLE_SOURCE FROM performance_schema.variables_info
  WHERE variable_name LIKE 'skip_%_start' ORDER BY 1;
