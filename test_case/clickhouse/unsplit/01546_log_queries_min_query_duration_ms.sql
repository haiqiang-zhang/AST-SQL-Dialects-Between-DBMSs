set log_queries_min_query_duration_ms=300000;
set log_query_threads=1;
set log_queries=1;
system flush logs;

set log_queries_min_query_duration_ms=300;
system flush logs;
