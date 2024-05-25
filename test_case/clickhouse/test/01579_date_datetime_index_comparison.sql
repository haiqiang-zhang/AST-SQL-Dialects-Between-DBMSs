select 1 from test_index where date < toDateTime('2020-10-30 06:00:00');
drop table if exists test_index;
select toTypeName([-1, toUInt32(1)]);
select toTypeName([-1, toInt128(1)]);
select toTypeName([toInt64(-1), toInt128(1)]);
select toTypeName([toUInt64(1), toUInt256(1)]);
