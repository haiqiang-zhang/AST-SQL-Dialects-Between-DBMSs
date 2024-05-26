select g % 2 as gg, sum(s) from table_01356_view_threads group by gg order by gg;
system flush logs;
drop table if exists table_01356_view_threads;
