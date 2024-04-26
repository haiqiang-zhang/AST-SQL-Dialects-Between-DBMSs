SET PERSIST autocommit=0;
SET @@persist.max_execution_time=60000;
SET PERSIST max_user_connections=10, PERSIST max_allowed_packet=8388608;
SET @@persist.max_user_connections=10, PERSIST max_allowed_packet=8388608;
SET @@persist.max_user_connections=10, @@persist.max_allowed_packet=8388608;
SET PERSIST max_user_connections=10, @@persist.max_allowed_packet=8388608;
SET PERSIST autocommit=0, GLOBAL max_user_connections=10;
SET @@persist.autocommit=0, @@global.max_user_connections=10;
SET GLOBAL autocommit=0, PERSIST max_user_connections=10;
SET @@global.autocommit=0, @@persist.max_user_connections=10;
SET PERSIST autocommit=0, SESSION auto_increment_offset=10;
SET @@persist.autocommit=0, @@session.auto_increment_offset=10;
SET SESSION auto_increment_offset=20, PERSIST max_user_connections=10;
SET @@session.auto_increment_offset=20, @@persist.max_user_connections=10;
SET PERSIST autocommit=0, auto_increment_offset=10;
SET autocommit=0, PERSIST auto_increment_offset=10;
SET PERSIST autocommit=0, SESSION auto_increment_offset=10, GLOBAL max_error_count= 128;
SET SESSION autocommit=0, GLOBAL auto_increment_offset=10, PERSIST max_allowed_packet=8388608;
SET GLOBAL autocommit=0, PERSIST auto_increment_offset=10, SESSION max_error_count= 128;
SET @@persist.autocommit=0, @@session.auto_increment_offset=10, @@global.max_allowed_packet=8388608;
SET @@session.autocommit=0, @@global.auto_increment_offset=10, @@persist.max_allowed_packet=8388608;
SET @@global.autocommit=0, @@persist.auto_increment_offset=10, @@session.max_error_count= 128;

let $MYSQLD_DATADIR= `select @@datadir`;
SELECT @@global.max_connections;
SET PERSIST max_connections=33;
SELECT @@global.max_connections;
SELECT @@global.sort_buffer_size;
SELECT @@global.max_heap_table_size;
SELECT @@global.replica_net_timeout;
SET PERSIST sort_buffer_size=256000;
SET PERSIST max_heap_table_size=999424, replica_net_timeout=124;
SET PERSIST long_query_time= 8.3452;
SET PERSIST sql_require_primary_key= true;
SET PERSIST default_table_encryption= true;
SET PERSIST table_encryption_privilege_check= true;
SELECT @@global.max_connections;
SELECT @@global.sort_buffer_size;
SELECT @@global.max_heap_table_size;
SELECT @@global.replica_net_timeout;
SELECT @@global.long_query_time;
SELECT @@global.sql_require_primary_key;
SELECT @@global.default_table_encryption;
SELECT @@global.table_encryption_privilege_check;
SET PERSIST sort_buffer_size=156000,max_connections= 52;
SET PERSIST max_heap_table_size=887808, replica_net_timeout=160;
SET PERSIST long_query_time= 7.8102;
SET PERSIST sql_require_primary_key= false;
SET PERSIST default_table_encryption= false;
SET PERSIST table_encryption_privilege_check= false;
SELECT @@global.max_connections;
SELECT @@global.sort_buffer_size;
SELECT @@global.max_heap_table_size;
SELECT @@global.replica_net_timeout;
SELECT @@global.long_query_time;
SELECT @@global.sql_require_primary_key;
SELECT @@global.default_table_encryption;
SELECT @@global.table_encryption_privilege_check;

