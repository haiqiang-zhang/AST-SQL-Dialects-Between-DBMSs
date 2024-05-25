-- create table
drop table if exists test;
create table test(`a` Nullable(Int32), `b` Nullable(Int32)) ENGINE = Memory;
insert into test (a,b) values (1,null), (2,3), (4, 5), (6,null);
select first_value(b) from test;
select first_value(b) ignore nulls from test;
select first_value(b) respect nulls from test;
select last_value(b) from test;
select last_value(b) ignore nulls from test;
select last_value(b) respect nulls from test;
SET allow_experimental_analyzer = 1;
select first_value(b) from test;
select first_value(b) ignore nulls from test;
select first_value(b) respect nulls from test;
select last_value(b) from test;
select last_value(b) ignore nulls from test;
select last_value(b) respect nulls from test;
