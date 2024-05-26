drop table if exists data_02295;
create table data_02295 (
    -- the order of "a" and "b" is important here
    -- (since finalizeChunk() accepts positions and they may be wrong)
    b Int64,
    a Int64,
    grp_aggreg AggregateFunction(groupArrayArray, Array(UInt64))
) engine = MergeTree() order by a;
insert into data_02295 select 0 b, intDiv(number, 2) a, groupArrayArrayState([toUInt64(number)]) from numbers(4) group by a, b;
SELECT a, min(b), max(b) FROM data_02295 GROUP BY a ORDER BY a, count() SETTINGS optimize_aggregation_in_order = 1;
drop table data_02295;
