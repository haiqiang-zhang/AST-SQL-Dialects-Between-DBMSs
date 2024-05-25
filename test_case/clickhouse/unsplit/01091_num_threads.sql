set log_queries=1;
set log_query_threads=1;
set max_threads=0;
WITH 01091 AS id SELECT 1;
SYSTEM FLUSH LOGS;
with 01091 as id select sum(number) from numbers(1000000);
SYSTEM FLUSH LOGS;
with 01091 as id select sum(number) from numbers_mt(1000000);
SYSTEM FLUSH LOGS;
