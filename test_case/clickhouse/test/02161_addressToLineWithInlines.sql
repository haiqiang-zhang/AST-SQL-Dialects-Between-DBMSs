SET allow_introspection_functions = 0;
SET allow_introspection_functions = 1;
SET query_profiler_real_time_period_ns = 0;
SET query_profiler_cpu_time_period_ns = 1000000;
SET log_queries = 1;
SELECT count() FROM numbers_mt(10000000000) SETTINGS log_comment='02161_test_case';
SET log_queries = 0;
SET query_profiler_cpu_time_period_ns = 0;
SYSTEM FLUSH LOGS;
