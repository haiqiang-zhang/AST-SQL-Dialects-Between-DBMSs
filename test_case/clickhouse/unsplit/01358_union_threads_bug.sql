set log_queries = 1;
set max_threads = 16;
SELECT count() FROM (SELECT number FROM numbers_mt(1000000) ORDER BY number DESC LIMIT 100 UNION ALL SELECT number FROM numbers_mt(1000000) ORDER BY number DESC LIMIT 100 UNION ALL SELECT number FROM numbers_mt(1000000) ORDER BY number DESC LIMIT 100);
system flush logs;