SELECT @@global.max_user_connections;
SELECT @@global.max_execution_time;
SET PERSIST sort_buffer_size=256000;
SET PERSIST max_heap_table_size=999424, replica_net_timeout=124;
SET PERSIST long_query_time= 2.999999;
SET PERSIST sql_require_primary_key= true;
SET PERSIST default_table_encryption= true;
SET PERSIST table_encryption_privilege_check= true;
SET @@persist.max_execution_time=44000, @@persist.max_user_connections=30;
SELECT @@global.sort_buffer_size;
SELECT @@global.max_heap_table_size;
SELECT @@global.replica_net_timeout;
SELECT @@global.max_user_connections;
SELECT @@global.max_execution_time;
SELECT @@global.long_query_time;
SELECT @@global.sql_require_primary_key;
SELECT @@global.default_table_encryption;
SELECT @@global.table_encryption_privilege_check;
SELECT @@global.sort_buffer_size;
SELECT @@global.max_heap_table_size;
SELECT @@global.replica_net_timeout;
SELECT @@global.max_user_connections;
SELECT @@global.max_execution_time;
SELECT @@global.max_connections;
SELECT @@global.server_id;
SELECT @@global.general_log;
SELECT @@global.concurrent_insert;
SELECT @@global.sql_require_primary_key;
SELECT @@global.default_table_encryption;
SELECT @@global.table_encryption_privilege_check;
SET PERSIST server_id=47, @@persist.general_log=0;
SET PERSIST concurrent_insert=NEVER;
SELECT @@global.sort_buffer_size;
SELECT @@global.max_heap_table_size;
SELECT @@global.replica_net_timeout;
SELECT @@global.max_user_connections;
SELECT @@global.max_execution_time;
SELECT @@global.max_connections;
SELECT @@global.server_id;
SELECT @@global.general_log;
SELECT @@global.concurrent_insert;
SELECT @@global.max_connections;
SELECT @@global.server_id;
SET PERSIST max_connections=88;
SET PERSIST server_id=9;
SET PERSIST session_track_system_variables='autocommit';
SELECT @@global.max_connections;
SELECT @@global.server_id;
SELECT @@global.session_track_system_variables;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SET PERSIST max_connections=77;
SET PERSIST session_track_system_variables='max_connections';
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SET PERSIST max_connections=99;
SET PERSIST concurrent_insert=ALWAYS;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SET PERSIST concurrent_insert=AUTO;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SET @@persist.sql_log_bin=0;

-- default is 1
SELECT @@global.persisted_globals_load;
SET PERSIST persisted_globals_load=0;
SET GLOBAL  persisted_globals_load=ON;
SET SESSION persisted_globals_load=1;
SET GLOBAL persisted_globals_load= 'abc';
SET GLOBAL persisted_globals_load= -1;

SET PERSIST sort_buffer_size=256000;
SET PERSIST max_heap_table_size=999424, replica_net_timeout=124;
SELECT @@global.sort_buffer_size;
SELECT @@global.max_heap_table_size;
SELECT @@global.replica_net_timeout;

SELECT @@global.foreign_key_checks;
SET PERSIST foreign_key_checks=0;
SET PERSIST flush_time=2;
SELECT @@global.sort_buffer_size;
SELECT @@global.max_heap_table_size;
SELECT @@global.replica_net_timeout;
SELECT @@global.foreign_key_checks;
SELECT @@global.flush_time;
SELECT @@global.sort_buffer_size;
SELECT @@global.replica_net_timeout;
SELECT @@global.max_heap_table_size;
SELECT @@global.foreign_key_checks;
SELECT @@global.flush_time;

SELECT @@global.persisted_globals_load;

SET PERSIST general_log=ON;
SET PERSIST autocommit= 0, innodb_deadlock_detect= OFF;
SET PERSIST enforce_gtid_consistency=ON;

SELECT @@global.general_log, @@global.autocommit,
       @@global.innodb_deadlock_detect, @@global.enforce_gtid_consistency;

SELECT @@global.general_log, @@global.autocommit,
       @@global.innodb_deadlock_detect, @@global.enforce_gtid_consistency;

SELECT @@global.innodb_buffer_pool_size;
SET PERSIST innodb_buffer_pool_size=10*1024*1024;
SELECT @@global.innodb_buffer_pool_size;

SELECT @@global.innodb_buffer_pool_size;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT @@gtid_mode;
SET PERSIST gtid_mode=OFF_PERMISSIVE;
SET PERSIST gtid_mode=ON_PERMISSIVE;
SELECT @@gtid_mode;

SELECT @@gtid_mode;

SET PERSIST default.key_buffer_size = 1024*1024;
SET GLOBAL default.key_buffer_size = DEFAULT;

-- int_sys_var.str_sys_var is duplicated in component_test_sys_var_service, this is expected.
call mtr.add_suppression("Duplicate variable name 'test_component.int_sys_var'");

SET PERSIST test_component.str_sys_var = 'test';
SELECT @@global.test_component.str_sys_var;
SELECT @@global.test_component.str_sys_var;
SELECT @@global.test_component.str_sys_var;
SELECT @@global.test_component.str_sys_var;
SELECT @@global.test_component.str_sys_var;
