SET log_queries = 1;
SELECT '01461_query_log_query_start_time_milliseconds_test';
SYSTEM FLUSH LOGS;
SET log_query_threads = 1;
SELECT '01461_query_thread_log_query_start_time_milliseconds_test';
SYSTEM FLUSH LOGS;
