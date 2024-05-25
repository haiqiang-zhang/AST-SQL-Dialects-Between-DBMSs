SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info
  WHERE VARIABLE_NAME = 'auto_increment_increment';
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
SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info
  WHERE VARIABLE_NAME = 'max_connections';
SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info
  WHERE VARIABLE_NAME IN ('max_connections','autocommit');
CREATE TABLE t1 (col1 INT);
DROP TABLE t1;
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
SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info
  WHERE VARIABLE_NAME IN('innodb_io_capacity','innodb_flush_sync');
SELECT VARIABLE_NAME, VARIABLE_SOURCE, SET_USER, SET_HOST
FROM performance_schema.variables_info
WHERE VARIABLE_NAME IN ('max_connections','event_scheduler',
'auto_increment_increment','innodb_checksum_algorithm');
SELECT VARIABLE_NAME, VARIABLE_SOURCE, SET_USER, SET_HOST
FROM performance_schema.variables_info
WHERE VARIABLE_NAME IN ('auto_increment_increment',
'innodb_checksum_algorithm');
select @@global.max_connections into @saved_max_connections;
select @@global.autocommit into @saved_autocommit;
SELECT VARIABLE_NAME, SET_USER, SET_HOST, SET_TIME from
performance_schema.variables_info where variable_name='max_connections' or
variable_name='autocommit';
SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info WHERE VARIABLE_NAME IN
  ('sort_buffer_size', 'max_connections', 'max_digest_length',
   'innodb_fast_shutdown', 'innodb_default_row_format', 'innodb_flush_log_at_trx_commit');
SELECT @@sort_buffer_size, @@max_connections, @@max_digest_length;
SELECT @@innodb_fast_shutdown, @@innodb_default_row_format, @@innodb_flush_log_at_trx_commit;
SELECT VARIABLE_NAME, VARIABLE_SOURCE
  FROM performance_schema.variables_info WHERE VARIABLE_NAME IN
  ('sort_buffer_size', 'max_connections', 'max_digest_length',
   'innodb_fast_shutdown', 'innodb_default_row_format', 'innodb_flush_log_at_trx_commit');
SELECT @@sort_buffer_size, @@max_connections, @@max_digest_length;
SELECT @@innodb_fast_shutdown, @@innodb_default_row_format, @@innodb_flush_log_at_trx_commit;
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
SELECT 'END OF TEST';
