SELECT @@global.binlog_gtid_simple_recovery;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
SELECT @@global.binlog_gtid_simple_recovery;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
SELECT @@global.ft_query_expansion_limit;
SELECT @@global.innodb_api_enable_mdl;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
SELECT @@global.ft_query_expansion_limit;
SELECT @@global.innodb_api_enable_mdl;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
SELECT @@global.ft_query_expansion_limit;
SELECT @@global.innodb_api_enable_mdl;
SELECT @@global.innodb_read_io_threads;
SELECT @@global.log_replica_updates;
SELECT @@global.ft_query_expansion_limit;
SELECT @@global.innodb_api_enable_mdl;
SELECT @@global.innodb_read_io_threads;
SELECT @@global.log_replica_updates;
SELECT @@global.max_connections, @@global.session_track_system_variables;
SELECT @@global.transaction_isolation;
SELECT @@global.max_connections, @@global.session_track_system_variables;
SELECT @@global.transaction_isolation;
SELECT @@global.max_connections, @@global.session_track_system_variables;
SELECT @@global.transaction_isolation;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
SELECT @@global.max_connections, @@global.session_track_system_variables;
SELECT @@global.transaction_isolation;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
SELECT @@global.relay_log_space_limit, @@global.replica_type_conversions;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT * FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME = 'replica_type_conversions';
SELECT * FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME IN ('auto_increment_increment')
  ORDER BY 1;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT VARIABLE_SOURCE, SET_USER, SET_HOST FROM performance_schema.variables_info
  WHERE VARIABLE_NAME = 'max_connections';
SELECT VARIABLE_SOURCE, SET_USER, SET_HOST FROM performance_schema.variables_info
  WHERE VARIABLE_NAME = 'max_connections';
SELECT VARIABLE_SOURCE, SET_USER, SET_HOST FROM performance_schema.variables_info
  WHERE VARIABLE_NAME = 'max_connections';
select @@global.log_replica_updates, @@global.super_read_only, @@global.end_markers_in_json;
SELECT FORMAT_BYTES(@@global.innodb_buffer_pool_size) AS Size, @@global.innodb_buffer_pool_instances AS Instances;
