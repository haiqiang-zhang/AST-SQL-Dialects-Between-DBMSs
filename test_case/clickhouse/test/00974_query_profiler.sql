-- Tag no-fasttest: Not sure why fail even in sequential mode. Disabled for now to make some progress.

SET allow_introspection_functions = 1;
SET query_profiler_real_time_period_ns = 100000000;
SET log_queries = 1;
SELECT sleep(0.5), ignore('test real time query profiler');
SET log_queries = 0;
SYSTEM FLUSH LOGS;
SET query_profiler_real_time_period_ns = 0;
SET query_profiler_cpu_time_period_ns = 1000000;
SET log_queries = 1;
SELECT count(), ignore('test cpu time query profiler') FROM numbers_mt(10000000000);
SET log_queries = 0;
SYSTEM FLUSH LOGS;
