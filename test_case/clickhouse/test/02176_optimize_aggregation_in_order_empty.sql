drop table if exists data_02176;
create table data_02176 (key Int) Engine=MergeTree() order by key;
set optimize_aggregation_in_order=1;
drop table data_02176;