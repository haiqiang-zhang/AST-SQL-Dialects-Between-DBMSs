drop table if exists map_test;
create table map_test engine=TinyLog() as (select (number + 1) as n, ([1, number], [1,2]) as map from numbers(1, 5));
select mapPopulateSeries(map.1, map.2) from map_test;
drop table map_test;
select mapPopulateSeries([toUInt8(1), 2], [toUInt8(1), 1]) as res, toTypeName(res);
