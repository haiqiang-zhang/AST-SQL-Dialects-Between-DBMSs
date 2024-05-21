drop table if exists test;
create table test (x Tuple(a UInt32, b UInt32)) engine=Memory();
select * from test;
drop table test;
