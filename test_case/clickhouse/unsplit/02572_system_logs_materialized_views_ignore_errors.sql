-- Tag no-parallel: due to attaching to system.query_log
-- Tag no-replicated-database: Replicated database will has extra queries

-- Attach MV to system.query_log and check that writing query_log will not fail

set log_queries=1;
drop table if exists log_proxy_02572;
drop table if exists push_to_logs_proxy_mv_02572;
system flush logs;
system flush logs;
system flush logs;
set log_queries=0;
system flush logs;
