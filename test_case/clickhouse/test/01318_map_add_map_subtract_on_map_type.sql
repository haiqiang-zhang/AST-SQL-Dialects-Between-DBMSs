select mapAdd(map(toUInt64(1), toInt32(1)), m) from mapop_test;
drop table mapop_test;
select mapAdd(map(toUInt8(1), 1, 2, 1), map(toUInt8(1), 1, 2, 1)) as res, toTypeName(res);
