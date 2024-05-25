select mapPopulateSeries(map.1, map.2) from map_test;
select mapPopulateSeries(map.1, map.2, toUInt64(3)) from map_test;
select mapPopulateSeries(map.1, map.2, toUInt64(10)) from map_test;
select mapPopulateSeries(map.1, map.2, 10) from map_test;
select mapPopulateSeries(map.1, map.2, n) from map_test;
select mapPopulateSeries(map.1, [11,22]) from map_test;
select mapPopulateSeries([3, 4], map.2) from map_test;
select mapPopulateSeries([toUInt64(3), 4], map.2, n) from map_test;
drop table map_test;
select mapPopulateSeries([toUInt8(1), 2], [toUInt8(1), 1]) as res, toTypeName(res);
select mapPopulateSeries([toUInt16(1), 2], [toUInt16(1), 1]) as res, toTypeName(res);
select mapPopulateSeries([toUInt32(1), 2], [toUInt32(1), 1]) as res, toTypeName(res);
select mapPopulateSeries([toUInt64(1), 2], [toUInt64(1), 1]) as res, toTypeName(res);
select mapPopulateSeries([toInt8(1), 2], [toInt8(1), 1]) as res, toTypeName(res);
select mapPopulateSeries([toInt16(1), 2], [toInt16(1), 1]) as res, toTypeName(res);
select mapPopulateSeries([toInt32(1), 2], [toInt32(1), 1]) as res, toTypeName(res);
select mapPopulateSeries([toInt64(1), 2], [toInt64(1), 1]) as res, toTypeName(res);
select mapPopulateSeries([toInt8(-10), 2], [toInt8(1), 1]) as res, toTypeName(res);
select mapPopulateSeries([toInt16(-10), 2], [toInt16(1), 1]) as res, toTypeName(res);
select mapPopulateSeries([toInt32(-10), 2], [toInt32(1), 1]) as res, toTypeName(res);
select mapPopulateSeries([toInt64(-10), 2], [toInt64(1), 1]) as res, toTypeName(res);
select mapPopulateSeries([toInt64(-10), 2], [toInt64(1), 1], toInt64(-5)) as res, toTypeName(res);
select mapPopulateSeries(cast([], 'Array(UInt8)'), cast([], 'Array(UInt8)'), 5);
