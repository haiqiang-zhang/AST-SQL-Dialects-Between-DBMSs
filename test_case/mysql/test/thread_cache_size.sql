SET @saved_thread_cache_size=@@thread_cache_size;
SET GLOBAL thread_cache_size=5;
let $wait_condition=select count(*)=1 from performance_schema.session_status where VARIABLE_NAME='Threads_cached' and VARIABLE_VALUE=5;
SET GLOBAL thread_cache_size = 2;
let $wait_condition=select count(*)=1 from performance_schema.session_status where VARIABLE_NAME='Threads_cached' and VARIABLE_VALUE=2;
SET GLOBAL thread_cache_size = 0;
let $wait_condition=select count(*)=1 from performance_schema.session_status where VARIABLE_NAME='Threads_cached' and VARIABLE_VALUE=0;

-- Privilege check
CREATE USER u1;
SET GLOBAL thread_cache_size = 5;
SET GLOBAL thread_cache_size=5;
DROP USER u1;
SET GLOBAL thread_cache_size=@saved_thread_cache_size;
