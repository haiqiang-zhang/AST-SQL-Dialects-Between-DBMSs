
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc
-- This test is also meant to check read-only persisted value of log-replica-updates,
-- thus, it makes sense to run this test when log-bin and log-replica-updates are enabled.
-- source include/have_log_bin.inc

--echo -- Syntax check for PERSIST_ONLY option
SET PERSIST_ONLY autocommit=0;
SET @@persist_only.max_execution_time=60000;
SET PERSIST_ONLY max_user_connections=10, PERSIST_ONLY max_allowed_packet=8388608;
SET @@persist_only.max_user_connections=10, PERSIST_ONLY max_allowed_packet=8388608;
SET @@persist_only.max_user_connections=10, @@persist_only.max_allowed_packet=8388608;
SET PERSIST_ONLY max_user_connections=10, @@persist_only.max_allowed_packet=8388608;
SET PERSIST_ONLY autocommit=0, GLOBAL max_user_connections=10;
SET @@persist_only.autocommit=0, @@global.max_user_connections=10;
SET GLOBAL autocommit=0, PERSIST_ONLY max_user_connections=10;
SET @@global.autocommit=0, @@persist_only.max_user_connections=10;
SET PERSIST_ONLY autocommit=0, SESSION auto_increment_offset=10;
SET @@persist_only.autocommit=0, @@session.auto_increment_offset=10;
SET SESSION auto_increment_offset=20, PERSIST_ONLY max_user_connections=10;
SET @@session.auto_increment_offset=20, @@persist_only.max_user_connections=10;
SET PERSIST_ONLY autocommit=0, auto_increment_offset=10;
SET autocommit=0, PERSIST_ONLY auto_increment_offset=10;
SET PERSIST_ONLY autocommit=0, SESSION auto_increment_offset=10, GLOBAL max_error_count= 128;
SET SESSION autocommit=0, GLOBAL auto_increment_offset=10, PERSIST_ONLY max_allowed_packet=8388608;
SET GLOBAL autocommit=0, PERSIST_ONLY auto_increment_offset=10, SESSION max_error_count= 128;
SET @@persist_only.autocommit=0, @@session.auto_increment_offset=10, @@global.max_allowed_packet=8388608;
SET @@session.autocommit=0, @@global.auto_increment_offset=10, @@persist_only.max_allowed_packet=8388608;
SET @@global.autocommit=0, @@persist_only.auto_increment_offset=10, @@session.max_error_count= 128;
SET PERSIST_ONLY autocommit=0, SESSION auto_increment_offset=10, GLOBAL max_error_count= 128, PERSIST sort_buffer_size=256000;
SET SESSION autocommit=0, GLOBAL auto_increment_offset=10, PERSIST_ONLY max_allowed_packet=8388608, PERSIST max_heap_table_size=999424;
SET GLOBAL autocommit=0, PERSIST long_query_time= 8.3452, PERSIST_ONLY auto_increment_offset=10, SESSION max_error_count= 128;
SET @@persist_only.autocommit=0, @@session.auto_increment_offset=10, @@persist.max_execution_time=44000, @@global.max_allowed_packet=8388608;
SET @@persist.concurrent_insert=ALWAYS, @@session.autocommit=0, @@global.auto_increment_offset=10, @@persist_only.max_allowed_packet=8388608;
SET @@global.autocommit=0, @@persist_only.auto_increment_offset=10, @@persist.autocommit=0, @@session.max_error_count= 128;

let $MYSQLD_DATADIR= `select @@datadir`;
SELECT @@global.binlog_gtid_simple_recovery;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
SET PERSIST_ONLY binlog_gtid_simple_recovery=0;
SELECT @@global.binlog_gtid_simple_recovery;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
SELECT @@global.ft_query_expansion_limit;
SELECT @@global.innodb_api_enable_mdl;
SET PERSIST_ONLY ft_query_expansion_limit=80, innodb_api_enable_mdl=1;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
SELECT @@global.ft_query_expansion_limit;
SELECT @@global.innodb_api_enable_mdl;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
SET PERSIST_ONLY ft_query_expansion_limit=200, innodb_api_enable_mdl=0;
SELECT @@global.ft_query_expansion_limit;
SELECT @@global.innodb_api_enable_mdl;

SELECT @@global.innodb_read_io_threads;
SELECT @@global.log_replica_updates;
SET PERSIST_ONLY innodb_read_io_threads= 16;
SET PERSIST_ONLY log_replica_updates= 1;
SELECT @@global.ft_query_expansion_limit;
SELECT @@global.innodb_api_enable_mdl;
SELECT @@global.innodb_read_io_threads;
SELECT @@global.log_replica_updates;
SET @@persist_only.max_connections=99;
SET PERSIST_ONLY table_open_cache_instances= 8;
SELECT @@global.max_connections, @@global.session_track_system_variables;
SELECT @@global.transaction_isolation;
SET @@persist_only.max_connections=99;
SET PERSIST_ONLY session_track_system_variables= 'max_connections';
SET @@persist_only.transaction_isolation= 'READ-COMMITTED';
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

