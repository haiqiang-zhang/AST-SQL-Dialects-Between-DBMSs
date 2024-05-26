drop table if exists summing_merge_tree_aggregate_function;
drop table if exists summing_merge_tree_null;
set allow_deprecated_syntax_for_merge_tree=1;
create table summing_merge_tree_aggregate_function (
    d Date,
    k UInt64,
    u AggregateFunction(uniq, UInt64)
) engine=SummingMergeTree(d, k, 1);
insert into summing_merge_tree_aggregate_function
select today() as d,
       number as k,
       uniqState(toUInt64(number % 500))
from numbers(5000)
group by d, k;
insert into summing_merge_tree_aggregate_function
select today() as d,
       number + 5000 as k,
       uniqState(toUInt64(number % 500))
from numbers(5000)
group by d, k;
