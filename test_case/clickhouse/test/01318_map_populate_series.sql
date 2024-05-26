select mapPopulateSeries(map.1, map.2) from map_test;
drop table map_test;
select mapPopulateSeries([toUInt8(1), 2], [toUInt8(1), 1]) as res, toTypeName(res);
