select mapAdd(([toUInt64(1)], [toInt32(1)]), map) from map_test;
drop table map_test;
select mapAdd(([toUInt8(1), 2], [1, 1]), ([toUInt8(1), 2], [1, 1])) as res, toTypeName(res);
