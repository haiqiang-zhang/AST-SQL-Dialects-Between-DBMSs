set max_insert_threads = 1;
insert into test select uniqState(number) as x, number as y from numbers(10) group by number order by x, y;
drop table test;
