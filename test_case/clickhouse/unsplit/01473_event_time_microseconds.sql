
-- an integration test as those metrics take 60s by default to be updated.
-- Refer: tests/integration/test_asynchronous_metric_log_table.

SET log_queries = 1;
SET log_query_threads = 1;
SET query_profiler_real_time_period_ns = 100000000;
SET query_profiler_real_time_period_ns = 1000000000;
SYSTEM FLUSH LOGS;
SELECT '01473_metric_log_table_event_start_time_microseconds_test';
SELECT '01473_trace_log_table_event_start_time_microseconds_test';
SELECT '01473_query_log_table_event_start_time_microseconds_test';
SELECT '01473_query_thread_log_table_event_start_time_microseconds_test';
SELECT '01473_text_log_table_event_start_time_microseconds_test';