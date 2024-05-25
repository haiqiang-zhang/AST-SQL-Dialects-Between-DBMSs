drop table if exists data_01409;
create table data_01409 engine=Memory as select * from numbers(20);
-- but can be done vai topKMerge(topKState()) as well

select 'AggregateFunctionTopK';
select 'AggregateFunctionTopKGenericData';
drop table data_01409;
