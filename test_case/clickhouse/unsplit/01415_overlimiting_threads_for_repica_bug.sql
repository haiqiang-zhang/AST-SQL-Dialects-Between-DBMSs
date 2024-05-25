-- no-parallel: it checks the number of threads, which can be lowered in presence of other queries

set log_queries = 1;
set max_threads = 16;
set prefer_localhost_replica = 1;
system flush logs;
