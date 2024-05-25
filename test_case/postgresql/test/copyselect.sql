create view v_test1
as select 'v_'||t from test1;
drop table test2;
drop view v_test1;
drop table test1;
select 4;
create table test3 (c int);
select 1;
drop table test3;
