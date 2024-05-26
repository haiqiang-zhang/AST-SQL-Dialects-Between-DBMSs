drop table if exists mapop_test;
set allow_experimental_map_type = 1;
create table mapop_test engine=TinyLog() as (select map(1, toInt32(2), number, 2) as m from numbers(1, 10));
select mapAdd(map(toUInt64(1), toInt32(1)), m) from mapop_test;
drop table mapop_test;
select mapAdd(map(toUInt8(1), 1, 2, 1), map(toUInt8(1), 1, 2, 1)) as res, toTypeName(res);
