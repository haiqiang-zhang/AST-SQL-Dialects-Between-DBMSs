select mapPopulateSeries(m) from map_test;
drop table map_test;
select mapPopulateSeries(map(toUInt8(1), toUInt8(1), 2, 1)) as res, toTypeName(res);
