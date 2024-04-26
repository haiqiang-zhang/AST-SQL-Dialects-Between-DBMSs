
let $MYSQLD_DATADIR= `select @@datadir`;
SET PERSIST sort_buffer_size=256000;
SET PERSIST long_query_time= 8.3452;
select * from performance_schema.persisted_variables ORDER BY 1;
select * from performance_schema.persisted_variables ORDER BY 1;
SET PERSIST sort_buffer_size=156000,max_connections= 52;
SET PERSIST max_heap_table_size=887808, replica_net_timeout=160;
SET PERSIST long_query_time= 7.8102;
select * from performance_schema.persisted_variables ORDER BY 1;
select * from performance_schema.persisted_variables ORDER BY 1;
select * from performance_schema.persisted_variables ORDER BY 1;

SET PERSIST join_buffer_size= 262144;
select * from performance_schema.persisted_variables ORDER BY 1;
select * from performance_schema.persisted_variables ORDER BY 1;

-- set all variables to default
SET GLOBAL long_query_time= DEFAULT,
           max_connections= DEFAULT, max_heap_table_size= DEFAULT,
           replica_net_timeout= DEFAULT, sort_buffer_size= DEFAULT,
           join_buffer_size= DEFAULT;
SET DEBUG_SYNC='in_set_persist_variables SIGNAL set WAIT_FOR go';
SET DEBUG_SYNC='now WAIT_FOR set';
SET DEBUG_SYNC='now SIGNAL go';
SELECT count(*) FROM performance_schema.persisted_variables
  WHERE variable_name = 'max_connections';
SET DEBUG_SYNC='RESET';
SET GLOBAL max_connections=DEFAULT;
