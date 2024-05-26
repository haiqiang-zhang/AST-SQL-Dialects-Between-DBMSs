drop table if exists map_test;
set allow_experimental_map_type = 1;
create table map_test engine=TinyLog() as (select (number + 1) as n, map(1, 1, number,2) as m from numbers(1, 5));
select mapPopulateSeries(m) from map_test;
drop table map_test;
select mapPopulateSeries(map(toUInt8(1), toUInt8(1), 2, 1)) as res, toTypeName(res);