SET PERSIST_ONLY replica_type_conversions= ALL_UNSIGNED;
SET @@persist_only.relay_log_space_limit=4096;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';

SELECT @@global.relay_log_space_limit, @@global.replica_type_conversions;
SELECT VARIABLE_NAME FROM performance_schema.variables_info
  WHERE VARIABLE_SOURCE = 'PERSISTED';
CREATE USER wl9787;
SET GLOBAL sort_buffer_size=256000;
SET PERSIST max_heap_table_size=999424;
SET PERSIST_ONLY ft_query_expansion_limit=80;
SET GLOBAL sort_buffer_size=256000;
SET PERSIST max_heap_table_size=999424;
SET PERSIST_ONLY ft_query_expansion_limit=80;
SET PERSIST_ONLY ft_query_expansion_limit=80;
       -- and PERSIST_RO_VARIABLES_ADMIN
--error ER_PERSIST_ONLY_ACCESS_DENIED_ERROR
SET PERSIST_ONLY ft_query_expansion_limit=80;
SET PERSIST_ONLY ft_query_expansion_limit=80;
SET @@persist_only.replica_type_conversions = ALL_UNSIGNED;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SET PERSIST auto_increment_increment=10;
SET PERSIST innodb_checksum_algorithm=strict_crc32;
SET PERSIST_ONLY ft_query_expansion_limit= DEFAULT;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT * FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME = 'replica_type_conversions';
SELECT * FROM performance_schema.persisted_variables
  WHERE VARIABLE_NAME IN ('auto_increment_increment')
  ORDER BY 1;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SET @@persist_only.basedir= "/";
SET @@persist_only.character_sets_dir= "/";
SET @@persist_only.ft_stopword_file= "/";
SET @@persist_only.lc_messages_dir= "/";
SET @@persist_only.log_error= "/";
SET @@persist_only.pid_file= "/";
SET @@persist_only.plugin_dir= "/";
SET @@persist_only.secure_file_priv= "/";
SET @@persist_only.replica_load_tmpdir= "/";
SET @@persist_only.tmpdir= "/";
SET @@persist_only.relay_log= "/";
SET @@persist_only.relay_log_index= "/";
SET @@persist_only.log_bin_basename= "/";
SET @@persist_only.log_bin_index= "/";
SET @@persist_only.bind_address= "";
SET @@persist_only.port= "";
SET @@persist_only.skip_networking= "";
SET @@persist_only.socket= "";
SET @@persist_only.default_authentication_plugin= "";
SET @@persist_only.core_file= "";
SET @@persist_only.innodb_read_only= "";
SET @@persist_only.persisted_globals_load= "";
SET @@persist_only.datadir= "";
SET @@persist_only.innodb_data_file_path= "";
SET @@persist_only.innodb_force_load_corrupted= "";
SET @@persist_only.innodb_page_size= "";
SET @@persist_only.version= "";
SET @@persist_only.version_comment= "";
SET @@persist_only.version_compile_machine= "";
SET @@persist_only.version_compile_os= "";
SET @@persist_only.have_compress= "";
SET @@persist_only.have_dynamic_loading= "";
SET @@persist_only.license= "";
SET @@persist_only.protocol_version= "";
SET @@persist_only.lower_case_file_system= "";
SET @@persist_only.innodb_buffer_pool_load_at_startup= "";

-- cleanup
RESET PERSIST;
DROP USER wl9787;

SELECT VARIABLE_SOURCE, SET_USER, SET_HOST FROM performance_schema.variables_info
  WHERE VARIABLE_NAME = 'max_connections';
SET PERSIST_ONLY max_connections = 151;
SELECT VARIABLE_SOURCE, SET_USER, SET_HOST FROM performance_schema.variables_info
  WHERE VARIABLE_NAME = 'max_connections';

-- ensure variable source is set to PERSISTED
SELECT VARIABLE_SOURCE, SET_USER, SET_HOST FROM performance_schema.variables_info
  WHERE VARIABLE_NAME = 'max_connections';

-- cleanup
RESET PERSIST;
SET PERSIST_ONLY gtid_owned='aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa:1';
SET PERSIST_ONLY gtid_executed='aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa:1';

SET PERSIST_ONLY log_replica_updates = 1,super_read_only=1, end_markers_in_json = 1;

select @@global.log_replica_updates, @@global.super_read_only, @@global.end_markers_in_json;
SET PERSIST_ONLY super_read_only="invalid value";
SET PERSIST_ONLY end_markers_in_json = flase;

-- default value is 0 which once persisted should make next server restart to start
SET PERSIST_ONLY super_read_only=default;

SET PERSIST innodb_buffer_pool_size = 1073742336;
SET PERSIST_ONLY innodb_buffer_pool_instances = 2;

SELECT FORMAT_BYTES(@@global.innodb_buffer_pool_size) AS Size, @@global.innodb_buffer_pool_instances AS Instances;
