SELECT child_key, parent_key, child_key FROM data_02233 GROUP BY parent_key, child_key, child_key ORDER BY parent_key ASC NULLS LAST SETTINGS max_threads = 1, optimize_aggregation_in_order = 1;
SELECT child_key, parent_key, child_key FROM data_02233 GROUP BY parent_key, child_key, child_key WITH TOTALS ORDER BY parent_key ASC NULLS LAST SETTINGS max_threads = 1, optimize_aggregation_in_order = 1;
insert into data_02233 select number%10, number%3, number from numbers(100);
explain pipeline select parent_key, child_key, count() from data_02233 group by parent_key, child_key with totals order by parent_key, child_key settings max_threads=1, optimize_aggregation_in_order=1, read_in_order_two_level_merge_threshold=1;
select parent_key, child_key, count() from data_02233 group by parent_key, child_key with totals order by parent_key, child_key settings max_threads=1, optimize_aggregation_in_order=1;
SELECT child_key, parent_key, child_key FROM data_02233 GROUP BY parent_key, child_key, child_key ORDER BY child_key, parent_key ASC NULLS LAST SETTINGS max_threads = 1, optimize_aggregation_in_order = 1;
SELECT child_key, parent_key, child_key FROM data_02233 GROUP BY parent_key, child_key, child_key WITH TOTALS ORDER BY child_key, parent_key ASC NULLS LAST SETTINGS max_threads = 1, optimize_aggregation_in_order = 1;
drop table data_02233;
