drop table if exists mapop_test;
set allow_experimental_map_type = 1;
create table mapop_test engine=TinyLog() as (select map(1, toInt32(2), number, 2) as m from numbers(1, 10));