drop table if exists map_test;
set allow_experimental_map_type = 1;
create table map_test engine=TinyLog() as (select (number + 1) as n, map(1, 1, number,2) as m from numbers(1, 5));
