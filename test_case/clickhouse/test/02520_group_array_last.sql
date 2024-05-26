select groupArrayLast(1)(number+1) from numbers(5);
select groupArrayLastArray(3)([1,2,3,4,5,6]);
create table simple_agg_groupArrayLastArray (key Int, value SimpleAggregateFunction(groupArrayLastArray(5), Array(UInt64))) engine=AggregatingMergeTree() order by key;
insert into simple_agg_groupArrayLastArray values (1, [1,2,3]), (1, [4,5,6]), (2, [4,5,6]), (2, [1,2,3]);
select * from simple_agg_groupArrayLastArray order by key, value;
system stop merges simple_agg_groupArrayLastArray;
insert into simple_agg_groupArrayLastArray values (1, [7,8]), (2, [7,8]);
select * from simple_agg_groupArrayLastArray order by key, value;
select * from simple_agg_groupArrayLastArray final order by key, value;
