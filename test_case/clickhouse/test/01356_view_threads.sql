-- no-parallel: it checks the number of threads, which can be lowered in presence of other queries

drop table if exists table_01356_view_threads;
create view table_01356_view_threads as select number % 10 as g, sum(number) as s from numbers_mt(1000000) group by g;
set log_queries = 1;
set max_threads = 16;
select g % 2 as gg, sum(s) from table_01356_view_threads group by gg order by gg;
system flush logs;
drop table if exists table_01356_view_threads;
