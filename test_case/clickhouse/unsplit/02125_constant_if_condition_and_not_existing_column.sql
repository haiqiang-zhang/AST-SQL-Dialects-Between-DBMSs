drop table if exists test;
create table test (x String) Engine=StripeLog;
insert into test values (0);
select if(0, y, 42) from test;
explain syntax select x, if((select hasColumnInTable(currentDatabase(), 'test', 'y')), y, x || '_')  from test;
drop table if exists t;
