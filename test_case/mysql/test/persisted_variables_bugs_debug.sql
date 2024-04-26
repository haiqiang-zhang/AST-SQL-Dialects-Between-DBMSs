
SET @@debug='+d,check_intern_find_sys_var_lock';
SET PERSIST_ONLY sql_mode=DEFAULT;
SET PERSIST sql_mode=DEFAULT;
SET @@debug='-d,check_intern_find_sys_var_lock';

SET PERSIST max_connections=42;
SET @@debug='+d,crash_after_open_persist_file';
SET PERSIST max_heap_table_size=887808, replica_net_timeout=160;
let $restart_parameters =;

SELECT @@max_connections, @@max_heap_table_size, @@replica_net_timeout;
SELECT variable_name FROM performance_schema.variables_info WHERE variable_source='PERSISTED';

SET @@debug='-d,crash_after_open_persist_file';
SET @@debug='+d,crash_after_write_persist_file';
SET PERSIST replica_net_timeout=160;
let $restart_parameters =;
SELECT @@max_connections, @@max_heap_table_size, @@replica_net_timeout;
SELECT variable_name FROM performance_schema.variables_info WHERE variable_source='PERSISTED';

SET @@debug='-d,crash_after_write_persist_file';
SET @@debug='+d,crash_after_close_persist_file';
SET PERSIST replica_net_timeout=124;
let $restart_parameters =;
SELECT @@max_connections, @@max_heap_table_size, @@replica_net_timeout;
SELECT variable_name FROM performance_schema.variables_info WHERE variable_source='PERSISTED';
SET @@debug='-d,crash_after_close_persist_file';
SET GLOBAL max_connections = default, replica_net_timeout = default, max_heap_table_size = default;
