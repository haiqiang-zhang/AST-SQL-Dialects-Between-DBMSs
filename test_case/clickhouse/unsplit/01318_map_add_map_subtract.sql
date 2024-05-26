drop table if exists map_test;
create table map_test engine=TinyLog() as (select ([1, number], [toInt32(2),2]) as map from numbers(1, 10));
select mapAdd(([toUInt64(1)], [toInt32(1)]), map) from map_test;
drop table map_test;
select mapAdd(([toUInt8(1), 2], [1, 1]), ([toUInt8(1), 2], [1, 1])) as res, toTypeName(res);
