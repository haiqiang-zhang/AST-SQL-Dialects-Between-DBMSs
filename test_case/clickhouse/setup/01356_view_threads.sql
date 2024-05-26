drop table if exists table_01356_view_threads;
create view table_01356_view_threads as select number % 10 as g, sum(number) as s from numbers_mt(1000000) group by g;
set log_queries = 1;
set max_threads = 16;
