set mutations_sync = 2;
drop table if exists mt_compact;
create table mt_compact(a UInt64, b UInt64 DEFAULT a * a, s String, n Nested(x UInt32, y String), lc LowCardinality(String))
engine = MergeTree
order by a partition by a % 10
settings index_granularity = 8,
min_bytes_for_wide_part = 0,
min_rows_for_wide_part = 10;
insert into mt_compact (a, s, n.y, lc) select number, toString((number * 2132214234 + 5434543) % 2133443), ['a', 'b', 'c'], number % 2 ? 'bar' : 'baz' from numbers(90);
