system stop merges test_table;
select distinct
    'constant_1' as constant_value,
    count(*) over(partition by constant_value, string_value) as value_cnt
from (
    select string_value
    from test_table
);
select distinct
 'constant_1' as constant_value, *
 from (select string_value from test_table)
 ORDER BY constant_value, string_value settings max_threads=1;
system start merges test_table;
drop table test_table;