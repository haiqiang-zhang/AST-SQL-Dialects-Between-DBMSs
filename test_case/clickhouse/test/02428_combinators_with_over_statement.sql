drop table if exists test;
create table test (x AggregateFunction(uniq, UInt64), y Int64) engine=Memory;
set max_insert_threads = 1;
insert into test select uniqState(number) as x, number as y from numbers(10) group by number order by x, y;
drop table test;
