select a, any(b), c, d from tab where b = 1 group by a, c, d order by c, d settings optimize_aggregation_in_order=1, query_plan_aggregation_in_order=1;
select * from (explain actions = 1, sorting=1 select a, any(b), c, d from tab where b = 1 group by a, c, d settings optimize_aggregation_in_order=1, query_plan_aggregation_in_order=1) where explain like '%ReadFromMergeTree%' or explain like '%Aggregating%' or explain like '%Order:%' settings allow_experimental_analyzer=0;
select * from (explain actions = 1, sorting=1 select a, any(b), c, d from tab where b = 1 group by a, c, d settings optimize_aggregation_in_order=1, query_plan_aggregation_in_order=1) where explain like '%ReadFromMergeTree%' or explain like '%Aggregating%' or explain like '%Order:%' settings allow_experimental_analyzer=1;
